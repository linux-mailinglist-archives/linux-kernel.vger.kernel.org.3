Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFD46DC78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhLHTww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhLHTwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:52:51 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2D4C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:49:19 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id m24so2224249pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JKzSbT0rCNnV5YmQ+rZyqrovGgCHm3fjAjJc4qHG0t8=;
        b=VT6vxWisD14+EXhgN646GUo3wzXqLJvahL3paconefu7c6wriLDFN2NV0xOCOW3j2M
         mu4rQ/md30wkzAPXWqif2bEyZu9gJnOedOGniSwVBGF6Fw5w7QsPSb9dco7Zl4JcGoIV
         vgwoiM1hrHOiCU194gSD1rVjoW8CvM171oUr0zDy6oQtE1g9bXxrhPybH7R6xbxBfnwc
         EOLFQMen4bgDJY4EMqtdqI5YnH3NPExhvysRTmD6xZS5aP6NGAQpClyI5gKLADma1vrC
         50jf84UcNCJj5Yshsqc89sQ1H2IARV226fLqL+qA3j69Gobw972TqbM9KtRehhZp859Y
         GLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JKzSbT0rCNnV5YmQ+rZyqrovGgCHm3fjAjJc4qHG0t8=;
        b=I/LmRkOdI2nfL3vqGGTWSZAUWhYWUICS2JMoGgwOS6IJaRg7ouQPRyRx+24fJCGEMR
         9YjtQxdJGm5XcsS4OhX1VC7pz9pwQ6IJCrOeb1GYmJmVdpNhGASuwOrH/KsbrxN2Kjqu
         XlvTUVdQdqlQMV3PO2ViCjZERGGGHdy+aEljQL3dQP7qZhTEWqHir1Dert8d9iNgJjHw
         bPxm51t0zP/5DalVM6UyqkSMJLfg2aFmP86ZljxNAguxcU5uGq/ByFa34/3zlVYwKu5f
         +U4znDeHgdObpNWUIVMnNqjOBrS5cHz9r7RGmYfV4mqm4wiXRfTS1HeFtGdRGLhlRVLl
         RaJA==
X-Gm-Message-State: AOAM533MrPmFd6S6wcASMgGcWWpi99Ry9v63LfW04zvTke4nu0c2u7cM
        1Ijb+6gbwQnKJaL88TtjWrI=
X-Google-Smtp-Source: ABdhPJyNk7n4oQIti525SC2SS3AmEjIG1p7BmAZQ5mMZqDZmSldVVKkzFWrQxmfKUQylKC8OIlcvUQ==
X-Received: by 2002:a17:90a:fe14:: with SMTP id ck20mr9721224pjb.72.1638992959220;
        Wed, 08 Dec 2021 11:49:19 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id t186sm4274559pfc.122.2021.12.08.11.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 11:49:18 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 8 Dec 2021 09:49:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Security Officers <security@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
Message-ID: <YbEMPal0sKkk0+Tl@slm.duckdns.org>
References: <20211208180501.11969-1-mkoutny@suse.com>
 <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
 <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Dec 08, 2021 at 11:39:43AM -0800, Linus Torvalds wrote:
>  (b) alternatively, go ahead and do the permission check at IO time,
> but do it using "file->f_cred" (ie the open-time permission), not the
> current process ones.
> 
> In the above, (a) and (b) are basically the same: it uses f_cred for
> permission checking. The only difference is that in (a) you may be
> using some function that _technically_ uses the implicit "current
> credentials" (there are many of them), and you just separately make
> sure that those current credentials are identical to what they were at
> open time.
> 
> Obviously (b) is hugely preferred, but sometimes the code organization
> (ie "file or f_cred just isn't passed down deep enough") means that
> (a) might be the only realistic option.
> 
> IOW, it's not *wrong* to do permission checking at IO time, but it
> absolutely needs to be done using the open-time credentials.

Yeah, (b) sounds good to me. Will look into it.

Thanks.

-- 
tejun

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461C246DC65
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbhLHTni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239709AbhLHTnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:43:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA206C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 11:40:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id t5so12179468edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSuTUaoWRkT8sF44dnJf0jK4LvvPfwkMU72mY4f5Ngs=;
        b=bh7MtAYmv+906sJufelChvHxeHFUnAiJ1qplujSffdHtxPmoYLuPEcRoqDVvor8fag
         e+PDVU0H2OcYLcvkRPZxEihXtB+ncnlkwcs71TQiat8GJN0uXSOG6aidzcMS9PXGss7I
         j8wOAbWs9eTfVZaTOIGplM5K3J3fT77CCUybE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSuTUaoWRkT8sF44dnJf0jK4LvvPfwkMU72mY4f5Ngs=;
        b=irj+fZZ8EtQfTqwx8asfR2D0ayBHZ1qSMyGFZKKvs8mRchQVTnuTQ+1NKEkCpQyMHf
         PXdqmfFtKx67aeJFzg+EhUDVnxDDPtvI1b9YChnlF9XmzyR1SJHPD0jfBBRQ+8QeqD3z
         APfssSdNwK9FlC9ewFXOnQ/3hrx4GF0Yyrg3DjS/jJjdp9F8jP3j0vL9XOQnKU/GeTkM
         nEXS4IobHCCNzsLwxBwXY8isPkM7S4tzLPixjAuNkq4KlHrxdeBDGrk0Jde81WsVrdNy
         5o7im6t7sYXMf/d+Ns67szTCfGDhhzGV7liVFbBdx6iev2NyEvzvazcoZ6S12FQ0TFXu
         1WWQ==
X-Gm-Message-State: AOAM533PJSr60+Qs1jtT0wUODnKV0Nz2GciwO9ywzV4M8VuIHYkEFoP2
        99wgcHTBcly9L7RIIoj7/FtYN4uFaN6AdKtD
X-Google-Smtp-Source: ABdhPJyXCwZMZkvBDE+QDBcYRU6GgDmS8jrghy1LY/1b857xQM++MyGS3qDcGz1VP2FgAK0NkWbSOg==
X-Received: by 2002:a17:906:4d4a:: with SMTP id b10mr9964251ejv.89.1638992401050;
        Wed, 08 Dec 2021 11:40:01 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id hx14sm1863243ejc.92.2021.12.08.11.39.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 11:40:00 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id v11so5883126wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 11:39:59 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr811808wrx.378.1638992399608;
 Wed, 08 Dec 2021 11:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20211208180501.11969-1-mkoutny@suse.com> <87sfv3540t.fsf@email.froward.int.ebiederm.org>
 <YbECHjMLPEHO0vqA@slm.duckdns.org>
In-Reply-To: <YbECHjMLPEHO0vqA@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Wed, 8 Dec 2021 11:39:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
Message-ID: <CAHk-=wjcWEYSEVKvowUA0yEeDM279Zg-ptM_SsCMxmRSPJHjAw@mail.gmail.com>
Subject: Re: [PATCH] exit: Retain nsproxy for exit_task_work() work entries
To:     Tejun Heo <tj@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 11:06 AM Tejun Heo <tj@kernel.org> wrote:
>
> > That said I can't quite tell if the test should be moved into
> > cgroup_file_open or if there is a permission entry that would work.
>
> It can't.

Two options:

 (a) anybody doing "current process" permission checks at IO time
should then also check that the credentials are still the same as when
the file was opened.

 (b) alternatively, go ahead and do the permission check at IO time,
but do it using "file->f_cred" (ie the open-time permission), not the
current process ones.

In the above, (a) and (b) are basically the same: it uses f_cred for
permission checking. The only difference is that in (a) you may be
using some function that _technically_ uses the implicit "current
credentials" (there are many of them), and you just separately make
sure that those current credentials are identical to what they were at
open time.

Obviously (b) is hugely preferred, but sometimes the code organization
(ie "file or f_cred just isn't passed down deep enough") means that
(a) might be the only realistic option.

IOW, it's not *wrong* to do permission checking at IO time, but it
absolutely needs to be done using the open-time credentials.

             Linus

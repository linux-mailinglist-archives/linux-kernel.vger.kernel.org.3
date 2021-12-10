Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B224707C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbhLJR5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbhLJR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:57:36 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F0FC061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:54:00 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w1so32173090edc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6KcS0GzYyJWsrud9ajNlchOWUE1+ffKy6LgugCQghf0=;
        b=bYDRKKz/qkJGTxBXtnbkyNjWng/sQsmYebWBFnKjWRewuj3vvrrACZ3j2sAPP9L0hO
         zxxIrU9WA+bRPSdLJ6FZ0Qbjz5rQx7QrlDisJ/nte7lDGTLHeg5W3RdNwty6VZUVGQpF
         koCJkvcACAXutS0h2ky9r22zkjTCQ65WRfxdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6KcS0GzYyJWsrud9ajNlchOWUE1+ffKy6LgugCQghf0=;
        b=MkeR5WkuM6s7R2CDnPaYROj0VE8noNGWRl26rWz61tS8am6GBT72hE01PphxdjF4uw
         CExivJqWXqsSPHa72nnNxSHRDvTGaZNow8NCDDj5pYz95alg7zk9FvJ1xvj+vxtyZSrx
         17b966Wb/OsZP0kf1xRY7nqAi+16Zg0Y02GfDKwyG3mu+N8EJCRX0tiifMYBChi2NrKp
         GfZ7I2BgjUMI+kjOe40B0un0shtuK5hmuJwn1z9P99G8dIoAqSyCYYeCiACnrhCi/n35
         08iYqxLHc0gqBuw0lmw8Aii+4nikzexLRZR58LlEnlRXcEFdyPtac1Hgkc+cuLMx0+QZ
         dNQg==
X-Gm-Message-State: AOAM530/kZHbcfp7nOiaem/3ADFedMJHNb/y4pLVGqU8N7Pqrt6FbEPf
        OXg381y16oPa+HhRt7Qee8hlNQUiZjVWCkwUpS0=
X-Google-Smtp-Source: ABdhPJxSOtcrsX5d6Lnp551aCGsO1Tpydt2sybZnbRwEe9JcPVSitujPkoleQCf9oz+Eohug6ivUyg==
X-Received: by 2002:a05:6402:5158:: with SMTP id n24mr40562319edd.230.1639158838682;
        Fri, 10 Dec 2021 09:53:58 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id bm22sm1889310edb.48.2021.12.10.09.53.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Dec 2021 09:53:57 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id u17so16255859wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 09:53:57 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr14384234wra.281.1639158837490;
 Fri, 10 Dec 2021 09:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20211209214707.805617-1-tj@kernel.org> <20211209214707.805617-3-tj@kernel.org>
In-Reply-To: <20211209214707.805617-3-tj@kernel.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Fri, 10 Dec 2021 09:53:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com>
Message-ID: <CAHk-=wgiYkECT=hZRKj8ZwfBPw2Uz=gpOGBGd4ny0KYhSsjC0w@mail.gmail.com>
Subject: Re: [PATCH 2/6] cgroup: Allocate cgroup_file_ctx for kernfs_open_file->priv
To:     Tejun Heo <tj@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Michal Koutny <mkoutny@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jim Newsome <jnewsome@torproject.org>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 1:47 PM Tejun Heo <tj@kernel.org> wrote:
>
> of->priv is currently used by each interface file implementation to store
> private information. This patch collects the current two private data usages
> into struct cgroup_file_ctx which is allocated and freed by the common path.
> This allows generic private data which applies to multiple files, which will
> be used to in the following patch.

I'm not sure if it's worth it having that union just to make the
struct be 8 bytes instead of 16 (and later 16 bytes instead of 24),
when the real cost is that dynamic allocation overhead, and there's
likely only one or two active actual allocations at a time.

IOW, I'm not convinced there's any real memory savings, and making it
a union means that now you have to be very careful about who does
what..

And yes, people historically had to be very careful _anyway_, because
the "union" was kind of implicit in how there was just a shared 'void
*priv' thing that was either that iterator pointer or that psi trigger
pointer.

So in that sense this is a semantically minimal patch, but I think
that practically speaking we'd be better off without that possible
source of confusion, and just always have that cgroup proc file have a
full structure.

In fact, I think it means we could just make the thing *contain* the
iterator, instead of having a pointer to an iterator, and getting rid
of the now redundant dynamic alloc/free of the iterator pointer.

Wouldn't that simplify things? And might there not be some cgroup
pressure user that also wants to use the iterator interfaces? Maybe
not, my point is more that once we have an explicit struct allocation
for cgroup proc files, we might as well clarify and simplify the
code..

           Linus

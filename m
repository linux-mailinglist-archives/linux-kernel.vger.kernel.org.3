Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB17749BE54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbiAYWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbiAYWSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:18:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA773C061748
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:18:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id me13so34079482ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 14:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFxRjQblzuQxMmeuxhqTt69j7JKM+h2YKSCx/fgMhRQ=;
        b=yy0IFEhuQcD3FvuWwa8wDXGhtUxNSAx66MnZHZbzCNhecpc5I8xOnUPy1+QODPd3Hk
         pcTAwgfPh2h9MgMpZPC2DpBrI7X0acnAeLs2rnetyF6+0SkWFrSNvygFTwvkpDvcNm6w
         21Wc/8rlhh71ko/itJqW2AGvK8cYvL7s/7UifnG29xGSNFI8rxsnZErm+P4nfT0PHO3Q
         xfIYOMB9zGBcqAWfPG2b4c1aYctpkjeSZql1+H1YKXBPDirfysT2c7s0i6cmXbdTvnxE
         fQ5/90JxAP1yz9/PVgd7b/Scqb4i2/a2o4YiJx43MejbjngUUsh10KSvyozYmqv4tpxg
         IBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFxRjQblzuQxMmeuxhqTt69j7JKM+h2YKSCx/fgMhRQ=;
        b=sHq0APnr0opO3iGW9jkeKhd41/Hvd6wGKjdWc9Ilc9+UGdLvw542ezNacLttuitnVq
         w6UopIrtVACsaKeToCvVDBh18BVfWL8EpwxUp/iKqc6nZ/wZUyMERzuFFKdmAjDBKAc7
         TUCyg5eNQOzFAAvcLEUweEAj08qgkybP9rwc98+fkmtS+VVCuZIuroRkiwkfSoXOBLS7
         mRWrt8djqCZnXUBCPCZPrOesY9kXD1gB6dV9Ec3sknrF8ZuKmLW4H9iZMBJhrg2m4s/S
         EdlAWaZcCe1gS9L3kIgVIRmV9IuWl/RF7/mt4Ogiq0ZjoP2V+1J6wvbLUxxNPAp0V4Oj
         asZQ==
X-Gm-Message-State: AOAM530v9INKDSKkSyTc7JOzV/nsc59qrVAWAUukWK8WN9sOXDY+O0s4
        7dhssuLEyvr4Y+CcD/gsA8VfBcnbfhuDHa8h4fe/MzEkKA==
X-Google-Smtp-Source: ABdhPJwrpIOZzAr+bseCxchlMSHEMYAimpBHm2qxGfEpHUACZ+FAiH4QA8BYe2CAjY20qlmr+ZzZ3BXkhD4a14WIxdo=
X-Received: by 2002:a17:907:968d:: with SMTP id hd13mr8727837ejc.12.1643149093133;
 Tue, 25 Jan 2022 14:18:13 -0800 (PST)
MIME-Version: 1.0
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com> <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
In-Reply-To: <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jan 2022 17:18:02 -0500
Message-ID: <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/12/2021 3:32 AM, Christian Brauner wrote:
> > On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
> >> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> >> a security module may return an error code indicating that it does not
> >> recognize an input.  In this particular case Smack sees a mount option
> >> that it recognizes, and returns 0. A call to a BPF hook follows, which
> >> returns -ENOPARAM, which confuses the caller because Smack has processed
> >> its data.
> >>
> >> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> > Thanks!
> > Note, I think that we still have the SELinux issue we discussed in the
> > other thread:
> >
> >       rc = selinux_add_opt(opt, param->string, &fc->security);
> >       if (!rc) {
> >               param->string = NULL;
> >               rc = 1;
> >       }
> >
> > SELinux returns 1 not the expected 0. Not sure if that got fixed or is
> > queued-up for -next. In any case, this here seems correct independent of
> > that:
>
> The aforementioned SELinux change depends on this patch. As the SELinux
> code is today it blocks the problem seen with Smack, but introduces a
> different issue. It prevents the BPF hook from being called.
>
> So the question becomes whether the SELinux change should be included
> here, or done separately. Without the security_fs_context_parse_param()
> change the selinux_fs_context_parse_param() change results in messy
> failures for SELinux mounts.

FWIW, this patch looks good to me, so:

Acked-by: Paul Moore <paul@paul-moore.com>

... and with respect to the SELinux hook implementation returning 1 on
success, I don't have a good answer and looking through my inbox I see
David Howells hasn't responded either.  I see nothing in the original
commit explaining why, so I'm going to say let's just change it to
zero and be done with it; the good news is that if we do it now we've
got almost a full cycle in linux-next to see what falls apart.  As far
as the question of one vs two patches, it might be good to put both
changes into a single patch just so that folks who do backports don't
accidentally skip one and create a bad kernel build.  Casey, did you
want to respin this patch or would you prefer me to submit another
version?

> > Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >
> >>  security/security.c | 14 +++++++++++++-
> >>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/security/security.c b/security/security.c
> >> index 09533cbb7221..3cf0faaf1c5b 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -885,7 +885,19 @@ int security_fs_context_dup(struct fs_context *fc, struct fs_context *src_fc)
> >>
> >>  int security_fs_context_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >>  {
> >> -    return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
> >> +    struct security_hook_list *hp;
> >> +    int trc;
> >> +    int rc = -ENOPARAM;
> >> +
> >> +    hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
> >> +                         list) {
> >> +            trc = hp->hook.fs_context_parse_param(fc, param);
> >> +            if (trc == 0)
> >> +                    rc = 0;
> >> +            else if (trc != -ENOPARAM)
> >> +                    return trc;
> >> +    }
> >> +    return rc;
> >>  }

-- 
paul-moore.com

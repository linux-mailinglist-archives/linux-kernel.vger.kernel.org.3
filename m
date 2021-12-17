Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B069E479680
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 22:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhLQVrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 16:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhLQVrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 16:47:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B547C061401
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:47:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so12785732edd.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YVjp7krYySQqC7CQqhrlLalS/tCzUZljrfIOgYw9c8=;
        b=ds0Or9hUQyHWLCwuDzWn0BKOyesMRrRWFAKar1GQ2Glri5544c68TYGrWEXROYpOzL
         3HFDKHjNGSZ9FTZxNFcCLsbmtVOfzMJBKlb4ukSA7MWWGzaKNuseZyUbLT1hCeuSu72c
         t3oVGGJ/WmgNaZQxKCKLDJRhLacQipu6zfyGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YVjp7krYySQqC7CQqhrlLalS/tCzUZljrfIOgYw9c8=;
        b=hpbm3vLPEIcVip456dUicIHUfehJIyvOIXBCbVXaolVl35L52cnuL5q68b9QNersIV
         njueqO72VqtHDJbOJjq0ng/c1cgmFdZvb8SxMofctcxv5qV4HwmBB1ox2NWQkRmbCwos
         8qGeVZHGfI5M9nMR6BJLbTqUwUFobQQJ1KK8u/zVJNPpOoCt0LXv30PvywCApUQV+dnn
         Bbj8FRJ51x/9eQ6RxpEk//s/8XRIKLxYBQdgAgxhquKL/sEp2KL7LP+BYlngHpU0gihL
         okbLWxVb/hptVPDZLSWgk3p8p1dc5x0FvJvYL79VbUyI7WrBpuiEipOppTqXun4SYtTt
         iocA==
X-Gm-Message-State: AOAM530/6wsW7wnLSiT9erCAK0GgPe6wGlUBlQQaEbyfRuw57xnh4RyB
        9HiV+TBlHlYdGShzLpUsNVYH4UlD53DXyrrzQNw=
X-Google-Smtp-Source: ABdhPJwqomkCxbc8xsQ6xXmG2OSa/iTMybEQ3ws8brLIPPWl5SD4tElQ4w4J+QUn+Ew8qHE5TTFIdg==
X-Received: by 2002:a50:dac5:: with SMTP id s5mr4712651edj.180.1639777657882;
        Fri, 17 Dec 2021 13:47:37 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id oz31sm3227974ejc.35.2021.12.17.13.47.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 13:47:37 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id c4so6471590wrd.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 13:47:36 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr3990177wrp.442.1639777656558;
 Fri, 17 Dec 2021 13:47:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhS=WgqJgqpQq9J+0Pec9u8e1VnvGwqOimR54wm6TRptVA@mail.gmail.com>
 <CAHk-=wiiqvcA3noHDqJt2=ik5ikQbycdFQ7s=uq70FcGxWgXvg@mail.gmail.com> <CAN-5tyEKGQu1Y=o8KfsX3q9NkP4XZRos5stwmrT=ZV1hr1fWrQ@mail.gmail.com>
In-Reply-To: <CAN-5tyEKGQu1Y=o8KfsX3q9NkP4XZRos5stwmrT=ZV1hr1fWrQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 13:47:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiDT0aZO6UFnb9sW4rfuxp4xfPTSydnifVgL6H8b5Rb4Q@mail.gmail.com>
Message-ID: <CAHk-=wiDT0aZO6UFnb9sW4rfuxp4xfPTSydnifVgL6H8b5Rb4Q@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.16 (#3)
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Paul Moore <paul@paul-moore.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Scott Mayhew <smayhew@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 1:08 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Can you please elaborate on what is problematic with the two patches
> you've highlighted.

Commit ec1ade6a0448 ("nfs: account for selinux security context when
deciding to share superblock") adds the call to
security_sb_mnt_opts_compat() from the nfs_compare_mount_options()
function.

But nfs_compare_mount_options() is called from nfs_compare_super(),
which is used as the the "test" callback function for the "sget_fc()"
call:

        s = sget_fc(fc, compare_super, nfs_set_super);

and sget_fc() traverses all the mounted filesystems of this type -
while holding the superblock lock that protects that list.

So nfs_compare_super() may not sleep. It's called while holding a very
core low-level lock, and it really is supposed to only do a "test".
Not some complex operation that may do dynamic memory allocations and
sleep.

Yet that is exactly what security_sb_mnt_opts_compat() does, as done
in 69c4a42d72eb ("lsm,selinux: add new hook to compare new mount to an
existing mount").

So those two patches are completely broken.

Now, commit cc274ae7763d ("selinux: fix sleeping function called from
invalid context") that I just merged "fixes" this by making the
allocations in parse_sid() be GFP_NOWAIT.

That is a *HORRIBLE* fix. It's a horrible fix because

 (a) GFP_NOWAIT can fail very easily, causing the mount to randomly
fail for non-obvious reasons.

 (b) even when it doesn't fail, you really shouldn't do things like
this under a very core spinlock.

Also, the original place - nfs_compare_mount_options() is called over
and over for each mount, so you're parsing those same mount options
over and over again. So not only was this sequence buggy, it's really
not very smart to begin with.

That's why I say that a much better approach would have been to parse
the mount options _once_ at the beginning, saving them off in some
temporary supoerblock (or whatever - anything that can hold those
pre-parsed mount options), and then have the "test" callback literally
just check those parsed options.

That's not necessarily the only way to go about this - there are
probably other approaches too, I didn't really think too much about
this. But those two commits on their own are buggy, and the fix is
somewhat problematic too.

                     Linus

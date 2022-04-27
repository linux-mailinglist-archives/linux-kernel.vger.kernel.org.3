Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1E551240B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 22:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236708AbiD0UqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbiD0UqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 16:46:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6358C6459;
        Wed, 27 Apr 2022 13:43:00 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651092179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTA8jJf9AA5RlYMvaBE3R4oWy0zZygajljklA7XJzag=;
        b=mM4ICMJf4ZxV0WhY5GyOlCIUT/RgT/M51rGUg9fNOC38KV0zCEgLt5Nei0yH+hVsjSsWIM
        OT3X9gKh3DxC5FNsxCykriCIgm46wUeRZXlpf02cSnYx+DCOtIY87H9BGmdzoKjCGQdBfS
        hI/C9nkG/9WJlLuoO4klAv0R2kQx5NtrtHb1eXnsmBzJ54i3yYbAhsBOvM/uIFIbNV6d6h
        Mf8K158dE23wJbk3kgeMnDuFy1lkVrA5+pCdC43ZXDVgTQ56ky9sNX/irtpkZDm9kT7Vbd
        arRp4vJymtq4DthvJV/m8+dQVC/re64KFV6KD3Vm8OW5vn0DSrfBxYyIXri+eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651092179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rTA8jJf9AA5RlYMvaBE3R4oWy0zZygajljklA7XJzag=;
        b=0L9v6aojyMJh/+MNxUBLkFOvo+i0292rxxHV9NBSXMeaJFOhItQIiRscaun5FOOf0w/2Tf
        iBqteUmuXhCpxaCQ==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220427112759.1cedda69@gandalf.local.home>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-2-kurt@linutronix.de>
 <20220426175338.3807ca4f@gandalf.local.home> <87r15i9azg.fsf@kurt>
 <20220427112759.1cedda69@gandalf.local.home>
Date:   Wed, 27 Apr 2022 22:42:57 +0200
Message-ID: <87fslyw94e.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed Apr 27 2022, Steven Rostedt wrote:
> I'm able to trigger this on x86 64bit too.

OK, reproduced it by using the function tracer (instead of events).

Anyway, with your patch applied [1] and the one below it looks way
better:

|            bash-4252    [003] ...1. 1651091299.936121: file_ra_state_init=
 <-do_dentry_open
|            bash-4252    [003] ...1. 1651091299.936121: inode_to_bdi <-fil=
e_ra_state_init
|            bash-4252    [003] ...1. 1651091299.936121: do_truncate <-path=
_openat
|            bash-4252    [003] ...1. 1651091299.936122: dentry_needs_remov=
e_privs <-do_truncate
|            bash-4252    [003] ...1. 1651091299.936122: should_remove_suid=
 <-dentry_needs_remove_privs
|            bash-4252    [003] ...1. 1651091299.936122: security_inode_nee=
d_killpriv <-dentry_needs_remove_privs
|            bash-4252    [003] ...1. 1651091299.936122: cap_inode_need_kil=
lpriv <-security_inode_need_killpriv
|            bash-4252    [003] ...1. 1651091299.936123: __vfs_getxattr <-c=
ap_inode_need_killpriv
|            bash-4252    [003] ...1. 1651091299.936123: xattr_resolve_name=
 <-__vfs_getxattr
|            bash-4252    [003] ...1. 1651091299.936123: is_bad_inode <-xat=
tr_resolve_name
|            bash-4252    [003] ...1. 1651091299.936123: down_write <-do_tr=
uncate
|            bash-4252    [003] ...1. 1651091299.936123: notify_change <-do=
_truncate
|            bash-4252    [003] ...1. 1651091299.936123: may_setattr <-noti=
fy_change
|            bash-4252    [003] ...1. 1651091299.936123: current_time <-not=
ify_change
|            bash-4252    [003] ...1. 1651091299.936124: ktime_get_coarse_r=
eal_ts64 <-current_time
|            bash-4252    [003] ...1. 1651091299.936124: security_inode_set=
attr <-notify_change
|            bash-4252    [003] ...1. 1651091299.936124: selinux_inode_seta=
ttr <-security_inode_setattr
|            bash-4252    [003] ...1. 1651091299.936125: inode_has_perm <-s=
elinux_inode_setattr
|/sys/kernel/debug/tracing # phc_ctl /dev/ptp0 get
|phc_ctl[760.604]: clock time is 1651091302.512977591 or Wed Apr 27 22:28:2=
2 2022

Thanks for debugging it!

[1] - https://lore.kernel.org/all/20220427153339.16c33f75@gandalf.local.hom=
e/

Thanks,
Kurt

commit 81c4f2de420cc4ac08efc39e78ffd80e146bfbd7
Author: Kurt Kanzenbach <kurt@linutronix.de>
Date:   Wed Apr 27 21:59:58 2022 +0200

    timekeeping: Mark mono fast time accessors as notrace
=20=20=20=20
    Mark the CLOCK_MONOTONIC fast time accessors as notrace. These function=
s are
    used in tracing to retrieve timestamps.
=20=20=20=20
    Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2c22023fbf5f..dddc37035215 100644
=2D-- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -482,7 +482,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct t=
k_fast *tkf)
  * of the following timestamps. Callers need to be aware of that and
  * deal with it.
  */
=2Du64 ktime_get_mono_fast_ns(void)
+u64 notrace ktime_get_mono_fast_ns(void)
 {
        return __ktime_get_fast_ns(&tk_fast_mono);
 }
@@ -494,7 +494,7 @@ EXPORT_SYMBOL_GPL(ktime_get_mono_fast_ns);
  * Contrary to ktime_get_mono_fast_ns() this is always correct because the
  * conversion factor is not affected by NTP/PTP correction.
  */
=2Du64 ktime_get_raw_fast_ns(void)
+u64 notrace ktime_get_raw_fast_ns(void)
 {
        return __ktime_get_fast_ns(&tk_fast_raw);
 }

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmJpqtETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgqHED/0ZjWkFpI8PVENtmyoz1uaWIYDcxajq
2gqUnkBzQAsHnNzfNqPpWcf9VD1G95pZGos86jjRWuOIV7b36EB4ogP1+aJKfqxF
a2FAu5UQKyKvgtsMRLhUwkTqNFw8ltSOMjNn0oi6rzvHNDuwcU8F4XyvXZ7XENWr
ckxLdtr0uBTVg7+Jg9ZdQF4uuOLMa+TWThmOkPGmL4wgvZIVa5kwCYAfkMhzcYao
tngqe2PhnH2RW0i5afm8AiEvVcCnP007MkD1Nfe8I9C2kng417fcmctP2OkwukdM
TgKWqhTRGa2dlNl32P8WnvSywJIhR7dw1GdnkJq8p0FEvROxHg8WRvtTQgHbitob
LBQvrCT85JARlmt/BFtfK5dKmsq71f7ZNv82GiJCIenSvMduMmO7Z+iC9JvR3eNx
QVoZdJTZBK63ZzG9dPhFf2bgzqamxyX7YBuVG7d3DWaglBMhqu4w1pLe7O3eHt+P
OhHpbHSVqrdlGmABNSG55Zgu5UVh6cSF2YbsDkOOKyAYSxsDqcAmceZq1DaqKRtw
dWFX/0hcCXOKbfvCjNTh3m/OvlGJek+fXlooshY/gW13/P/KGI4qq9JOpvjpzihD
eGuv9mzVbUvIjqIIkI3gnUHIGZH1dGEazdSD4jbT2ceDnjOFlwhCqr2T1oLsQywT
8X4DJSpMAvGcCQ==
=v69O
-----END PGP SIGNATURE-----
--=-=-=--

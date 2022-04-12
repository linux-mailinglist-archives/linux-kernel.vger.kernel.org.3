Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E750A4FD562
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355202AbiDLIKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353701AbiDLHZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:25:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED11227B23;
        Tue, 12 Apr 2022 00:03:46 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649747024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSOBIIfV1E6zWOf6Ap6BP42f42YeWjssrthGrpaLNqo=;
        b=yuUXZkDhtS1Q1i49HqF5bGILbELxK/GZnL8Jn+JxafbqH9uRdOYH0XloFzxS4yjiVdcotk
        j6BOGnhzlnrKxUbopjSVQgMym8UGnW47lBEAeg0dcYHGAhiSXyL34PDMJX8BgXkqMrPGjH
        xKwz0Kd9qKW+j+XqekCZfFBvC3oYyEt3+PB9XmVfVwb9d6F9NjDeqEQeXehvDMgAVtBSNp
        WU2dUnTQLEtQbjxLQX3Ia9N89AWj1FKpwBzm5wowwIadQ9LeHAXRwMPz92Od6SxFJuZVbp
        oYmaRQ0rzzedOvdjHyydXJemNj2kHToiAqAXOiPC6Ck5s+WFs9RlrdekE+iIgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649747024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSOBIIfV1E6zWOf6Ap6BP42f42YeWjssrthGrpaLNqo=;
        b=eLpfoolnSQcLA7qBjjn0dS096grclyQUpFIj2A+VpoERe0u6v2ABtPMrS2o2T05GUxKV09
        I3rnJkbs3SmEPGAg==
To:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <87k0bvfibm.ffs@tglx>
References: <20220409081300.4762-1-kurt@linutronix.de>
 <20220409081300.4762-2-kurt@linutronix.de>
 <20220409093727.7dda6371@rorschach.local.home> <871qy6hu8q.ffs@tglx>
 <87k0bvfibm.ffs@tglx>
Date:   Tue, 12 Apr 2022 09:03:42 +0200
Message-ID: <87v8vepyup.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon Apr 11 2022, Thomas Gleixner wrote:
> On Sat, Apr 09 2022 at 22:33, Thomas Gleixner wrote:
>> On Sat, Apr 09 2022 at 09:37, Steven Rostedt wrote:
>>> On Sat,  9 Apr 2022 10:12:58 +0200
>>> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>>>
>>>> ---
>>>>  include/linux/timekeeping.h |  1 +
>>>>  kernel/time/timekeeping.c   | 17 +++++++++++++++++
>>>>  2 files changed, 18 insertions(+)
>>>
>>> If the time keeping folks are OK with this and ack it, I'm happy to
>>> take this through my tree.
>>
>> Go ahead. I just sent a Reviewed-by and I don't see conflicting changes
>> in that area. Famous last words :)
>
> And yes, I have some conflicting changes in the pipeline and just saw
> that this lacks a data_race() annotation like the boot variant from
> which this is derived.

Interesting, didn't see that annotation. Anyway, this patch also misses
the corresponding documentation entry. See below.

Thanks,
Kurt

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 729e24864fe7..22ec68f24421 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -132,6 +132,7 @@ Some additional variants exist for more specialized cases:
 .. c:function:: u64 ktime_get_mono_fast_ns( void )
                u64 ktime_get_raw_fast_ns( void )
                u64 ktime_get_boot_fast_ns( void )
+               u64 ktime_get_tai_fast_ns( void )
                u64 ktime_get_real_fast_ns( void )

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmJVJE4THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzghWjD/sEeBixzbfdwEh+0NSFI9u11RnAGvC9
wycvpdO5v5MNsKBgXsnO5Ssq7a1Mzx6i6hRY452BEfUvIuFFK2hvFgnvGzIQpFJZ
Y5orhocN5IeJTq7jv+Iq75Rk1z4Zbsng9qCaDIVZa2u3pxqeng/HbpvNc8bczx5G
TFIdkGDHJUXjsNkBa48Wj/p18QInGdrEXqHYua3auKUB+EHF0pEjqhnzXhKTHGsy
CtZUqRkqCp2ONr5aU8jZhMLm8uNnezWC7dz8x3iN8KhEJkJezKa8X/JK7g2zLiSy
bTviKsrixxYY7IOaBQbqynuvYPvJL9ESIik8AitJiv0qfEzpfR6ZblSzjJgPrHVS
h4Fvw1yJZ3hTX3SJXgLcCQAgPfaRDRuwssjVmFVmjBDclZ2BwCqxE31Uo1hucEIw
ewDwZRa/MKqGSpUGmsZAMm1MP0FW8y8p4qpHgb0BeCCiwxFyKsr6Ky/9YRO+2zAq
zP9UpKGle8MZXy4n1RB2WZ1uStEujYnAF1+Sgm2kEUYptjTfoWqNxEQb+S12oYYG
0VOty1agDe+UflrRKveE+I0RS8r9ohMHeSEVda2m/Ae9h+E9KZwPOGlZMGHdJaY8
264CmK4YqwH3jl7CL3xE3rXlBaOCgGBd+3YhVPP25yOqiCmuRyim4ZuYYd02FK4B
7CrnH8wL+HCuaA==
=w1aW
-----END PGP SIGNATURE-----
--=-=-=--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EC0500C44
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbiDNLlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiDNLlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:41:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD2D86E2A;
        Thu, 14 Apr 2022 04:39:00 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649936338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AY30W6+ipE8tv0jnqpr+K7cq6+IFyrSuzCK12VLVYw=;
        b=GvUF1qynsCri8gGc/nnSyUDUek7DQ6jMg16N+aPbQbJ+qOCaqxr/gchfcQgCP4CdDBcDJi
        /n8EkfW0upDMiG7wqh5LTmgHhnPcXyHItYogqCYU7AgSikCvdeJ+v3EyUCvOJ1VvYIuGuG
        CW2+N2oNctK6XtYlt9E6uEbPJw8C9XSvni2JrjSF56GaG5BjafrJeejq0jpOjOAyUBRXgL
        2aHL0KFWYmmX6BvTsvUlodKVRzQSdEMcs77D5gO+XXAeHDx9zS3RwGWy9mOu0qiPT3xtFo
        /hEy2jz4ihatSM3QuCC7ojjH/YdrV7nNeINUs/C5rbnRsfEi3rM9HMj3QrAyiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649936338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2AY30W6+ipE8tv0jnqpr+K7cq6+IFyrSuzCK12VLVYw=;
        b=S+AwNNkvqObJWBQolXrNzbKLfkL/JniTJpw1MsVEqNFGg4huV56FZfEChGXdfN/MJ0UNpV
        MzDqA97AeFO/IkDw==
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tracing: Add documentation for trace clock tai
In-Reply-To: <0dd9ba0e-712a-37f6-a50d-f5510cd23033@gmail.com>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-4-kurt@linutronix.de>
 <0dd9ba0e-712a-37f6-a50d-f5510cd23033@gmail.com>
Date:   Thu, 14 Apr 2022 13:38:57 +0200
Message-ID: <871qxzq4ha.fsf@kurt>
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

On Thu Apr 14 2022, Bagas Sanjaya wrote:
> On 4/14/22 16:18, Kurt Kanzenbach wrote:
>> +	tai:
>> +		This is the tai clock (CLOCK_TAI) and is derived from the wall-
>> +		clock time. However, this clock does not experience
>> +		discontinuities and backwards jumps caused by NTP inserting leap
>> +		seconds. Since the clock access is designed for use in tracing,
>> +		side effects are possible. The clock access may yield wrong
>> +		readouts in case the internal TAI offset is updated e.g., caused
>> +		by setting the system time or using adjtimex() with an offset.
>> +		These effects are rare and post processing should be able to
>> +		handle them. See comments in the ktime_get_tai_fast_ns()
>> +		function for more information.
>> +
>
> In what file are the ktime_get_tai_fast_ns() comments?

In kernel/time/timekeeping.c. That function is introduced in patch #1
and has kernel doc comments. Similar to ktime_get_boot_fast_ns().

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmJYB9ETHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgicJD/9A7CLbPVNGF89I2TFog7qSZXhTkEDx
G1J3fJZkFtdv7+zSrNWqHPiYZcbMAOUX6Txe0aRqEV5dfNta+8i9w1zpLKVSw84V
lOHlYb5pF03sZ1iqIgFvPKx9wym+1w9dFDNqL/hp+T1FaSjVhzj3MFZh/nFKcgO0
m105ui2jQI/VRLRfoGn6C5l+EmEYlb7D4ohTBfjolPirwAm1UUluIZlV6DOuVCxq
ic6U6NlFRSN/gTaJMr1i3g/QGw0CSHfqGcUT52YWQXAS5kjuL8yLxsIWt9nAL7N/
bmc65bJVmLmxItIgKYQipZxB/2cKqnQsJWR5sxCNSCy1xZ2c4fLKpfckWqZzL4Rg
kz3xKx70eiV1Lvojh4TyaqHqTftMk2HNaOouchFWcwQAYEeYhkK32f5PnEJ0FRMt
Lp2PHJrpIxQMbAMLXIwKbV/AQCgtxYP8niMYkzDdEGV2Fku3mVracJ4cMFVBmC/5
f9sWlOzhilkM2cC1ajvQt4g2QkzjBVj6a1ivN3wULsc2AuBRj89EWJbYfGqxE212
MxxPKy8JhE0igm6OAS9QV7el4D+oKG1ExHeFNb0iSBjU9SmhWlUML+H+WrwWjGGb
irQ6zqrCrgjIiyQDxu9pA9qoLcUOFP4r1ZVxMgdZLvvwKzuQuCfc44eKWLmD0KA8
lHVcM/IpaRwzBA==
=u8Ks
-----END PGP SIGNATURE-----
--=-=-=--

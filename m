Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA851139D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359476AbiD0ImP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbiD0ImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:42:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08876A018;
        Wed, 27 Apr 2022 01:39:02 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651048741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzMQGXqkpUhrUWCXBrGu4FxwFSp+DerGEsoezHXPpw8=;
        b=HcDpgLJcOKVcS1iYB6drBO2RdkOQ0pdO0oaebDDrafbD8rjrVTdi7ikE8VSQxUUBW75XiW
        +zOT6Mbc9wfn+jq9xD2GGp3hES127TCjmsPilsJAy8z71jSsGB/hBOfNvNAk3zS8twmmIK
        NFD2C/9GlCgSGUuCF6rkN+s96GxiM5c14HRRf5Mq84nKyyPRW3Bcq/hRmscTP1dW/HxTNP
        yFcLP0dBZkGMgl2HtyP+Ivd9YOqPyYMwEyoXdjDkDPbv4SXQSUgfdXvrn1PjA7jeF8EczX
        CaVSbaYssrdoeOYSFFe/6eGBWTHOJ/lUKxbz4qYtWs03F6zYzzEgmEgebpLgew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651048741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GzMQGXqkpUhrUWCXBrGu4FxwFSp+DerGEsoezHXPpw8=;
        b=POa/YUZgEcY1UmXTe6ny+2c9tvxDmnli5oU8lJEvt4c3iBIP9BiMOYWDvsfVojQDC/miCl
        RzRUFunHqaLP00Bg==
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] timekeeping: Introduce fast accessor to clock tai
In-Reply-To: <20220426175338.3807ca4f@gandalf.local.home>
References: <20220414091805.89667-1-kurt@linutronix.de>
 <20220414091805.89667-2-kurt@linutronix.de>
 <20220426175338.3807ca4f@gandalf.local.home>
Date:   Wed, 27 Apr 2022 10:38:59 +0200
Message-ID: <87r15i9azg.fsf@kurt>
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

On Tue Apr 26 2022, Steven Rostedt wrote:
> On Thu, 14 Apr 2022 11:18:03 +0200
> Kurt Kanzenbach <kurt@linutronix.de> wrote:
>
> I finally ran this series through my tests, and it has some issues.

Thanks!

[snip]

>> +/**
>> + * ktime_get_tai_fast_ns - NMI safe and fast access to tai clock.
>> + *
>> + * The same limitations as described for ktime_get_boot_fast_ns() apply. The
>> + * mono time and the TAI offset are not read atomically which may yield wrong
>> + * readouts. However, an update of the TAI offset is an rare event e.g., caused
>> + * by settime or adjtimex with an offset. The user of this function has to deal
>> + * with the possibility of wrong timestamps in post processing.
>> + */
>> +u64 notrace ktime_get_tai_fast_ns(void)
>> +{
>> +	struct timekeeper *tk = &tk_core.timekeeper;
>> +
>> +	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_tai)));
>
> As you are using this for tracing, can you open code the
> ktime_get_mono_fast_ns(), otherwise we need to mark that function as
> notrace. Not to mention, this is a fast path and using the noinline of
> __ktime_get_fast_ns() should be less overhead.

Looking at the other functions used for tracing:

 - ktime_get_mono_fast_ns - no annotations
 - ktime_get_raw_fast_ns  - no annotations
 - ktime_get_boot_fast_ns - notrace
 - ktime_get_tai_fast_ns  - notrace

Seems a little bit inconsistent.

>
> That said, I hit this too:
>
>             less-5071    [000] d.h2. 498087876.351330: do_raw_spin_trylock <-_raw_spin_lock
>             less-5071    [000] d.h4. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>             less-5071    [000] d.h5. 498087876.351334: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>             less-5071    [000] d.h3. 498087876.351334: rcu_read_lock_sched_held <-lock_acquired
>             less-5071    [000] d.h5. 498087876.351337: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h7. 1651009380.982749: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h5. 1651009380.982749: rcu_read_lock_held_common <-rcu_read_lock_sched_held
>     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h7. 498087876.375905: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>     kworker/u8:1-45      [003] d.h5. 498087876.375905: update_cfs_group <-task_tick_fair
>     kworker/u8:1-45      [003] d.h7. 498087876.375909: ktime_get_mono_fast_ns <-ktime_get_tai_fast_ns
>
> The clock seems to be toggling between 1651009380 and 498087876 causing the
> ftrace ring buffer to shutdown (it doesn't allow for time to go backwards).
>
> This is running on a 32 bit x86.

Hm. The only problem is that the TAI offset may change. That should only
happen if the time is set or similar. For the TSN use case I've ran
ptp4l and phc2sys. phc2sys in the default configuration sets the offset
hard once and uses frequency adjustments from that point on. I didn't
observe any time jumps. Nevertheless, my test systems is based on
arm64. I'll do some testing on x86.

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmJpASMTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzglnWD/sHU1zSn04SZ1cl1tnLEp6QZWQZnLNs
w1jxDj/MM25pe/uP5JH3gRMmwXUGI0QPsKoWm9Cl0q4+cAMB7ZzmFGMP6vyWzVyv
HPtuC5vXJizM+pwKykAqHsr2bAKF46Ve1Pmp5ndE/QFIwqZZgJAWscWIdExfi/j1
ZlN0ZLCp2kuq39wTaqNS2Uk9OYMiT06yqurRDHlDa6kdz3P0bmseAfgiXqIOzXP/
ovubuuJoRfmkj7E/bWqUWgxRJg4TUVQvVhdSBnfHbCc4S3TUldghMGgBuTaBW+V7
EeH6yiceHv1Llx80BOjQp35fF5VP92/U0m7hoQVsmcN/5coHTA2SXShcIDEYzxI+
Vn61rTxb8ksev7ORYOFELB6m3i6QCbSvs5hEUPJ784mv/PrJxgyBXU6UmUKHqo/X
rHR+wby/9jsqHAdK9ReNFvB5KDIfy5APGbr7q5w3NCxNEMF+Pl2AA6UxI4GYfuOB
iIccit04WOws14nj4VhB6m5HSn5JHeNyu7Y+ftrHremx/DM/0COVDDoqxFSqR+k4
OHZy6pg6QiDDV50Vk0MrMPo1CdXSKTBqfIVDuqnIrh67zTgvkrqI/V57ve0vOua2
eDQ4JQJyBO8clV/pbxE8Lvhr9TBXoRcE09BFcuRfUXTkgO/MuLJEQaOtPbLln0KA
k6V9lBpH296Evg==
=ePHe
-----END PGP SIGNATURE-----
--=-=-=--

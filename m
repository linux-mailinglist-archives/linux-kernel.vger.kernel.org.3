Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE1A4FEE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbiDMFO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMFOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:14:23 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C184BFF1;
        Tue, 12 Apr 2022 22:12:03 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so5171042pjn.3;
        Tue, 12 Apr 2022 22:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=rg2lurYr3ruoQu8jYzT28vzciXuBIWQaGUdRPFYHa8Y=;
        b=cqpW5WJq2dxo9Xpl9AtxtfJpPdxf2XqiC0K0NveMKKkqavqky1FSiLJZYafjLeWjcB
         esN4rtETggEWXs9X5/1NdJvjls2G1Cl3YTI2dZ8bh88HL57ziOZikc02NKL3TJxu760Z
         hej+rFnf9SGUI7TFdh/OFEz/SlHHOFWonerQ9O87sUkxWHqlMXuTIWCPArHU1u0njF7R
         srqTFh7g3PqUxop7rUb6RGCABgD2aAAcXsEOosBBmM+YFZV3LTC1yjdobLLohsqTcIIS
         cpc2p3Qp3msmWNq0+wPdvmraF3XemUOqZId39+2nyM7pG6jI9qC3Ba2v8YZWtcPTnYJr
         i9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=rg2lurYr3ruoQu8jYzT28vzciXuBIWQaGUdRPFYHa8Y=;
        b=KTevU7Up0ix/vRNSgWQQLi+sjjIfuFpUHat1gqZe0SZOEhJPqoXcOVJXMWigzF3PPd
         z/hZxbiLQTyGNjBDTssvBuIG/l6iD+mQw8h1LN3rwhI6MLqm4yfbhjd8FNyIpH7lMN7r
         uS1JJSohUomI1+gTc8DdKimU/EDbx4SetnQdLJfa/knMmYtmz6b/oeHp6A2IBZlQvEEk
         eZdwnU6FuX7zHVMHvOTKOh9ovr8EOSUc/CXR0KgMtyderzAZCWXGfAtywxE4VEdxQi5G
         8OmWv/zzGsngycVtXn0032hKGChtPMZ2gYIDu0UP4nZp11B804gtGbzOiCtA4i7Aw5MN
         OL7w==
X-Gm-Message-State: AOAM532syk9tC5lXX5B7XT0BA1Dopo3XCaA9UM89f4s4BqaRzK8G1zEL
        VkSZRV+MqpAiDZeBLGwQtk4=
X-Google-Smtp-Source: ABdhPJzOQ6Inv+6gpLXSzaV644vqnglofSuRMAchIsFaKAm/W4uaXTh1v8ofvyh/oXkIinU/GdnbRA==
X-Received: by 2002:a17:902:a712:b0:158:9e75:686c with SMTP id w18-20020a170902a71200b001589e75686cmr2409612plq.56.1649826723274;
        Tue, 12 Apr 2022 22:12:03 -0700 (PDT)
Received: from localhost (220-235-208-104.tpgi.com.au. [220.235.208.104])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ad3c400b001c65ba76911sm1268956pjw.3.2022.04.12.22.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 22:12:02 -0700 (PDT)
Date:   Wed, 13 Apr 2022 15:11:57 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: 
To:     Michael Ellerman <mpe@ellerman.id.au>, paulmck@kernel.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rcu <rcu@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
        <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
        <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
        <87pmls6nt7.fsf@mpe.ellerman.id.au> <87k0bz7i1s.fsf@mpe.ellerman.id.au>
In-Reply-To: <87k0bz7i1s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Message-Id: <1649818529.j46672mh2p.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Daniel, Thomas, Viresh

Subject: Re: rcu_sched self-detected stall on CPU

Excerpts from Michael Ellerman's message of April 9, 2022 12:42 am:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> "Paul E. McKenney" <paulmck@kernel.org> writes:
>>> On Wed, Apr 06, 2022 at 05:31:10PM +0800, Zhouyi Zhou wrote:
>>>> Hi
>>>>=20
>>>> I can reproduce it in a ppc virtual cloud server provided by Oregon
>>>> State University.  Following is what I do:
>>>> 1) curl -l https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/snapshot/linux-5.18-rc1.tar.gz
>>>> -o linux-5.18-rc1.tar.gz
>>>> 2) tar zxf linux-5.18-rc1.tar.gz
>>>> 3) cp config linux-5.18-rc1/.config
>>>> 4) cd linux-5.18-rc1
>>>> 5) make vmlinux -j 8
>>>> 6) qemu-system-ppc64 -kernel vmlinux -nographic -vga none -no-reboot
>>>> -smp 2 (QEMU 4.2.1)
>>>> 7) after 12 rounds, the bug got reproduced:
>>>> (http://154.223.142.244/logs/20220406/qemu.log.txt)
>>>
>>> Just to make sure, are you both seeing the same thing?  Last I knew,
>>> Zhouyi was chasing an RCU-tasks issue that appears only in kernels
>>> built with CONFIG_PROVE_RCU=3Dy, which Miguel does not have set.  Or di=
d
>>> I miss something?
>>>
>>> Miguel is instead seeing an RCU CPU stall warning where RCU's grace-per=
iod
>>> kthread slept for three milliseconds, but did not wake up for more than
>>> 20 seconds.  This kthread would normally have awakened on CPU 1, but
>>> CPU 1 looks to me to be very unhealthy, as can be seen in your console
>>> output below (but maybe my idea of what is healthy for powerpc systems
>>> is outdated).  Please see also the inline annotations.
>>>
>>> Thoughts from the PPC guys?
>>
>> I haven't seen it in my testing. But using Miguel's config I can
>> reproduce it seemingly on every boot.
>>
>> For me it bisects to:
>>
>>   35de589cb879 ("powerpc/time: improve decrementer clockevent processing=
")
>>
>> Which seems plausible.
>>
>> Reverting that on mainline makes the bug go away.
>>
>> I don't see an obvious bug in the diff, but I could be wrong, or the old
>> code was papering over an existing bug?
>>
>> I'll try and work out what it is about Miguel's config that exposes
>> this vs our defconfig, that might give us a clue.
>=20
> It's CONFIG_HIGH_RES_TIMERS=3Dn which triggers the stall.
>=20
> I can reproduce just with:
>=20
>   $ make ppc64le_guest_defconfig
>   $ ./scripts/config -d HIGH_RES_TIMERS
>=20
> We have no defconfigs that disable HIGH_RES_TIMERS, I didn't even
> realise you could disable it TBH :)
>=20
> The Rust CI has it disabled because I copied that from the x86 defconfig
> they were using back when I added the Rust support. I think that was
> meant to be a stripped down fast config for CI, but the result is it's
> just using a badly tested combination which is not helpful.
>=20
> So I'll send a patch to turn HIGH_RES_TIMERS on for the Rust CI, and we
> can debug this further without blocking them.

So we traced the problem down to possibly a misunderstanding between=20
decrementer clock event device and core code.

The decrementer is only oneshot*ish*. It actually needs to either be=20
reprogrammed or shut down otherwise it just continues to cause=20
interrupts.

Before commit 35de589cb879, it was sort of two-shot. The initial=20
interrupt at the programmed time would set its internal next_tb variable=20
to ~0 and call the ->event_handler(). If that did not set_next_event or=20
stop the timer, the interrupt will fire again immediately, notice=20
next_tb is ~0, and only then stop the decrementer interrupt.

So that was already kind of ugly, this patch just turned it into a hang.

The problem happens when the tick is stopped with an event still=20
pending, then tick_nohz_handler() is called, but it bails out because=20
tick_stopped =3D=3D 1 so the device never gets programmed again, and so it=20
keeps firing.

How to fix it? Before commit a7cba02deced, powerpc's decrementer was=20
really oneshot, but we would like to avoid doing that because it requires=20
additional programming of the hardware on each timer interrupt. We have=20
the ONESHOT_STOPPED state which seems to be just about what we want.

Did the ONESHOT_STOPPED patch just miss this case, or is there a reason=20
we don't stop it here? This patch seems to fix the hang (not heavily
tested though).
=20
Thanks,
Nick

---
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2d76c91b85de..7e13a55b6b71 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1364,9 +1364,11 @@ static void tick_nohz_handler(struct clock_event_dev=
ice *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
=20
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/* If we are tickless, change the clock event to stopped */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
=20
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);

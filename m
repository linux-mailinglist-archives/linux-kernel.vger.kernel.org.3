Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EB3516B77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359014AbiEBH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243888AbiEBH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:59:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C089C29CA9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 00:56:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651478162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSTsTvc0i3X+jcobiwC8b/0Z6n30nlP5evwaZXnZegM=;
        b=okjCS72WW/zgt3w/ziE/MMfsTjIrUSVQFO0RXs+GPl/L9V76kOYHdWayuBtXsDLniKL8Ql
        fuxxGyMEWoQRXwpt9aTog7sizd/eBmdS4MXUC/xyANVtDhkKF25G+YGNJaxRUfrS7rdkz5
        3vQp0XI3AuMI0qj0a+nB0r9ykYUuRSh4D1HRFMJ4sbxg8qhyNtItcVaLb1pOJqQlAWd6Zo
        lypOuA4db3vKV5IJxfqRabOuOHwLPuWmqkVuLieSGG2dnrnVQ9ojon6q/widLLXlcq7YUB
        gqveHUiRSirDtR1eyC7V9A8JTOtf55hOvMF0ycxnKoEhH/J+oM1weyXD7pmcNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651478162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSTsTvc0i3X+jcobiwC8b/0Z6n30nlP5evwaZXnZegM=;
        b=70uwt0LUFfpBzUcqZQ/4Uo/fGpZCStcsokrQ6yEFiIW3asCuHZJ7tZjUFw+tWrsCV8lmDV
        H81sBkHYEShx40DQ==
To:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Feng Tang <feng.tang@intel.com>,
        Bill Gray <bgray@redhat.com>, Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH 2/2] x86/tsc_sync: Add synchronization overhead to tsc
 adjustment
In-Reply-To: <b86038fe-43f8-4e16-f57d-8283b7da0bb4@redhat.com>
References: <20220314194630.1726542-1-longman@redhat.com>
 <20220314194630.1726542-3-longman@redhat.com> <87czhymql2.ffs@tglx>
 <d1a04785-4822-3a3f-5c37-81329a562364@redhat.com> <87levx8kou.ffs@tglx>
 <4f02fe46-b253-2809-0af7-f2e9da091fe9@redhat.com> <87czh50xwf.ffs@tglx>
 <68837b1a-f85b-e842-f8c0-1cad162856f4@redhat.com> <87h76ew3sb.ffs@tglx>
 <b86038fe-43f8-4e16-f57d-8283b7da0bb4@redhat.com>
Date:   Mon, 02 May 2022 09:56:01 +0200
Message-ID: <87a6c0nzam.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29 2022 at 13:41, Waiman Long wrote:
> On 4/27/22 18:38, Thomas Gleixner wrote:
>> I grant you that it does not matter for the loop under the assumption
>> that the loop runs at constant frequency, but is that a guarantee that
>> it does not matter later on?
> Yes, that is my point that frequency doesn't matter if frequency remain=20
> the same. Of course, all bets are off if frequency really change.

Frequency changes after boot.

>> If you overcompensate by a factor of 3 because the upcoming CPU ran at
>> the lowest frequency, then it might become visible later when everything
>> runs at full speed.
> I don't think the overhead will be directly proportional to the cpu=20
> frequency. A 3X increase in frequency will certainly cause the overhead=20
> to be lowered, but it won't be 1/3. Maybe 1/2 at most.

It's very close to proportional according to my experiments.

>>> However about we half the measure sync_overhead as compensation to avoid
>>> over-estimation, but probably increase the chance that we need a second
>>> adjustment of TSC wrap.
>> Half of what?
>
> What I mean is
>
> @@ -533,7 +551,7 @@ void check_tsc_sync_target(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * really depends on CPU=
, node distance and frequency. Add the
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * estimated sync overhe=
ad to the adjustment value.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur->adjusted +=3D cur_max_warp + s=
ync_overhead;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cur->adjusted +=3D cur_max_warp + s=
ync_overhead/2;

The point is? Make it magically half while it still jumps around:

>>> With this patch applied, the measured overhead on the same CooperLake
>>> system on different reboot runs varies from 104 to 326.
>> Half of something which jumps around? Not convinced. :)

...

> I have applied your patch with some modification and below was the=20
> relevant part of the boot up log on a Cooperlake system with this TSC=20
> sync problem.
>
> [=C2=A0=C2=A0=C2=A0 0.008858] smpboot: CPU 36 Converting physical 0 to lo=
gical die 2
> [=C2=A0=C2=A0=C2=A0 0.008858] Sync overhead: 230
> [=C2=A0=C2=A0=C2=A0 0.008858] Sync overhead: 547 A: 149597 M: 149596 F: 2=
500016
> [=C2=A0=C2=A0=C2=A0 0.008858] TSC ADJUST compensate: CPU36 observed 76342=
 warp=20
> (overhead 230). Adjust: 76457
> [=C2=A0=C2=A0=C2=A0 0.008858] smpboot: CPU 54 Converting physical 0 to lo=
gical die 3
> [=C2=A0=C2=A0=C2=A0 0.008858] Sync overhead: 178
> [=C2=A0=C2=A0=C2=A0 0.008858] Sync overhead: 658 A: 177970 M: 177968 F: 2=
500028
> [=C2=A0=C2=A0=C2=A0 0.008858] TSC ADJUST compensate: CPU54 observed 76568=
 warp=20
> (overhead 178). Adjust: 76657
>
> BTW, CPUs 36 and 54 are the first CPU of socket 2 and 3 respectively. It=
=20
> is always these CPUs that need TSC adjustment.
>
> I have no idea why the sync overhead actually increase in the subsequent=
=20
> measurement as the frequency was set at 2.5GHz, I think.

See, that's the thing I'm worried about. An allegedly remote lock takes
178 cycles, but a loop of cache local lock operations takes on average
658 cycles.

That does not make sense and I haven't seen that behaviour on any of my
machines I ran that on. The average was always less than the initial
measurement.

> I tried to offline all the CPUs in a socket and then online the first=20
> CPU as suggested. However, I was not able to cause the tsc_sync loop
> to run.

It runs for sure when the first CPU on a socket goes online except when
TSC is already disabled. It does not matter whether it was online before
or not.

> BTW, without my patch the same system will boot up with the following
> log:

We know that by now.

> How about we add the full sync_overhead at bootup stage, but then half=20
> sync_overhead after boot in case the tsc_sync loop is run again for new=20
> online CPUs? Or any other scheme that you think is appropriate.

Can you please stop grasping for straws?

I'm as much interested as you to get this solved, but I'm not interested
in 'works for me' and 'we don't know why it works' solutions simply
because they end up on my desk sooner than later again.

Thanks

        tglx

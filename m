Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2B55E200
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiF0O1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbiF0O1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:27:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD313F21;
        Mon, 27 Jun 2022 07:27:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EE5EB817CF;
        Mon, 27 Jun 2022 14:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EBEC3411D;
        Mon, 27 Jun 2022 14:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656340041;
        bh=TnJe5GtjYTivQDaip5nx0C9FQQe/W49iagWHzZpEVqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RJ1BibMLtKVYG/mbMot4Vmh/rnLk7kdmdwq3LkHswz6YkDJwPZJKlUL1OuW0dpCQD
         YKJ33EIEfNVVs6aBjrLGiT86XoIcikMSHksQPRRvVOdDR71ycoH8GTXXVfK8fV3Vdr
         fPdPBeLmqEpf3oMPAUDPgdy8i0sQAw8BmbyRy9nupzbIMs0CZyI91xmyH0a/QxAvpF
         IOhoNkozuR7eTx7KAnNGzlMlMH0S4xrQKAGrmHQAWFKYwF1t0LJ7bhHoo4Rd7dIHQX
         mLf1vucr+MTikDigGq4pxQYpmb5mXNv/znGWviXBqVljnyWjHqrodbvdpRwpod9m/T
         fNZJJzxSDuuqQ==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o5phv-003TLr-3j;
        Mon, 27 Jun 2022 15:27:19 +0100
MIME-Version: 1.0
Date:   Mon, 27 Jun 2022 15:27:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Dragan Mladjenovic <Dragan.Mladjenovic@syrmia.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2 07/12] clocksource: mips-gic-timer: Always use cluster
 0 counter as clocksource
In-Reply-To: <5ff65346-ba7b-c440-a7e7-73c84fe13165@syrmia.com>
References: <20220525121030.16054-1-Dragan.Mladjenovic@syrmia.com>
 <20220525121030.16054-8-Dragan.Mladjenovic@syrmia.com>
 <5ff65346-ba7b-c440-a7e7-73c84fe13165@syrmia.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <efc1d0884a821377ba007e7d77344260@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: Dragan.Mladjenovic@syrmia.com, tglx@linutronix.de, cfu@wavecomp.com, daniel.lezcano@linaro.org, geert@linux-m68k.org, gerg@kernel.org, hauke@hauke-m.de, ilya.lipnitskiy@gmail.com, jiaxun.yang@flygoat.com, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, paulburton@kernel.org, peterz@infradead.org, fancer.lancer@gmail.com, yangtiezhu@loongson.cn, tsbogend@alpha.franken.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-27 15:17, Dragan Mladjenovic wrote:
> On 25-May-22 14:10, Dragan Mladjenovic wrote:
>> From: Paul Burton <paulburton@kernel.org>
>> 
>> In a multi-cluster MIPS system we have multiple GICs - one in each
>> cluster - each of which has its own independent counter. The counters 
>> in
>> each GIC are not synchronised in any way, so they can drift relative 
>> to
>> one another through the lifetime of the system. This is problematic 
>> for
>> a clocksource which ought to be global.
>> 
>> Avoid problems by always accessing cluster 0's counter, using
>> cross-cluster register access. This adds overhead so we only do so on
>> systems where we actually have CPUs present in multiple clusters.
>> For now, be extra conservative and don't use gic counter for vdso or
>> sched_clock in this case.
>> 
>> Signed-off-by: Paul Burton <paulburton@kernel.org>
>> Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
>> Signed-off-by: Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>
>> 
>> diff --git a/drivers/clocksource/mips-gic-timer.c 
>> b/drivers/clocksource/mips-gic-timer.c
>> index be4175f415ba..6632d314a2c0 100644
>> --- a/drivers/clocksource/mips-gic-timer.c
>> +++ b/drivers/clocksource/mips-gic-timer.c
>> @@ -170,6 +170,37 @@ static u64 gic_hpt_read(struct clocksource *cs)
>>   	return gic_read_count();
>>   }
>>   +static u64 gic_hpt_read_multicluster(struct clocksource *cs)
>> +{
>> +	unsigned int hi, hi2, lo;
>> +	u64 count;
>> +
>> +	mips_cm_lock_other(0, 0, 0, CM_GCR_Cx_OTHER_BLOCK_GLOBAL);
>> +
>> +	if (mips_cm_is64) {
>> +		count = read_gic_redir_counter();
>> +		goto out;
>> +	}
>> +
>> +	hi = read_gic_redir_counter_32h();
>> +	while (true) {
>> +		lo = read_gic_redir_counter_32l();
>> +
>> +		/* If hi didn't change then lo didn't wrap & we're done */
>> +		hi2 = read_gic_redir_counter_32h();
>> +		if (hi2 == hi)
>> +			break;
>> +
>> +		/* Otherwise, repeat with the latest hi value */
>> +		hi = hi2;
>> +	}
>> +
>> +	count = (((u64)hi) << 32) + lo;
>> +out:
>> +	mips_cm_unlock_other();
>> +	return count;
>> +}
>> +
>>   static struct clocksource gic_clocksource = {
>>   	.name			= "GIC",
>>   	.read			= gic_hpt_read,
>> @@ -204,6 +235,11 @@ static int __init __gic_clocksource_init(void)
>>   	/* Calculate a somewhat reasonable rating value. */
>>   	gic_clocksource.rating = 200 + gic_frequency / 10000000;
>>   +	if (mips_cps_multicluster_cpus()) {
>> +		gic_clocksource.read = &gic_hpt_read_multicluster;
>> +		gic_clocksource.vdso_clock_mode = VDSO_CLOCKMODE_NONE;
>> +	}
>> +
>>   	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
>>   	if (ret < 0)
>>   		pr_warn("Unable to register clocksource\n");
>> @@ -262,7 +298,8 @@ static int __init gic_clocksource_of_init(struct 
>> device_node *node)
>>   	 * stable CPU frequency or on the platforms with CM3 and CPU 
>> frequency
>>   	 * change performed by the CPC core clocks divider.
>>   	 */
>> -	if (mips_cm_revision() >= CM_REV_CM3 || 
>> !IS_ENABLED(CONFIG_CPU_FREQ)) {
>> +	if ((mips_cm_revision() >= CM_REV_CM3 || 
>> !IS_ENABLED(CONFIG_CPU_FREQ)) &&
>> +	     !mips_cps_multicluster_cpus()) {
>>   		sched_clock_register(mips_cm_is64 ?
>>   				     gic_read_count_64 : gic_read_count_2x32,
>>   				     64, gic_frequency);
> 
> Hi,
> 
> I was expecting some comments on this, but I'll ask first. We now
> taking a conservative approach of not using gic as sched_clock in
> multicluster case. Is this necessary or can sched_clock tolerate a
> fixed delta between clocks on different cpu clusters?

I don't think that's wise. We generally go into all sort of
troubles to keep sched_clock() strictly identical between CPUs,
and there are tons of things that rely on this (the scheduler
itself, but any sort of tracing...). You just have to grep
for the various use cases.

A consequence of the above is that the kernel can (and will)
snapshot a sched_clock value, and compare it to the value on
the current CPU. Imagine what happens if the difference is
negative...

So I don't know what the deal is with the MIPS GIC, but if any
of the above can happen, you're doomed.

         M.
-- 
Jazz is not dead. It just smells funny...

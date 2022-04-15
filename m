Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C378502087
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348705AbiDOCeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348706AbiDOCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:33:56 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB393A5F0;
        Thu, 14 Apr 2022 19:31:26 -0700 (PDT)
X-UUID: 149aa723d4ab405889f2674279dab145-20220415
X-UUID: 149aa723d4ab405889f2674279dab145-20220415
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2035343171; Fri, 15 Apr 2022 10:31:19 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 15 Apr 2022 10:31:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 Apr
 2022 10:31:18 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 Apr 2022 10:31:18 +0800
Message-ID: <3fc36d6b803ff3e1bef601839aaca3f4f03e62ad.camel@mediatek.com>
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Kevin Hilman <khilman@baylibre.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 15 Apr 2022 10:31:18 +0800
In-Reply-To: <7hbkx3fiac.fsf@baylibre.com>
References: <7hbkx3fiac.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-14 at 14:48 -0700, Kevin Hilman wrote:
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> 
> > On Wed, 2022-04-13 at 14:41 -0700, Kevin Hilman wrote:
> > > Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> > > 
> > > [...]
> > > 
> > > > From the Chanwoo's devfreq passive govonor series, it's
> > > > impossible
> > > > to
> > > > let cci devreq probed done before cpufreq because the passive
> > > > govonor
> > > > will search for cpufreq node and use it.
> > > > 
> > > > Ref: function: cpufreq_passive_register_notifier()
> > > > 
> > > > 
> > 
> > 
https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/commit/?h=devfreq-testing&id=b670978ddc43eb0c60735c3af6e4a370603ab673__;!!CTRNKA9wMg0ARbw!z58Lc1p9REo88oHn-NkxroN_fBd0TsHYmhscNZwnWwT71ecRkTeqZ6vFl5l7HpkTdM6t$
> > > >  
> > > 
> > > Well this is a problem, because CCI depends on CPUfreq, but
> > > CPUfreq
> > > depends on CCI, so one of them has to load and then wait for the
> > > other.
> > > 
> > > > After I discuss with Angelo and Jia-wei, we think we are
> > > > keeping
> > > > the
> > > > function in target_index and if the cci is not ready we will
> > > > use
> > > > the
> > > > voltage which is set by bootloader to prevent high freqeuncy
> > > > low
> > > > voltage crash. And then we can keep seting the target
> > > > frequency.
> > > > 
> > > 
> > >  > We assume the setting of bootloader is correct and we can do
> > > this.
> > > 
> > > I'm still not crazy about this because you're lying to the
> > > CPUfreq
> > > framework.  It's requesting one OPP, but you're not setting that,
> > > you're
> > > just keeping the bootloader frequency.
> > > 
> > > In my earlier reply, I gave two other options for handling this.
> > > 
> > > 1) set a (temporary) constraint on the voltage regulator so that
> > > it
> > > cannot change.
> > > 
> > > or more clean, IMO:
> > > 
> > > 2) set a CPUfreq policy that restricts available OPPs to ones
> > > that
> > > will
> > > not break CCI.
> > > 
> > > Either of these solutions allow you to load the CPUfreq driver
> > > early,
> > > and then wait for the CCI driver to be ready before removing the
> > > restrictions.
> > 
> > Hello Kevin,
> > 
> > I think I do not describe this clearly.
> > The proposal is:
> > 
> > In cpufreq probe:
> > we record the voltage value which is set by bootloader.
> > 
> > In mtk_cpufreq_set_target():
> > We do NOT directly return 0.
> > Instead, we will find the voltage of target cpufreq and use the
> > value
> > max(booting voltage, target cpufreq voltage)
> > 
> > mtk_cpufreq_set_target() {
> > 	/* NOT return 0 if !is_ccifreq_ready */
> > 	....
> > 	vproc = get voltage of target cpufreq from opp.
> > 
> > 	if (ccifreq_supported && !is_ccifreq_ready)
> > 		vproc = max(vproc, vproc_on_boot)
> > 
> > 	//setting voltage and target frequency
> > 	....
> > }
> 
> You explained this well, but it's still not an appropriate solution
> IMO,
> because you're still not setting the target that is requested by the
> CPUfreq core.
> 
> The job of ->set_target() is to set the frequency *requested by
> CPUfreq
> core*.  If you cannot do that, you should return failure.  What you
> posted
> in the original patch and what you're proposing here is to ignore the
> frequency passed to ->set_target() and do something else.  In the
> orignal patch, you propose do to nothing.  Now, you're ignoring the 
> target passed in and setting something else.  In both cases, the
> CPUfreq
> core things you have successfuly set the frequency requested, but you
> have not.  This means there's a mismatch between what the CPUfreq
> core &
> governer things the frequency is and what is actually set.  *This* is
> the part that I think is wrong.
> 
> Instead, the proper way of restricting available frequencies is to
> use
> governors or policies.  This ensures that the core & governors are
> aligned with what the platform driver actually does.
> 
> As I proposed earlier, I think a clean solution to this problem is to
> create a temporary policy at probe time that restricts the available
> OPPs based on what the current CCI freq/voltage are.  Once CCI driver
> is
> loaded and working, this policy can be removed.
> 
> Kevin
> 
> 

Hello Kevin,

In new proposal, we DO set the cpufreq passed by cpufreq core.
We just not set the corresponding voltage of target frequency which
is lookedup from opp table.
Actually, because of the shared regulator, corresponding voltage is
not always set.

I take this for example:
----------
Assumption:
- The opp table and voltage in this example are just a example,
  and it is not for any actual SoCs.
- We just use one regulator instead of two. (like proc and sram)
- cpufreq and mediatek cci devfreq share the same regulator_0.

OPP table for cpufreq:
target freq => min reguired voltage
2.0GHz => 1.0V
1.8GHZ => 0.9V
1.5GHz => 0.6V

OPP table for mediatek cci devfreq:
target freq => min reguired voltage
1.4GHz => 1.2V
1.0GHz => 0.8V

1. For normal case:
   (regulator_0 is already registered by cpufreq and cci)
   - When the cpufreq want to adjust to 1.5GHz, from the opp table the
     voltage sholud be 0.6V.
   - When the cci want to adjust to 1.4GHz, from the opp table the
     voltage sholud be 1.2V.
   - cpufreq driver use the regulator_set_voltage() to set the
     voltage, but the function will use 1.2V(ref:[1])

2. For our new proposed solution:
   (regulator_0 is registered by cpufreq but is not registered by cci)
   - Assume the freqs when booting to kernel are:
     1.8GHz for cpufreq (min 0.9V) and 1.0GHz for cci (min 0.8V).
     The voltage when booting to kernel(voltage_on_boot) should be 0.9V
	 to let cpufreq and cci work correctly.
   - When cpufreq want to set target freq to 1.5GHz the voltage from
     opp table is 0.6V and we compare this voltage with
voltage_on_boot(0.9V).
	 We will choose the max voltage 0.9V to prevent crash issue.
	 (This is original covered by regulator_set_voltage()
	  if regulator_0 is registered by both cci and cpufre.)
	- When the voltage is choosed, we will set the cpufreq to
1.5GHz while
	  the voltage is safe for both cpufreq and cci.
----------

In summary, we think it's a proper solution to cover the situation
when cci is not probed.

I think there is something to improve:
We can choose to lookup cci opp table using cci freq to determine
the voltage instead of voltage_on_boot.
But IMO, it's not neccessary to register cci opp table inside cpufreq
driver just for the short period.

Because I finish to prepare other patches and I think we also can
take a look at other patches which are including some cleanup, I will
send next version today.
If there is any concern and question, we can discuss in next version.

Thanks for your big support!

[1]:
https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L4022

BRs,
Rex


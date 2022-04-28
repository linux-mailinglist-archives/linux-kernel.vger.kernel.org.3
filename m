Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42538513245
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiD1LUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbiD1LUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:20:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD9E52B12;
        Thu, 28 Apr 2022 04:16:41 -0700 (PDT)
X-UUID: 99dcd6c7b8c14047b1fc936b4ede6ca6-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:6ce3acf7-14bd-4058-bdb1-c51983d16a9b,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:8c8dd3c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 99dcd6c7b8c14047b1fc936b4ede6ca6-20220428
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2020644970; Thu, 28 Apr 2022 19:16:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 28 Apr 2022 19:16:33 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 19:16:32 +0800
Message-ID: <346736a339bed576817179ded3795d61f71fa06a.camel@mediatek.com>
Subject: Re: [PATCH V4 07/14] cpufreq: mediatek: Add .get function
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <jia-wei.chang@mediatek.com>,
        <roger.lu@mediatek.com>, <hsinyi@google.com>,
        <khilman@baylibre.com>, <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 28 Apr 2022 19:16:32 +0800
In-Reply-To: <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-8-rex-bc.chen@mediatek.com>
         <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
         <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
         <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
         <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
         <20220427031141.or2owu5wrh2cadfo@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-27 at 08:41 +0530, Viresh Kumar wrote:
> On 26-04-22, 19:13, Rex-BC Chen wrote:
> > We have a non-upstream driver which tries to get frequency by
> > 'cpufreq_get'.
> 
> This is the right thing to do there.
> 
> > When we use that non-upstream driver, 'cpufreq_verify_current_freq'
> > will be further invoked by 'cpufreq_get' and it would cause voltage
> > pulse issue as I described previously.
> 
> I see this will eventually resolve to __cpufreq_driver_target(),
> which
> should return without any frequency updates.
> 

Hello Viresh,

Yes, the call stack will eventually go to __cpufreq_driver_target.
However, we can observe the mismatch between target_freq and policy-cur 
with a tiny difference.
e.g.
[ 553.065356] cpufreq: target for CPU 0: 500000 kHz, relation 0,
requested 500000 kHz
[ 553.066366] cpufreq: target_freq/policy->cur: 500000/499999 kHz

We check the assignment of policy->cur could be either from
cpufreq_driver->get_intermediate or from cpufreq_driver->get.
But it is strange to have the frequency value like 499999 kHz.
Is the result of tiny frequency difference expected from your point of
view?

> What do you mean by "voltage pulse" here? What actually happens which
> you want to avoid.
> 

When cpufreq is fixed to lowest opp, "voltage pulse" is a quick voltage
rising and falling phenomenon which can be observed if 'cpufreq_get' is
invoked.
From top of view, if 'cpufreq_get' is NOT invoked in that condition,
the voltage pulse will no longer occur.
That's why we add this patch for this series.

> > Therefore, we apply the solution in this series.
> 
> I won't call it a solution but a Bug as .get() is supposed to read
> real freq of the hardware.
> 
> > Recently, we found that using 'cpufreq_generic_get' directly in our
> > non-upstream driver can do the same thing without pulse issue.
> 
> That would be an abuse of the cpufreq_generic_get() API. It is ONLY
> allowed to be used while setting .get callback in the driver.
> 

Thank you for sharing the correct information.
Is it possible to get frequency (API) a simple way, like get current
opp frequency?

BRs,
Rex


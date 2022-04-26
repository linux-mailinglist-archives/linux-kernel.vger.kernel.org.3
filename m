Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDDE50FBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349452AbiDZLQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiDZLQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:16:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D4A155718;
        Tue, 26 Apr 2022 04:13:35 -0700 (PDT)
X-UUID: d7dfa7577f97488fa3da5b91bcbc977d-20220426
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:0a80d0a3-5084-49e1-be28-af18ac120d1e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:790689c6-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: d7dfa7577f97488fa3da5b91bcbc977d-20220426
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1466788043; Tue, 26 Apr 2022 19:13:28 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 26 Apr 2022 19:13:27 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Apr
 2022 19:13:26 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Apr 2022 19:13:26 +0800
Message-ID: <078b1f9b39690da98cbd3c4528ba28374a097083.camel@mediatek.com>
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
Date:   Tue, 26 Apr 2022 19:13:26 +0800
In-Reply-To: <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
References: <20220422075239.16437-1-rex-bc.chen@mediatek.com>
         <20220422075239.16437-8-rex-bc.chen@mediatek.com>
         <20220425053548.72w2jh2g6lpzgz6g@vireshk-i7>
         <64c690e8edf493ec0a4a14e0fdaad2d8e88e6da7.camel@mediatek.com>
         <20220425100058.4kbvmpi63ygni6k5@vireshk-i7>
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

On Mon, 2022-04-25 at 15:30 +0530, Viresh Kumar wrote:
> On 25-04-22, 17:34, Rex-BC Chen wrote:
> > We found that the pulses of cpu voltage could be observed when
> > frequency is fixed (scaling_max_freq == scaling_min_freq) if using
> > cpufreq_generic_get as '.get' callback in MT8186.
> > cpufreq framework will constantly (~ 1 sec) call 'update' if the
> > policy
> 
> Which function gets called here in that case ? I would expect
> cpufreq_driver_target() to not make a call to MTK driver in that
> case, after it
> finds that new and old frequency are same (it will check the
> corresponding freq
> from cpufreq table).
> 
> > frequency is NOT equal to hardware frequency in
> > cpufreq_verify_current_freq.
> > The problem is that there might be a tiny difference between the
> > policy
> > frequency and the hardware frequency even they are very close.
> > e.g. policy frequency is 500,000,000 Hz however, hardware frequency
> > is
> > 499,999,726 Hz for MT8186 opp15.
> > 
> > To prevent the voltage pulses, we currently use the software cached
> > values as you pointed out.
> > I wonder is it possible to add a tolerence for checking difference
> > between policy frequency and hardware frequency in cpufreq
> > framework so
> > that we can use cpufreq_generic_get as callback without pulse
> > issue.
> > Or any suggestion would be appreciated.
> 
> 

Hello Viresh,

We have a non-upstream driver which tries to get frequency by
'cpufreq_get'.
When we use that non-upstream driver, 'cpufreq_verify_current_freq'
will be further invoked by 'cpufreq_get' and it would cause voltage
pulse issue as I described previously.
Therefore, we apply the solution in this series.

Recently, we found that using 'cpufreq_generic_get' directly in our
non-upstream driver can do the same thing without pulse issue.
It can meet your request as well.

So here, for cpufreq, I think it is proper to drop this patch and I
will do it in the next version.

Thanks for your review.

BRs,
Rex


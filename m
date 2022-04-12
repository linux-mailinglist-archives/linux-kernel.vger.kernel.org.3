Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE94FE14C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351082AbiDLM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355250AbiDLMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:53:55 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF47EF7;
        Tue, 12 Apr 2022 05:26:15 -0700 (PDT)
X-UUID: 1169b8e3297a45ce80bbb58ed31e58a4-20220412
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:965c7447-afd0-4661-ae77-ff0adbeb80eb,OB:0,LO
        B:0,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:25
X-CID-META: VersionHash:faefae9,CLOUDID:cccee7a8-d103-4e36-82b9-b0e86991b3df,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 1169b8e3297a45ce80bbb58ed31e58a4-20220412
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 909156321; Tue, 12 Apr 2022 20:26:08 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Apr 2022 20:26:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Apr 2022 20:26:06 +0800
Message-ID: <f00e3df2e270e5edc160f8ff1bd8c52a49bf71d5.camel@mediatek.com>
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
Date:   Tue, 12 Apr 2022 20:26:06 +0800
In-Reply-To: <7hwnfv4hfr.fsf@baylibre.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
         <20220408045908.21671-14-rex-bc.chen@mediatek.com>
         <7hfsmn5m9f.fsf@baylibre.com>
         <bc6dd020a1cc3f00f5be2bf2929046b9116bbeef.camel@mediatek.com>
         <7hwnfv4hfr.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-11 at 11:13 -0700, Kevin Hilman wrote:
> Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> 
> > On Fri, 2022-04-08 at 13:54 -0700, Kevin Hilman wrote:
> > > Rex-BC Chen <rex-bc.chen@mediatek.com> writes:
> > > 
> > > > From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > > 
> > > > In some MediaTek SoCs, like MT8183, CPU and CCI share the same
> > > > power
> > > > supplies. Cpufreq needs to check if CCI devfreq exists and wait
> > > > until
> > > > CCI devfreq ready before scaling frequency.
> > > > 
> > > > - Add is_ccifreq_ready() to link CCI device to CPI, and CPU
> > > > will
> > > > start
> > > >   DVFS when CCI is ready.
> > > > - Add platform data for MT8183.
> > > > 
> > > > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > 
> > > The checks here are not enough, and will lead to unexpected
> > > behavior.
> > > IIUC, before doing DVFS, you're checking:
> > > 
> > > 1) if the "cci" DT node is present and
> > > 2) if the driver for that device is bound
> > > 
> > > If both those conditions are not met, you don't actually fail,
> > > you
> > > just
> > > silently do nothing in ->set_target().  As Angelo pointed out
> > > also,
> > > this
> > > is not a good idea, and will be rather confusing to users.
> > > 
> > > The same thing would happen if the cci DT node was present, but
> > > the
> > > CCI
> > > devfreq driver was disabled.  Silent failure would also be quite
> > > unexpected behavior.  Similarily, if the cci DT node is not
> > > present
> > > at
> > > all (like it is in current upstream DT), this CPUfreq driver will
> > > silently do nothing.  Not good.
> > > 
> > > So, this patch needs to handle several scenarios:
> > > 
> > > 1) CCI DT node not present
> > > 
> > > In this case, the driver should still operate normally.  With no
> > > CCI
> > > node, or driver there's no conflict.
> > > 
> > > 2) CCI DT present/enabled but not yet bound
> > > 
> > > In this case, you could return -EAGAIN as suggested by Angelo, or
> > > maybe
> > > better, it should do a deferred probe.
> > > 
> > > 3) CCI DT present, but driver disabled
> > > 
> > > This case is similar to (1), this driver should continue to work.
> > > 
> > > Kevin
> > 
> > Hello Kevin and Angelo,
> > 
> > In my review, if we do not get the link or the link status is not
> > correct between cci and cpufreq in target_index, I think it will
> > never
> > established again for this link.
> > Because it's not checked in probe stage.
> > 
> > So I think we just need to deal with the issue without cci device,
> > and
> > don't expect the link between cci and cpufreq will be connected
> > again.
> > 
> > If I am wrong, please correct me.
> 
> I don't fully understand your questions, but I think what your
> getting
> at suggest that you might need to use deferred probe to handle the
> case
> where the ordering of CCI and cpufreq probing is not predictable.
> 
> Kevin

Hello Kevin and Angelo,

I can summary what I got now:

1. Why we need cci for cpufreq in MT8183 and MT8186:
   a. CCI is a mediatek hw module.
   b. For mediatek SoCs before MT8183, like MT8173, the CCI hw
      is not introduced.
   c. The frequency for cci and cpufreq are determined could
      be configed at bootloader stage, so the frequency when
      entering kernel is unknown.
   d. Cpu little core and cci are using the same regulator.
   e. If we do not control CCI and just adjust the voltage in
      cpufreq driver.
      When we adjust the voltage smaller because we need to reduce
      the frequency, the CCI could run in high frequency which is
      set in bootloader.
      This will cause some problem, the cci could crash.

      Use MT8186 for a example, the bootloader set cci freq as
      1.385GHz and cpufreq as 2GHz.
      If entering kernel and we only adjust the cpufreq voltage, if
      the cpufreq is under 1.618GHz, the cci will be out of spec.
      You can refer to the chrome project bootloader "Coreboot" patch:
      
https://review.coreboot.org/c/coreboot/+/59569/2/src/mainboard/google/corsola/romstage.c

   f. If cpufreq driver wait cci ready, regulator framework will take
      the highest voltage requests from cci and cpufreq as output
      so that it prevents from high freqeuncy low voltage crash.
   d. Therefore, I think it's not a good idea to bypass cci device if
      the ccifreq_supported is true in MT8183 and MT8186.

2. Check the device link status is DL_DEV_DRIVER_BOUND is used for
   promising the cci is probed done.

3. About the cpufreq_driver->target_index
   a. When I trace the common drivers, I found if the return value is
      not zero, it will be BUG_ON.
      ref:
https://elixir.bootlin.com/linux/latest/source/drivers/cpufreq/cpufreq.c#L1471
   b. I also try to move is_ccifreq_ready() to other place, like
      cpufreq_driver->init and cpufreq probe function.
      There will be new issue. Do you have any suggetion that we can
      retern value of DEFER_PROBE?

BRs,
Rex


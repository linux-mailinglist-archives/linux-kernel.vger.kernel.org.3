Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A0E509C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387642AbiDUJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiDUJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:31:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20EC27FED;
        Thu, 21 Apr 2022 02:28:42 -0700 (PDT)
X-UUID: cf98e13ca3e946fe8a34fd1b5d5f830e-20220421
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fc5ddcd6-c240-4824-9a46-f3a202e054c3,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:188379f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: cf98e13ca3e946fe8a34fd1b5d5f830e-20220421
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1368554041; Thu, 21 Apr 2022 17:28:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 21 Apr 2022 17:28:35 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Apr 2022 17:28:35 +0800
Message-ID: <3d463c8b099fdb1c9a0df9e615a8ca1d8a034120.camel@mediatek.com>
Subject: Re: [PATCH v24 0/7] soc: mediatek: SVS: introduce MTK SVS
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
Date:   Thu, 21 Apr 2022 17:28:35 +0800
In-Reply-To: <7hczhbe3wn.fsf@baylibre.com>
References: <20220420102044.10832-1-roger.lu@mediatek.com>
         <7hczhbe3wn.fsf@baylibre.com>
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

Hi Kevin,

On Wed, 2022-04-20 at 16:22 -0700, Kevin Hilman wrote:
> Hi Roger,
> 
> 
> Roger Lu <roger.lu@mediatek.com> writes:
> 
> > The Smart Voltage Scaling(SVS) engine is a piece of hardware
> > which calculates suitable SVS bank voltages to OPP voltage table.
> > Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> > when receiving OPP_EVENT_ADJUST_VOLTAGE.
> > 
> > 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> > 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by
> > get_cpu_device().
> > After retrieving subsys device, SVS driver calls device_link_add() to make
> > sure probe/suspend callback priority.
> > 
> > [1] 
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp*linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5__;Lw!!CTRNKA9wMg0ARbw!3gWsdVuiyF0iafrmVINP9FVz7fjGB1UqTPLfMNWEhsl96RDPB-Se6Q-g3F8daK-u$
> >  
> > [2] 
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp*linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87__;Lw!!CTRNKA9wMg0ARbw!3gWsdVuiyF0iafrmVINP9FVz7fjGB1UqTPLfMNWEhsl96RDPB-Se6Q-g3Lel3h4j$
> >  
> > [3] 
> > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next*dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2__;Lw!!CTRNKA9wMg0ARbw!3gWsdVuiyF0iafrmVINP9FVz7fjGB1UqTPLfMNWEhsl96RDPB-Se6Q-g3KhMdm00$
> >  
> > 
> > Change since v23:
> > - Change wording from "Mediatek" to "MediaTek" (uppercase T) in mtk-
> > svs.yaml.
> > - Use cpuidle_pause_and_lock() to prevent system from entering cpuidle
> > instead of applying pm_qos APIs.
> > - Add kfree() at the end of svs_probe() when encountering probe fail.
> > - Change MODULE_LICENSE from "GPL v2" to "GPL".
> > - Add nvmem_cell_put() in error handling when nvmem_cell_read() encounters
> > fail.
> 
> I also gave you a reviewed-by on v23, but here it is again:
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> 
> 
> That being said, it would be really nice to see an integration tree
> where this was all tested on mainline (e.g. v5.17, or v5.18-rc)
> 
> For example, I can apply this to v5.18-rc2 and boot on my mt8183-pumpkin
> board, it fails to probe[1] because there is no CCI node in the upstream
> mt8183.dtsi.
> 
> I'm assuming this series is also not very useful without the CPUfreq
> series from Rex, so being able to test this, CCI and CPUfreq together on
> MT8183 on a mainline kernel would be very helpful.
> 
> Kevin
> 
> [1]
> [    0.573332] mtk-svs 1100b000.svs: cannot find cci node
> [    0.574061] mtk-svs 1100b000.svs: error -ENODEV: svs platform probe fail

Just share. I've tested this series on below two platforms and it works as
expected.
- mt8183-Krane (kernel-v5.10)
- mt8192-Hayato (kernel-v5.4)

Sincerely,
Roger Lu.


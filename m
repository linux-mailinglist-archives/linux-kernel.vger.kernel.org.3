Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C234DD918
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiCRLkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbiCRLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:40:00 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962E49FA9;
        Fri, 18 Mar 2022 04:38:35 -0700 (PDT)
X-UUID: bb2d225d082942c08a700be84e0d674c-20220318
X-UUID: bb2d225d082942c08a700be84e0d674c-20220318
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 354714786; Fri, 18 Mar 2022 19:38:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Mar 2022 19:38:29 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 19:38:29 +0800
Message-ID: <1848fcaa4be6fba1b8dd821791077ae3b2f647d4.camel@mediatek.com>
Subject: Re: [PATCH v4] remoteproc: mediatek: Fix side effect of mt8195 sram
 power on
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 18 Mar 2022 19:38:29 +0800
In-Reply-To: <20220317162509.GA2630429@p14s>
References: <20220316031117.7311-1-tinghan.shen@mediatek.com>
         <20220316163451.GA2546942@p14s>
         <8a7be596-531a-52f4-c1b0-ed1d23cfa1bb@collabora.com>
         <20220317162509.GA2630429@p14s>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Thu, 2022-03-17 at 10:25 -0600, Mathieu Poirier wrote:
> On Wed, Mar 16, 2022 at 05:44:04PM +0100, AngeloGioacchino Del Regno wrote:
> > Il 16/03/22 17:34, Mathieu Poirier ha scritto:
> > > Good morning,
> > > 
> > > On Wed, Mar 16, 2022 at 11:11:17AM +0800, Tinghan Shen wrote:
> > > > The definition of L1TCM_SRAM_PDN bits on mt8195 is different to mt8192.
> > > > 
> > > > L1TCM_SRAM_PDN bits[3:0] control the power of mt8195 L1TCM SRAM.
> > > > 
> > > > L1TCM_SRAM_PDN bits[7:4] control the access path to EMI for SCP.
> > > > These bits have to be powered on to allow EMI access for SCP.
> > > > 
> > > > Bits[7:4] also affect audio DSP because audio DSP and SCP are
> > > > placed on the same hardware bus. If SCP cannot access EMI, audio DSP is
> > > > blocked too.
> > > > 
> > > > L1TCM_SRAM_PDN bits[31:8] are not used.
> > > > 
> > > > This fix removes modification of bits[7:4] when power on/off mt8195 SCP
> > > > L1TCM. It's because the modification introduces a short period of time
> > > > blocking audio DSP to access EMI. This was not a problem until we have
> > > > to load both SCP module and audio DSP module. audio DSP needs to access
> > > > EMI because it has source/data on DRAM. Audio DSP will have unexpected
> > > > behavior when it accesses EMI and the SCP driver blocks the EMI path at
> > > > the same time.
> > > > 
> > > > Fixes: 79111df414fc ("remoteproc: mediatek: Support mt8195 scp")
> > > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > > > ---
> > > > v4: add Fixes and Reviewed-by tags
> > > > v3: fix build error
> > > > v2: apply comments about macro definition and function calls
> > > > ---
> > > >   drivers/remoteproc/mtk_common.h |  2 ++
> > > >   drivers/remoteproc/mtk_scp.c    | 67 +++++++++++++++++++++++++++++++----------
> > > >   2 files changed, 53 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> > > > index 5ff3867c72f3..ff954a06637c 100644
> > > > --- a/drivers/remoteproc/mtk_common.h
> > > > +++ b/drivers/remoteproc/mtk_common.h
> > > > @@ -51,6 +51,8 @@
> > > >   #define MT8192_CORE0_WDT_IRQ		0x10030
> > > >   #define MT8192_CORE0_WDT_CFG		0x10034
> > > > +#define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
> > > > +
> > > >   #define SCP_FW_VER_LEN			32
> > > >   #define SCP_SHARE_BUFFER_SIZE		288
> > > > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > > > index 36e48cf58ed6..5f686fe09203 100644
> > > > --- a/drivers/remoteproc/mtk_scp.c
> > > > +++ b/drivers/remoteproc/mtk_scp.c
> > > > @@ -365,22 +365,22 @@ static int mt8183_scp_before_load(struct mtk_scp *scp)
> > > >   	return 0;
> > > >   }
> > > > -static void mt8192_power_on_sram(void __iomem *addr)
> > > > +static void scp_sram_power_on(void __iomem *addr, u32 reserved_mask)
> > > 
> > > Why is @reserved_mask needed?  It is not described in the changelong and as far
> > > as I can see in this patchset the parameter is always set to '0', which has no
> > > effect on the mask that gets generated.
> > > 
> > 
> > Hello Mathieu,
> > the @reserved_mask is explained in perhaps not very very clear terms, meaning
> > that he's not explicitly saying the name of the new param, but that's it:
> > 
> > "This fix removes modification of bits[7:4] when power on/off mt8195 SCP
> > L1TCM."
> > 
> > ....and it's actually being used, check below....
> > 
> > > Thanks,
> > > Mathieu
> > > 
> > > >   {
> > > >   	int i;
> > > >   	for (i = 31; i >= 0; i--)
> > > > -		writel(GENMASK(i, 0), addr);
> > > > +		writel(GENMASK(i, 0) & ~reserved_mask, addr);
> > > >   	writel(0, addr);
> > > >   }
> > > > -static void mt8192_power_off_sram(void __iomem *addr)
> > > > +static void scp_sram_power_off(void __iomem *addr, u32 reserved_mask)
> > 
> > ...snip...
> > 
> > > > +static int mt8195_scp_before_load(struct mtk_scp *scp)
> > > > +{
> > > > +	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
> > > > +	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
> > > > +
> > > > +	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
> > > > +
> > > > +	/* enable SRAM clock */
> > > > +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> > > > +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> > > > +	scp_sram_power_on(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > 
> > 
> > > > +	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> > > > +			  MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> > 
> > here	
> 
> Yes - it's obvious now that you point it out.  
> 
> This patch conflicts with the newly added support for mt8186[1].  I tried to fix
> it but did not know if mt8185 needed the same kind of bit masking as mt8195.
> Please have a look and rebase to rproc-next.
> 
> Thanks,
> Mathieu

Ok, I'll rebase to rproc-next at next version.
Thank you!


Best regards,
TingHan

> 
> [1]. 80d691854ffb remoteproc: mediatek: Support mt8186 scp
> 
> > 
> > > > +	scp_sram_power_on(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> > > >   	/* enable MPU for all memory regions */
> > > >   	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
> > 
> > ...snip...
> > 
> > > > +
> > > > +static void mt8195_scp_stop(struct mtk_scp *scp)
> > > > +{
> > > > +	/* Disable SRAM clock */
> > > > +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_0, 0);
> > > > +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_1, 0);
> > > > +	scp_sram_power_off(scp->reg_base + MT8192_L2TCM_SRAM_PD_2, 0);
> > > > +	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
> > > > +			   MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS);
> > 
> > and here 			^^^^^^^^
> > 
> > > > +	scp_sram_power_off(scp->reg_base + MT8192_CPU0_SRAM_PD, 0);
> > 
> > Cheers,
> > Angelo


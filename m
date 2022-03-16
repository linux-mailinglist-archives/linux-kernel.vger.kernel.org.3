Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65DE4DA78F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353016AbiCPBuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353008AbiCPBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:50:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE455E157;
        Tue, 15 Mar 2022 18:48:58 -0700 (PDT)
X-UUID: 926dba9c6db54f90aa966f99697e9a0e-20220316
X-UUID: 926dba9c6db54f90aa966f99697e9a0e-20220316
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2009940203; Wed, 16 Mar 2022 09:48:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Mar 2022 09:48:53 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Mar 2022 09:48:53 +0800
Message-ID: <9b9d1cb4c606a051ffc2e926d40a7af33004aaf6.camel@mediatek.com>
Subject: Re: [PATCH v3] remoteproc: mediatek: fix side effect of mt8195 sram
 power on
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 16 Mar 2022 09:48:53 +0800
In-Reply-To: <36e7847e-56ed-8768-388e-c6a00a2cb0ec@collabora.com>
References: <20220314111806.28168-1-tinghan.shen@mediatek.com>
         <36e7847e-56ed-8768-388e-c6a00a2cb0ec@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Mon, 2022-03-14 at 12:31 +0100, AngeloGioacchino Del Regno wrote:
> Il 14/03/22 12:18, Tinghan Shen ha scritto:
> > The definition of L1TCM_SRAM_PDN bits on mt8195 is different to mt8192.
> > 
> > L1TCM_SRAM_PDN bits[3:0] control the power of mt8195 L1TCM SRAM.
> > 
> > L1TCM_SRAM_PDN bits[7:4] control the access path to EMI for SCP.
> > These bits have to be powered on to allow EMI access for SCP.
> > 
> > Bits[7:4] also affect audio DSP because audio DSP and SCP are
> > placed on the same hardware bus. If SCP cannot access EMI, audio DSP is
> > blocked too.
> > 
> > L1TCM_SRAM_PDN bits[31:8] are not used.
> > 
> > This fix removes modification of bits[7:4] when power on/off mt8195 SCP
> > L1TCM. It's because the modification introduces a short period of time
> > blocking audio DSP to access EMI. This was not a problem until we have
> > to load both SCP module and audio DSP module. audio DSP needs to access
> > EMI because it has source/data on DRAM. Audio DSP will have unexpected
> > behavior when it accesses EMI and the SCP driver blocks the EMI path at
> > the same time.
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> 
> Hello Tinghan,
> 
> I'm sorry, but in the last review I forgot to mention that you should
> really add a Fixes tag to this commit, since this is.. a fix.
> 
> This is the tag that you should use:
> 
> Fixes: 79111df414fc ("remoteproc: mediatek: Support mt8195 scp")
> 
> After adding that,
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

I'll add it at next version.
thank you very much!

Best regards,
TingHan

> > ---
> > v3: fix build error
> > v2: apply comments about macro definition and function calls
> > ---
> >   drivers/remoteproc/mtk_common.h |  2 +
> >   drivers/remoteproc/mtk_scp.c    | 67 +++++++++++++++++++++++++--------
> >   2 files changed, 53 insertions(+), 16 deletions(-)
> > 


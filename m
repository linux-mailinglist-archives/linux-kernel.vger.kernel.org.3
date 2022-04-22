Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9FE50AE39
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443607AbiDVCzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352185AbiDVCza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:55:30 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E964C789;
        Thu, 21 Apr 2022 19:52:38 -0700 (PDT)
X-UUID: ff2a2f2aeaba4611930dd65b8409cff7-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:1116bf02-5ec1-46cb-a6cc-99048546d742,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:8
X-CID-META: VersionHash:faefae9,CLOUDID:823bb6ef-06b0-4305-bfbf-554bfc9d151a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ff2a2f2aeaba4611930dd65b8409cff7-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 649484769; Fri, 22 Apr 2022 10:52:30 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 10:52:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 Apr
 2022 10:52:28 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 10:52:27 +0800
Message-ID: <d77e445b764cab4085390c0dd09a69f9479aec05.camel@mediatek.com>
Subject: Re: [PATCH] media: platform: mtk-mdp: Fix mdp_ipi_comm structure
 alignment
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <minghsiu.tsai@mediatek.com>
CC:     <houlong.wei@mediatek.com>, <andrew-ct.chen@mediatek.com>,
        <mchehab@kernel.org>, <matthias.bgg@gmail.com>,
        <hans.verkuil@cisco.com>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>,
        <acourbot@chromium.org>
Date:   Fri, 22 Apr 2022 10:52:27 +0800
In-Reply-To: <7658c8e4-596b-abfc-9255-854c16f920a7@collabora.com>
References: <20220307155653.460910-1-angelogioacchino.delregno@collabora.com>
         <7658c8e4-596b-abfc-9255-854c16f920a7@collabora.com>
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

Dear Angelo,

On Thu, 2022-04-21 at 13:03 +0200, AngeloGioacchino Del Regno wrote:
> Il 07/03/22 16:56, AngeloGioacchino Del Regno ha scritto:
> > The mdp_ipi_comm structure defines a command that is either
> > PROCESS (start processing) or DEINIT (destroy instance); we
> > are using this one to send PROCESS or DEINIT commands from Linux
> > to an MDP instance through a VPU write but, while the first wants
> > us to stay 4-bytes aligned, the VPU instead requires an 8-bytes
> > data alignment.
> > 
> > Keeping in mind that these commands are executed immediately
> > after sending them (hence not chained with others before the
> > VPU/MDP "actually" start executing), it is fine to simply add
> > a padding of 4 bytes to this structure: this keeps the same
> > performance as before, as we're still stack-allocating it,
> > while avoiding hackery inside of mtk-vpu to ensure alignment
> > bringing a definitely bigger performance impact.
> > 
> > Fixes: c8eb2d7e8202 ("[media] media: Add Mediatek MDP Driver")
> > Signed-off-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> 
> Hello,
> is there any issue with this patch?
> 
> Regards,
> Angelo
> 
> > ---
> > 
> > This patch has been tested on Acer Chromebook R 13 (MT8173 Elm) on
> > Debian Sid.
> > 
> > This is an alternative solution to the mtk-vpu approach, found
> > here:
> > 
https://lore.kernel.org/all/20210920170408.1561-1-dafna.hirschfeld@collabora.com
> > 
> >   drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> > b/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> > index 2cb8cecb3077..b810c96695c8 100644
> > --- a/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> > +++ b/drivers/media/platform/mtk-mdp/mtk_mdp_ipi.h
> > @@ -40,12 +40,14 @@ struct mdp_ipi_init {
> >    * @ipi_id        : IPI_MDP
> >    * @ap_inst       : AP mtk_mdp_vpu address
> >    * @vpu_inst_addr : VPU MDP instance address
> > + * @padding       : Alignment padding
> >    */
> >   struct mdp_ipi_comm {
> >   	uint32_t msg_id;
> >   	uint32_t ipi_id;
> >   	uint64_t ap_inst;
> >   	uint32_t vpu_inst_addr;
> > +	uint32_t padding;
> >   };
> >   
> >   /**
The struct definition should be keep align between Kernel and
User(sizeof(kernel) == sizeof(md32)), for backward compatible, the new
"padding" variable can't be accessed by Kernel and md32, just for
alignment padding in kernel side.

Reviewed-by: Irui Wang <irui.wang@mediatek.com>
> 


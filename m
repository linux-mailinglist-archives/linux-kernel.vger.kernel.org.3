Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D4B47EDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343966AbhLXJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:39:04 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:50872 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1343812AbhLXJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:39:02 -0500
X-UUID: 249930cfafff4f549a169c87bdbde67c-20211224
X-UUID: 249930cfafff4f549a169c87bdbde67c-20211224
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1935198536; Fri, 24 Dec 2021 17:39:00 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 24 Dec 2021 17:38:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Dec
 2021 17:38:58 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Dec 2021 17:38:58 +0800
Message-ID: <a6f0704e430453fc6bbbb49eabcd5518c6852f4c.camel@mediatek.com>
Subject: Re: [PATCH v16 4/7] soc: mediatek: SVS: add debug commands
From:   Roger Lu <roger.lu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 24 Dec 2021 17:38:58 +0800
In-Reply-To: <715c9587-825f-6c22-96a2-273fb7f07bc3@collabora.com>
References: <20210428065440.3704-1-roger.lu@mediatek.com>
         <20210428065440.3704-5-roger.lu@mediatek.com>
         <715c9587-825f-6c22-96a2-273fb7f07bc3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply.

On Thu, 2021-10-21 at 10:52 +0200, AngeloGioacchino Del Regno wrote:
> Il 28/04/21 08:54, Roger Lu ha scritto:
> > The purpose of SVS is to help find the suitable voltages
> > for DVFS. Therefore, if SVS bank voltages are concerned
> > to be wrong, we can adjust SVS bank voltages by this patch.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   drivers/soc/mediatek/mtk-svs.c | 328 +++++++++++++++++++++++++++++++++
> >   1 file changed, 328 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> > index 2d2153c92373..8794a2d87baa 100644
> > --- a/drivers/soc/mediatek/mtk-svs.c
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> > @@ -6,6 +6,7 @@
> >   #include <linux/bits.h>
> >   #include <linux/clk.h>
> >   #include <linux/completion.h>
> > +#include <linux/debugfs.h>
> >   #include <linux/device.h>
> >   #include <linux/init.h>
> >   #include <linux/interrupt.h>
> > @@ -24,6 +25,7 @@
> >   #include <linux/pm_runtime.h>
> >   #include <linux/regulator/consumer.h>
> >   #include <linux/reset.h>
> > +#include <linux/seq_file.h>
> >   #include <linux/slab.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/thermal.h>
> > @@ -62,6 +64,39 @@
> >   #define SVSB_INTSTS_COMPLETE		0x1
> >   #define SVSB_INTSTS_CLEAN		0x00ffffff
> >   
> > +#define debug_fops_ro(name)						
> > \
> > +	static int svs_##name##_debug_open(struct inode *inode,		\
> > +					   struct file *filp)		\
> > +	{								\
> > +		return single_open(filp, svs_##name##_debug_show,	\
> > +				   inode->i_private);			\
> > +	}								\
> > +	static const struct file_operations svs_##name##_debug_fops = {	\
> > +		.owner = THIS_MODULE,					\
> > +		.open = svs_##name##_debug_open,			\
> > +		.read = seq_read,					\
> > +		.llseek = seq_lseek,					\
> > +		.release = single_release,				\
> > +	}
> > +
> > +#define debug_fops_rw(name)						
> > \
> > +	static int svs_##name##_debug_open(struct inode *inode,		\
> > +					   struct file *filp)		\
> > +	{								\
> > +		return single_open(filp, svs_##name##_debug_show,	\
> > +				   inode->i_private);			\
> > +	}								\
> > +	static const struct file_operations svs_##name##_debug_fops = {	\
> > +		.owner = THIS_MODULE,					\
> > +		.open = svs_##name##_debug_open,			\
> > +		.read = seq_read,					\
> > +		.write = svs_##name##_debug_write,			\
> > +		.llseek = seq_lseek,					\
> > +		.release = single_release,				\
> > +	}
> > +
> > +#define svs_dentry(name)	{__stringify(name), &svs_##name##_debug_fops}
> > +
> >   static DEFINE_SPINLOCK(mtk_svs_lock);
> >   
> >   /*
> > @@ -83,6 +118,7 @@ enum svsb_phase {
> >   	SVSB_PHASE_INIT01,
> >   	SVSB_PHASE_INIT02,
> >   	SVSB_PHASE_MON,
> > +	SVSB_PHASE_NUM,
> 
> I would move the addition of these last members in the previous (3/7) patch,
> where you introduce the driver in the first place.
> 
> Also, I think that using _MAX instead would be better, as it is pretty
> much a common practice. So, this would become SVSB_PHASE_MAX.

Okay. I'll move it to previous (3/7) patch. Thanks for advice.

> 
> >   };
> >   
> >   enum svs_reg_index {
> > @@ -140,6 +176,7 @@ enum svs_reg_index {
> >   	SPARE2,
> >   	SPARE3,
> >   	THSLPEVEB,
> > +	SVS_REG_NUM,
> 
> ... and this would become SVS_REG_MAX

Okay. I'll move it to previous (3/7) patch. Thanks for advice.

> 
> >   };
> >   
> >   static const u32 svs_regs_v2[] = {
> 
> Apart from that,
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 


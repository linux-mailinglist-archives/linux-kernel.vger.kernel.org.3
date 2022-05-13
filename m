Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87835525AC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 06:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376932AbiEMEbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 00:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346255AbiEMEa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 00:30:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA062BB3D;
        Thu, 12 May 2022 21:30:51 -0700 (PDT)
X-UUID: 6aa3c49978d0498489f77b9ed50246db-20220513
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:01a3c9d9-087f-46fb-b109-acc0c979a54a,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:673e11f2-ab23-4aed-a67b-f96514452486,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 6aa3c49978d0498489f77b9ed50246db-20220513
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 123668449; Fri, 13 May 2022 12:30:48 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 13 May 2022 12:30:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Fri, 13 May 2022 12:30:47 +0800
Message-ID: <e70280d5bbc42a7d31602e68e98f3d33e24836ac.camel@mediatek.com>
Subject: Re: [PATCH v4] pwrap: mediatek: fix FSM timeout issue
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <eddie.huang@mediatek.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <hsin-hsiung.wang@mediatek.com>,
        <sean.wang@mediatek.com>, <macpaul.lin@mediatek.com>,
        <wen.su@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 13 May 2022 12:30:47 +0800
In-Reply-To: <20220513034356.5268-2-zhiyong.tao@mediatek.com>
References: <20220513034356.5268-1-zhiyong.tao@mediatek.com>
         <20220513034356.5268-2-zhiyong.tao@mediatek.com>
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

On Fri, 2022-05-13 at 11:43 +0800, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> Fix pwrap FSM timeout issue which leads the system crash on GFX VSRAM
> power on.
> The crash log:
> [ 3986.543401] mediatek-drm-dp 1c500000.edp_tx:
> drm_helper_hpd_irq_event
> [ 3986.670756] vsram_others: is_enabled() failed: -ETIMEDOUT
> [ 3986.670765] mali 13000000.mali: Power on reg 1 failed error = -110
> [ 3986.670768] ------------[ cut here ]------------
> [ 3986.670770] unbalanced disables for vsram_others
> [ 3986.670783] WARNING: CPU: 7 PID: 4125 at
> drivers/regulator/core.c:2761 _regulator_disable+0x194/0x1a0
> [ 3986.670785] Modules linked in: rfcomm algif_hash algif_skcipher
> af_alg veth uinput btusb btmtk btintel btbcm btrtl xt_cgroup
> bluetooth uvcvideo videobuf2_vmalloc ecdh_generic ecc mtk_vcodec_dec
> mtk_vcodec_enc mtk_mdp3 v4l2_h264 mtk_vcodec_common
> videobuf2_dma_contig mtk_vpu videobuf2_memops v4l2_mem2mem
> xt_MASQUERADE videobuf2_v4l2 videobuf2_common cros_ec_rpmsg mtk_scp
> mtk_rpmsg rpmsg_core mtk_scp_ipi ip6table_nat fuse 8021q
> iio_trig_sysfs cros_ec_sensors cros_ec_lid_angle cros_ec_sensors_core
> industrialio_triggered_buffer kfifo_buf cros_ec_sensorhub mt7921e
> mt7921_common mt76_connac_lib lzo_rle mt76 lzo_compress mac80211
> cfg80211 zram r8152 mii joydev
> [ 3986.670830] CPU: 7 PID: 4125 Comm: mali-cmar-backe Not tainted
> 5.10.78-CL2781499-v287 #1 b899b40a63da40d4767c6c0e96b6700d2f3eb242
> [ 3986.670832] Hardware name: MediaTek Tomato board (DT)
> [ 3986.670835] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> [ 3986.670838] pc : _regulator_disable+0x194/0x1a0
> [ 3986.670840] lr : _regulator_disable+0x194/0x1a0
> [ 3986.670842] sp : ffffffc016203a10
> [ 3986.670843] x29: ffffffc016203a10 x28: ffffffb7c3186b28
> [ 3986.670846] x27: 0000000000000002 x26: fffffffffffffdc8
> [ 3986.670848] x25: ffffffc017225000 x24: ffffffb7c0e94880
> [ 3986.670851] x23: ffffffb7c31840f0 x22: ffffffd6b4f3e275
> [ 3986.670853] x21: ffffffb7c3181a00 x20: ffffffb7c27e7800
> [ 3986.670855] x19: ffffffb7c27e7800 x18: 00000000ffff0a10
> [ 3986.670857] x17: 0000000000000020 x16: 00000000000000ec
> [ 3986.670860] x15: ffffffd6b44fa17c x14: 0000000000000003
> [ 3986.670862] x13: 0000000000000004 x12: 0000000000fd8318
> [ 3986.670864] x11: c000000100029ccd x10: 00000000ffffffff
> [ 3986.670866] x9 : 7dd6d080afd6f400 x8 : 7dd6d080afd6f400
> [ 3986.670868] x7 : 0000000000000000 x6 : ffffffd6b5459f0c
> [ 3986.670871] x5 : ffffffc016203a58 x4 : 0000000000000000
> [ 3986.670873] x3 : ffffffc016203668 x2 : ffffffc016203670
> [ 3986.670875] x1 : 0000000100029ccd x0 : 0000000000000024
> [ 3986.670878] Call trace:
> [ 3986.670880]  _regulator_disable+0x194/0x1a0
> [ 3986.670883]  regulator_disable+0x4c/0x8c
> 
> Add a usleep delay to avoid busy read for the H/W status.
> If (time_after()) be turn first, it maybe cause the system behavior
> crash problem like above. so we change it after sleep delay.
> 
> Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
> MT8173 SoCs")
> 
> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
> b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 952bc554f443..f9e7c2f35157 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -4,6 +4,7 @@
>   * Author: Flora Fu, MediaTek
>   */
>  #include <linux/clk.h>
> +#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct
> pmic_wrapper *wrp,
>  	timeout = jiffies + usecs_to_jiffies(10000);
>  
>  	do {
> -		if (time_after(jiffies, timeout))
> -			return fp(wrp) ? 0 : -ETIMEDOUT;
>  		if (fp(wrp))
>  			return 0;
> +
> +		usleep_range(10, 11);
> +
> +		if (time_after(jiffies, timeout))
> +			return fp(wrp) ? 0 : -ETIMEDOUT;
>  	} while (1);
>  }
>  

Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>


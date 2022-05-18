Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275CF52B79A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiERJiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiERJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E96B82EE;
        Wed, 18 May 2022 02:37:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6C636176F;
        Wed, 18 May 2022 09:37:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D1C385AA;
        Wed, 18 May 2022 09:37:29 +0000 (UTC)
Message-ID: <ea9a04fb-368d-daca-96ae-9366253a5e91@xs4all.nl>
Date:   Wed, 18 May 2022 11:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6, 6/7] media: mediatek: vcodec: prevent kernel crash
 when scp ipi timeout
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220513092526.9670-1-yunfei.dong@mediatek.com>
 <20220513092526.9670-7-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220513092526.9670-7-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

On 5/13/22 11:25, Yunfei Dong wrote:
> When SCP timeout during playing video, kernel crashes with following
> message. It's caused by accessing NULL pointer in vpu_dec_ipi_handler.
> This patch doesn't solve the root cause of NULL pointer, but merely
> prevent kernel crashed when encounter the NULL pointer.

Is the root cause being addressed as well? Where is the root cause? Is it
in this driver or in the scp (i.e. the remoteproc) driver?

I need a bit more information to decide whether this series is ready to
be merged for 5.20 or not.

Regards,

	Hans

> 
> After applied this patch, kernel keeps alive, only the video player turns
> to green screen.
> 
> [67242.065474] pc : vpu_dec_ipi_handler+0xa0/0xb20 [mtk_vcodec_dec]
> [67242.065485] [MTK_V4L2] level=0 fops_vcodec_open(),334:
> 18000000.vcodec_dec decoder [135]
> [67242.065523] lr : scp_ipi_handler+0x11c/0x244 [mtk_scp]
> [67242.065540] sp : ffffffbb4207fb10
> [67242.065557] x29: ffffffbb4207fb30 x28: ffffffd00a1d5000
> [67242.065592] x27: 1ffffffa0143aa24 x26: 0000000000000000
> [67242.065625] x25: dfffffd000000000 x24: ffffffd0168bfdb0
> [67242.065659] x23: 1ffffff76840ff74 x22: ffffffbb41fa8a88
> [67242.065692] x21: ffffffbb4207fb9c x20: ffffffbb4207fba0
> [67242.065725] x19: ffffffbb4207fb98 x18: 0000000000000000
> [67242.065758] x17: 0000000000000000 x16: ffffffd042022094
> [67242.065791] x15: 1ffffff77ed4b71a x14: 1ffffff77ed4b719
> [67242.065824] x13: 0000000000000000 x12: 0000000000000000
> [67242.065857] x11: 0000000000000000 x10: dfffffd000000001
> [67242.065890] x9 : 0000000000000000 x8 : 0000000000000002
> [67242.065923] x7 : 0000000000000000 x6 : 000000000000003f
> [67242.065956] x5 : 0000000000000040 x4 : ffffffffffffffe0
> [67242.065989] x3 : ffffffd043b841b8 x2 : 0000000000000000
> [67242.066021] x1 : 0000000000000010 x0 : 0000000000000010
> [67242.066055] Call trace:
> [67242.066092]  vpu_dec_ipi_handler+0xa0/0xb20 [mtk_vcodec_dec
> 12220d230d83a7426fc38c56b3e7bc6066955bae]
> [67242.066119]  scp_ipi_handler+0x11c/0x244 [mtk_scp
> 8fb69c2ef141dd3192518b952b65aba35627b8bf]
> [67242.066145]  mt8192_scp_irq_handler+0x70/0x128 [mtk_scp
> 8fb69c2ef141dd3192518b952b65aba35627b8bf]
> [67242.066172]  scp_irq_handler+0xa0/0x114 [mtk_scp
> 8fb69c2ef141dd3192518b952b65aba35627b8bf]
> [67242.066200]  irq_thread_fn+0x84/0xf8
> [67242.066220]  irq_thread+0x170/0x1ec
> [67242.066242]  kthread+0x2f8/0x3b8
> [67242.066264]  ret_from_fork+0x10/0x30
> [67242.066292] Code: 38f96908 35003628 91004340 d343fc08 (38f96908)
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> index 35f4d5583084..1041dd663e76 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec_vpu_if.c
> @@ -91,6 +91,11 @@ static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv)
>  	struct vdec_vpu_inst *vpu = (struct vdec_vpu_inst *)
>  					(unsigned long)msg->ap_inst_addr;
>  
> +	if (!vpu) {
> +		mtk_v4l2_err("ap_inst_addr is NULL");
> +		return;
> +	}
> +
>  	mtk_vcodec_debug(vpu, "+ id=%X", msg->msg_id);
>  
>  	vpu->failure = msg->status;

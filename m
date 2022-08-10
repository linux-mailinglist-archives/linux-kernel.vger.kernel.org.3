Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4832E58F3C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiHJVP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHJVPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:15:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760418B35
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:15:24 -0700 (PDT)
Received: from notapiano (korma.collabora.co.uk [168.119.224.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5965D6601C74;
        Wed, 10 Aug 2022 22:15:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660166122;
        bh=/jwBuBx79c+lk7i4kE7uZcAxqKWyDiBWEZ+cunWmR8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvWzDwX0VnghTEO0QFED/hL1bYc0BmK5NdO9GgXLRMZBmo4xFdsI1+HUKIexdrZU3
         t1kciV686A0kO1LKnmvEBDmN+HU/UKXcHqBwOB9IXx4viufCZbIt9AWT3vohoycFYh
         j5SrFZnSKHHuMJHCXm4D8urFnrjLTBptx49lPhnwjMG4qbYz0XIBWY+mMuQU5KCZdo
         mZwj59EUoqrrCEE1tqhQVnkytD8qIB6mRQ4BI55in0xWVcqUVI7veJatspDIz3HqTo
         q1hzwfwFbF3x7fmqd8OycPrqam9pIxQ7tqz54EFzf/QX+esMGspdF9PKcuU7Efp3c3
         +hmmAOJaqc7gA==
Date:   Wed, 10 Aug 2022 17:15:14 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/mediatek: dsi: Add atomic {destroy,duplicate}_state,
 reset callbacks
Message-ID: <20220810211514.nmufrsi6gssb2kel@notapiano>
References: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 07:27:27PM +0200, AngeloGioacchino Del Regno wrote:
> Add callbacks for atomic_destroy_state, atomic_duplicate_state and
> atomic_reset to restore functionality of the DSI driver: this solves
> vblank timeouts when another bridge is present in the chain.
> 
> Tested bridge chain: DSI <=> ANX7625 => aux-bus panel
> 
> Fixes: 7f6335c6a258 ("drm/mediatek: Modify dsi funcs to atomic operations")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested on mt8183-jacuzzi-juniper. As part of enabling IGT tests on that machine
in KernelCI, this regression needs to be fixed. [1]

Thanks,
Nícolas

[1] https://github.com/kernelci/kernelci-core/pull/1059

> ---
> 
> Note: The commit that has been mentioned in the Fixes tag should
>       *not* have my Reviewed-by tag, as the author changed it but
>       erroneously retained the tag that I had released for an
>       earlier version of that commit (which was fine, but the new
>       version broke mtk_dsi!).
> 
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 9cc406e1eee1..5b624e0f5b0a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -808,10 +808,13 @@ static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>  
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>  	.attach = mtk_dsi_bridge_attach,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_disable = mtk_dsi_bridge_atomic_disable,
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_enable = mtk_dsi_bridge_atomic_enable,
>  	.atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
>  	.atomic_post_disable = mtk_dsi_bridge_atomic_post_disable,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
>  	.mode_set = mtk_dsi_bridge_mode_set,
>  };
>  
> -- 
> 2.35.1
> 
> 

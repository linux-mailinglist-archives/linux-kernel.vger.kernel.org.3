Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B744CA3F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 12:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbiCBLlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 06:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiCBLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 06:41:35 -0500
X-Greylist: delayed 348 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 03:40:52 PST
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3638D8F9B5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 03:40:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 192CAFB03;
        Wed,  2 Mar 2022 12:35:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Le1pHLclBSLN; Wed,  2 Mar 2022 12:34:59 +0100 (CET)
Date:   Wed, 2 Mar 2022 12:34:57 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robert.foss@linaro.org, linux-imx@nxp.com
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Remove superfluous write to
 NWL_DSI_IRQ_MASK register
Message-ID: <Yh9WYZ5pA/MUyZFx@qwark.sigxcpu.org>
References: <20220216085842.1973868-1-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216085842.1973868-1-victor.liu@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,
On Wed, Feb 16, 2022 at 04:58:42PM +0800, Liu Ying wrote:
> To initialize register NWL_DSI_IRQ_MASK, it's enough to write it
> only once in function nwl_dsi_init_interrupts().
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
>  drivers/gpu/drm/bridge/nwl-dsi.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
> index af07eeb47ca0..fcc4a2889ad4 100644
> --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> @@ -333,17 +333,13 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
>  
>  static int nwl_dsi_init_interrupts(struct nwl_dsi *dsi)
>  {
> -	u32 irq_enable;
> -
> -	nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK, 0xffffffff);
> -	nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK2, 0x7);
> -
> -	irq_enable = ~(u32)(NWL_DSI_TX_PKT_DONE_MASK |
> -			    NWL_DSI_RX_PKT_HDR_RCVD_MASK |
> -			    NWL_DSI_TX_FIFO_OVFLW_MASK |
> -			    NWL_DSI_HS_TX_TIMEOUT_MASK);
> +	u32 irq_enable = ~(u32)(NWL_DSI_TX_PKT_DONE_MASK |
> +				NWL_DSI_RX_PKT_HDR_RCVD_MASK |
> +				NWL_DSI_TX_FIFO_OVFLW_MASK |
> +				NWL_DSI_HS_TX_TIMEOUT_MASK);
>  
>  	nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK, irq_enable);
> +	nwl_dsi_write(dsi, NWL_DSI_IRQ_MASK2, 0x7);

Works fine here. I thought it was due to some hw quirk but can't find
any note in it so:

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Thanks,
 -- Guido

>  
>  	return nwl_dsi_clear_error(dsi);
>  }
> -- 
> 2.25.1
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEEA49F5BE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiA1I4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA1I4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:56:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F647C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:56:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B80BB824EF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B317AC340E0;
        Fri, 28 Jan 2022 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643360200;
        bh=L0e4NOI8iG8yDPknydOzu7XKjt3ExbCSSt6U9t2mwlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pdortB5pJt7xqL4W8flMRwt4+3nBc6nX2GmXa31LWVMwz3ZEucgJaChv2CTimRTDq
         dLWleVTLlmb8shrU97yRAOCl0NSvhsIq2n3rfhH61EcT/BNao1tStg9QSvYQqrlQm+
         W+Md3VSLEBn6uB3Wf/kV+Fjq+8qkkluMCjKbnWgrVaz3PWbamdRz4+t9pGe3mgs3uB
         kQZ0tOdni1n8dZBafj+mqXM/6COPoShqg3tBMl3AKdqbk8PzbMoT4MWdccUR8NWwB7
         ZTuFA2hhP9LJXgWnKjQaAIFV1Uc828CkgXrDZuzYEImSXnJ+aYSoMRsPANEjrkB+FF
         sBq144hBLoqeA==
Date:   Fri, 28 Jan 2022 16:56:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: imx: add get resource owner api
Message-ID: <20220128085633.GG4686@dragon>
References: <20220111032147.342012-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111032147.342012-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:21:47AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add resource owner management API, this API could be used to check
> whether M4 is under control of Linux.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/rm.c           | 45 +++++++++++++++++++++++++++++
>  include/linux/firmware/imx/svc/rm.h |  5 ++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/firmware/imx/rm.c b/drivers/firmware/imx/rm.c
> index a12db6ff323b..3c3605f98123 100644
> --- a/drivers/firmware/imx/rm.c
> +++ b/drivers/firmware/imx/rm.c
> @@ -43,3 +43,48 @@ bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
>  	return hdr->func;
>  }
>  EXPORT_SYMBOL(imx_sc_rm_is_resource_owned);
> +
> +/*
> + * This function get @resource partition number
> + *
> + * @param[in]     ipc         IPC handle
> + * @param[in]     resource    resource the control is associated with
> + * @param[out]    pt          pointer to return the partition number
> + *
> + * @return Returns 0 for success and < 0 for errors.
> + */

Shouldn't the documentation be put right above the function?

Shawn

> +struct imx_sc_msg_rm_get_resource_owner {
> +	struct imx_sc_rpc_msg hdr;
> +	union {
> +		struct {
> +			u16 resource;
> +		} req;
> +		struct {
> +			u8 val;
> +		} resp;
> +	} data;
> +} __packed __aligned(4);
> +
> +int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource, u8 *pt)
> +{
> +	struct imx_sc_msg_rm_get_resource_owner msg;
> +	struct imx_sc_rpc_msg *hdr = &msg.hdr;
> +	int ret;
> +
> +	hdr->ver = IMX_SC_RPC_VERSION;
> +	hdr->svc = IMX_SC_RPC_SVC_RM;
> +	hdr->func = IMX_SC_RM_FUNC_GET_RESOURCE_OWNER;
> +	hdr->size = 2;
> +
> +	msg.data.req.resource = resource;
> +
> +	ret = imx_scu_call_rpc(ipc, &msg, true);
> +	if (ret)
> +		return ret;
> +
> +	if (pt)
> +		*pt = msg.data.resp.val;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(imx_sc_rm_get_resource_owner);
> diff --git a/include/linux/firmware/imx/svc/rm.h b/include/linux/firmware/imx/svc/rm.h
> index 456b6a59d29b..ff481b23ea36 100644
> --- a/include/linux/firmware/imx/svc/rm.h
> +++ b/include/linux/firmware/imx/svc/rm.h
> @@ -59,11 +59,16 @@ enum imx_sc_rm_func {
>  
>  #if IS_ENABLED(CONFIG_IMX_SCU)
>  bool imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource);
> +int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource, u8 *pt);
>  #else
>  static inline bool
>  imx_sc_rm_is_resource_owned(struct imx_sc_ipc *ipc, u16 resource)
>  {
>  	return true;
>  }
> +static inline int imx_sc_rm_get_resource_owner(struct imx_sc_ipc *ipc, u16 resource, u8 *pt)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif
>  #endif
> -- 
> 2.25.1
> 

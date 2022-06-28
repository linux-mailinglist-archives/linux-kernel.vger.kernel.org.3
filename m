Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D1C55C45C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiF1GfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245754AbiF1GeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:34:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E311A32
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2F72B81BF0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C001C3411D;
        Tue, 28 Jun 2022 06:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656398049;
        bh=VvEWlLSYf1AS2FlRiY/L+9odO+J+SSl8cDEJrocltKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJRjI3Ya1ZNstXRK3GzGD96PnYZqAzIxMuUV+szhxnal+osN816FlWfU5ohNCWhPj
         DPgSlvbPOH0K6iyIjrVOTKrSSyT3Zo6nRgkNrsy2qKf7fF1iWUCrb14GKzKa/pcoWx
         6NFecWg3FkUEuqz0Y0X37gJnHZN09/KNWg5kW2p0=
Date:   Tue, 28 Jun 2022 08:34:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/12] habanalabs: add unsupported functions
Message-ID: <Yrqg3vZlqaMvUeeO@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-5-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202620.961350-5-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:26:12PM +0300, Oded Gabbay wrote:
> There are a number of new ASIC-specific functions that were added
> for Gaudi2. To make the common code work, we need to define empty
> implementations of those functions for Goya and Gaudi.
> 
> Some functions will return error if called with Goya/Gaudi.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 24 ++++++++++++++++++++++++
>  drivers/misc/habanalabs/goya/goya.c   | 24 ++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index ae894335e9f8..f4581220ecd5 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -8588,6 +8588,11 @@ static void gaudi_ctx_fini(struct hl_ctx *ctx)
>  	gaudi_internal_cb_pool_fini(ctx->hdev, ctx);
>  }
>  
> +int gaudi_pre_schedule_cs(struct hl_cs *cs)
> +{
> +	return 0;
> +}

static?

Did you run sparse on this change?

thanks,

greg k-h

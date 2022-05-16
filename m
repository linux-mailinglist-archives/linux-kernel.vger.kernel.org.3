Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EE1527D72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbiEPGNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiEPGNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:13:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2122C20F70;
        Sun, 15 May 2022 23:13:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE1E9B80B46;
        Mon, 16 May 2022 06:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77732C34113;
        Mon, 16 May 2022 06:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652681592;
        bh=UTUuhN0um7hJQqdQeOchUoEm+GyHH2sayGEMfRN9Os8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FjmE/Rc7ORV8WRQjYTNUGobIKVgFeXTEOjVGR4nyEF5YtfXcvP9paEhosnuQEeU64
         3lomSFPmaOqPvhAQfXKtGMZwCW6m9487+Tbh2APx3PS8PJr9DEoWRU73OKFxEMXw5v
         A8VcQ13S3nlqdWbmMYtZNRe2Oodx3X+X4wAoPj+M=
Date:   Mon, 16 May 2022 08:13:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     mani@kernel.org, loic.poulain@linaro.org, quic_hemantk@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev
Subject: Re: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
Message-ID: <YoHrdGsEdWL8Yrui@kroah.com>
References: <MEYP282MB2374B1DA0004F6E5821A2FB5FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2374B1DA0004F6E5821A2FB5FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 02:09:34PM +0800, Yonglin Tan wrote:
> The product's enumeration align with previous 
> Quectel EM120R-GL, so the EM120 FCCL would use 
> the same config as Quectel EM120R-GL. 
> 
> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 8416267..0a6469c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> +	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> +		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> -- 
> 2.7.4
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

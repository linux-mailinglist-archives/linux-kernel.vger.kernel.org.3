Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4C250C9DE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiDWM0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiDWM0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD177183F84;
        Sat, 23 Apr 2022 05:23:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 483C560FC8;
        Sat, 23 Apr 2022 12:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F49C385A5;
        Sat, 23 Apr 2022 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650716616;
        bh=1ZDjuPtLpq1fxqlJBuXcS1neob/RlAg1nHXUoBOA43g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjpyDUwtlQrv7/c1lLzBfXgeagx3tB/M9NIXbNSBZAykTurh15C8vVIyOdNv6uvYV
         eOdhCz+zsQJ1nFw6vafKtQzuD5FHLNram2173vjiK5+k63EaqfGCNvuL8jgjcoX6Rt
         dpUKR8mN/T5+vXvlO+WtMhUGiIlKdGGg232QZxGRydyrOvP5rnw4Aq+3U4MhcpWVvu
         QXQF+IpwCxn4jeHGiYMgk8lhBMYzt0gYXhrgR4eet1ibG8TnCUQnycsLPO8dRUC2fI
         NaLUmU0qBf5dDJPFfbH/zxncTvbE80CpkG+w7VMPDdADqkPzmaKLQYC5+UUNhHFCWX
         C6ciwV7uNcJ5g==
Date:   Sat, 23 Apr 2022 17:53:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        dnlplm@gmail.com
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Sort mhi_pci_id_table
 based on the PID
Message-ID: <20220423122329.GK374560@thinkpad>
References: <20220411133428.42165-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411133428.42165-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:04:28PM +0530, Manivannan Sadhasivam wrote:
> Sorting this way helps in identifying the products of vendors. There is no
> sorting required for VID and the new VID should be added as the last entry.
> 
> Let's also add a note clarifying this.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

Thanks,
Mani

> ---
> 
> Changes in v2:
> 
> * Fixup the 0x0306 entry by moving it after subid
> 
>  drivers/bus/mhi/host/pci_generic.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 541ced27d941..8858f3bf4f04 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -446,20 +446,21 @@ static const struct mhi_pci_dev_info mhi_sierra_em919x_info = {
>  	.sideband_wake = false,
>  };
>  
> +/* Keep the list sorted based on the PID. New VID should be added as the last entry */
>  static const struct pci_device_id mhi_pci_id_table[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
>  	/* EM919x (sdx55), use the same vid:pid as qcom-sdx55m */
>  	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_QCOM, 0x0306, 0x18d7, 0x0200),
>  		.driver_data = (kernel_ulong_t) &mhi_sierra_em919x_info },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0306),
>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx55_info },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> -		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx24_info },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
>  	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
> -		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> -- 
> 2.25.1
> 

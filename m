Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001855E011
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiF1G3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245212AbiF1G3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:29:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D5255B7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94203B818AA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D615AC3411D;
        Tue, 28 Jun 2022 06:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656397750;
        bh=E83LBuNMKlEgRdfk2QHLqn7lqqiFoYrjq8ZINudc9fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/GM1ExXBbDkdkfqdK8Wu2isGiswEn26J5b4+A31qIxb8P3uxGKHY9Z4i9LkFwsur
         +I7QQeNEUA27QatacXBvKRWzHZOzHzfW62z4MY+hG8hfp5dLmiTzpYuDNiUTxDbsAA
         2MZnZolUNH/3mnjxGi7OiYtJaFy7X3+9panV/whw=
Date:   Tue, 28 Jun 2022 08:29:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] habanalabs: enable gaudi2 code in driver
Message-ID: <Yrqfs3xUWwqHcbeR@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-13-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202620.961350-13-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:26:20PM +0300, Oded Gabbay wrote:
> Enable the Gaudi2 ASIC code in the pci probe callback of the driver so
> the driver will handle Gaudi2 ASICs.
> 
> Add the PCI ID to the PCI table and add the ASIC enum value to all
> relevant places.
> 
> Fixup the device parameters initialization for Gaudi2.
> 
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> ---
>  drivers/misc/habanalabs/common/device.c       |  8 +++
>  drivers/misc/habanalabs/common/habanalabs.h   | 13 ++--
>  .../misc/habanalabs/common/habanalabs_drv.c   | 67 +++++++++++++++----
>  drivers/misc/habanalabs/common/sysfs.c        |  6 ++
>  4 files changed, 77 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> index 38cf2f1659ee..a4656eac495e 100644
> --- a/drivers/misc/habanalabs/common/device.c
> +++ b/drivers/misc/habanalabs/common/device.c
> @@ -645,6 +645,14 @@ static int device_early_init(struct hl_device *hdev)
>  		gaudi_set_asic_funcs(hdev);
>  		strscpy(hdev->asic_name, "GAUDI SEC", sizeof(hdev->asic_name));
>  		break;
> +	case ASIC_GAUDI2:
> +		gaudi2_set_asic_funcs(hdev);
> +		strscpy(hdev->asic_name, "GAUDI2", sizeof(hdev->asic_name));
> +		break;
> +	case ASIC_GAUDI2_SEC:
> +		gaudi2_set_asic_funcs(hdev);
> +		strscpy(hdev->asic_name, "GAUDI2 SEC", sizeof(hdev->asic_name));
> +		break;
>  	default:
>  		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
>  			hdev->asic_type);
> diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
> index 4537845658f8..587b1c537115 100644
> --- a/drivers/misc/habanalabs/common/habanalabs.h
> +++ b/drivers/misc/habanalabs/common/habanalabs.h
> @@ -3033,7 +3033,6 @@ struct hl_reset_info {
>   * @disabled: is device disabled.
>   * @late_init_done: is late init stage was done during initialization.
>   * @hwmon_initialized: is H/W monitor sensors was initialized.
> - * @heartbeat: is heartbeat sanity check towards CPU-CP enabled.

You remove this field, but you still keep it in the structure, you just
move it later down to the bottom for some reason:

>   * @reset_on_lockup: true if a reset should be done in case of stuck CS, false
>   *                   otherwise.
>   * @dram_default_page_mapping: is DRAM default page mapping enabled.
> @@ -3066,6 +3065,10 @@ struct hl_reset_info {
>   * @is_compute_ctx_active: Whether there is an active compute context executing.
>   * @compute_ctx_in_release: true if the current compute context is being released.
>   * @supports_mmu_prefetch: true if prefetch is supported, otherwise false.
> + * @reset_upon_device_release: reset the device when the user closes the file descriptor of the
> + *                             device.
> + * @skip_iatu_for_unsecured_device: skip the device PCI controller initialization when working
> + *                                  with device that runs f/w that is not secured.
>   */
>  struct hl_device {
>  	struct pci_dev			*pdev;
> @@ -3175,7 +3178,6 @@ struct hl_device {
>  	u8				disabled;
>  	u8				late_init_done;
>  	u8				hwmon_initialized;
> -	u8				heartbeat;
>  	u8				reset_on_lockup;
>  	u8				dram_default_page_mapping;
>  	u8				memory_scrub;
> @@ -3199,6 +3201,8 @@ struct hl_device {
>  	u8				is_compute_ctx_active;
>  	u8				compute_ctx_in_release;
>  	u8				supports_mmu_prefetch;
> +	u8				reset_upon_device_release;
> +	u8				skip_iatu_for_unsecured_device;
>  
>  	/* Parameters for bring-up */
>  	u64				nic_ports_mask;
> @@ -3212,11 +3216,9 @@ struct hl_device {
>  	u8				dram_scrambler_enable;
>  	u8				hard_reset_on_fw_events;
>  	u8				bmc_enable;
> -	u8				rl_enable;
>  	u8				reset_on_preboot_fail;
> -	u8				reset_upon_device_release;
> -	u8				skip_iatu_for_unsecured_device;
>  	u8				reset_if_device_not_idle;
> +	u8				heartbeat;
>  };

Did you mean to do that?

thanks,

greg k-h

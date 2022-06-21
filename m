Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE4C553378
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351591AbiFUNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351410AbiFUNTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:19:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C7522505;
        Tue, 21 Jun 2022 06:18:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EFB1B816BF;
        Tue, 21 Jun 2022 13:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48233C3411C;
        Tue, 21 Jun 2022 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655817484;
        bh=RtUe+YE8cUHP2cPCHPPT+9RzwFZCRXFfUKZJSO4gf7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tY4G5uLg/ZgLvp3Rin3eVnNTL+6ffuGuM0DF/xs+uJ5AD/EgXB6yUvHHwCOv03jZs
         xJrB171Um3I/ZrL6YgamfNN4i8iz4Bj4OUXN2mcE9cxhhhD8fCrnp7bG3MOXD9C7Dn
         yhGEy6kzOwjzyTCLd8QOSFhop9Ww1qDkrvbzXl6baPtmNZevuFLFG6i6TU2LmK41pr
         jGh8OfBXxdkrFg383LHvqtu+pqM2HbzoloesbLQke+xMJvfgtm3CPIu3fC7MsN9wdt
         aHHjhRskI1C6hQ5QVqu/aOveTtJj7OlGAZGJxhyIOIrUOc7ry9eEuiqxZO4UilW5BJ
         QJakkvvyAGAVQ==
Date:   Tue, 21 Jun 2022 18:47:51 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     quic_hemantk@quicinc.com, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH] bus: mhi: host: Add support for Cinterion MV31-W with
 new device ID
Message-ID: <20220621131751.GD17181@thinkpad>
References: <20220601061915.10946-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601061915.10946-1-slark_xiao@163.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 02:19:15PM +0800, Slark Xiao wrote:

Please use pci_generic in the subject as this change belongs to that driver:

bus: mhi: host: pci_generic: Add Cinterion MV31-W with new baseline

> As Thales would use a new baseline, so we need to add
> a new device ID to separate it from previous.
> 

Thales refers to Cinterion MV31-W, right? Better just use Cinterion MV31-W.
Like,

Cinterion MV31-W modem with a new baseline (firmware) is sold as a separate
product with different device ID. So add support for the same reusing the
config.

Thanks,
Mani

> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 6fbc5915ea36..a2a4fd2cd13d 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -578,6 +578,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(0x1269, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> +	/* MV31-W (Cinterion), based on new baseline */
> +	{ PCI_DEVICE(0x1269, 0x00b4),
> +		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
>  	/* MV32-WA (Cinterion) */
>  	{ PCI_DEVICE(0x1269, 0x00ba),
>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

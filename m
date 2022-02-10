Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13624B111F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbiBJPBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:01:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbiBJPBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:01:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3891B3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:01:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D149C61AD8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C03C004E1;
        Thu, 10 Feb 2022 15:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644505277;
        bh=Hi2Mca6jqEt1GgA8oCBVMaSPWVu89ItIPId18WE1+wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jyWCLFa1Mw22hr0+sxUUJEtJ98QtJ4JJPXo70nMNuzLgcM7f1avHCogMbutMJA2JW
         cWG1WXhix/0Ra+ALhv74XBk85rxAjUV0XN3f67EOqvzjAarXw516zah75060+9/SL3
         DwFv2jtxPqLw77w8PAksghjaxmBYedc3GTxH2jJgSxtALSFf1ISuY+DON88OffKy55
         jEjSugCGbpNc4R4kTrjH1CKwFrtw3KO23kNoDEVlS2Uppfy56vbuEH7VzmdeXRWLVJ
         9+SKJuEgLWbKyqdnNtS4Vf8yo5Un0yKMBPVjp/rmM8LmvwmKD6rY3nE0p7xZFKYpL9
         dt4rQCfvOh1pw==
Date:   Thu, 10 Feb 2022 07:01:14 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Message-ID: <20220210150114.GB1617879@dhcp-10-100-145-180.wdc.com>
References: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:51:16PM +0530, Nitin Rawat wrote:
> The Toshiba KBG40ZPZ256G SSD is having resume issues on SC7280 platform.
> Hence enabling quick suspend quirks for Toshiba KBG40ZPZ256G on sc7280
> platform so that nvme device is taken through shutdown path
> during resume.
> 
> No issue is seen after enabling this quirks.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed6..04c5954 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3032,6 +3032,15 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>  		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
> +
> +		/*
> +		 * Toshiba KBG40ZPZ256G on Sc7280 platform is having NVMe
> +		 * Resume issue. Appending quick suspend quirks for sc7280
> +		 * platforms so that full NVMe device shutdown path is
> +		 * executed during resume.
> +		 */
> +		if (of_machine_is_compatible("qcom,sc7280"))
> +			return NVME_QUIRK_SIMPLE_SUSPEND;

Shouldn't this check be moved outside the vendor/device check? It
doesn't seem like this behavior for this platform is specific to any
particular controller, right?

Otherwise, looks fine.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A65E4B15CC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiBJTEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:04:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343596AbiBJTEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D6100C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:04:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A010CB82728
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 19:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733CAC004E1;
        Thu, 10 Feb 2022 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644519880;
        bh=wz/CdZorfFHWlSqN+7ZDozbR07LEsU/eeljIy+oXNh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gw/2JQpYdEpG0z4AKa6gfM5FwzjZ92a4UBh5SD7mdRMlJopWrw6LvowC9gA2D/WRo
         /arBEknMaaOh8XIDzo9a0jUiNTyUcjCp9hjE9MtCQYOJfI2SFpNEHc3gZvfTX6k9dy
         KZcpKHFHaHe5ySUnfj1VW3wzFJ93+olpaFH9o4V/cznKOMxHyrMdJ0kA4zSPtcEcp7
         fUr2xIzZGyGQcgkzhxDqJDpchfIjkQKv2YezWWKgN3GjVr9C2/v54zdLEUcQXibHdY
         MkQF5SdB+cnpAe+LWg4wEcU+jffysL1kYjdluTzirAlO1UXZPOLzWPriD6nUQM2Hzd
         ZVB83J8dS5aog==
Date:   Thu, 10 Feb 2022 11:04:36 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v2] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <20220210190436.GA1658231@dhcp-10-100-145-180.wdc.com>
References: <1644512104-24035-1-git-send-email-quic_nitirawa@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644512104-24035-1-git-send-email-quic_nitirawa@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:25:04PM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power
> to nvme device is removed during suspend-resume process. This
> is done to avoid the failure dring resume.
> 
> This enables simple suspend path for this platform.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
> 
> Change from v1-v2:
> 
> *Moving the check condition outside vendor/device check
>  to make this platform specific
> 
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6a99ed6..fa25d9fab 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3032,6 +3032,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
>  		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>  		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
> +	} else if (of_machine_is_compatible("qcom,sc7280")) {
> +		/*
> +		 * Append quick suspend quirks for sc7280 platforms
> +		 * so that simple suspend path is executed for this
> +		 * platform to avoid any resume failure.
> +		 */
> +		return NVME_QUIRK_SIMPLE_SUSPEND;
>  	}

Did you test this? Because I think you said that this is the Kioxa
controller matching the vendor:device in the previos "else if", which
means we won't reach this part.

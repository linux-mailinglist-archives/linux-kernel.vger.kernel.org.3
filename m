Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DD74F57E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiDFI3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 04:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245726AbiDFI2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 04:28:32 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A71229A9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1649211058; x=1680747058;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d0+FytOO558btlFRtC1lBvGsmdlxFF1L6dG+96oaJ+4=;
  b=Ap2r6wIi1nWueID3nez4OAOxwWCiDpxDfRQnNYpGf0oTP3C759vS0rQ9
   m/Vn/rBGvGys1He1yI9o4kSsgZfk3QtOahH+c/q/eVmfLzdfMMUwcAzP5
   mBvqRGq7kuRBYhMFjUGV5W34MjsNt1205gNvQ6pVqE0dNk9UhdoOKs1nI
   4zg4PZMs2advY+LczYDuo2jbygA91DA1AOoNnkYEErwXcM3ia4tzmy3Qd
   LlBCwRluYYzlKjobnpfPjyLveH3YdY+eobA/GHe4K7dnYwDrS7NsSKDfd
   dkMlHbJh2At0i/EhmfYJI9pCDLg5/hStjtD1CZP+EsNZoZbVOHCV0mLUX
   g==;
X-IronPort-AV: E=Sophos;i="5.90,238,1643644800"; 
   d="scan'208";a="196065495"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2022 10:10:51 +0800
IronPort-SDR: zKnTsBzZU1ojdFhMsC8qeMSGf/pKmkJZ1Zgv0MgaQ0yfSBoFovouw3NNhJpoVFwvTy1HQzCI6e
 HwRTubTjQzXtK8ioGiWiQJXYEcRKKkm8v0CUQp96wSjb9UvhlhOu//Av6WiOlCu53Z7jEwICWc
 IRAQXuGjaWygGBVddo6hfSSLrOWsN1LP3CqGhmSpdnuqu2AftOvzkIO24oNNVB09MBFGfley9F
 Ob3OF9EhGG8aaYdcGiOxY/r+dv69b/kM6lCKPe8PXzM3XhBtPSW8Aq5H2w9E6zFm/Kwc1bd0hF
 dsjihTklAi7q+tJYZX/ISAYr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 18:41:33 -0700
IronPort-SDR: chAfzkgNz4WCosDK2IfDaYnz5xVfWM+UDoz3YYygAtPKRYHy1VOWn0Yx4smyCRkuvhUnvawHAN
 /Iv43xYUvtCiU+Kj1aB5WWgJHjRvRqOmavFlTGrZYfkKjm567p7iai8g7/ygqizt8OtpOCx2Hy
 0gvb9gXxGGmwn0lNuw2Zp5MRj/jV7g74wS3C3RJYkhtdFT2s57+jPW3UaKfPPQiTxBDQgbF63J
 E62F2LzLIWPNTR0nQ3sFNiHaTVc52LNgPLXwM0AbEVi2ylyKYnb9/6KqvWPrNf1ywkzuD7JuIw
 4Qk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Apr 2022 19:10:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KY7K65Yv2z1SVp0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:10:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1649211050; x=1651803051; bh=d0+FytOO558btlFRtC1lBvGsmdlxFF1L6dG
        +96oaJ+4=; b=DGiCKGDztbwwCLwB/GNQfZx3xgOClhBsxA45wxipCKiSXhNZqTz
        p6csTAu3GZxbpDP4IlHGdtZdmut7dIt1KCRj75DkmeMfA5gnFB+hE9tLkHpKgaPr
        /6mssPYeZ16UAmbDgiWOjdCgpJNBaNQhmHGOHesrlL8zE/sKhwnEJVM+9IHPvPUi
        FrsRxTAq6YVv8r/ByCzAkUek1sZHIYZ/Vw0wKflzibFNO/qBQYB8ay3c6eIiexkK
        6M7Yghqh6wKRWZzgGjNaatgroogitGgXU1Zf7aPL+j7PRxzXMnpTpxUFJ9kw3ugc
        skIeqNZoWlGz9PUZRczE+owJvbQVsYaSkWQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bvf9uKsKlF-2 for <linux-kernel@vger.kernel.org>;
        Tue,  5 Apr 2022 19:10:50 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KY7K52xF7z1Rvlx;
        Tue,  5 Apr 2022 19:10:49 -0700 (PDT)
Message-ID: <da15b34f-2f13-6c97-29f1-9f26c8ec5a3d@opensource.wdc.com>
Date:   Wed, 6 Apr 2022 11:10:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] ata: ahci: Rename CONFIG_SATA_LPM_POLICY
 configuration item back
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hdegoede@redhat.com,
        Christoph Hellwig <hch@infradead.org>
References: <20220404200202.9388-1-mario.limonciello@amd.com>
 <20220404200202.9388-2-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220404200202.9388-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 05:02, Mario Limonciello wrote:
> CONFIG_SATA_LPM_MOBILE_POLICY was renamed to CONFIG_SATA_LPM_POLICY in
> commit 4dd4d3deb502 ("ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
> configuration item").
> 
> This caused some pain as users would invisibly lose configuration policy
> defaults when they built the new kernel.  To help alleviate that, switch
> back to the old name (even if it's wrong).
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I applied this manually as the "default 3" is from the first patch, 
which is for 5.19. This one is queued in for-5.18-fixes now. Thanks.

> ---
> v1->v2:
>   * New patch
>   drivers/ata/Kconfig | 6 ++++--
>   drivers/ata/ahci.c  | 2 +-
>   drivers/ata/ahci.h  | 2 +-
>   3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index 3ffe14057ed2..c3194b80c655 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -115,14 +115,16 @@ config SATA_AHCI
>   
>   	  If unsure, say N.
>   
> -config SATA_LPM_POLICY
> +config SATA_MOBILE_LPM_POLICY
>   	int "Default SATA Link Power Management policy for low power chipsets"
>   	range 0 4
>   	default 3
>   	depends on SATA_AHCI
>   	help
>   	  Select the Default SATA Link Power Management (LPM) policy to use
> -	  for chipsets / "South Bridges" designated as supporting low power.
> +	  for chipsets / "South Bridges" supporting low-power modes. Such
> +	  chipsets are typically found on most laptops but desktops and
> +	  servers now also widely use chipsets with low power modes support.
>   
>   	  The value set has the following meanings:
>   		0 => Keep firmware settings
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 84456c05e845..397dfd27c90d 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1595,7 +1595,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>   static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>   					   struct ahci_host_priv *hpriv)
>   {
> -	int policy = CONFIG_SATA_LPM_POLICY;
> +	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
>   
>   
>   	/* Ignore processing for chipsets that don't use policy */
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 6ead58c1b6e5..ad11a4c52fbe 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -236,7 +236,7 @@ enum {
>   	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
>   							only registers */
>   	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
> -							SATA_LPM_POLICY
> +							SATA_MOBILE_LPM_POLICY
>   							as default lpm_policy */
>   	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
>   							suspend/resume */


-- 
Damien Le Moal
Western Digital Research

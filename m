Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2195A1CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243205AbiHYWrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiHYWrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:47:16 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DBBC6B4D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661467635; x=1693003635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7bnGiLNDdbzL+OpMhMFod9p6nfLWSX3ijhQ5UCG6Esg=;
  b=HDNqBQimdCq1rgZ5KQ8PDloGAkBLbiTJCd7otnQA9mT0hIs4ruhcw8cs
   dERR+ZFBqgxIZfKrDWhMxSK+Gv/N4DC73fv9dw/5Z58uSEOnsLrzKUwii
   AqRungzLR4v/LnXwWdL1Ybey4Nk+1AJFPue/Zi5QUiji6FX/VJva6UaKQ
   YTk5CB9dCOmw1hwMQY9IKd92b0i867mYel/qhF5eIUPK+0GTNw1kyPgtu
   /nlWxVDMLtMiPOW0MFbffu+5V9Zmw1kCc1iUzFDK/kTd6tiUkdW6dP0jo
   WP2JDiDSIWOVddNGS6WnSfBQleXkCtlJexU11KUxfhpue0ZO0Xn4i7zZm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654531200"; 
   d="scan'208";a="208130788"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2022 06:47:13 +0800
IronPort-SDR: hyRXQzhA/UsU5f55AK0u0WaC9GwwGR8cIPZlc5eknImYVyMC5klsc32FvJXb792JQSqTIYJyXs
 mWWo2RGidEbycW6ghLovdpGxgFIFUMGI7l9lv07J1hPcIQe7e/O4b26dfK66dKws47GOsIYbGm
 cWMjgn8lVdii+JaZU6F63j9oemiS5PM+3yW4vcp6rBEw1qRKGdNsso3JX3fGHcYqWW6z/fyqeZ
 fWizNhZi5bKpTsc8KkDbPhG6RPKYo4omGBMiaBAOOHbmlsIs/ybA48vLjpaNX/Lq3wNfpABx82
 xPrWWOT8dX9rGAdDn9jiYSZM
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:02:27 -0700
IronPort-SDR: mYLVXj45u5XUs2fS6rrmiKsJIvznjTEAAg4dBN2gZlGiM/BYQZJ3XeXva0ykL3YxQXXt1JeuHc
 Xta/ganbkRQfb+CJpJN+lYkf6PgyRmBrdISSgdVX+l3kIbY8gt27EiYf++hHDwCWQ1zAQDcQmh
 Zm8t7+7Mbijg1dOMzyGtk85sKWa3NkNIeiXmYFvwRRdto+TG+QtURKfiWYHCGgKo2PWR63KNdo
 T20xqzdCkOEDlnko4b7loMIM94LPOKTmxMscJw3W93wswE4CjsFFXYEVD9t5XXr3gPsUvE3HEH
 rA4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2022 15:47:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MDJ4d3JYxz1Rwnm
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:47:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1661467632; x=1664059633; bh=7bnGiLNDdbzL+OpMhMFod9p6nfLWSX3ijhQ
        5UCG6Esg=; b=ChLCjB459DayV0tnQC/b/cC8cpPYrEtomZvVzvcOv4jwS0z1XvQ
        NEL6kQc0kY46ydvMNqDvmAqI8pzwO55TqexKxcb7gAd/3H6LaPWKuU2hbdigFFPD
        VEZ+Wk8RiUxIz5cJwAxd8D2HzabWrrI8A1sImw8+sFnFPSY1F8BP2eLilWRxe2Dc
        D2vWHxCNRM5WGZ5hQMWovv7B9E9UNLVGge1UUI0YXFRkNGGZYtDdQPVsxpqJbxVh
        Prd1Ybya/O8C8h8AszsqjHuX95mhZaEcHsICUEZoRRPjDtNqA3JBSCgKy5NhFshI
        It4m44/HRGnu5JOHsr321zS+596peYuJa0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CWGoQ5lU4udR for <linux-kernel@vger.kernel.org>;
        Thu, 25 Aug 2022 15:47:12 -0700 (PDT)
Received: from [10.225.163.46] (unknown [10.225.163.46])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MDJ4c1FcJz1RtVk;
        Thu, 25 Aug 2022 15:47:12 -0700 (PDT)
Message-ID: <d8c72b2b-3962-786e-e87b-18be4b511637@opensource.wdc.com>
Date:   Fri, 26 Aug 2022 07:47:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3] ata: ahci: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <12054041.O9o76ZdvQC@kreacher>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <12054041.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 03:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> use low-power S0 idle on the given platform than S3 (provided that
> the latter is supported) and it doesn't preclude using either of
> them (which of them will be used depends on the choices made by user
> space).
> 
> For this reason, there is no benefit from checking that flag in
> ahci_update_initial_lpm_policy().
> 
> First off, it cannot be a bug to do S3 with policy set to either
> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
> protect the S3-capable systems from failing.
> 
> Second, suspend-to-idle can be carried out on a system with
> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
> needed to handle that case correctly, it should be done regardless of
> the ACPI_FADT_LOW_POWER_S0 value.
> 
> Accordingly, replace the ACPI_FADT_LOW_POWER_S0 check in
> ahci_update_initial_lpm_policy() with pm_suspend_default_s2idle()
> which is more general and also takes the user's preference into
> account and drop the CONFIG_ACPI #ifdef around it that is not necessary
> any more.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied to for-6.1. Thanks !

> ---
> 
> v2 -> v3:
>    * Use pm_suspend_default_s2idle() instead of the check being dropped.
>    * Update the changelog.
> 
> v1 -> v2:
>    * Adjust subject (Damien).
>    * Drop #ifdef CONFIG_ACPI that is not necessary any more (Mario).
>    * Update the changelog.
> 
> ---
>  drivers/ata/ahci.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/ata/ahci.c
> ===================================================================
> --- linux-pm.orig/drivers/ata/ahci.c
> +++ linux-pm/drivers/ata/ahci.c
> @@ -1609,15 +1609,12 @@ static void ahci_update_initial_lpm_poli
>  		goto update_policy;
>  	}
>  
> -#ifdef CONFIG_ACPI
> -	if (policy > ATA_LPM_MED_POWER &&
> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> +	if (policy > ATA_LPM_MED_POWER && pm_suspend_default_s2idle()) {
>  		if (hpriv->cap & HOST_CAP_PART)
>  			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>  		else if (hpriv->cap & HOST_CAP_SSC)
>  			policy = ATA_LPM_MIN_POWER;
>  	}
> -#endif
>  
>  update_policy:
>  	if (policy >= ATA_LPM_UNKNOWN && policy <= ATA_LPM_MIN_POWER)
> 
> 
> 


-- 
Damien Le Moal
Western Digital Research

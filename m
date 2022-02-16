Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C64B87F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiBPMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:44:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiBPMoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:44:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2855A25B2FC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645015448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Zcog3cik3bGjNock09Ii/aUv14bgaGz4QSyjfBiDCg=;
        b=GSq3SA/zGdbqC3LoAZl6Swd8FELkuVsS4lFcbXQmo5jqwiLkKu/4bjrDnjcbhV0mhLwmDq
        MHT4XPI92o2HSKA3dLCSFe4h5BgSlnsyOs8dRRpCM75DrJGxm4g84OR8ZUotyaMiSO4Un9
        2sZTKKJ1YdWVpx+sFlvv8lPPy6DyBoo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-QG9oovbnOWm81Xgvz7Br6w-1; Wed, 16 Feb 2022 07:44:06 -0500
X-MC-Unique: QG9oovbnOWm81Xgvz7Br6w-1
Received: by mail-ed1-f71.google.com with SMTP id y13-20020aa7c24d000000b00411925b7829so1304092edo.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6Zcog3cik3bGjNock09Ii/aUv14bgaGz4QSyjfBiDCg=;
        b=tDDapEx2/7LHNgDMIM9F8g/jFyi4Pjso+W0E47N7zSX8WuGD4AYFjAW6hYf4ihB7iF
         cbH6qTRQ/BxDQ6wZyELpn6RqdR5b9qogGl99u9uxPLiBtyqEjh77IdAB3IhFWMmtYzZc
         nRFigS6WV29uiUw+dxWaepNCuCURKzcMD/9oFlbky5W5mxLMIa2HCVAywJei9TbBH9S3
         52T+O8ZhKMdZwsmhnEEfzMy9Ho618b2nQ6+iVL8ABXCBU7rYlJKgfIJCATCh2mSvkk7m
         FlxQQ6phRtVC10lm19VZJtIvE8Qn3dhYgcyxw4B+NwhiI8aZZwUiFiJNQDCPuPy2ZeMO
         iuCQ==
X-Gm-Message-State: AOAM5334fcVl94c2zgsCB/LAVa6o2dWMy1F7IEx3N1hU2Gf0Tbs+zici
        rZvz2SSd8ppcqgAZh/oHVaX4hWdAq0/Qo0axloaNy1ar8TLg+wpDt1Jvetcl4498T7G5/pa48WR
        w+aoc7gtN/JNS52Y9BmA7irS5
X-Received: by 2002:aa7:df1a:0:b0:409:5174:68a9 with SMTP id c26-20020aa7df1a000000b00409517468a9mr2828906edy.145.1645015445494;
        Wed, 16 Feb 2022 04:44:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfmmjsKy8cMPXhvStBzpKHYBpkq8niES5JkbPmhPNNa6/pgM0iDQnierLaeOdoUQwq4nWl6w==
X-Received: by 2002:aa7:df1a:0:b0:409:5174:68a9 with SMTP id c26-20020aa7df1a000000b00409517468a9mr2828885edy.145.1645015445278;
        Wed, 16 Feb 2022 04:44:05 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id q10sm12870701ejn.3.2022.02.16.04.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 04:44:04 -0800 (PST)
Message-ID: <d3287f3c-a0d7-7540-c4b5-388363b34628@redhat.com>
Date:   Wed, 16 Feb 2022 13:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 3/3] ata: ahci: Rename CONFIG_SATA_LPM_MOBILE_POLICY
 configuration item
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, pmenzel@molgen.mpg.de
References: <20220216025934.1892723-1-mario.limonciello@amd.com>
 <20220216025934.1892723-3-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220216025934.1892723-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/16/22 03:59, Mario Limonciello wrote:
> `CONFIG_SATA_LPM_MOBILE_POLICY` reflects a configuration to apply only to
> mobile chipsets.  As some desktop boards may want to use this policy by
> default as well, rename the configuration item to `SATA_LPM_POLICY`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/ata/Kconfig | 6 +++---
>  drivers/ata/ahci.c  | 2 +-
>  drivers/ata/ahci.h  | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index cb54631fd950..52c086f155f0 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -115,14 +115,14 @@ config SATA_AHCI
>  
>  	  If unsure, say N.
>  
> -config SATA_MOBILE_LPM_POLICY
> -	int "Default SATA Link Power Management policy for mobile chipsets"
> +config SATA_LPM_POLICY

Maybe "config SATA_DEFAULT_LPM_POLICY" at least that matches the summary text better ?

> +	int "Default SATA Link Power Management policy for supported chipsets"
>  	range 0 4
>  	default 0
>  	depends on SATA_AHCI
>  	help
>  	  Select the Default SATA Link Power Management (LPM) policy to use
> -	  for mobile / laptop variants of chipsets / "South Bridges".
> +	  for certain chipsets / "South Bridges".

Maybe:

for chipsets where using a different default policy then max_performance
is deemed desirable.

Yeah no, that IMHO is no good either, but "certain" also is very much
not helpful in this help text.

Looking at this patch I'm starting to think that maybe the maybe mobile was not
that bad of a name after all :)

Maybe for v2 do s/mobile/low_power/ in each of the patches instead?

Regards,

Hans











>  
>  	  The value set has the following meanings:
>  		0 => Keep firmware settings
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 5be889de9b1e..7a7fa1090bb0 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -1592,7 +1592,7 @@ static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
>  static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  					   struct ahci_host_priv *hpriv)
>  {
> -	int policy = CONFIG_SATA_MOBILE_LPM_POLICY;
> +	int policy = CONFIG_SATA_LPM_POLICY;
>  
>  
>  	/* Ignore processing for chipsets that don't use policy */
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 1ad48e2fe573..5badbaca05a0 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -236,7 +236,7 @@ enum {
>  	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
>  							only registers */
>  	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
> -							SATA_MOBILE_LPM_POLICY
> +							SATA_LPM_POLICY
>  							as default lpm_policy */
>  	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
>  							suspend/resume */
> 


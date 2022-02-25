Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339B44C506E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbiBYVOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiBYVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:14:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02EE7182DAB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645823633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/yDZp0QIlvOMp3d/09RLCVQWT0E/Mn5hK04vODPthUs=;
        b=ibQ/TG5SRj/DDlVchfqAjMtN5MkDyIgKqlbDKJBItIxxZ0vaKzbssl2TzsoDJ0Jouv9x6C
        GN1F4WzXrjS1dOfzPWa+4f/+C4Fo5IfZaNx1E+GbmUNmUAqF3//8NPvBINDUC6FLfjH+ti
        qRE3KjLOKDK1soUY3qrociz8xnBKOoA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-1wxSPgZOOkespvUHFd_8_g-1; Fri, 25 Feb 2022 16:13:51 -0500
X-MC-Unique: 1wxSPgZOOkespvUHFd_8_g-1
Received: by mail-ej1-f71.google.com with SMTP id sa7-20020a170906eda700b006d1b130d65bso3095986ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/yDZp0QIlvOMp3d/09RLCVQWT0E/Mn5hK04vODPthUs=;
        b=r7JE8nyNSykMVUd+ko7h48dIidD1ScfPF/4mb28ATo8RNzYIqLs9etobvKvLsF2FdI
         X1B13jIHn3dzGPnSti8LEcQoP5HmyBpaQqAYJ4ZTwSFVqA9fZkDs7sKqpdUkN6os0xln
         5DjVE7PDjdnrefEeBjtTGuBDIcsahy8gbGQjKHjrdgGdJgPONaOlBrKZRliaUb8P3U18
         jiNfgOBHudpR9YgAKG8Ajk9t50z0VpceR4Yfb0QOf+5hHMIcUoevO5jHdha/jArI8Ore
         q7hbngwRkWO8aCdT3ZDh+T5L3nPXGjw/YsNq19NgchKWmFLA7X5iUoZ1a1P69a+mPPj9
         9ylQ==
X-Gm-Message-State: AOAM5312vRY8/BZvGMqkieJFuhj5GR7NC8hgHtDsEvn03USZEHTZDb+N
        E/r2OFfkmG1ouO9MhL3F5REAz9OKPfU6GorttswFMM9KP2g00wTaB084wYdd3Re17gPTMloNqK8
        wYQwYb0h8LS63Wqewj5LQPTCT
X-Received: by 2002:a17:906:82c4:b0:6b7:e0fc:c9e0 with SMTP id a4-20020a17090682c400b006b7e0fcc9e0mr7889654ejy.555.1645823630134;
        Fri, 25 Feb 2022 13:13:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJySk3r/AcVl9qG9Y4vEvlqAF3q8syx4SgFtm3zj6oTTuXo4fa0nJGlatsJm0Nts8rquOPTPcA==
X-Received: by 2002:a17:906:82c4:b0:6b7:e0fc:c9e0 with SMTP id a4-20020a17090682c400b006b7e0fcc9e0mr7889635ejy.555.1645823629816;
        Fri, 25 Feb 2022 13:13:49 -0800 (PST)
Received: from ?IPV6:2a0e:5700:4:11:334c:7e36:8d57:40cb? ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id la3-20020a170906ad8300b006d0562a1011sm1421495ejb.21.2022.02.25.13.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 13:13:49 -0800 (PST)
Message-ID: <52ed571d-0e46-9eb3-33e4-0221eea2f5d7@redhat.com>
Date:   Fri, 25 Feb 2022 22:13:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC 1/2] ata: ahci: Drop low power policy board type
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
References: <20220225181030.980223-1-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220225181030.980223-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/25/22 19:10, Mario Limonciello wrote:
> The low power policy board type was introduced to allow systems
> to get into deep states reliably.  Before it was introduced `min_power`
> was causing problems for a number of drives.  New power policies
> `min_power_with_partial` and `med_power_with_dipm` have been introduced
> which provide a more stable baseline for systems.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

As I already said in the other email thread about this:

I'm not going to block this if people want
to give this a try, but it is going to require someone keeping
a very close look at any issues popping up and we must be
prepared to roll-back the change if necessary.

Regards,

Hans





> ---
>  drivers/ata/Kconfig |   2 +-
>  drivers/ata/ahci.c  | 105 +++++++++++++++++++-------------------------
>  drivers/ata/ahci.h  |   9 ++--
>  3 files changed, 50 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index cb9e71b4ca4d..3624d56d32b4 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -116,7 +116,7 @@ config SATA_AHCI
>  	  If unsure, say N.
>  
>  config SATA_LPM_POLICY
> -	int "Default SATA Link Power Management policy for low power chipsets"
> +	int "Default SATA Link Power Management policy"
>  	range 0 4
>  	default 0
>  	depends on SATA_AHCI
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ffaad9eaa79d..17d757ad7111 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -50,7 +50,6 @@ enum board_ids {
>  	/* board IDs by feature in alphabetical order */
>  	board_ahci,
>  	board_ahci_ign_iferr,
> -	board_ahci_low_power,
>  	board_ahci_no_debounce_delay,
>  	board_ahci_nomsi,
>  	board_ahci_noncq,
> @@ -135,13 +134,6 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> -	[board_ahci_low_power] = {
> -		AHCI_HFLAGS	(AHCI_HFLAG_USE_LPM_POLICY),
> -		.flags		= AHCI_FLAG_COMMON,
> -		.pio_mask	= ATA_PIO4,
> -		.udma_mask	= ATA_UDMA6,
> -		.port_ops	= &ahci_ops,
> -	},
>  	[board_ahci_no_debounce_delay] = {
>  		.flags		= AHCI_FLAG_COMMON,
>  		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
> @@ -275,13 +267,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
> @@ -291,9 +283,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci }, /* PCH M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci }, /* PCH M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
> @@ -316,9 +308,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci }, /* CPT M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci }, /* CPT M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
> @@ -327,29 +319,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci }, /* Panther M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci }, /* Panther M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci }, /* Lynx M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci }, /* Lynx M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci }, /* Lynx M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon Lake PCH-LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci }, /* Cannon Lake PCH-LP AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
> @@ -381,26 +373,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci }, /* Wildcat LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci }, /* Wildcat LP RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci }, /* 9 Series M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci }, /* 9 Series M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci }, /* 9 Series M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci }, /* Sunrise LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci }, /* Sunrise LP RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
> -	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci }, /* Sunrise M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise M RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci }, /* Sunrise M RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
> @@ -413,13 +405,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
> -	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry Tr. AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci }, /* Cherry Tr. AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci }, /* ApolloLake AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci }, /* Ice Lake LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci }, /* Comet Lake PCH-U AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci }, /* Comet Lake PCH RAID */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> @@ -447,7 +439,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>  	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> -	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci }, /* AMD Green Sardine */
>  	/* AMD is using RAID class only for ahci controllers */
>  	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
> @@ -1594,11 +1586,6 @@ static void ahci_update_initial_lpm_policy(struct ata_port *ap,
>  {
>  	int policy = CONFIG_SATA_LPM_POLICY;
>  
> -
> -	/* Ignore processing for chipsets that don't use policy */
> -	if (!(hpriv->flags & AHCI_HFLAG_USE_LPM_POLICY))
> -		return;
> -
>  	/* user modified policy via module param */
>  	if (mobile_lpm_policy != -1) {
>  		policy = mobile_lpm_policy;
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 5badbaca05a0..a2ca78e1df5c 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -235,14 +235,11 @@ enum {
>  	AHCI_HFLAG_YES_ALPM		= (1 << 23), /* force ALPM cap on */
>  	AHCI_HFLAG_NO_WRITE_TO_RO	= (1 << 24), /* don't write to read
>  							only registers */
> -	AHCI_HFLAG_USE_LPM_POLICY	= (1 << 25), /* chipset that should use
> -							SATA_LPM_POLICY
> -							as default lpm_policy */
> -	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 26), /* handle PHYs during
> +	AHCI_HFLAG_SUSPEND_PHYS		= (1 << 25), /* handle PHYs during
>  							suspend/resume */
> -	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 27), /* ignore -EOPNOTSUPP
> +	AHCI_HFLAG_IGN_NOTSUPP_POWER_ON	= (1 << 26), /* ignore -EOPNOTSUPP
>  							from phy_power_on() */
> -	AHCI_HFLAG_NO_SXS		= (1 << 28), /* SXS not supported */
> +	AHCI_HFLAG_NO_SXS		= (1 << 27), /* SXS not supported */
>  
>  	/* ap->flags bits */
>  


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82E94C3E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiBYGdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiBYGds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:33:48 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EE26836C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645770796; x=1677306796;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DKdzJdz7X3MBlw1+mq3OGMFxMSG4czrPtbHLlI2wBgo=;
  b=HT1RUOuDhDmeuiUlQjlblMy1g7+29KqpNF9pv4zwwsbsRxPYBIjxk1+s
   s1Tf38w0js+C312jjegmdQ0oqNflaufIlsHWbiSFD9EceHU2sg3bks8by
   atVO5zQgb43Y7zEtI3fX+vnXytU/0vpYAiRlnAqVtdJP6/IR7ELzVkYQl
   1LEE8JlyJx1bKQ9mvni/RtPoYLxKc0+3zqJm/psRUh8s5JUGPR+JxmN/f
   dGtjrfo9UY4GYG+0qBvj6JBo/CWKobQJ1VVLEAkHNJVfaVk1FWffLfB9V
   CdaXUyCZCpYfk7wmpZj4sHV1qE532GWKyzK66y471tXQj/UOikdRWocy/
   A==;
X-IronPort-AV: E=Sophos;i="5.90,135,1643644800"; 
   d="scan'208";a="192847079"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2022 14:33:15 +0800
IronPort-SDR: ir9T2xNXzZV1RBVsRJtXGaj51765ZqShwfF5HdfLU5qsdldmPm4tZzs3vsoCLVjTq4irkzl2NJ
 6KO0ej4vBqps8Qaxo9g5xee7m4EsgK2clKGFfW5eYaabcrey0rxrHjkRI9Z5snLzxbfzZOHH5Z
 QKeOwJ1xi6+/yiHrdjFYd29EXQcVOdZ+AgA87gX3TJ4rB3HoHFjCYPN6zam0PdMqONVLfgZs9b
 1FNOGvu0NRhpHvF/YiNG9tzDCfcM0+6TeJLAJQpFMAGA6uV5MhX02gNFUwRvwflkxcHjQADh9h
 sDP5SHTxZly3Nw7wgGSWe8vY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 22:05:49 -0800
IronPort-SDR: 44jzajvkLfRSwuGuebn11dsJwksrdgYi30HjrQWvouzMRwkNYbvCRN7/hcjehAOqn7uvq2DCf9
 Bd9A3OMDHAAcK2RxS/BT7uCRNivWbhAnKZdYQUPg1VSXIayd/JTC+f2DjllmKs0KIcpmQFSmAT
 tZDnjMPioq137cBDLbX8ENxla/fakUvDF/hq9uB8O6vZCowV4PJ+q/6W7rgR3aRgJcL1a5m6ah
 9ecjFdV7k9Xn4H9H10f32n6Sq7HVRMngizoZVslm51N8DNB+LmIo8UWwK+DRViSH0RukxRW/v1
 u8Q=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 22:33:15 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K4g2L5gtPz1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 22:33:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645770793; x=1648362794; bh=DKdzJdz7X3MBlw1+mq3OGMFxMSG4czrPtbH
        LlI2wBgo=; b=R37kIYa+9LtyS2jMIESt4QMI3BLlrWE5lmdF8wn2Vm9UWwBKnV8
        3sgcAD8+s/t2Ao9EquE4Qem3oNbd+QdaeoBZepr88pS1vfR52W7O6mP0QpNi5TYl
        MuDMx/tg5qyRQG9Y5yufUn9FX3EZedPRFDzxr94ykea31DA5GT0bO9vDw+vjYo9j
        XUbgyEZt+54kuJqe1yTauTZYHMmfyQM6j9Ml9g+VbiF1vG4ae27iM1mSG+TUrPCn
        WA5nZafOLsLuF4HoQyRtYh/JFaHtBs4BR5IqaCYcRI1wJkCCNmnGOtwiXBiKqswM
        lt6DxkrFWFvBoUoyplR1QHl9Bm8zzyv6P2g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hOJY7Kw_7-g7 for <linux-kernel@vger.kernel.org>;
        Thu, 24 Feb 2022 22:33:13 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K4g2J70X7z1Rvlx;
        Thu, 24 Feb 2022 22:33:12 -0800 (PST)
Message-ID: <8b809200-189d-940d-4a32-dc74cde6b626@opensource.wdc.com>
Date:   Fri, 25 Feb 2022 15:33:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] ata: ahci: Rename board_ahci_mobile
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        pmenzel@molgen.mpg.de, hdegoede@redhat.com
References: <20220225061113.223920-1-mario.limonciello@amd.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220225061113.223920-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 15:11, Mario Limonciello wrote:
> This board definition was originally created for mobile devices to
> designate default link power managmeent policy to influence runtime
> power consumption.
> 
> As this is interesting for more than just mobile designs, rename the
> board to `board_ahci_low_power` to make it clear it is about default
> policy.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> changes from v1->v2:
>  * Rename to board_ahci_low_power
> 
>  drivers/ata/ahci.c | 96 +++++++++++++++++++++++-----------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index ab5811ef5a53..995ef962eb92 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -49,8 +49,8 @@ enum {
>  enum board_ids {
>  	/* board IDs by feature in alphabetical order */
>  	board_ahci,
> +	board_ahci_low_power,

Nit: please keep the alphabetical order.

>  	board_ahci_ign_iferr,
> -	board_ahci_mobile,
>  	board_ahci_no_debounce_delay,
>  	board_ahci_nomsi,
>  	board_ahci_noncq,
> @@ -135,7 +135,7 @@ static const struct ata_port_info ahci_port_info[] = {
>  		.udma_mask	= ATA_UDMA6,
>  		.port_ops	= &ahci_ops,
>  	},
> -	[board_ahci_mobile] = {
> +	[board_ahci_low_power] = {
>  		AHCI_HFLAGS	(AHCI_HFLAG_IS_MOBILE),
>  		.flags		= AHCI_FLAG_COMMON,
>  		.pio_mask	= ATA_PIO4,
> @@ -275,13 +275,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
>  	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_mobile }, /* ICH9M */
> -	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_mobile }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
> -	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_mobile }, /* ICH9M */
> +	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
>  	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>  	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
> @@ -291,9 +291,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_mobile }, /* PCH M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
> -	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
> @@ -316,9 +316,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_mobile }, /* CPT M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
> @@ -327,29 +327,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG/Lewisburg RAID*/
>  	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_mobile }, /* Panther M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_mobile }, /* Lynx M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_mobile }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_mobile }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_mobile }, /* Lynx M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_mobile }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_mobile }, /* Lynx LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon Lake PCH-LP AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
> @@ -381,26 +381,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
>  	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_mobile }, /* Wildcat LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_mobile }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_mobile }, /* Wildcat LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_mobile }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat LP RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_mobile }, /* 9 Series M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_mobile }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_mobile }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series M RAID */
>  	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
> -	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_mobile }, /* 9 Series M RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_mobile }, /* Sunrise LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_mobile }, /* Sunrise LP RAID */
> -	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_mobile }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series M RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise LP RAID */
> +	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise LP RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
> -	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_mobile }, /* Sunrise M AHCI */
> +	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise M AHCI */
>  	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
> -	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
> +	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise M RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa182), board_ahci }, /* Lewisburg AHCI*/
>  	{ PCI_VDEVICE(INTEL, 0xa186), board_ahci }, /* Lewisburg RAID*/
> @@ -413,13 +413,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
>  	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
> -	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_mobile }, /* Comet Lake PCH-U AHCI */
> -	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
> +	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trail AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry Tr. AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLake AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
> +	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
>  
>  	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
>  	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> @@ -447,7 +447,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>  	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>  	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
>  	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> -	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
>  	/* AMD is using RAID class only for ahci controllers */
>  	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>  	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },


-- 
Damien Le Moal
Western Digital Research

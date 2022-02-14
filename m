Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223ED4B4341
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240706AbiBNIHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:07:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiBNIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:07:51 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65755F27B;
        Mon, 14 Feb 2022 00:07:42 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aebfe.dynamic.kabel-deutschland.de [95.90.235.254])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id A6BA961EA1924;
        Mon, 14 Feb 2022 09:07:39 +0100 (CET)
Message-ID: <960946b8-8f73-9f81-735a-64e5cc555a9c@molgen.mpg.de>
Date:   Mon, 14 Feb 2022 09:07:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/2] ahci: Add Green Sardine vendor ID as
 board_ahci_mobile
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
References: <20211112201539.17377-1-mario.limonciello@amd.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211112201539.17377-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mario,


(For the records, is part of Linux since 5.16-rc2 (commit 1527f69204fe).)

Am 12.11.21 um 21:15 schrieb Mario Limonciello:
> AMD requires that the SATA controller be configured for devsleep in order
> for S0i3 entry to work properly.
> 
> commit b1a9585cc396 ("ata: ahci: Enable DEVSLP by default on x86 with
> SLP_S0") sets up a kernel policy to enable devsleep on Intel mobile
> platforms that are using s0ix.  Add the PCI ID for the SATA controller in
> Green Sardine platforms to extend this policy by default for AMD based
> systems using s0i3 as well.
> 
> Cc: Nehal-bakulchandra Shah <Nehal-bakulchandra.Shah@amd.com>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/ata/ahci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index d60f34718b5d..1e1167e725a4 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -438,6 +438,7 @@ static const struct pci_device_id ahci_pci_tbl[] = {
>   	/* AMD */
>   	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
>   	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
> +	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */

Aren’t 0x7900 and 0x7901 the same device only in different modes? I 
wonder, why different boards and different comments are used.

Additionally, the device 0x7901 is also present in desktop systems like 
Dell OptiPlex 5055 and MSI B350 MORTAR. Is `board_ahci_mobile` the right 
board then? Or should the flag `AHCI_HFLAG_IS_MOBILE` be renamed to 
avoid confusion?

>   	/* AMD is using RAID class only for ahci controllers */
>   	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
>   	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },


Kind regards,

Paul

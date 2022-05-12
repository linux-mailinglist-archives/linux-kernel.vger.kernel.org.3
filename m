Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526E52466E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350700AbiELHFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350655AbiELHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:05:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B162A2A;
        Thu, 12 May 2022 00:05:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 277F921C96;
        Thu, 12 May 2022 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652339102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYEZIJCb/ziOe6Si9v0MsJ0j4uOo99EQ+8585TVoH+U=;
        b=ywnzkHHG4yupE80RAODPrmWcc4SSpMHkyRg+y8KsPUTcw8fTH21wSB/XqFl4mnCsKFjOBR
        g1dEV3vkPc4g6OTJeZD50mXBPEAy4laTSjDAJFtr9f8Q7B7WICDWOPlIggrFttYg1HTW3x
        uYc6A8EYk2Sx9EaF1yfggtpdxUNfrUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652339102;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYEZIJCb/ziOe6Si9v0MsJ0j4uOo99EQ+8585TVoH+U=;
        b=QTIzOzdhB0V5K7cQEnabpR9zxk9UKt0DK2bR762wRxAg0MfdACvm/+AiX/QWFa3wqEoPex
        PY1fSmdyGt4KfRCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAF0C13A97;
        Thu, 12 May 2022 07:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fEorNZ2xfGKxXAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 07:05:01 +0000
Message-ID: <122e0019-4bee-f469-5e04-a9fbc66f3313@suse.de>
Date:   Thu, 12 May 2022 09:05:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 17/23] ata: ahci: Introduce firmware-specific caps
 initialization
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-18-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-18-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/22 01:18, Serge Semin wrote:
> There are systems with no BIOS or comprehensive embedded firmware which
> could be able to properly initialize the SATA AHCI controller
> platform-specific capabilities. In that case a good alternative to having
> a clever bootloader is to create a device tree node with the properties
> well describing all the AHCI-related platform specifics. All the settings
> which are normally detected and marked as available in the HBA and its
> ports capabilities fields [1] could be defined in the platform DTB by
> means of a set of the dedicated properties. Such approach perfectly fits
> to the DTB-philosophy - to provide hardware/platform description.
> 
> So here we suggest to extend the SATA AHCI device tree bindings with the
> next set of additional DT boolean properties:
> 1) hba-sss - Controller supports Staggered Spin-up.
> 2) hba-smps - Mechanical Presence Switch is support by controller.
> 3) hba-hpcp - Hot Plug Capable Port.
> 4) hba-mpsp - Mechanical Presence Switch Attached to Port.
> 5) hba-cpd - Cold Presence Detection.
> 6) hba-esp - External SATA Port.
> 7) hba-fbscp - FIS-based Switching Capable Port.
> All of these capabilities require to have a corresponding hardware
> configuration. Thus it's ok to have them defined in DTB.
> 
> Even though the driver currently takes into account the state of the ESP
> and FBSCP flags state only, there is nothing wrong with having all them
> supported by the generic AHCI library in order to have a complete OF-based
> platform-capabilities initialization procedure. These properties will be
> parsed in the ahci_platform_get_resources() method and their values will
> be stored in the saved_* fields of the ahci_host_priv structure, which in
> its turn then will be used to restore the H.CAP, H.PI and P#.CMD
> capability fields on device init and after HBA reset.
> 
> Please note this modification concerns the HW-init HBA and its ports flags
> only, which are by specification [1] are supposed to be initialized by the
> BIOS/platform firmware/expansion ROM and which are normally declared in
> the one-time-writable-after-reset register fields. Even though these flags
> aren't supposed to be cleared after HBA reset some AHCI instances may
> violate that rule so we still need to perform the fields resetting after
> each reset. Luckily the corresponding functionality has already been
> partly implemented in the framework of the ahci_save_initial_config() and
> ahci_restore_initial_config() methods.
> 
> [1] Serial ATA AHCI 1.3.1 Specification, p. 103
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   drivers/ata/ahci.h             |  1 +
>   drivers/ata/libahci.c          | 51 ++++++++++++++++++++++++++++------
>   drivers/ata/libahci_platform.c | 51 ++++++++++++++++++++++++++++++++--
>   3 files changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> index 8b9826533ae5..0de221055961 100644
> --- a/drivers/ata/ahci.h
> +++ b/drivers/ata/ahci.h
> @@ -337,6 +337,7 @@ struct ahci_host_priv {
>   	u32			saved_cap;	/* saved initial cap */
>   	u32			saved_cap2;	/* saved initial cap2 */
>   	u32			saved_port_map;	/* saved initial port_map */
> +	u32			saved_port_cap[AHCI_MAX_PORTS]; /* saved port_cap */
>   	u32 			em_loc; /* enclosure management location */
>   	u32			em_buf_sz;	/* EM buffer size in byte */
>   	u32			em_msg_type;	/* EM message type */
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 1ffaa5f5f21a..763ff1058da6 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -16,6 +16,7 @@
>    * http://www.intel.com/technology/serialata/pdf/rev1_1.pdf
>    */
>   
> +#include <linux/bitops.h>
>   #include <linux/kernel.h>
>   #include <linux/gfp.h>
>   #include <linux/module.h>
> @@ -443,16 +444,28 @@ static ssize_t ahci_show_em_supported(struct device *dev,
>   void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>   {
>   	void __iomem *mmio = hpriv->mmio;
> -	u32 cap, cap2, vers, port_map;
> +	void __iomem *port_mmio;
> +	unsigned long port_map;

Why is this an 'unsigned long' now? I thought we could have only 32 ports?

> +	u32 cap, cap2, vers;
>   	int i;
>   
>   	/* make sure AHCI mode is enabled before accessing CAP */
>   	ahci_enable_ahci(mmio);
>   
> -	/* Values prefixed with saved_ are written back to host after
> -	 * reset.  Values without are used for driver operation.
> +	/*
> +	 * Values prefixed with saved_ are written back to the HBA and ports
> +	 * registers after reset. Values without are used for driver operation.
> +	 */
> +
> +	/*
> +	 * Override HW-init HBA capability fields with platform-specific values.
> +	 * The rest of the HBA capabilities are defined with strictly RO flags
> +	 * and can't be modified in CSR anyway.
>   	 */
> -	hpriv->saved_cap = cap = readl(mmio + HOST_CAP);
> +	cap = readl(mmio + HOST_CAP);
> +	if (hpriv->saved_cap)
> +		cap = (cap & ~(HOST_CAP_SSS | HOST_CAP_MPS)) | hpriv->saved_cap;
> +	hpriv->saved_cap = cap;
>   
>   	/* CAP2 register is only defined for AHCI 1.2 and later */
>   	vers = readl(mmio + HOST_VERSION);
> @@ -519,7 +532,7 @@ void ahci_save_initial_config(struct device *dev, struct ahci_host_priv *hpriv)
>   	/* Override the HBA ports mapping if the platform needs it */
>   	port_map = readl(mmio + HOST_PORTS_IMPL);

And we're still using 'readl', so we will only initialize 32 bits ...

>   	if (hpriv->saved_port_map && port_map != hpriv->saved_port_map) {

Tsk. And now comparing is to a u32 ...

Please change it back to be 32 bits.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

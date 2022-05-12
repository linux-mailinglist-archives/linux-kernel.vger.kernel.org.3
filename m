Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6F65245E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350435AbiELGcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343684AbiELGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:32:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDE2B265;
        Wed, 11 May 2022 23:32:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 10CF81F8F4;
        Thu, 12 May 2022 06:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652337158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1dnGRodwZfQvAzAQyphqZSe/zqVMsDCqlcuW+HAnWk=;
        b=x8L5kNHi+f3EH7tGI41yh0aG4m6uxELC+cJz1wfF9AKrje+b/4nY6OoVwe8Kgag5F22EUc
        GVuNOIPgvnMDF5DUIpgXAUzSJckwGu5q3OrDUQWrG+wxp336lxpD0eB10z9QNsOJ6eTZQ+
        kwtFIjRXUVjhEb4tFSxqwbhBWwyfSWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652337158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D1dnGRodwZfQvAzAQyphqZSe/zqVMsDCqlcuW+HAnWk=;
        b=fldwxa8pn+j2CO04dAvZ+AhIi1++2POneQnfDum8X5iY7F5IfacSKuE8k89SU491ptpXZ2
        c+7LLCdiYoX9xyCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5C2713ABE;
        Thu, 12 May 2022 06:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0QnfMwWqfGJDUAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:32:37 +0000
Message-ID: <0732a28c-579e-52f8-21ad-653fd9a10aa2@suse.de>
Date:   Thu, 12 May 2022 08:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 08/23] ata: libahci_platform: Add function returning a
 clock-handle by id
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
 <20220511231810.4928-9-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-9-Sergey.Semin@baikalelectronics.ru>
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

On 5/12/22 01:17, Serge Semin wrote:
> Since all the clocks are retrieved by the method
> ahci_platform_get_resources() there is no need for the LLD (glue) drivers
> to be looking for some particular of them in the kernel clocks table
> again. Instead we suggest to add a simple method returning a
> device-specific clock with passed connection ID if it is managed to be
> found. Otherwise the function will return NULL. Thus the glue-drivers
> won't need to either manually touching the hpriv->clks array or calling
> clk_get()-friends. The AHCI platform drivers will be able to use the new
> function right after the ahci_platform_get_resources() method invocation
> and up to the device removal.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Fix some grammar mistakes in the method description.
> ---
>   drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
>   include/linux/ahci_platform.h  |  3 +++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 3cff86c225fd..7ff6626fd569 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
>   }
>   EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
>   
> +/**
> + * ahci_platform_find_clk - Find platform clock
> + * @hpriv: host private area to store config values
> + * @con_id: clock connection ID
> + *
> + * This function returns a pointer to the clock descriptor of the clock with
> + * the passed ID.
> + *
> + * RETURNS:
> + * Pointer to the clock descriptor on success otherwise NULL
> + */
> +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
> +{
> +	struct clk *clk = NULL;
> +	int i;
> +
> +	for (i = 0; i < hpriv->n_clks; i++) {
> +		if (!strcmp(hpriv->clks[i].id, con_id)) {
> +			clk = hpriv->clks[i].clk;
> +			break;
> +		}
> +	}
> +
> +	return clk;
> +}
> +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> +
>   /**
>    * ahci_platform_enable_clks - Enable platform clocks
>    * @hpriv: host private area to store config values
> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> index 49e5383d4222..fd964e6a68d6 100644
> --- a/include/linux/ahci_platform.h
> +++ b/include/linux/ahci_platform.h
> @@ -13,6 +13,7 @@
>   
>   #include <linux/compiler.h>
>   
> +struct clk;
>   struct device;
>   struct ata_port_info;
>   struct ahci_host_priv;
> @@ -21,6 +22,8 @@ struct scsi_host_template;
>   
>   int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
>   void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> +struct clk *
> +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
>   int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
>   void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
>   int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);

Where is this function being used?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

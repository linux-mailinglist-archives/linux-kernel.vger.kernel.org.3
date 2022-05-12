Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FF6524619
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbiELGsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiELGs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:48:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA76B7E8;
        Wed, 11 May 2022 23:48:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3A0A1F8F4;
        Thu, 12 May 2022 06:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652338105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eu9dmL37+61LEqPwl8A52yyx9mTfxqzqsNTK2LFvPLQ=;
        b=GINM0xc9jq+k+Rm9dfJBpBb5b9xYd3NSyOFAAM1GqUZofWwqRW0xafLC2TRExNkREM8Cs6
        tp/EaLSZs6qv9kdrKhLQwbLEBA4vkkcJiDOXnWZaRutFi0aM46eUBxJhHOXFEuzyd9SfaH
        2JjjJoGuXX8RinzI5mrEB/Aj3Q/RLZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652338105;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eu9dmL37+61LEqPwl8A52yyx9mTfxqzqsNTK2LFvPLQ=;
        b=OZM1ZcPj2bCc+as8UglJ1d7CTen0JK3v7tACdsnA71o+G83xWyJcNR4pz+ISE12LF5OYqK
        Li91Qrr6y7QZjzBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B51A013ABE;
        Thu, 12 May 2022 06:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iagnKritfGLoVQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:48:24 +0000
Message-ID: <1e349868-b302-1473-188a-1a6f2bb88cd5@suse.de>
Date:   Thu, 12 May 2022 08:48:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-11-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 10/23] ata: libahci_platform: Parse ports-implemented
 property in resources getter
In-Reply-To: <20220511231810.4928-11-Sergey.Semin@baikalelectronics.ru>
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
> The ports-implemented property is mainly used on the OF-based platforms
> with no ports mapping initialized by a bootloader/BIOS firmware. Seeing
> the same of_property_read_u32()-based pattern has already been implemented
> in the generic AHCI LLDD (glue) driver and in the Mediatek, St AHCI
> drivers let's move the property read procedure to the generic
> ahci_platform_get_resources() method. Thus we'll have the forced ports
> mapping feature supported for each OF-based platform which requires that,
> and stop re-implementing the same pattern in there a bit simplifying the
> code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   drivers/ata/ahci_mtk.c         | 2 --
>   drivers/ata/ahci_platform.c    | 3 ---
>   drivers/ata/ahci_st.c          | 3 ---
>   drivers/ata/libahci_platform.c | 3 +++
>   4 files changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
> index 1f6c85fde983..c056378e3e72 100644
> --- a/drivers/ata/ahci_mtk.c
> +++ b/drivers/ata/ahci_mtk.c
> @@ -118,8 +118,6 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
>   				   SYS_CFG_SATA_EN);
>   	}
>   
> -	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
> -
>   	return 0;
>   }
>   
> diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> index 28a8de5b48b9..9b56490ecbc3 100644
> --- a/drivers/ata/ahci_platform.c
> +++ b/drivers/ata/ahci_platform.c
> @@ -56,9 +56,6 @@ static int ahci_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	of_property_read_u32(dev->of_node,
> -			     "ports-implemented", &hpriv->force_port_map);
> -
>   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
>   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
>   
> diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> index 7526653c843b..068621099c00 100644
> --- a/drivers/ata/ahci_st.c
> +++ b/drivers/ata/ahci_st.c
> @@ -168,9 +168,6 @@ static int st_ahci_probe(struct platform_device *pdev)
>   
>   	st_ahci_configure_oob(hpriv->mmio);
>   
> -	of_property_read_u32(dev->of_node,
> -			     "ports-implemented", &hpriv->force_port_map);
> -
>   	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
>   				      &ahci_platform_sht);
>   	if (err) {
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 4e54e19f07b2..f7f9cac10cb1 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -512,6 +512,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   		goto err_out;
>   	}
>   
> +	of_property_read_u32(dev->of_node,
> +			     "ports-implemented", &hpriv->force_port_map);
> +
>   	if (child_nodes) {
>   		for_each_child_of_node(dev->of_node, child) {
>   			u32 port;

What happens on the other platforms?
Won't they register an error if that property isn't implemented?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0699D5245C2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350218AbiELG2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350406AbiELG2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:28:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901D5F8D6;
        Wed, 11 May 2022 23:27:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 19BEA21ACB;
        Thu, 12 May 2022 06:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652336874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Yif5rQWHgrq+WHn14NbPf9qK8+CDYsZFAUQ+p+C2iM=;
        b=NK97LIFCPNWla3WDhxnaKX/cUQmu+IBEFCWDR6Qne3sDHfcLOAfk9oTkX4tKw8mEyaFMNj
        lsGniYn9j9O75NhIqgzWLMGajpHH+fVU74lbofJr5ocHyBIukDPYG0SdiYWoFYlFsBiPNa
        IUvemT8bUL5LCK59GLGMQQDFzKk2ZeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652336874;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Yif5rQWHgrq+WHn14NbPf9qK8+CDYsZFAUQ+p+C2iM=;
        b=A10xl/mGFm1BaaG+a7kggJcQHhrtAtcEFOmhQawcDjOo58ERVivE6zbqsSFhU56UnEuSI0
        5G45mdKef8qFg9CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFAC313ABE;
        Thu, 12 May 2022 06:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u/YAOemofGKUTgAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:27:53 +0000
Message-ID: <4bd4318b-a753-6453-a815-716fbfffab3f@suse.de>
Date:   Thu, 12 May 2022 08:27:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 05/23] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
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
 <20220511231810.4928-6-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-6-Sergey.Semin@baikalelectronics.ru>
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
> It's better for readability and maintainability to explicitly assign an
> error number to the variable used then as a return value from the method
> on the cleanup-on-error path. So adding new code in the method we won't
> have to think whether the overridden rc-variable is set afterward in case
> of an error. Saving one line of code doesn't worth it especially seeing
> the rest of the ahci_platform_get_resources() function errors handling
> blocks do explicitly write errno to rc.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Drop rc variable initialization (@Damien)
> ---
>   drivers/ata/libahci_platform.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 32495ae96567..f7f9bfcfc164 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   	struct ahci_host_priv *hpriv;
>   	struct clk *clk;
>   	struct device_node *child;
> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> +	int i, enabled_ports = 0, rc, child_nodes;
>   	u32 mask_port_map = 0;
>   
>   	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   
>   	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
>   			     GFP_KERNEL);
> -	if (!hpriv)
> +	if (!hpriv) {
> +		rc = -ENOMEM;
>   		goto err_out;
> +	}
>   
>   	devres_add(dev, hpriv);
>   
I disagree.
As 'rc' is now only initialized within a conditional we're risking 'rc' 
will be left uninitialized.
And in the end, it's a matter of style; this patch doesn't change the 
flow of events and the benefits are hard to see.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

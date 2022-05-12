Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554EF5245D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350425AbiELGb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350510AbiELGbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:31:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63506B7F8;
        Wed, 11 May 2022 23:31:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2017921ACB;
        Thu, 12 May 2022 06:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652337074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSlksHatCxuErh8m6va0Tvd5w4S67Q4daZM1+wIIBZQ=;
        b=b5F/GnHtyOkwgPSDiuZ+fi3p1tayUF0PKP7TfAjuL198Pid9iTqOHSBtqgKdxNPXX7Qe0m
        yhuEKtOlT7/xmgL+XWne7a5bqy3ZZ5pXiq8AYZYPq+pvr/7exEATVM+aeIevi0mJ+rRrS9
        8A9vW8E14CS1c7vevDKE4Oak/q4Z5Q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652337074;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSlksHatCxuErh8m6va0Tvd5w4S67Q4daZM1+wIIBZQ=;
        b=8Ew4CvB/RZkqIa9AFGxzxR2aJw5JHFV+/W55HOzkGhmfVZJqHoLwSKGs91dxl+D8Rk0DOY
        +15rhDcWQWiJSXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEAEA13ABE;
        Thu, 12 May 2022 06:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6osSNrGpfGLjTwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:31:13 +0000
Message-ID: <252c0b18-c640-f813-408f-6f8d2e4af1d4@suse.de>
Date:   Thu, 12 May 2022 08:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 06/23] ata: libahci_platform: Convert to using platform
 devm-ioremap methods
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
 <20220511231810.4928-7-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-7-Sergey.Semin@baikalelectronics.ru>
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
> Currently the IOMEM AHCI registers space is mapped by means of the
> two functions invocation: platform_get_resource() is used to get the very
> first memory resource and devm_ioremap_resource() is called to remap that
> resource. Device-managed kernel API provides a handy wrapper to perform
> the same in single function call: devm_platform_ioremap_resource().
> 
> While at it seeing many AHCI platform drivers rely on having the AHCI CSR
> space marked with "ahci" name let's first try to find and remap the CSR
> IO-mem with that name and only if it fails fallback to getting the very
> first registers space platform resource.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Check whether there is "ahhi" reg resource before using the
>    devm_platform_ioremap_resource_byname() method in order to prevent a
>    false error message printed in the log (@Damien)
> - Slightly update the patch title due to the change above and to be more
>    specific that the platform device managed methods are utilized.
> ---
>   drivers/ata/libahci_platform.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index f7f9bfcfc164..8c9fbcc3043b 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -404,8 +404,14 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   
>   	devres_add(dev, hpriv);
>   
> -	hpriv->mmio = devm_ioremap_resource(dev,
> -			      platform_get_resource(pdev, IORESOURCE_MEM, 0));
> +	/*
> +	 * If the DT provided an "ahci" named resource, use it. Otherwise,
> +	 * fallback to using the default first resource for the device node.
> +	 */
> +	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
> +		hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
> +	else
> +		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(hpriv->mmio)) {
>   		rc = PTR_ERR(hpriv->mmio);
>   		goto err_out;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35DA5245E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbiELGeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240472AbiELGeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:34:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B2E1B4371;
        Wed, 11 May 2022 23:34:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2BD8F1F8B3;
        Thu, 12 May 2022 06:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652337245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/pyuexYUFM0t5yjVOWBZIC5p2ptEJasZfAOlFN5UhY=;
        b=Xe8d04QYAgASf9HfAr+ajQeKxmjqfVqgUL/sAIBtlQyoqslDT/4dnfzfyb20Jpf5ruMHSg
        SHSrpt9Wmgeq0pgjiz23fEpOaye1ilZl7VJ+NlXpLJYVp2gUKzN2hMeLKQ4sOx2QQcGecY
        tC4tw85pG4/l9Sj138TV0zYQJcQeVjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652337245;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/pyuexYUFM0t5yjVOWBZIC5p2ptEJasZfAOlFN5UhY=;
        b=g11tkIQe2JxDV7hUBu1nnFH5YbRkmGq9FiRWsIH2J4+jq7zIc0/V389ZwVogSlcfcH3kJ5
        nigp7sz1jFXcJQCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7C8313ABE;
        Thu, 12 May 2022 06:34:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yO5+L1yqfGKwUAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 12 May 2022 06:34:04 +0000
Message-ID: <f0a15a0d-7cb3-f635-d8d6-6c32e83ed93b@suse.de>
Date:   Thu, 12 May 2022 08:34:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 09/23] ata: libahci_platform: Sanity check the DT child
 nodes number
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
 <20220511231810.4928-10-Sergey.Semin@baikalelectronics.ru>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220511231810.4928-10-Sergey.Semin@baikalelectronics.ru>
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
> Having greater than (AHCI_MAX_PORTS = 32) ports detected isn't that
> critical from the further AHCI-platform initialization point of view since
> exceeding the ports upper limit will cause allocating more resources than
> will be used afterwards. But detecting too many child DT-nodes doesn't
> seem right since it's very unlikely to have it on an ordinary platform. In
> accordance with the AHCI specification there can't be more than 32 ports
> implemented at least due to having the CAP.NP field of 4 bits wide and the
> PI register of dword size. Thus if such situation is found the DTB must
> have been corrupted and the data read from it shouldn't be reliable. Let's
> consider that as an erroneous situation and halt further resources
> allocation.
> 
> Note it's logically more correct to have the nports set only after the
> initialization value is checked for being sane. So while at it let's make
> sure nports is assigned with a correct value.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Drop the else word from the child_nodes value checking if-else-if
>    statement (@Damien) and convert the after-else part into the ternary
>    operator-based statement.
> ---
>   drivers/ata/libahci_platform.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> index 7ff6626fd569..4e54e19f07b2 100644
> --- a/drivers/ata/libahci_platform.c
> +++ b/drivers/ata/libahci_platform.c
> @@ -480,15 +480,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>   		}
>   	}
>   
> -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
> +	/*
> +	 * Too many sub-nodes most likely means having something wrong with
> +	 * the firmware.
> +	 */
> +	child_nodes = of_get_child_count(dev->of_node);
> +	if (child_nodes > AHCI_MAX_PORTS) {
> +		rc = -EINVAL;
> +		goto err_out;
> +	}
>   
>   	/*
>   	 * If no sub-node was found, we still need to set nports to
>   	 * one in order to be able to use the
>   	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
>   	 */
> -	if (!child_nodes)
> -		hpriv->nports = 1;
> +	hpriv->nports = child_nodes ?: 1;
>   
>   	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
>   	if (!hpriv->phys) {

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

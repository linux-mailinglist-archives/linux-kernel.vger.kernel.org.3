Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E780152632B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381497AbiEMNhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381118AbiEMNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:31:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51B3E5296;
        Fri, 13 May 2022 06:31:42 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id v4so10279225ljd.10;
        Fri, 13 May 2022 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Na7KKiRW8g4tHv1id7jR6DFKacvqXxknGAITtk875TM=;
        b=KFSjXIqFSyF8XNjKgP/oTuuLiMUh2SEArbQCznMA0nlw4N0ApWuIbkA/bkbwWwzMXt
         ELayu0ZHjr9dkjB5ZgnRSw5DW/JaAl3ufbUXPvzofZe+HewnZ/0KaxEO79/5AZb25pgk
         uMxLcqMIQXjvBnHZMRE9K0IcparMt3vhH64aYietbnLmZH0P8vwEehx6iEPGIo7pWxvF
         1dbMrI5YXH7GdSnowidxxc3wTxXMKK+1Pnerjvuj3bBw3ZYpw+a8lqMq8dZu/Xky4UYt
         9167H7iwFrE+tW7ASgCNkQSgmmms+Aqu/6GzZYLOtN/XxMF5CLi+GWQWELEeeXb4qwof
         3xbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Na7KKiRW8g4tHv1id7jR6DFKacvqXxknGAITtk875TM=;
        b=04aIjI3Qh3E+u3jb5B7YXpxgogKANKQmAS4eZ2A40fjFLKi/7KpZ38YSZlIGMjTiui
         +MGS03ru/p9hm/dcsbSFv/QFt8oTFtDTzgL2XRXhwoP/E+0jsYNLZnTlHb38SGtDFoCr
         9GGG23VIfw/3K/Xqwx4W/3oPDySL5qir83k4IJ7sbYBLvCREOLglV6qW90zL46y8DfCL
         Ft4DdE4IAJEgrauK9Ja3ZLvntaRF2wBd5EoZFV4Ze4SuX3dlY2yGP4sv9zMUx50dyWsv
         oX7G4w2K0G282BFZtFfdJZX+4PDfm7A1vcWFi6NaR01m2GD0b+f7uusXzdY5u25VqV+V
         wxuw==
X-Gm-Message-State: AOAM533wvXijAovQ8UT4xID4PaBSqOG40NCoalcD38Ant2yaHeYQBQSf
        +/AvQbBGl+RgXVXTESr94qg=
X-Google-Smtp-Source: ABdhPJz56UMDH0Hhn7SVFGu8yjI811vwyRUUfOnKCOz+qNf8d0wIF18Xt4hl2aodxiGtYO7ef5TRpQ==
X-Received: by 2002:a2e:9645:0:b0:24f:2e6f:f931 with SMTP id z5-20020a2e9645000000b0024f2e6ff931mr3149716ljh.466.1652448701036;
        Fri, 13 May 2022 06:31:41 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id g10-20020a2e390a000000b0024f3d1dae92sm438634lja.26.2022.05.13.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 06:31:40 -0700 (PDT)
Date:   Fri, 13 May 2022 16:31:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/23] ata: libahci_platform: Add function returning a
 clock-handle by id
Message-ID: <20220513133138.mmi3n6zc5yvcf5py@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-9-Sergey.Semin@baikalelectronics.ru>
 <0732a28c-579e-52f8-21ad-653fd9a10aa2@suse.de>
 <20220512142607.u2kls35pevnjsjjh@mobilestation>
 <83ae3312-36ea-fa01-9b53-28818a04699f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83ae3312-36ea-fa01-9b53-28818a04699f@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 11:32:09AM +0200, Damien Le Moal wrote:
> On 2022/05/12 16:26, Serge Semin wrote:
> > On Thu, May 12, 2022 at 08:32:37AM +0200, Hannes Reinecke wrote:
> >> On 5/12/22 01:17, Serge Semin wrote:
> >>> Since all the clocks are retrieved by the method
> >>> ahci_platform_get_resources() there is no need for the LLD (glue) drivers
> >>> to be looking for some particular of them in the kernel clocks table
> >>> again. Instead we suggest to add a simple method returning a
> >>> device-specific clock with passed connection ID if it is managed to be
> >>> found. Otherwise the function will return NULL. Thus the glue-drivers
> >>> won't need to either manually touching the hpriv->clks array or calling
> >>> clk_get()-friends. The AHCI platform drivers will be able to use the new
> >>> function right after the ahci_platform_get_resources() method invocation
> >>> and up to the device removal.
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>>
> >>> ---
> >>>
> >>> Changelog v2:
> >>> - Fix some grammar mistakes in the method description.
> >>> ---
> >>>   drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
> >>>   include/linux/ahci_platform.h  |  3 +++
> >>>   2 files changed, 30 insertions(+)
> >>>
> >>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >>> index 3cff86c225fd..7ff6626fd569 100644
> >>> --- a/drivers/ata/libahci_platform.c
> >>> +++ b/drivers/ata/libahci_platform.c
> >>> @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
> >>> +/**
> >>> + * ahci_platform_find_clk - Find platform clock
> >>> + * @hpriv: host private area to store config values
> >>> + * @con_id: clock connection ID
> >>> + *
> >>> + * This function returns a pointer to the clock descriptor of the clock with
> >>> + * the passed ID.
> >>> + *
> >>> + * RETURNS:
> >>> + * Pointer to the clock descriptor on success otherwise NULL
> >>> + */
> >>> +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
> >>> +{
> >>> +	struct clk *clk = NULL;
> >>> +	int i;
> >>> +
> >>> +	for (i = 0; i < hpriv->n_clks; i++) {
> >>> +		if (!strcmp(hpriv->clks[i].id, con_id)) {
> >>> +			clk = hpriv->clks[i].clk;
> >>> +			break;
> >>> +		}
> >>> +	}
> >>> +
> >>> +	return clk;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> >>> +
> >>>   /**
> >>>    * ahci_platform_enable_clks - Enable platform clocks
> >>>    * @hpriv: host private area to store config values
> >>> diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> >>> index 49e5383d4222..fd964e6a68d6 100644
> >>> --- a/include/linux/ahci_platform.h
> >>> +++ b/include/linux/ahci_platform.h
> >>> @@ -13,6 +13,7 @@
> >>>   #include <linux/compiler.h>
> >>> +struct clk;
> >>>   struct device;
> >>>   struct ata_port_info;
> >>>   struct ahci_host_priv;
> >>> @@ -21,6 +22,8 @@ struct scsi_host_template;
> >>>   int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
> >>>   void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> >>> +struct clk *
> >>> +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
> >>>   int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
> >>>   void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
> >>>   int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
> >>
> > 
> >> Where is this function being used?
> > 
> > It will be used in the DWC AHCI SATA driver and can be utilized in the
> > rest of the drivers to simplify the available clocks access.
> > BTW Damien asked the same question in v1. My response was the same.
> 

> Please squash this patch together with the patch introducing the first use of
> this function.

I don't find this required seeing the changes introduced here are
coherent and can be considered as preparation to the corresponding
patch. This doesn't break any submitting patch procedure and
doesn't complicate the review process but simplifies it.

-Sergey

> 
> > 
> > -Sergey
> > 
> >>
> >> Cheers,
> >>
> >> Hannes
> >> -- 
> >> Dr. Hannes Reinecke		           Kernel Storage Architect
> >> hare@suse.de			                  +49 911 74053 688
> >> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> >> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

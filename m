Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37E9525005
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355302AbiELOcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355294AbiELOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:32:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC74B56231;
        Thu, 12 May 2022 07:31:59 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id q130so6742332ljb.5;
        Thu, 12 May 2022 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=manC7iWfn9O9mSZZf/Btg4vn4iIWLjuT6FYutQmRzFY=;
        b=ozDrfX1l+/RUW8QJ1TMix/At6wyNsvaD9ODXyDqQrCaB9eSbfLWUA6SeaDJXwGU4Ms
         Pee9Z2CzInoumsPAtCWVoFDjAFLl0hiFTaCzL49q+oSbtalZ5Vp+JSv9GheL57GfLYoF
         QvJI+Z9V2kwvSRlhCbx5WRrjJXXmfhA1+2nRHZTvR4nLsh3/McCXa93fs7uvzKi0cKL1
         2dm27fPhZL5zV6XBuRb+/owrt0DPbt92JcyFQZXLf/I/DoYIG9tMQCgxOXOvSjN0XCNK
         1eHGXg/tH/lS9uDyEa7LDlEgpmaPi7yfszTfc4Te0mdYbYmhmq67p3GgLiCjdnOytdFc
         8Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=manC7iWfn9O9mSZZf/Btg4vn4iIWLjuT6FYutQmRzFY=;
        b=dvUjsXUhZ8K/UpzU8y7LQHh9NUa+118Rzzb67pfqc1CSqUGOyd2vM7V/PIcCr5iqyn
         Wk3qVvkhibTjS1Pq9uyzNwjlO/KpWiqTMIGJC3h4yPlBKYOjPELUeEPjuyOXF7EhVK6P
         sSeJgTbUP8kPl3uLvPWaiy+YJZYQGgQq140BPG3S46RrlxWwvBOVyB/yqaz2XsVcCda5
         VMWbaOgx1hrXLpEep47atgauttMUCdqn+tIP7jhkFbfgwjFKnRhd9CjXBILzy7y3mxSA
         DA/sezO4eXJhjwfwpuBreVjsdWUEyMWVDw1xiT+4zixYukIcQel6IdcfDo6vMufIxASv
         U1zA==
X-Gm-Message-State: AOAM532Apby1kbrYzghjWSqf6knzD+LNfYIQvKp8zBfUScwXLpGAFpE6
        /wSZTnMngDt66u018z5RlDE=
X-Google-Smtp-Source: ABdhPJxPMcqx1CMFsYmZMBXkj4J0Io9idgJtMFiS4ZUOw9GabuWBPo2zvHAFBH0SAeWcFpq0rvCz7A==
X-Received: by 2002:a2e:9019:0:b0:250:8205:dfb4 with SMTP id h25-20020a2e9019000000b002508205dfb4mr183915ljg.396.1652365918175;
        Thu, 12 May 2022 07:31:58 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id l6-20020a19c206000000b0047255d210f1sm814755lfc.32.2022.05.12.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:31:57 -0700 (PDT)
Date:   Thu, 12 May 2022 17:31:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 10/23] ata: libahci_platform: Parse ports-implemented
 property in resources getter
Message-ID: <20220512143155.c6gbufrwju3z5wmi@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-11-Sergey.Semin@baikalelectronics.ru>
 <1e349868-b302-1473-188a-1a6f2bb88cd5@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e349868-b302-1473-188a-1a6f2bb88cd5@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:48:24AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:17, Serge Semin wrote:
> > The ports-implemented property is mainly used on the OF-based platforms
> > with no ports mapping initialized by a bootloader/BIOS firmware. Seeing
> > the same of_property_read_u32()-based pattern has already been implemented
> > in the generic AHCI LLDD (glue) driver and in the Mediatek, St AHCI
> > drivers let's move the property read procedure to the generic
> > ahci_platform_get_resources() method. Thus we'll have the forced ports
> > mapping feature supported for each OF-based platform which requires that,
> > and stop re-implementing the same pattern in there a bit simplifying the
> > code.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >   drivers/ata/ahci_mtk.c         | 2 --
> >   drivers/ata/ahci_platform.c    | 3 ---
> >   drivers/ata/ahci_st.c          | 3 ---
> >   drivers/ata/libahci_platform.c | 3 +++
> >   4 files changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
> > index 1f6c85fde983..c056378e3e72 100644
> > --- a/drivers/ata/ahci_mtk.c
> > +++ b/drivers/ata/ahci_mtk.c
> > @@ -118,8 +118,6 @@ static int mtk_ahci_parse_property(struct ahci_host_priv *hpriv,
> >   				   SYS_CFG_SATA_EN);
> >   	}
> > -	of_property_read_u32(np, "ports-implemented", &hpriv->force_port_map);
> > -
> >   	return 0;
> >   }
> > diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
> > index 28a8de5b48b9..9b56490ecbc3 100644
> > --- a/drivers/ata/ahci_platform.c
> > +++ b/drivers/ata/ahci_platform.c
> > @@ -56,9 +56,6 @@ static int ahci_probe(struct platform_device *pdev)
> >   	if (rc)
> >   		return rc;
> > -	of_property_read_u32(dev->of_node,
> > -			     "ports-implemented", &hpriv->force_port_map);
> > -
> >   	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
> >   		hpriv->flags |= AHCI_HFLAG_NO_FBS | AHCI_HFLAG_NO_NCQ;
> > diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
> > index 7526653c843b..068621099c00 100644
> > --- a/drivers/ata/ahci_st.c
> > +++ b/drivers/ata/ahci_st.c
> > @@ -168,9 +168,6 @@ static int st_ahci_probe(struct platform_device *pdev)
> >   	st_ahci_configure_oob(hpriv->mmio);
> > -	of_property_read_u32(dev->of_node,
> > -			     "ports-implemented", &hpriv->force_port_map);
> > -
> >   	err = ahci_platform_init_host(pdev, hpriv, &st_ahci_port_info,
> >   				      &ahci_platform_sht);
> >   	if (err) {
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 4e54e19f07b2..f7f9cac10cb1 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -512,6 +512,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >   		goto err_out;
> >   	}

> > +	of_property_read_u32(dev->of_node,
> > +			     "ports-implemented", &hpriv->force_port_map);
> > +
> >   	if (child_nodes) {
> >   		for_each_child_of_node(dev->of_node, child) {
> >   			u32 port;
> 
> What happens on the other platforms?
> Won't they register an error if that property isn't implemented?

No. The force_port_map field will be left unmodified (zero by default) in case
if the optional 'ports-implemented' property is unavailable. See the
of_property_read_u32_array() method kdoc:
https://elixir.bootlin.com/linux/latest/source/include/linux/of.h#L1261

-Sergey

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke		           Kernel Storage Architect
> hare@suse.de			                  +49 911 74053 688
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
> HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238AE4FB369
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 08:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244836AbiDKGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 02:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244817AbiDKGEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:04:36 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A25133E1C;
        Sun, 10 Apr 2022 23:02:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id j9so16607437lfe.9;
        Sun, 10 Apr 2022 23:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pk6Z4UHZeD6IhuVkj5UlspFzQRTU4pf7XGhWj665kzI=;
        b=Cog9qeV3+oiutPT646uEGo5oqzrR/SFDOAHJcjgO/cKicNW8Cpeac4uCTuHnsD3IWy
         3/R/cVMTtd54MLXHEzgcrZIfHoVUfTQw0yuqdBsVihLgjoTII6oVVdCT3dHiC3hfoXD7
         O+RKhGLv550O4PVx5/L7Xhr5FCHdTIWA2p96ROFFFcy63ScVFdKUuIojV+0lXakHzfOx
         BuHMpqrN/A/OCJ4tOU+l0H++4blGdDpjt7r8X9m6UoeP0YIYdwYCVgcFwk/EnZKuZ+05
         Es3DhU8PEw8+ZBZJc1h2N4a5ZvFhg3q70rkWEj2XqFnQPa5HRUIL0WwNwFVXL98cHhFL
         rMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pk6Z4UHZeD6IhuVkj5UlspFzQRTU4pf7XGhWj665kzI=;
        b=YnUM89G5FaJPZp1xfPlNkOgzgjKEpR4I+e93+IDRxlwnuVjV166fEOfzZOUOC7LrsB
         pBq3Lc9QO+n3QVpJIL6VBtkG566ifRrgKAfsKrZbzkB3FSk7YQF6cp12L8gn0erv4O9C
         Bh92VsLm/kqQ6Qzod9Qavn7EScSVw6lzZy/juAW2oI5ZaKEN+mFiiecebIg0ixLTMaI8
         Ujaaq8v/7qg8ePccXMd934EdBz1WuPWQYTQ6N7AJgJhIF9Baqv+jjpzDdT0za1ex2poi
         MMK/Dbj17qv15OtLklKIq6w669qHsWGvIUtb2x2ELKXSDBZP8JU7w7VN5JM8duXOV+pb
         1SIg==
X-Gm-Message-State: AOAM532nVwUT8WzqjHvurw45c8YBB6kTtEcEK9gMNGQ+X9+1Sa6+0h7/
        bCPeUeGiSZI4LgvX47LAiAQ=
X-Google-Smtp-Source: ABdhPJx2+13cycgCnbBAQsUVs+ElZT7kTinbubOe4F5Jh+O9tUP3OWwaxiD6uSmKoBq2bHC7Y+hH0g==
X-Received: by 2002:a05:6512:970:b0:46b:acec:2ecb with SMTP id v16-20020a056512097000b0046bacec2ecbmr777954lft.221.1649656939364;
        Sun, 10 Apr 2022 23:02:19 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id x24-20020a056512047800b0046b9dafd55bsm509545lfd.164.2022.04.10.23.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 23:02:18 -0700 (PDT)
Date:   Mon, 11 Apr 2022 09:02:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 06/21] ata: libahci_platform: Add function returning a
 clock-handle by id
Message-ID: <20220411060217.xj2zbcqva3mblvt2@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-7-Sergey.Semin@baikalelectronics.ru>
 <b2a8b347-8029-9df3-edcd-a526ba3eef82@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a8b347-8029-9df3-edcd-a526ba3eef82@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:36:04AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > Since all the clocks are retrieved by the method
> > ahci_platform_get_resources() there is no need for the glue-drivers to be
> > looking for some particular of them in the kernel clocks table again.
> > Instead we suggest to add a simple method returning a device-specific
> > clock with passed connection ID if it is managed to be found. Otherwise
> > the function will return NULL. Thus the glue-drivers won't need to either
> 

> "glue-drivers" is really unclear. What do you mean ?

"Glue drivers" is a common name to address the drivers which are used to
pre-initialize the platform-specifics, then normally create a core driver
descriptor/data and finally call some core method (like
ahci_platform_init_host()) to really bind the device in the particular
bus. You can find them in almost all the kernel subsystems. For instance
in case of this patchset the glue-driver is drivers/ata/ahci_dwc.c, while
the main/core part of the driver is implemented in drivers/ata/achi.c,
drivers/ata/libahci.c, drivers/ata/libahci_platform.c, etc.

It's not like I've come up with the term by myself. I've seen it used in a
plenty of the kernel patches and subsystems and will unlikely stop using
it since it determines the particular type of the kernel drivers in a
short and direct manner.

> 
> > manually touching the hpriv->clks array or calling clk_get()-friends. The
> > AHCI platform drivers will be able to use the new function right after the
> > ahci_platform_get_resources() method invocation and up to the device
> > removal.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
> >  include/linux/ahci_platform.h  |  3 +++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index d805ddc3a024..4fb9629c03ab 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
> >  }
> >  EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
> >  
> > +/**
> > + * ahci_platform_find_clk - Find platform clock
> > + * @hpriv: host private area to store config values
> > + * @con_id: clock connection ID
> > + *
> > + * This function returns point to the clock descriptor of the clock with
> > + * passed ID.
> > + *
> > + * RETURNS:
> > + * Pointer to the clock descriptor on success otherwise NULL
> > + */
> > +struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id)
> > +{
> > +	struct clk *clk = NULL;
> > +	int i;
> > +
> > +	for (i = 0; i < hpriv->n_clks; i++) {
> > +		if (!strcmp(hpriv->clks[i].id, con_id)) {
> > +			clk = hpriv->clks[i].clk;
> > +			break;
> > +		}
> > +	}
> > +
> > +	return clk;
> > +}
> > +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> > +
> >  /**
> >   * ahci_platform_enable_clks - Enable platform clocks
> >   * @hpriv: host private area to store config values
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index 49e5383d4222..fd964e6a68d6 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -13,6 +13,7 @@
> >  
> >  #include <linux/compiler.h>
> >  
> > +struct clk;
> >  struct device;
> >  struct ata_port_info;
> >  struct ahci_host_priv;
> > @@ -21,6 +22,8 @@ struct scsi_host_template;
> >  
> >  int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
> >  void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> > +struct clk *
> > +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
> 

> No users for this function ?

It will be used in the next two patches:
[PATCH 17/21] ata: ahci: Add DWC AHCI SATA controller support
[PATCH 20/21] ata: ahci-dwc: Add Baikal-T1 AHCI SATA interface support
and most likely in the new AHCI/SATA drivers which need to tune the clocks
up in the platform-specific way.

-Sergey

> 
> >  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
> >  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
> >  int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

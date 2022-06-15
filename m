Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2954D3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350106AbiFOVYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349490AbiFOVYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:24:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E78554BE;
        Wed, 15 Jun 2022 14:24:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id h23so20851951lfe.4;
        Wed, 15 Jun 2022 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=peqy01VggIT1uRQjQeqqFB+gR0sAWrSD7edJX84V7Mk=;
        b=o+B+vgHFKQ+VDXcmSN9mEZWAWh7aDrnnd1rJGysYV1AEXtvhrezJvOqiwVD6ZooNdY
         fVgZkrXFVaXhAkugd06guj3J+AOJeGbnO0xp8kBgb46lAVwuKON+veuEsGuQBnyx4Qa1
         wOLs6UAtYZyW7Rk7B9ydvVBYuNKpK9XBeHr7STrMR3EnviI6r3pd/i2otXmhmCnWATlg
         zgLwXQvATPjnwND/jo1Yc6EoTjVCx8W4qB2ycwDNIimx4JBWE9tbinfAnAXIZVyRSoyO
         kDdc28/PWakbvEcNAKTyFIK+W/83C5XrIDmHJjd5+rvzMLKs+A9znWwvg7hpY93OUrpI
         pgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=peqy01VggIT1uRQjQeqqFB+gR0sAWrSD7edJX84V7Mk=;
        b=54AKWZq46zZi7zCsv4NGqytVTOHitHDQ6BIN0oAArz78iVPlknzi133umJa1XrevCu
         Jg9Lk4ZCEolVpV5lnK4mQszI4jFxbI+kWdf/vkYnkug9Dhz1OUScJV05n0jGqG+6Uy96
         p8eDP3YjvjB1IFRPyWApGocM2EUxSsybgB0j5klIWKmmuPxZCGQbF6DBnwYSoRKTS/uq
         Lhc1c6YxiM4klD3hy5TfW+zOUr9hoY2f1xcKg2RZq3cbGRXTfpdVG+hFPv/fUAMToQDW
         S08eC6QQPI1oHn9k1RByOCYIAl4k9ZwEBpqF9fDICPOjTBDJIsIJwSTWEKOQTtdeFegC
         e2+Q==
X-Gm-Message-State: AJIora+4PQv5olAJd+rQC4i3gtwgX1KYjIL4XNdZE5VIr/7/+KxISjpz
        Fe3xjV0wsDGdQNRRrqg5LQw=
X-Google-Smtp-Source: AGRyM1vl9Th7OIF5POLvrtEojwMO8Ll6jPy4AU2qh4nUeFA48cQqgBOvYwNwOk3+CxDKMFVCXXgqOw==
X-Received: by 2002:a05:6512:22ce:b0:479:ef3:141c with SMTP id g14-20020a05651222ce00b004790ef3141cmr771288lfu.393.1655328285558;
        Wed, 15 Jun 2022 14:24:45 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id s27-20020a056512203b00b00478a311d399sm1937222lfs.0.2022.06.15.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:24:44 -0700 (PDT)
Date:   Thu, 16 Jun 2022 00:24:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 18/23] ata: libahci_platform: Add function returning a
 clock-handle by id
Message-ID: <20220615212443.2zkirzppeby25xs6@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-19-Sergey.Semin@baikalelectronics.ru>
 <611c8eeb-fa7e-286c-bef2-0e24cc2b6b2e@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611c8eeb-fa7e-286c-bef2-0e24cc2b6b2e@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:45:35PM +0900, Damien Le Moal wrote:
> On 6/10/22 17:17, Serge Semin wrote:
> > Since all the clocks are retrieved by the method
> > ahci_platform_get_resources() there is no need for the LLD (glue) drivers
> > to be looking for some particular of them in the kernel clocks table
> > again. Instead we suggest to add a simple method returning a
> > device-specific clock with passed connection ID if it is managed to be
> > found. Otherwise the function will return NULL. Thus the glue-drivers
> > won't need to either manually touching the hpriv->clks array or calling
> > clk_get()-friends. The AHCI platform drivers will be able to use the new
> > function right after the ahci_platform_get_resources() method invocation
> > and up to the device removal.
> > 
> > Note the method is left unused here, but will be utilized in the framework
> > of the DWC AHCI SATA driver being added in the next commit.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Fix some grammar mistakes in the method description.
> > 
> > Changelog v4:
> > - Add a note regarding the new method usage.
> > ---
> >  drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
> >  include/linux/ahci_platform.h  |  3 +++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 8b542a8bc487..418961f954af 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -95,6 +95,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
> >  }
> >  EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
> >  
> > +/**
> > + * ahci_platform_find_clk - Find platform clock
> > + * @hpriv: host private area to store config values
> > + * @con_id: clock connection ID
> > + *
> > + * This function returns a pointer to the clock descriptor of the clock with
> > + * the passed ID.
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
> 
> 			return hpriv->clks[i].clk;
> 
> > +			break;
> > +		}
> > +	}
> > +
> > +	return clk;
> 

> And then "return NULL;" here and you do not need the clk variable.

Ok.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> > +
> >  /**
> >   * ahci_platform_enable_clks - Enable platform clocks
> >   * @hpriv: host private area to store config values
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index 6d7dd472d370..3418980b0341 100644
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

> Please make this:
> 
> struct clk *ahci_platform_find_clk(struct ahci_host_priv *hpriv,
> 
>                                    const char *con_id);

Ok.

-Sergey

> 
> >  int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
> >  void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
> >  int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

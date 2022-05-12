Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6633F524FEE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbiELO0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354953AbiELO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:26:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F7220F0;
        Thu, 12 May 2022 07:26:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 4so6696804ljw.11;
        Thu, 12 May 2022 07:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TfDCVHRtgrPCtctsl2EaaUulg/1gPdaA0bbzv0CbTF4=;
        b=fB+mgiTBS84Bwp+xHMfq0NKZ3fBFe/flDnHYXWZ+kv8LPyaY6zhcd62nSQIvceLorv
         jRlleaRdnVjoNGj6DRLWpVt1YyI7/nJ4qqelKf+yBMlrrNieTEEmGHicnddbmcDCTp1/
         s6xbzwjF4l3LeU4fY6wYD9PWbZkAEGM8aEEijnldR0bH9GyY2YNAUzDRr3aEB8H077W1
         /lGrI5uwNicPF7EOle/9VpvR4NtXhTI3YnRcj7aSdZV2vV8CgPLeSCal+y4x9k9T+91K
         xto2zzz/OzelrGGIaiISEcec1AqxCkm2gZAiIKzh6b3wZlTkHKFaVzZ3lL1ba+KG3TA2
         nrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TfDCVHRtgrPCtctsl2EaaUulg/1gPdaA0bbzv0CbTF4=;
        b=fvYWBKWbxpnNB385ncEdnpWF6iBOHvHil2A8sgDyiUKc4YgR3Ss+Tu13eX01sWysP9
         81naCrDrrhBbmSppZ5aJtonZfdWH+LoYC7WhqWeCHQFUz/evpRxA4jxd5YES12NMkDm+
         OQhK4uzoTdHNDFqtVfZDD2XGr3w1z1hd7bYL5zyfRUv6SKVRKn4hgYjNmE2p/6/AKIlP
         rYYkxD0xIuIvmJwQOTms5h1CIdBU6xLbJyxdWN44/AiqnkplSyG9j//pnnhOh99nm7xe
         ZwmKTMtCRv3KAyA39eaE7KfxkiW2VzKuXoXb+rjkkqRDum7X/RWauT8tCMzABjuilqp0
         +lsA==
X-Gm-Message-State: AOAM533S31ZGZL2VlxIfTqQ2g9x5uZqzP2oCfLY4IDbGVyPQr1xs6z2N
        oWuIaXZB1zdv0ys6edxPGuhuRhgtu5JrpQ==
X-Google-Smtp-Source: ABdhPJziSKzmfdfSYwT3FoP3fegLwMFcliuj82gmIzZ9/NR3VKY9dVP/M49ulboPnBLqiuA49DBm/A==
X-Received: by 2002:a05:651c:160b:b0:247:f955:1b18 with SMTP id f11-20020a05651c160b00b00247f9551b18mr152728ljq.427.1652365570388;
        Thu, 12 May 2022 07:26:10 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id y5-20020ac24465000000b0047255d21165sm807567lfl.148.2022.05.12.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 07:26:09 -0700 (PDT)
Date:   Thu, 12 May 2022 17:26:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/23] ata: libahci_platform: Add function returning a
 clock-handle by id
Message-ID: <20220512142607.u2kls35pevnjsjjh@mobilestation>
References: <20220511231810.4928-1-Sergey.Semin@baikalelectronics.ru>
 <20220511231810.4928-9-Sergey.Semin@baikalelectronics.ru>
 <0732a28c-579e-52f8-21ad-653fd9a10aa2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0732a28c-579e-52f8-21ad-653fd9a10aa2@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 08:32:37AM +0200, Hannes Reinecke wrote:
> On 5/12/22 01:17, Serge Semin wrote:
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
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v2:
> > - Fix some grammar mistakes in the method description.
> > ---
> >   drivers/ata/libahci_platform.c | 27 +++++++++++++++++++++++++++
> >   include/linux/ahci_platform.h  |  3 +++
> >   2 files changed, 30 insertions(+)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 3cff86c225fd..7ff6626fd569 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -94,6 +94,33 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
> >   }
> >   EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
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
> > +			break;
> > +		}
> > +	}
> > +
> > +	return clk;
> > +}
> > +EXPORT_SYMBOL_GPL(ahci_platform_find_clk);
> > +
> >   /**
> >    * ahci_platform_enable_clks - Enable platform clocks
> >    * @hpriv: host private area to store config values
> > diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
> > index 49e5383d4222..fd964e6a68d6 100644
> > --- a/include/linux/ahci_platform.h
> > +++ b/include/linux/ahci_platform.h
> > @@ -13,6 +13,7 @@
> >   #include <linux/compiler.h>
> > +struct clk;
> >   struct device;
> >   struct ata_port_info;
> >   struct ahci_host_priv;
> > @@ -21,6 +22,8 @@ struct scsi_host_template;
> >   int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
> >   void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
> > +struct clk *
> > +ahci_platform_find_clk(struct ahci_host_priv *hpriv, const char *con_id);
> >   int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
> >   void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
> >   int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
> 

> Where is this function being used?

It will be used in the DWC AHCI SATA driver and can be utilized in the
rest of the drivers to simplify the available clocks access.
BTW Damien asked the same question in v1. My response was the same.

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84254D3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349429AbiFOVZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbiFOVZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:25:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B115156200;
        Wed, 15 Jun 2022 14:25:35 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c4so20803913lfj.12;
        Wed, 15 Jun 2022 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pyTQQlNbGPEuJO15lTuPZ7DQfEn06e9frSoizvFwKWw=;
        b=oTZQqk2F8TVXVFGVypiZ5kqvrzYjclRj/aSnxyTIM6hQJnbMveHh8CN5NSKdEjXmrT
         xnw04YfUTHUA41scTdZ/ihwYtqlZNJ9sUR0uy9FJ1xPpQgOZvvs4lW4nToN3lIemtsoJ
         kxboW1x3I1bnf4Kq6p6QHgo6/qu6mbpOjgHIQPMjvOS77A6H3dVySOFH9pN377hOv0zY
         ue1Cr1ZBlam4ytR7Ko6On/O1zB9BOiLb+JehNpP6MKeyhGYMYY+GsyW+/StTuZPDXhQK
         20RA9vj8+odsXy1OjpAVHocdS9L+G9ETirfDVa8V52HKPFVLpnzz0eGA5ueD8WlYeHD8
         TcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pyTQQlNbGPEuJO15lTuPZ7DQfEn06e9frSoizvFwKWw=;
        b=i5SIFNeaLxI/O95l+vVoTP4agizPWv3URQEJL4a7D/u/BnNU10AKaot9WybfYeVzAO
         jYqfa2UDLRfFok7ilkhdV9eWeZRB32Ger7030uCCkYCY1rAA/kAr5h/UF5vIbgzNmMa1
         /d9i6ImW2vM8B+gxXG0pjiNcBgn4neIwdoIFGRXcXQ48UGehx8EndZBCyiDiz2HVNb6A
         4StRP2FPzoEiiMRmXs9orUcY0Kr8CobFUR4F/2BgbQ1ajQmZUlrOBKVpaIyCNCQn7Kb5
         9lXIOQ6hII3fw3+1gDVabHCyqxKYFI4DHFmnGd4f1hcLhiXt7MU64luyJHNKCh9Atk94
         e7lQ==
X-Gm-Message-State: AJIora/phkDpkeekJR6hLUtKV9Hp8O/jCmJ+4agx0AaICwpo0xZgagwA
        U9rCb4qCFAq4lV8EUu+CeoQ=
X-Google-Smtp-Source: AGRyM1tNfm48SgxJ6bhN8fJEPsmy+wX9TOkullLnS11iK/m9CjlKWH6IosEJU9UKnbB9kyNUpONeSg==
X-Received: by 2002:a05:6512:6c1:b0:478:e288:1c39 with SMTP id u1-20020a05651206c100b00478e2881c39mr840800lff.58.1655328334096;
        Wed, 15 Jun 2022 14:25:34 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id r30-20020ac25c1e000000b004791f9ea46esm1924017lfp.231.2022.06.15.14.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:25:33 -0700 (PDT)
Date:   Thu, 16 Jun 2022 00:25:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 15/23] ata: ahci: Convert __ahci_port_base to
 accepting hpriv as arguments
Message-ID: <20220615212531.gmyfxjwdmeukmnzz@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-16-Sergey.Semin@baikalelectronics.ru>
 <707c18cb-d499-a499-db9a-db5d73f0f3b4@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <707c18cb-d499-a499-db9a-db5d73f0f3b4@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:38:14PM +0900, Damien Le Moal wrote:
> On 6/10/22 17:17, Serge Semin wrote:
> > It may get required to retrieve the port-base address even before the
> 
> The port base address may be required even before the...
> 
> > ata_host instance is initialized and activated, for instance in the
> > ahci_save_initial_config() method which we about to update (consider this
> 
> s/we/we are

Got it. will be fixed in v5.

-Sergey

> 
> > modification as a preparation for that one). Seeing the __ahci_port_base()
> > function isn't used much it's the best candidate to provide the required
> > functionality. So let's convert it to accepting the ahci_host_priv
> > structure pointer.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > ---
> >  drivers/ata/ahci.c | 2 +-
> >  drivers/ata/ahci.h | 7 ++++---
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> > index 9bc8fa77e92f..d14d74649e0e 100644
> > --- a/drivers/ata/ahci.c
> > +++ b/drivers/ata/ahci.c
> > @@ -689,7 +689,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
> >  			mv = 2;
> >  		else
> >  			mv = 4;
> > -		port_mmio = __ahci_port_base(host, mv);
> > +		port_mmio = __ahci_port_base(hpriv, mv);
> >  
> >  		writel(0, port_mmio + PORT_IRQ_MASK);
> >  
> > diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
> > index 0e66446a5883..8b9826533ae5 100644
> > --- a/drivers/ata/ahci.h
> > +++ b/drivers/ata/ahci.h
> > @@ -431,10 +431,9 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht);
> >  void ahci_error_handler(struct ata_port *ap);
> >  u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked);
> >  
> > -static inline void __iomem *__ahci_port_base(struct ata_host *host,
> > +static inline void __iomem *__ahci_port_base(struct ahci_host_priv *hpriv,
> >  					     unsigned int port_no)
> >  {
> > -	struct ahci_host_priv *hpriv = host->private_data;
> >  	void __iomem *mmio = hpriv->mmio;
> >  
> >  	return mmio + 0x100 + (port_no * 0x80);
> > @@ -442,7 +441,9 @@ static inline void __iomem *__ahci_port_base(struct ata_host *host,
> >  
> >  static inline void __iomem *ahci_port_base(struct ata_port *ap)
> >  {
> > -	return __ahci_port_base(ap->host, ap->port_no);
> > +	struct ahci_host_priv *hpriv = ap->host->private_data;
> > +
> > +	return __ahci_port_base(hpriv, ap->port_no);
> >  }
> >  
> >  static inline int ahci_nr_ports(u32 cap)
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

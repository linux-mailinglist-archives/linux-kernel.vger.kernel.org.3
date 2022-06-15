Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3054D2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348631AbiFOUxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349323AbiFOUxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:53:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0ED054FA6;
        Wed, 15 Jun 2022 13:53:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c2so20811929lfk.0;
        Wed, 15 Jun 2022 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dkNLjdDW3Fz/m7M441ZwWT9nGf+j42bVYyQKzjzvhUs=;
        b=nyhckwPzYvb5+DY7chXK08bpIkP5CR0LjriS4B82ISsX9equWKiptiscQ9eRxWMKtj
         k2SUVn3ZcCRcWEjCPmW/R4jsaQ0SzJ+zdGDYFkhCdGx3PU+CEluPuePcpULVe4NEbsvD
         2v6N4iS8qH6gt9ZfZjsJy+fpuS6RJ+YWcmdP0gROM5lIXmTgANry/M07Df0z/+Zu7ejG
         6tEQXc1stzbOEISFZHTNnZQnr9MIyrikEUiNO4KRgdhc82kDzLh28vJE3XGiSrDrSSP0
         3n2nK18z0ckgsbnoB/RtgNRUUKm1z4TULbLOsQyOJrOD59p+613VtvJpI0+70aXfl3Lu
         x5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dkNLjdDW3Fz/m7M441ZwWT9nGf+j42bVYyQKzjzvhUs=;
        b=Jsva56ilnqudemQY3Fw8qnDxcn7+1hGXAzhsA+oU3AL2b66V4x0tnbQj+OZfIG0/mW
         Uzn5zyYHaTqI9t27xRFNqbu4TDf/LSBwaHKJsUmg/cp5XwAEg9LS0JpO7x3+WkxwTzJB
         IE7dDQqtDyCVTqLcnLnYUZz5RE/4/BFynXdfs2l/uDffauZX87avzQXqbapeJhObR/VT
         7YmeCHrU5qeVtRbCmSWCWaKh/FjWz2t7u2jjSsSHiAQE6zVsR6RSWrZb+FAVNUds+qNI
         glEkhyP5CSameuNOveWtk2cf1ChCCCuhKxOp2M3yKUJSptkjbyjqy5R3C0oSJhZOYTWC
         RM9A==
X-Gm-Message-State: AJIora9TKzpLmQHmKSS6ORO+Pe0/MQz9aRrpR67Ty+GXJdkpc6l3omta
        IK7nYQHCo7KsPTWEQu6dBtE=
X-Google-Smtp-Source: AGRyM1u51hJv1mQ/ajBoNSZ6zc7XEpSrk9yR0l23nwS1A6zSYkrB4ctYGJDOTzdXXP7wlbkJl672rQ==
X-Received: by 2002:a19:2d51:0:b0:479:1269:a146 with SMTP id t17-20020a192d51000000b004791269a146mr780304lft.572.1655326411015;
        Wed, 15 Jun 2022 13:53:31 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id t20-20020a056512069400b004795311530asm1911636lfe.209.2022.06.15.13.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 13:53:30 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:53:28 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/23] ata: libahci_platform: Sanity check the DT
 child nodes number
Message-ID: <20220615205328.chwruabvksdbnaex@mobilestation>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
 <20220610081801.11854-9-Sergey.Semin@baikalelectronics.ru>
 <c388835e-3bc1-a69c-82a7-6036c7adec1b@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c388835e-3bc1-a69c-82a7-6036c7adec1b@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:23:33PM +0900, Damien Le Moal wrote:
> On 6/10/22 17:17, Serge Semin wrote:
> > Having greater than AHCI_MAX_PORTS (32) ports detected isn't that critical
> > from the further AHCI-platform initialization point of view since
> > exceeding the ports upper limit will cause allocating more resources than
> > will be used afterwards. But detecting too many child DT-nodes doesn't
> > seem right since it's very unlikely to have it on an ordinary platform. In
> > accordance with the AHCI specification there can't be more than 32 ports
> > implemented at least due to having the CAP.NP field of 5 bits wide and the
> > PI register of dword size. Thus if such situation is found the DTB must
> > have been corrupted and the data read from it shouldn't be reliable. Let's
> > consider that as an erroneous situation and halt further resources
> > allocation.
> > 
> > Note it's logically more correct to have the nports set only after the
> > initialization value is checked for being sane. So while at it let's make
> > sure nports is assigned with a correct value.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > 
> > ---
> > 
> > Changelog v2:
> > - Drop the else word from the child_nodes value checking if-else-if
> >   statement (@Damien) and convert the after-else part into the ternary
> >   operator-based statement.
> > 
> > Changelog v4:
> > - Fix some logical mistakes in the patch log. (@Sergei Shtylyov)
> > ---
> >  drivers/ata/libahci_platform.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 814804582d1d..8aed7b29c7ab 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -451,15 +451,22 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  		}
> >  	}
> >  
> > -	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
> > +	/*
> > +	 * Too many sub-nodes most likely means having something wrong with
> > +	 * the firmware.
> > +	 */
> > +	child_nodes = of_get_child_count(dev->of_node);
> > +	if (child_nodes > AHCI_MAX_PORTS) {
> > +		rc = -EINVAL;
> > +		goto err_out;
> > +	}
> >  
> >  	/*
> >  	 * If no sub-node was found, we still need to set nports to
> >  	 * one in order to be able to use the
> >  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
> >  	 */
> > -	if (!child_nodes)
> > -		hpriv->nports = 1;
> > +	hpriv->nports = child_nodes ?: 1;
> 

> This change is not necessary and makes the code far less easy to read.

elaborate please. What change? What part of this change makes the code
less easy to read?

-Sergey

> 
> >  
> >  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
> >  	if (!hpriv->phys) {
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

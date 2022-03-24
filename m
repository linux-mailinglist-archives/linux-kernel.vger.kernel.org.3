Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADCC4E6A51
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 22:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354224AbiCXVjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 17:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354206AbiCXVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 17:39:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A44C62FA;
        Thu, 24 Mar 2022 14:38:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h7so10314474lfl.2;
        Thu, 24 Mar 2022 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3EV5jVGVORkcwBWlYkHnDU/8t2ejwnBah9c2b+qBJtE=;
        b=Ymzt93eQMlfyMnxc1ou81QK0kvPlT7RhpdB6x8iioI++blHk5V0ifh7E1R4q7yE9K1
         HAgLAjb8WtE5m7ZoOL39/X1/J2ALfg5TSeey/eMn5hfsgkEQv5gC8mTclEADS7Sz/XTd
         NB5cVBGMNAFQbfPlP2Z0q/AqGPPcV+/Tc6UCRMooKvlrEXWGZUCZBCst93whMPDfESn9
         9ia6o1CFyWv5rn9K0EnXFh6LLT1mgA7PD+j0XB4I4Glw9Je3FjxMd0S0AqCZZd9HMDsB
         /Ebk4wW5sccShdIWlIgknPMfOnPv59dBP7usJqagtBSgbnY/T/SyTGfHqKIsbVBUmw9/
         ZqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3EV5jVGVORkcwBWlYkHnDU/8t2ejwnBah9c2b+qBJtE=;
        b=VSHVPg7jZyZ8XjSVHr19aOZczp2UpfgGoeqcvH9FxRgmszzPhZ+EizznDyf5EBRSWg
         mIoZFuZWC55pNn7/NC5QESAUxYayH/vLGcKYt+ywSzh/Rx+iAPeo4wBGMYu7SITPFbLV
         KNqZlXKv3IFHOjQOuoyEtXAJRHWzq4bW9tCU2HEPJDPJ66H/oqWIdhmUT031L80rxhDg
         OCYEnUnrdnI2GNXcZbSiCPW+n/GG06ljc98d0WPHP1amUhKAz7Gfj+INb9yx2RwtlB1S
         5MByAlHa2qKiKClhijpuG2ZGOpuzoAWfDjKhXomydPBuIbwHn0FAFr12Je7k9BUimgBh
         Xw9w==
X-Gm-Message-State: AOAM5335mteEDUG2vFeCMvBymZ2cnL4J25FvPzJWBbWWv6/IB2YE4hUA
        56wdHbVF/j2ezPBZ0ID8AGg=
X-Google-Smtp-Source: ABdhPJzNL6+fdjJSSdRzlE8dCWrlf4b7VUImQfBBNO81U4cDhxqRTZunokYlpO8B9AT1CYPxPEZsJw==
X-Received: by 2002:a19:5e1c:0:b0:44a:143e:ba3b with SMTP id s28-20020a195e1c000000b0044a143eba3bmr5343845lfb.137.1648157881575;
        Thu, 24 Mar 2022 14:38:01 -0700 (PDT)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id o3-20020a198c03000000b00448b7b1780csm471179lfd.63.2022.03.24.14.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 14:38:00 -0700 (PDT)
Date:   Fri, 25 Mar 2022 00:37:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 03/21] ata: libahci_platform: Explicitly set rc on
 devres_alloc failure
Message-ID: <20220324213758.vihvh5z2pg3skr6i@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
 <9128f850-fcc1-811e-b781-b7fbcb2403ba@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9128f850-fcc1-811e-b781-b7fbcb2403ba@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Damien

On Thu, Mar 24, 2022 at 09:58:34AM +0900, Damien Le Moal wrote:
> On 3/24/22 09:16, Serge Semin wrote:
> > It's better for readability and maintainability to explicitly assign an
> > error number to the variable used then as a return value from the method
> > on the cleanup-on-error path. So adding new code in the method we won't
> 

> No it is not. On-stack variable initialization is not free. So if
> initializing the variable is not needed, do not do it.

This patch isn't about on-stack initialization, but about bringing an
order to the error-handling procedure of the
ahci_platform_get_resources() method. Explicitly setting the rc variable
with an error value closer to the place caused the error much easier
to perceive than keeping in mind that the variable has been set with
some default value. That turns to be even more justified seeing the
rest of the method does it that way.

See my next comment regarding the initialization.

> 
> > have to think whether the overridden rc-variable is set afterward in case
> > of an error. Saving one line of code doesn't worth it especially seeing
> > the rest of the ahci_platform_get_resources() function errors handling
> > blocks do explicitly write errno to rc.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/ata/libahci_platform.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 18296443ccba..1bd2f1686239 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  	struct ahci_host_priv *hpriv;
> >  	struct clk *clk;
> >  	struct device_node *child;
> > -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> > +	int i, enabled_ports = 0, rc = 0, child_nodes;
> >  	u32 mask_port_map = 0;
> >  
> >  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> > @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >  
> >  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
> >  			     GFP_KERNEL);
> > -	if (!hpriv)
> > +	if (!hpriv) {
> > +		rc = -ENOMEM;
> >  		goto err_out;
> > +	}
> 

> If you set rc to -ENOMEM here, then the 0 initialization of rc is not needed.

Normally you are right. But the case of the rc/ret/etc variables is
special. I'd stick with having it defaulted to 0 here. Here is why.

When it comes to using the rc/ret/etc variables the maintainability
gets to be more important than some small optimization (especially
here seeing the ahci_platform_get_resources() is called once per
device life-time) because in case of the method alteration these
variables very often get to be involved in one way or another. If due
to a mistake the rc/ret/etc variable isn't updated in case of an
erroneous situation but the method is terminated with the goto-pattern
and rc/ret/etc isn't initialized with any default value then we will
end up with having a garbage pointer returned. We'd be lucky if it was
a null pointer, but in general it can be a reference to some random
memory region. In the later case the kernel may experience random
crashes with hard-to-find cause of the problem. In the former case the
problem would have been tracked right away on the testing stage by
getting the system invalid-pointer de-reference crash. That's why
defaulting the variable to zero here is still useful.

-Sergey

> 
> >  
> >  	devres_add(dev, hpriv);
> >  
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

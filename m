Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF5E4F6C65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiDFVRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDFVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:17:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3B725DA89;
        Wed,  6 Apr 2022 13:03:37 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so5977640lfg.7;
        Wed, 06 Apr 2022 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4+OJAkAhIpYr4dUURX+n/miMXTZ5adYcNvlJUTxiMo=;
        b=XJLCoJ64S+YLqT+cFVwyP9lTa15JBXlVaonaDiPi35phnY7VMspLBdw0avp9unkdd4
         oD6emCucTEQtHoTi5bq3pyiAOr0Yh+N3bJNnXeXDX9OTN5Lzrgp27ydF2l2RfdHx/8if
         aJHLmmuqqWpbq4LMyKnzzQbEObZ3I4U0OeAvin16spGN0QwxVjq98sndBG0i8DdnWFDf
         cjoBqHVHO+ybGsWlKTqiA9VxT79sgsHGuWYcaPh9D2c7sT0M6PFprx+Xl181rVl5Ncgx
         ZThx5wk6mGsr3hlU7MdPH8zfUiAGkMHc6OgRDaDfZP/yYvVcCWDAR9O2QQ1juB/tff2A
         aXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4+OJAkAhIpYr4dUURX+n/miMXTZ5adYcNvlJUTxiMo=;
        b=PM0Q+FwBTgCMDT9Y0PynQHGsM/1NMn6QW7KKVnPAVfzWR5ArmHpRhEF405DAN038qS
         bwaJ1UH4NOqnva9nkT+mfm1fSQylrGd3iQQAj07efRUa7J2s+7M2N1s4UhY72UIIegcj
         CzyycrKExFu2RwSPRrkDOR/Ebz+5hMkqDhsuRMjE1PGX534c3gyVHTRpD3QKQbODV5jT
         tkWu+lMvE4KboONAgc7ITsRvMG0dla1GUw0ItPdfi7LmnfE6BLXCyYQU7VUwoLRAuxzP
         L3D2fPgK3wCTYCk3MLzEL4QFj23vBn8H6ZRONfuC9cq8NMlneBcKkyLJhdQUWmrdAuud
         X5+A==
X-Gm-Message-State: AOAM530C60rkYv9x3W9cGP7qQ/dJqnW5qQGfHehX0Upj37jYCvfzQt1H
        1UoVHt8UNsutDBkQYDrNVvk=
X-Google-Smtp-Source: ABdhPJzT0+wr0kHlkE/R+eu4k+VxrRsnXJJcITDlDKbnW4Px0dtwSxcd+S6OsxvKy9LuPTe6WhbHTw==
X-Received: by 2002:a05:6512:33d0:b0:44a:72b2:cd36 with SMTP id d16-20020a05651233d000b0044a72b2cd36mr7166337lfg.113.1649275415897;
        Wed, 06 Apr 2022 13:03:35 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id m14-20020a2eb6ce000000b0024afbbbb0c3sm1760089ljo.70.2022.04.06.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:03:35 -0700 (PDT)
Date:   Wed, 6 Apr 2022 23:03:33 +0300
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
Message-ID: <20220406200333.3olw47az7eqjqnyq@mobilestation>
References: <20220324001628.13028-1-Sergey.Semin@baikalelectronics.ru>
 <20220324001628.13028-4-Sergey.Semin@baikalelectronics.ru>
 <9128f850-fcc1-811e-b781-b7fbcb2403ba@opensource.wdc.com>
 <20220324213758.vihvh5z2pg3skr6i@mobilestation>
 <f163f982-852f-027f-8d24-e624e45fbbf1@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f163f982-852f-027f-8d24-e624e45fbbf1@opensource.wdc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:56:29AM +0900, Damien Le Moal wrote:
> On 2022/03/25 6:37, Serge Semin wrote:
> > Hello Damien
> > 
> > On Thu, Mar 24, 2022 at 09:58:34AM +0900, Damien Le Moal wrote:
> >> On 3/24/22 09:16, Serge Semin wrote:
> >>> It's better for readability and maintainability to explicitly assign an
> >>> error number to the variable used then as a return value from the method
> >>> on the cleanup-on-error path. So adding new code in the method we won't
> >>
> > 
> >> No it is not. On-stack variable initialization is not free. So if
> >> initializing the variable is not needed, do not do it.
> > 
> > This patch isn't about on-stack initialization, but about bringing an
> > order to the error-handling procedure of the
> > ahci_platform_get_resources() method. Explicitly setting the rc variable
> > with an error value closer to the place caused the error much easier
> > to perceive than keeping in mind that the variable has been set with
> > some default value. That turns to be even more justified seeing the
> > rest of the method does it that way.
> 
> I agree with that change. Setting "rc = -ENOMEM" under the "if" checking for
> error is fine.
> 
> > 
> > See my next comment regarding the initialization.
> > 
> >>
> >>> have to think whether the overridden rc-variable is set afterward in case
> >>> of an error. Saving one line of code doesn't worth it especially seeing
> >>> the rest of the ahci_platform_get_resources() function errors handling
> >>> blocks do explicitly write errno to rc.
> >>>
> >>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >>> ---
> >>>  drivers/ata/libahci_platform.c | 6 ++++--
> >>>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> >>> index 18296443ccba..1bd2f1686239 100644
> >>> --- a/drivers/ata/libahci_platform.c
> >>> +++ b/drivers/ata/libahci_platform.c
> >>> @@ -389,7 +389,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>>  	struct ahci_host_priv *hpriv;
> >>>  	struct clk *clk;
> >>>  	struct device_node *child;
> >>> -	int i, enabled_ports = 0, rc = -ENOMEM, child_nodes;
> >>> +	int i, enabled_ports = 0, rc = 0, child_nodes;
> >>>  	u32 mask_port_map = 0;
> >>>  
> >>>  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
> >>> @@ -397,8 +397,10 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
> >>>  
> >>>  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
> >>>  			     GFP_KERNEL);
> >>> -	if (!hpriv)
> >>> +	if (!hpriv) {
> >>> +		rc = -ENOMEM;
> >>>  		goto err_out;
> >>> +	}
> >>
> > 
> >> If you set rc to -ENOMEM here, then the 0 initialization of rc is not needed.
> > 
> > Normally you are right. But the case of the rc/ret/etc variables is
> > special. I'd stick with having it defaulted to 0 here. Here is why.
> > 
> > When it comes to using the rc/ret/etc variables the maintainability
> > gets to be more important than some small optimization (especially
> > here seeing the ahci_platform_get_resources() is called once per
> > device life-time) because in case of the method alteration these
> > variables very often get to be involved in one way or another. If due
> > to a mistake the rc/ret/etc variable isn't updated in case of an
> > erroneous situation but the method is terminated with the goto-pattern
> > and rc/ret/etc isn't initialized with any default value then we will
> > end up with having a garbage pointer returned. We'd be lucky if it was
> > a null pointer, but in general it can be a reference to some random
> > memory region. In the later case the kernel may experience random
> > crashes with hard-to-find cause of the problem. In the former case the
> > problem would have been tracked right away on the testing stage by
> > getting the system invalid-pointer de-reference crash. That's why
> > defaulting the variable to zero here is still useful.
> 

> No it is not. We have code reviews and testing to catch mistakes. If we start
> thinking along these lines, any useless local variable initialization can be
> justified. So let's not go there please.

Ok. That's up to the maintainer to decide after all. I'll just drop the
initialization as you say then.

-Sergey

> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

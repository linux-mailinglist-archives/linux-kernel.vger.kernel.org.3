Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8572054E69C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377754AbiFPQDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbiFPQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:03:14 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B41A077
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:03:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e5so1038048wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NCDcJFvk5h0uaZbSheAbbUu21FNky9fEI5n0bdk5PYA=;
        b=ROc6sV/gbq1bnkxk/b64yFCbwBLupx3UlHaKrDRxug/BVGmiFk97Niu22ImE6Tb3yy
         x4MOtjwFkaYroEPEyH/H7NEM8kp36yS9M5iQp+GZXweWdZQ01KGpRrIvi28YSci/OhZK
         d6GdXCISXgMFQbbGueXydI6fsx/csManMtB2vWGQpDcUz5fZ1eAyxp3BBnjuNPvz5btE
         iXAISCKnqhHzlfihdkbK/KBoDVFNHXPMpHIr8PTB8MZseUE8cgMAwN8qd05ax5jqANya
         451g8HDsjfhcVKxTK5HIOk3BdIU4pUz31IBayUGjOKwaxVe6qNOQphCSKSjxViOEXdiW
         HAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NCDcJFvk5h0uaZbSheAbbUu21FNky9fEI5n0bdk5PYA=;
        b=ZFM7b+y4L6fNRqdHgGTPxQidSfAvLMr1dfSDaABFY9wdPokeqZYCz3IsrJE0Pxrkyd
         qbdG0JYnqSvj2NXX96C3cYhKeYOD0jni4XFFyH5YSP2QXTARUDQKBdAZWD9TqdrwTt7e
         i3hssa4njXs29JI9A9VNbqyKQfr2usBA7qljkhiKpC3s8ZWTkc9ygH85zKtYWmNZufhc
         x2IJS62phUTvzX18UE3YSWvPAcAqrq6k10TE2HJwj8++/jXL9R9CN0I43/grXNhYhy3g
         JP4EtP5o2FfQ8+6KmCL3qWNBmz/wIlIOFJlalqhKwIhoP/SG24AoYlNDtficr7LGpJKA
         UeoA==
X-Gm-Message-State: AOAM533yXs45Zdqr3cZJYOCiAzug/pDtLtE+fjVLrCzKLKFZKGw1FaX4
        KdtLDq6N/cJqWPPagBSJkAeAgg==
X-Google-Smtp-Source: ABdhPJwKJgudjRYYNB+jz7FFiZbOYWUUm8oEeuxgv14rC0xeIIJsR/5Z7h/lohJ8LRK08wDy5HriQw==
X-Received: by 2002:a05:600c:3493:b0:39c:8731:84c3 with SMTP id a19-20020a05600c349300b0039c873184c3mr16445573wmq.45.1655395391961;
        Thu, 16 Jun 2022 09:03:11 -0700 (PDT)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id n125-20020a1c2783000000b003974cb37a94sm6365683wmn.22.2022.06.16.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:03:11 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:03:10 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, will@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YqtUPh/9qK7+jqJc@google.com>
References: <20220616092737.1713667-1-sebastianene@google.com>
 <20220616092737.1713667-3-sebastianene@google.com>
 <YqsBeme1Vnzj5k7+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqsBeme1Vnzj5k7+@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 12:10:02PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jun 16, 2022 at 09:27:39AM +0000, Sebastian Ene wrote:
> > This driver creates per-cpu hrtimers which are required to do the
> > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > userspace is responsible for delivering the 'pet' events by writing to
> > the particular /dev/watchdogN node. In this case we require a strong
> > thread affinity to be able to account for lost time on a per vCPU.
> > 
> > This part of the driver is the 'frontend' which is reponsible for
> > delivering the periodic 'pet' events, configuring the virtual peripheral
> > and listening for cpu hotplug events. The other part of the driver
> > handles the peripheral emulation and this part accounts for lost time by
> > looking at the /proc/{}/task/{}/stat entries and is located here:
> > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  drivers/misc/Kconfig               |  12 ++
> >  drivers/misc/Makefile              |   1 +
> >  drivers/misc/vcpu_stall_detector.c | 222 +++++++++++++++++++++++++++++
> >  3 files changed, 235 insertions(+)
> >  create mode 100644 drivers/misc/vcpu_stall_detector.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 41d2bb0ae23a..9b3cb5dfd5a7 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -483,6 +483,18 @@ config OPEN_DICE
> >  
> >  	  If unsure, say N.
> >  
> > +config VCPU_STALL_DETECTOR
> > +	tristate "VCPU stall detector"
> > +	select LOCKUP_DETECTOR
> > +	help
> > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > +	  has to do a 'pet', it exits the guest through MMIO write and the
> > +	  backend driver takes into account the lost ticks for this particular
> > +	  CPU.

Hi,

> 
> which virtual machine framework is this for?  kvm?  xen?  hyperv?
> vmware?  something else?
> 
> Specifics please...
> 
> thanks,

I will improve my description, thanks for taking a look.

> 
> greg k-h

Seb

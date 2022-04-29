Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF87514562
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbiD2J3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356541AbiD2J3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:29:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38F8C4013
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:26:29 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so9985616wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QX7FQMLThcuJs/2cBMas+FdLeZ0raDGjPsBB8zqn6fk=;
        b=IGLrSesTPryWuHxSpSIcGomwqe3OV44Xq4NPCw4fMrdMIT8H3Bjkf8aMNdxvR4bUm8
         E72PxAGOEOzBCd2lmfeqBdnV94WA3+wHZrvVNySCmMppiXLvcnMpf15IOTjiqk9HG5fk
         kBrxEqsTugnJoBpKqqBdpQ7Up902WpOw8ty0lx74MNvU9Tta35pcLhYiZYQ2l0TcBMQO
         uwtPoJjn5nUBiAuT2mf2TuHaLhi9/4gfqHVXkupG1vd543LmM/gFw+I2cBEt6JdFnqgJ
         FiqEZUOsxHXWTdMBSbMJ73O1WAt8KdyGAKLG9v/xeoeULDw8cVjqFOplvxqOoJ4BtWUT
         BWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QX7FQMLThcuJs/2cBMas+FdLeZ0raDGjPsBB8zqn6fk=;
        b=XrVcArXNOFlZYDmBhJMBrzijTGQf5F2GHwuMgS6UakLtsyGY7DVG7QsM+kreStTDsF
         ZqSAx6lCYa8L85MoGqmdt5B8vKAgB9bDGyor1/7GcwFfO4A4IGDc2f8pFntgQjxGBLXW
         2B28dNZFSS0r/s5qfaqkvJUWAVc24HmyBeQRm0CqOfit3j4cMWRi+whuDb3RbCZj5+57
         WU5KPlouqKM93mc4m/d9PYEgny0FHZyaVDcepSklhLt5FZg4AFemf5ioesm6NegTI/uO
         RVlX5pdhKN+JwB/ZIQmXocC6AvgemOs6FbRVR79jYemrsChlDljkf1rA1DfqQ4NwrMRY
         ix1A==
X-Gm-Message-State: AOAM5311RFJZtcztTiUIA4A69fT34QMoAJJXxOmhoPQ8IFrjMTVcho4Z
        xRuXH+KJgFFTD4cn0cwlO2xZ9w==
X-Google-Smtp-Source: ABdhPJwjHtX0jD2ghcawoeRZfZ6mOzKq+7goYkFpQrwGpzUfxCj2gJjshEdHfuNt1zfcI7VtiVbWRw==
X-Received: by 2002:a5d:4311:0:b0:205:f26b:fb98 with SMTP id h17-20020a5d4311000000b00205f26bfb98mr30515219wrq.202.1651224388238;
        Fri, 29 Apr 2022 02:26:28 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id f10-20020adfc98a000000b0020acee46c88sm2057293wrh.21.2022.04.29.02.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 02:26:27 -0700 (PDT)
Date:   Fri, 29 Apr 2022 09:26:26 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmuvQvuPF/mn5S4C@google.com>
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmunAm8ooJkNCx5D@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmunAm8ooJkNCx5D@kroah.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 10:51:14AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
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
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  drivers/misc/Kconfig       |  12 +++
> >  drivers/misc/Makefile      |   1 +
> >  drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 219 insertions(+)
> >  create mode 100644 drivers/misc/vm-watchdog.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 2b9572a6d114..26c3a99e269c 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -493,6 +493,18 @@ config OPEN_DICE
> >  
> >  	  If unsure, say N.
> >  
> > +config VM_WATCHDOG
> > +	tristate "Virtual Machine Watchdog"
> > +	select LOCKUP_DETECTOR
> > +	help
> > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > +	  has to do a 'pet', it exits the guest through MMIO write and the
> > +	  backend driver takes into account the lost ticks for this particular
> > +	  CPU.

Hi,

> 
> There's nothing to keep this tied to a virtual machine at all, right?
> You are just relying on some iomem address to be updated, so it should
> be a "generic_iomem_watchdog" driver as there's nothing specific to vms
> at all from what I can tell.
> 
> thanks,
> 
> greg k-h

That's right although I might think of using the term "generic lockup detector"
instead of watchdog. The only reason why I would keep "virtual machine"
word in, is that there is no actual hardware for this.

Thanks,
Seb

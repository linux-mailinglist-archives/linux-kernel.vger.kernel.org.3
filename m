Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45C516A98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 07:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383403AbiEBGBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiEBGBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:01:42 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886D22CC9C
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 22:58:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so7915794wmn.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vDT6/tY8zoIHIWNIkOC1cQJGoUW1dbZJBla1wtkRQW0=;
        b=BlYI1gyTfrKeQnkuyubgA0no/SA5tgsvSzauIm8z7eCvzd+FfdolqNaIyCpXJ4SSbD
         Xh75zmWDwrLxIBWNkqm3wJTBFunLSzHOLC37brmVQD/MJIkoHXNr++ZJFyU5DPtOzXfQ
         MjNJCPyjKAwAEpYQxMKLfpy2cs931MZpbJvqDcFeG/rNm/BnjokJo3IwZrR99J6W7fP1
         VL08b7P6QSNgYhKAqtUTalnVugH/+NxOKA/9LRSvYKaG3UY2kTwSW3sH6xVW2JNe1qjm
         F7PcqujgpGX1/svIvJl53fo0MihXVsQhjSgr8at8sPLKwRymckMzTtA4bAqtQYZN5VuF
         yz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vDT6/tY8zoIHIWNIkOC1cQJGoUW1dbZJBla1wtkRQW0=;
        b=TjvLzGKMaXvT/8LDc2tSCEMcujiJNOTftS9fAjUJr7LLfgRBVoChzjNYyhCtrqc+yT
         RBmzInd4JB9Tyr5ChX6ArmHvAuwWfRfwpdVYwHlB0a7jlSzmP+Hkw5onW+6kDHKpI/1+
         2c0BMKeE14soVWaL7ojx26v4/+bbVSwzrMWJmTwifp8xtUoJRmUSfbOdB0NSRSfWyWtN
         KGlNmn40YmMQpwOIo25LSbFr++SCigVCqvXsJr/6KhJp6tXHY4sYV6s2Y7WjMdpU3hfk
         E0/vHgMkcDWfNddiPz/pfjKHfw2TxifPKzLJyv5sXlqHzFHWcsnY3Vdyj5If/ETQm9d7
         aOuQ==
X-Gm-Message-State: AOAM531e1gPyhm7NGjyakuWSANQK/XyTB44lSIJfyDurn9NoG3mUIaWo
        D/PCqa91lAAUTJ2PEDNnl0fI9w==
X-Google-Smtp-Source: ABdhPJxalZwLpvhz3ptVg7FD8Nk4eg088NUMnBilwPASoQ/Rvei1P5G8MBnR+5R02rSkfEmIpVm8QA==
X-Received: by 2002:a05:600c:48b:b0:394:2ee9:5847 with SMTP id d11-20020a05600c048b00b003942ee95847mr8501983wme.117.1651471093005;
        Sun, 01 May 2022 22:58:13 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id o8-20020a1c4d08000000b003942a244ecesm5393224wmh.19.2022.05.01.22.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 22:58:12 -0700 (PDT)
Date:   Mon, 2 May 2022 05:58:10 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org, maz@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <Ym9y8hwuk41cf7YS@google.com>
References: <20220429083030.3241640-1-sebastianene@google.com>
 <20220429083030.3241640-3-sebastianene@google.com>
 <YmumSgiTrQUWoXsb@kroah.com>
 <e94fdd89-7b8e-eec3-4b2f-dcea55c7f0bc@roeck-us.net>
 <YmzUpr0e+eq0NUYc@kroah.com>
 <4217c96d-2fe2-fdef-3b15-b5368499f1bf@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4217c96d-2fe2-fdef-3b15-b5368499f1bf@roeck-us.net>
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

On Sat, Apr 30, 2022 at 05:36:50AM -0700, Guenter Roeck wrote:
> On 4/29/22 23:18, Greg Kroah-Hartman wrote:
> > On Fri, Apr 29, 2022 at 09:51:51AM -0700, Guenter Roeck wrote:
> > > On 4/29/22 01:48, Greg Kroah-Hartman wrote:
> > > > On Fri, Apr 29, 2022 at 08:30:33AM +0000, Sebastian Ene wrote:
> > > > > This driver creates per-cpu hrtimers which are required to do the
> > > > > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > > > > userspace is responsible for delivering the 'pet' events by writing to
> > > > > the particular /dev/watchdogN node. In this case we require a strong
> > > > > thread affinity to be able to account for lost time on a per vCPU.
> > > > > 
> > > > > This part of the driver is the 'frontend' which is reponsible for
> > > > > delivering the periodic 'pet' events, configuring the virtual peripheral
> > > > > and listening for cpu hotplug events. The other part of the driver
> > > > > handles the peripheral emulation and this part accounts for lost time by
> > > > > looking at the /proc/{}/task/{}/stat entries and is located here:
> > > > > https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/3548817
> > > > > 
> > > > > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > > > > ---
> > > > >    drivers/misc/Kconfig       |  12 +++
> > > > >    drivers/misc/Makefile      |   1 +
> > > > >    drivers/misc/vm-watchdog.c | 206 +++++++++++++++++++++++++++++++++++++
> > > > >    3 files changed, 219 insertions(+)
> > > > >    create mode 100644 drivers/misc/vm-watchdog.c
> > > > > 
> > > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > > index 2b9572a6d114..26c3a99e269c 100644
> > > > > --- a/drivers/misc/Kconfig
> > > > > +++ b/drivers/misc/Kconfig
> > > > > @@ -493,6 +493,18 @@ config OPEN_DICE
> > > > >    	  If unsure, say N.
> > > > > +config VM_WATCHDOG
> > > > > +	tristate "Virtual Machine Watchdog"
> > > > > +	select LOCKUP_DETECTOR
> > > > > +	help
> > > > > +	  Detect CPU locks on the virtual machine. This driver relies on the
> > > > > +	  hrtimers which are CPU-binded to do the 'pet' operation. When a vCPU
> > > > > +	  has to do a 'pet', it exits the guest through MMIO write and the
> > > > > +	  backend driver takes into account the lost ticks for this particular
> > > > > +	  CPU.
> > > > > +	  To compile this driver as a module, choose M here: the
> > > > > +	  module will be called vm-wdt.
> > > > 
> > > > You forgot to name the module properly here based on the Makefile change
> > > > you made.
> > > > 
> > > > And again, as this is called a "watchdog", it seems crazy that it is not
> > > > in drivers/watchdog/
> > > > 
> > > 
> > > I disagree. It is not a watchdog driver in the traditional sense (it does
> > > not use, want to use, or need to use the watchdog driver API or ABI).
> > > Its functionality is similar to the functionality of kernel/watchdog.c,
> > > which doesn't belong into drivers/watchdog either.

Hi,

> > 
> > Ah, ok, that makes more sense, the user/kernel api is not the same.
> > Someone should put that in the changelog next time :)
> > 

I will include this in the changelog to fix the confusion.

> 
> Renaming it to "VCPU stall detector" or similar should fix the confusion.
> 

Yes I think that is a better naming.

Thanks,
Seb

> Guenter

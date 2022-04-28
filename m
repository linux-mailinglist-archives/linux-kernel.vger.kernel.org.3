Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B7F513675
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbiD1ONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347933AbiD1ONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:13:37 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C085E749
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:10:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k2so6973770wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hDK2LW4ixFaiS76Yog56KrcGnNdurhIS+pY8Y104vts=;
        b=OB73Vf/TiDEDaq66Sl/bRYqcZ/YVS6/pn5Z7K8ZY4DwuCIUsL+udPqXRYsS/p1mCkG
         hNXWWzV2UYh3HlilxhPtpgFomaVcT5ludnmS2DJseIFX3yVO0hgkQKmqr2xJGxoxsrLb
         tm0548XOg88uK1d59cnJ/qRX0OinBQCQfK4yc6YvlxofVXstQJ2QqiEPbNXkua3Cb/Qf
         Yja0+Fl5aT4TKUtjDv0ErKjr10bs0Mak83gvB/J5tie2PCeNBfEiH/Bt5+ZNfP5X80Jb
         nTS0zWTyGBZx4hsa8rSRzrV9g/qVN6pB1U+PelFvVs66Rz/WmcS92wiuFU0mXfI5NYpn
         d/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDK2LW4ixFaiS76Yog56KrcGnNdurhIS+pY8Y104vts=;
        b=SHCUCbpC6w+y1aNzMEmrhd6jVeff9MD9pFtQEudIhacddVlvS5n5SqaSFjH/MRrs7t
         mG7ia8B0y7SablV4oynrp6mPT27aA5aGr16l4dZQJNoNUCHOKieIzGWnINRh841ZaqaH
         zgfT/Ter2K3Jgsx14Ai1v7y+H5zZcug7V6o/aR1Q0boAs5+43Ke8OkCNVlwUepbw7bKs
         E4Kr/eIygvv3/vs4G97oQnxv0waJIXSQX0FQhLD2nQHqypCz4lQLChyRX7hI9MjJH2eC
         r+mMKYNkGKLTL//KqYldQB/7jmUkLI2ElS/1gjGLmb8k9tYfFFSsihkfPL7hmJCZUFe5
         r5Qg==
X-Gm-Message-State: AOAM531Qx3Zmr66VQmpdpmkwrWVj5OweYXXue3dQChUTTVhDzC0FTfXt
        9gNTXv/TOBdGXQLe5SQhi0ZlmusOKxAcqA==
X-Google-Smtp-Source: ABdhPJz2j2Cic+9yZ2453CMk5FbhXKf1RvIRzyVKuz1CtWy/DI7LGqsle1CvTJu+hsECDbJ9+ApMPA==
X-Received: by 2002:a5d:44cf:0:b0:20a:c5d2:b6c3 with SMTP id z15-20020a5d44cf000000b0020ac5d2b6c3mr26522444wrr.177.1651155019802;
        Thu, 28 Apr 2022 07:10:19 -0700 (PDT)
Received: from google.com (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020aa79d55b5sm19435890wrb.35.2022.04.28.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:10:19 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:10:18 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        qperret@google.com, will@kernel.org, maz@kernel.org
Subject: Re: [PATCH v3 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <YmqgSg6viIK5H9Rc@google.com>
References: <20220425134204.149042-1-sebastianene@google.com>
 <20220425134204.149042-3-sebastianene@google.com>
 <1d938867-05b9-fab5-1f48-a635d92420d3@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d938867-05b9-fab5-1f48-a635d92420d3@infradead.org>
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

On Mon, Apr 25, 2022 at 09:02:03AM -0700, Randy Dunlap wrote:
> 
> 
> On 4/25/22 06:42, Sebastian Ene wrote:
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
> >  drivers/misc/Kconfig  |  12 +++
> >  drivers/misc/Makefile |   1 +
> >  drivers/misc/vm-wdt.c | 207 ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 drivers/misc/vm-wdt.c
> > 
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 2b9572a6d114..71c173e3f064 100644
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
> > +	  has to do a 'pet', it exists the guest through MMIO write and the

Hi,

> 
> 	                        exits ?
> I dunno, but it's confusing.
> 

Yes, I will correct this typo, thanks for the notice.

> > +	  backend driver takes into account the lost ticks for this particular
> > +	  CPU.
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called vm-wdt.
> 
> 
> 
> -- 
> ~Randy

Sebastian

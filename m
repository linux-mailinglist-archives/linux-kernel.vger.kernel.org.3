Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6144CDE52
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiCDULx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiCDUKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:10:30 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D121BFDD6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 12:05:53 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so10640566ooq.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 12:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=T7SqPemMgzqeX0eBPPz3FX/ZWDE+/Yzg/d3Nfke4UpM=;
        b=nUAICK4lB2FzB60FGNvELrGPzsWLAjTyIY1hxQMeB4g3nlxzTPnpn4Pt/zlACk5wc1
         cy3Zs1aBJ7wPqAQoDO/H17ddd3w7XoM6a9OuUGQNbSiVRpqLPRbMLQQ5fe1gc4FUICkB
         KI0EdhJ1jrQFyF3o9fgl6S7gLIFzcnYyPaxWHUpA8oQO6YlH5p0PqfEPdFPRjXVLQk9G
         8q6I5jVnzAH0tvKyoB3+meUU7xM2HA1GGpPmYxFK/WinealJPKydUbH/2Jmid4lNcFxj
         WZmBXF4mO7SW2Xac6u7RWjuWeeDA9ljSuoo1jmLZBDjaCPqRe8SSVZIbJY0zE4WNa0/l
         lF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T7SqPemMgzqeX0eBPPz3FX/ZWDE+/Yzg/d3Nfke4UpM=;
        b=qSNk/YyQOyamNtEG7wy7dbXrxURHqAZ2b9e2PVxRvGSF6QFfTX34ygCgkk3YmMFfhA
         ljoxqkcUsASsHT7BJ5nhjm25wGhJvmroofeQizUvtBH9RwRWDSsxza2xV5uM0OR3Nbq+
         oWw6wVbedFGgYZVoq4FdcOjOOWg0e+2UaZ8sSnWBqQJFfdvl3s7VGNvFKrAV0x2GBBgs
         q7pzl/6YiNRl/VhDvvnU3i530uQdpq1PVCXxWY4pvz5IXhl/SHQz2Nu0iVsCe/jZbwQM
         hZkvufKVXD7bE0/y4nSvb5hyv6hlwoVUetSkn8rdecAk3LqTP5l6RgGBKwHCquyl330r
         VGmw==
X-Gm-Message-State: AOAM530D/go64tgJk3qtJyANuxuKAcpQDBP4VuxgSIAVduEwmm6jn5Zv
        yt0i1+2SZIP2v/wS6LFvJBHRAcYH0ug=
X-Google-Smtp-Source: ABdhPJyN779d3j8xQjEPoJqb5A/WWySFaaoReEhphvW0mluDY66q8fKLlSno3yM2LfcRvhW6GeoNMQ==
X-Received: by 2002:a05:6870:3510:b0:d7:179e:7e90 with SMTP id k16-20020a056870351000b000d7179e7e90mr8887695oah.168.1646422228486;
        Fri, 04 Mar 2022 11:30:28 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 ([181.22.168.223])
        by smtp.gmail.com with ESMTPSA id b43-20020a4a98ee000000b0031bf8505320sm2595215ooj.25.2022.03.04.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 11:30:27 -0800 (PST)
Date:   Fri, 4 Mar 2022 16:30:15 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, ojaswin98@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: Re: [PATCH 2/2] staging: vchiq_arm: add prototype of function
 vchiq_platform_init()
Message-ID: <20220304193015.wgofp34efl2loplj@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1646255044.git.gascoar@gmail.com>
 <b74ac90e869f71a98a04b834c4f3b5ab37bb38ea.1646255044.git.gascoar@gmail.com>
 <20220303122546.GH2794@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303122546.GH2794@kadam>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:25:47PM +0300, Dan Carpenter wrote:
> On Wed, Mar 02, 2022 at 06:36:38PM -0300, Gaston Gonzalez wrote:
> > Fix "no previous prototype" W=1 warning by adding the prototype of the
> > function vchiq_platform_init().
> > 
> > Note: vchiq_platform_init() is only called once in vchiq_probe(), so
> > presumably should be static function. However, making the function
> > static breaks the build.
> > 
> 
> That's weird.  I don't have an ARM cross compile set up.  How does the
> build break?
> 
> regards,
> dan carpenter
>

Hi Dan,

Test building the driver in x86 I get the error pasted below.

However, now that you mention it, I made an ARM (64 bit) cross
compilation: making the function static builds OK without the warning.
I'll to do the same for a 32 bit setup.

So I suppose that making the function static is the right approach ?

FWIW, branch and cross-compiler:

- Remote: https://github.com/raspberrypi/linux.git
- Branch: rpi-5.17.y
- gcc: aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110


-> x86 build error:

CC [M]  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.o
In function ‘free_pagelist’,
    inlined from ‘vchiq_complete_bulk’ at drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:650:3:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:434:4: error: argument 2 null where non-null expected [-Werror=nonnull]
  434 |    memcpy((char *)kmap(pages[0]) +
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  435 |     pagelist->offset,
      |     ~~~~~~~~~~~~~~~~~
  436 |     fragments,
      |     ~~~~~~~~~~
  437 |     head_bytes);
      |     ~~~~~~~~~~~
In file included from ./arch/x86/include/asm/string.h:5,
                 from ./include/linux/string.h:20,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./arch/x86/include/asm/cpumask.h:5,
                 from ./arch/x86/include/asm/msr.h:11,
                 from ./arch/x86/include/asm/processor.h:22,
                 from ./arch/x86/include/asm/timex.h:5,
                 from ./include/linux/timex.h:65,
                 from ./include/linux/time32.h:13,
                 from ./include/linux/time.h:60,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:13,
                 from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:8:
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c: In function ‘vchiq_complete_bulk’:
./arch/x86/include/asm/string_64.h:14:14: note: in a call to function ‘memcpy’ declared here
   14 | extern void *memcpy(void *to, const void *from, size_t len);
      |              ^~~~~~
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:288: drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.o] Error 1
make: *** [Makefile:1831: drivers/staging/vc04_services] Error 2

regards,

Gaston

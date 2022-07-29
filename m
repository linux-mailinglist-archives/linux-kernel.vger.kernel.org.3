Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C87584CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiG2HzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiG2Hy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:54:59 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EE7E016
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:54:55 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bf13so3413440pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EpbrqnKtk3kFON9/3PAbidIFZ967vmGDGx5zkRsOP3s=;
        b=I1HX+JufsaIJKogL6+pxskC89VSj9U8lAOwSP4OPH6ZBKqXgpxMKVb/7HkFSfhzUqT
         bKoCqFkLvsq+dXwbKTtZXHlYEzfPuEWsJUzP5sS0S+CiNpWrD9G0AtzoSs/4VZjVrYIr
         UQaWNEZ4GVva9fMzdTMqnEA6b4SciwrCYgt5FMWakgpB3AxM63CtYjtWAcjmdvnM8OTY
         6ocBXBaljQ1mFM4RrsETvpDgMj2z0s/PyBnI+5BI8j+dPW+RKd/OoYXYgMCQAA0lrXB5
         1Raerz6bba5mhyRx4lnaiL5jgpJZiDNAhgLhjgM3x1qGwLlaiN/hVOdJJSyzdTNKgpd2
         QGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EpbrqnKtk3kFON9/3PAbidIFZ967vmGDGx5zkRsOP3s=;
        b=l+uMeG1G4mgHtvx50Wl60323V7/SMgZxdn5TB/Qc3eAQCrTcaR/kE1jG5qxnaqQUbh
         u4ta2ZDi/FaJHBjZZbacUQllW/6ms4ABzlNlY30GvUGFkDkbjOY6cM8/kUPK1Tb2U955
         SX2K+2UODDBSX4nLKd2cU5CcgRINQJPV5sBRa86NJwZ3vLIQt9Tauy1CCTYjmpwFcKRg
         8coigmX/4N1k8ocQ34V32rg4mh9oU73Dzuz49sPMMjSaGhd2imEXGcsT2la8LtfI4YWT
         BJXE3YzcncMxWB3ma7/theYYVQ1ZWaMw/Mdaz/lxIdalxBZ/vVKZh7IqpZkwVER4fNBl
         yb1g==
X-Gm-Message-State: AJIora8ap8y6g7v9hBVkvKTdFJb5+S2d7Gz/3G9uRxed82iznMfJgLLR
        nSrARMenZBsTVPRNQI2Z/6o=
X-Google-Smtp-Source: AGRyM1sWjyhz6qAc2teSfLZClNCOrL9fLPKhtaaMwWEQ+Mrxkqs6+b3EQhDIck94K9ehm7RsmRuFnA==
X-Received: by 2002:a05:6a00:27a6:b0:52a:e089:e777 with SMTP id bd38-20020a056a0027a600b0052ae089e777mr2295265pfb.53.1659081294923;
        Fri, 29 Jul 2022 00:54:54 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x26-20020aa79a5a000000b00525521a288dsm2181583pfj.28.2022.07.29.00.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 00:54:54 -0700 (PDT)
Date:   Fri, 29 Jul 2022 16:54:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v3 2/3] openrisc: Add pci bus support
Message-ID: <YuOSTOAVw6zekvL+@antec>
References: <20220725020737.1221739-1-shorne@gmail.com>
 <20220725020737.1221739-3-shorne@gmail.com>
 <20220729033728.GA2195022@roeck-us.net>
 <YuN1PWcDukEPdtQy@antec>
 <ceb732ee-0ea1-b471-0b57-3cc3bcb80a2d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb732ee-0ea1-b471-0b57-3cc3bcb80a2d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:10:37PM -0700, Guenter Roeck wrote:
> On 7/28/22 22:50, Stafford Horne wrote:
> > On Thu, Jul 28, 2022 at 08:37:28PM -0700, Guenter Roeck wrote:
> > > On Mon, Jul 25, 2022 at 11:07:36AM +0900, Stafford Horne wrote:
> > > > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > > > This is being tested on the OpenRISC QEMU virt platform which is in
> > > > development.
> > > > 
> > > > OpenRISC does not have IO ports so we keep the definition of
> > > > IO_SPACE_LIMIT and PIO_RESERVED to be 0.
> > > > 
> > > > Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> > > > systems") all platforms that support PCI also need to support parallel
> > > > port.  We add a generic header to support compiling parallel port
> > > > drivers, though they generally will not work as they require IO ports.
> > > > 
> > > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > 
> > > This patch results in
> > > 
> > > Building openrisc:allmodconfig ... failed
> > > --------------
> > > Error log:
> > > drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
> > > drivers/video/fbdev/riva/fbdev.c:2062:42: error:
> > > 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> > > 
> > > drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
> > > drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
> > > 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> > > 
> > > drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
> > > drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
> > > 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> > > 
> > > ... and so on.
> > > 
> > > Prior to this patch, the code was not enabled because it depends on PCI.
> > 
> > Hi Guenter,
> > 
> > Thanks for reporting this.
> > 
> > It's interesting, I don't get this on the openrisc/for-next branch.
> > 
> 
> Hmm, weird. I see it all over the place. Complete log is at
> https://kerneltests.org/builders/next-openrisc-next/builds/1880/steps/buildcommand/logs/stdio
> if you are interested.
> 
> > BTW, do you turn off WERROR on the allmodconfig config?  I get many warnings
> > such as the below, but I haven't looked into it much yet:
> > 
> 
> No, I don't. Disabling it would defeat its purpose.
> 
> >      fs/exec.c: In function 'shift_arg_pages':
> >      fs/exec.c:687:27: error: 'tlb' is used uninitialized [-Werror=uninitialized]
> >        687 |         struct mmu_gather tlb;
> > 	  |                           ^~~
> > 
> 
> I don't see that in next-20220728. I tried with gcc-11.2 and 11.3.
> Which compiler do you use ?

I am using gcc 12.0.1 with next-20220728.  That might exaplain it, I am doing
compiler development at the same time so I always end up with the latest and
greatest warnings.

$ or1k-linux-gcc -v
  ..
  gcc version 12.0.1 20220210 (experimental) (GCC)

I can see the issue now:

    drivers/video/fbdev/riva/fbdev.c:2062:42: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     2062 |                 iounmap(default_par->riva.PRAMIN);
	  |                         ~~~~~~~~~~~~~~~~~^~~~~~~

Just adding volatile does seem to fix this, I will do some more testing and
create a formal patch.

--

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 625ac6ad1205..ee6043a03173 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -31,7 +31,7 @@
 void __iomem *ioremap(phys_addr_t offset, unsigned long size);
 
 #define iounmap iounmap
-extern void iounmap(void __iomem *addr);
+extern void iounmap(volatile void __iomem *addr);
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a76743..8ec0dafecf25 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -77,7 +77,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 }
 EXPORT_SYMBOL(ioremap);
 
-void iounmap(void __iomem *addr)
+void iounmap(volatile void __iomem *addr)
 {
        /* If the page is from the fixmap pool then we just clear out
         * the fixmap mapping.


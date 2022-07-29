Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EAD584B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 07:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiG2Fu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 01:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiG2Fu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 01:50:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B801D0F0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:50:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ha11so3931893pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 22:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hooXzavq61OdyVwoEg3NJ7Ka9aB9gcxnUcMNvrkkRcI=;
        b=iMgD4NGv+2uIl/fjBfL2BN4KrO0PvbxewwctglR5ywpPU1nqsajLaHJpNmCJ1EMPqw
         iINEDLWgJJAX9HhGMOyRQZLHpLMCZk8p0MUgRS/QVVWyykG9ubjZI5LICP1B17yp0ie8
         HB9XPkOySDkJ+tFA6qqGaMvC2PS2SS2TUm5npGVO7PpQXD8NLyTcqyi1N9YxsjE9Q/6y
         Na84lACy3H1pQJj9yqcsVYuIR9OEHo7/mERPRdOQ56Bp6xSijnPqo9DxQ4NcWstvup16
         c0aBlTa3NGg6her7sVQI+m7j4uBcp6IPMndixEUrPda5OMr0dbRjXpD5fsFSwg9BFzuh
         Wv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hooXzavq61OdyVwoEg3NJ7Ka9aB9gcxnUcMNvrkkRcI=;
        b=dTzy4XFBgMQSwP/q6+alkeqIyyrfW/tNuE/gJRL6XCXL+HrtHcO40cGYo6FpBu1tTh
         A2D+yMfsN1AKOKN5dJzhxK2PsVTGx+FeAuTMy7dSw8N4VeXmynM0rykzQopa3AD9vof9
         +yYPacS8j/A5ADktk8BCY0vWeEGimcsF69eOiWJOJLmeG0VL70E7wJgtncD4xIoOBNjB
         99nqnOcWqix1RVfuOHGO8MlylRJDvfR4dSi/rmufxmvSAUpiVaJqsmEL3Beb3IUhHGJz
         lHN2E98XxOpVBOZU6p2xjAnmV/9BxCkbym2ysVJrgRJyxamMgVzNakQ7DFt8uCp5Fh0+
         ryVw==
X-Gm-Message-State: ACgBeo1ecDgXReDLHv2PWpwJ6vpYzF0bA0GF147JG1k/Zx4YoPVaeUw0
        JK5BNwcJWSw6ZckmuR+20IxhJBQMha7Msw==
X-Google-Smtp-Source: AA6agR7GcbuMOAjWweWH8vNuHQGGnZ6wC0D9a0qyNyE89WFYthYxlpKly4dFc2cbaFH5+NglJmAr+w==
X-Received: by 2002:a17:902:eac2:b0:16d:cce2:e5c6 with SMTP id p2-20020a170902eac200b0016dcce2e5c6mr2230262pld.149.1659073855479;
        Thu, 28 Jul 2022 22:50:55 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id o6-20020a625a06000000b005259578e8fcsm1800443pfb.181.2022.07.28.22.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 22:50:55 -0700 (PDT)
Date:   Fri, 29 Jul 2022 14:50:53 +0900
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
Message-ID: <YuN1PWcDukEPdtQy@antec>
References: <20220725020737.1221739-1-shorne@gmail.com>
 <20220725020737.1221739-3-shorne@gmail.com>
 <20220729033728.GA2195022@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729033728.GA2195022@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 08:37:28PM -0700, Guenter Roeck wrote:
> On Mon, Jul 25, 2022 at 11:07:36AM +0900, Stafford Horne wrote:
> > This patch adds required definitions to allow for PCI buses on OpenRISC.
> > This is being tested on the OpenRISC QEMU virt platform which is in
> > development.
> > 
> > OpenRISC does not have IO ports so we keep the definition of
> > IO_SPACE_LIMIT and PIO_RESERVED to be 0.
> > 
> > Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> > systems") all platforms that support PCI also need to support parallel
> > port.  We add a generic header to support compiling parallel port
> > drivers, though they generally will not work as they require IO ports.
> > 
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> This patch results in
> 
> Building openrisc:allmodconfig ... failed
> --------------
> Error log:
> drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
> drivers/video/fbdev/riva/fbdev.c:2062:42: error:
> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
> drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
> drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
> 	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type
> 
> ... and so on.
> 
> Prior to this patch, the code was not enabled because it depends on PCI.

Hi Guenter,

Thanks for reporting this.

It's interesting, I don't get this on the openrisc/for-next branch.

BTW, do you turn off WERROR on the allmodconfig config?  I get many warnings
such as the below, but I haven't looked into it much yet:

    fs/exec.c: In function 'shift_arg_pages':
    fs/exec.c:687:27: error: 'tlb' is used uninitialized [-Werror=uninitialized]
      687 |         struct mmu_gather tlb;
	  |                           ^~~

I will try to see what is going on in linux-next.

-Stafford


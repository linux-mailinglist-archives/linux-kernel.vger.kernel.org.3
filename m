Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38BF584A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbiG2Dhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbiG2Dhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:37:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8A7C1AB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:37:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j70so4555456oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jVbZ9bmsOHazMdxh0GDBgdwGjsfWr7pMUJNONrNaL9s=;
        b=Aj0rVguqvsuZZ0t8pNqTKyCYkhPLraEXCjqKSqKsCd33Sp63cwyRHrEgurLEQru+A/
         KR2SQWOaz2u/oDoYdltfXGP3Z8KCcFUvI5euVUjBENEVPg8YDEf0116AW1R/VwvzZ8JA
         OyD/KkHdT4re5j9I3JO69aubXGTsC8uKnotHnI6M52pbMAvgzMXILDiLK1jisFXNMEN4
         Vr5zzrWuLbvIVqhh0sxxeGij/zA3zGpYjDMsTFWwuza/iVNQ5G46JBSCUMmanxVL5hX1
         4qLFiTKWeduwuHZz7BuYcIkZ5JvjbJStA07Z2zbnxnAIKBpml/GPl5ljPD8reotV8Hme
         wlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jVbZ9bmsOHazMdxh0GDBgdwGjsfWr7pMUJNONrNaL9s=;
        b=n8wTI+X1F7ybZl3Zxpm7cYswiw0XjlseFmlcrphM9zizPXOlNhd+KdX1hCcpkOWSQJ
         cGRgDIx8Iyv6YW6cblield9oJ4mOy6B+QqONHZYf5y2Laln2tr80QD/GR10I0atY+JNy
         wGEH9ApSJydmCSIVg6+fGQ3O0aJ2HCpfNj6VDQMH63lg2GxxERMaszNIVxK6qChTiVAV
         2doNVyLmf0EXmfc67Sdg5SqF6engLyZSpa1VXzNN+aIyf9Y/TCOUsuHNuYS8rC5M20yP
         0GOX6wy537Q+oa1pbONm0980WWshOK+GtbBaIGlkfhI23zeOXu18OZ4vBiPqG/oaUaNs
         Yoew==
X-Gm-Message-State: AJIora/zoEkyMwVBmsWKjKnFTD39EPuJKcwLuQZ8Hozjd32IKWTRTh8z
        1mgYW+K0q/K4pdNaGiURd2w=
X-Google-Smtp-Source: AGRyM1stmIDzT8euWFlVJw0SMcjwdX8Fvl215sWpa689RARkkMlG+uqN0oPR18jPdyDGOk0RgnyNrQ==
X-Received: by 2002:a54:4086:0:b0:33a:6fc9:1f8c with SMTP id i6-20020a544086000000b0033a6fc91f8cmr789379oii.71.1659065851695;
        Thu, 28 Jul 2022 20:37:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a40-20020a056870d62800b0010e00d6a1c0sm1196320oaq.51.2022.07.28.20.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 20:37:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Jul 2022 20:37:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v3 2/3] openrisc: Add pci bus support
Message-ID: <20220729033728.GA2195022@roeck-us.net>
References: <20220725020737.1221739-1-shorne@gmail.com>
 <20220725020737.1221739-3-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725020737.1221739-3-shorne@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:07:36AM +0900, Stafford Horne wrote:
> This patch adds required definitions to allow for PCI buses on OpenRISC.
> This is being tested on the OpenRISC QEMU virt platform which is in
> development.
> 
> OpenRISC does not have IO ports so we keep the definition of
> IO_SPACE_LIMIT and PIO_RESERVED to be 0.
> 
> Note, since commit 66bcd06099bb ("parport_pc: Also enable driver for PCI
> systems") all platforms that support PCI also need to support parallel
> port.  We add a generic header to support compiling parallel port
> drivers, though they generally will not work as they require IO ports.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>

This patch results in

Building openrisc:allmodconfig ... failed
--------------
Error log:
drivers/video/fbdev/riva/fbdev.c: In function 'rivafb_probe':
drivers/video/fbdev/riva/fbdev.c:2062:42: error:
	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

drivers/video/fbdev/nvidia/nvidia.c: In function 'nvidiafb_probe':
drivers/video/fbdev/nvidia/nvidia.c:1414:20: error:
	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

drivers/scsi/aic7xxx/aic7xxx_osm.c: In function 'ahc_platform_free':
drivers/scsi/aic7xxx/aic7xxx_osm.c:1231:41: error:
	passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type

... and so on.

Prior to this patch, the code was not enabled because it depends on PCI.

Bisect log attached.

Guenter

---
# bad: [7c5e07b73ff3011c9b82d4a3286a3362b951ad2b] Add linux-next specific files for 20220728
# good: [e0dccc3b76fb35bb257b4118367a883073d7390e] Linux 5.19-rc8
git bisect start 'HEAD' 'v5.19-rc8'
# bad: [96bce6a87ad9690eaa9b1ca9ace7c98444d7869f] Revert "Revert "drm/amdgpu: add drm buddy support to amdgpu""
git bisect bad 96bce6a87ad9690eaa9b1ca9ace7c98444d7869f
# bad: [08765bd733f4662c2ad80e813c933758b3c1dddc] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
git bisect bad 08765bd733f4662c2ad80e813c933758b3c1dddc
# good: [d40269b953fd9abba9aadaa57c6486990ab806d1] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
git bisect good d40269b953fd9abba9aadaa57c6486990ab806d1
# bad: [3d810ed5c60843645c6a40cc5ebd66e399c94165] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
git bisect bad 3d810ed5c60843645c6a40cc5ebd66e399c94165
# good: [046537a939b089589a1a6e70df16b10a8f0c8ca8] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
git bisect good 046537a939b089589a1a6e70df16b10a8f0c8ca8
# good: [d6b551b8f90cc92c7d3c09cf38c748efe305ecb4] powerpc/64e: Fix build failure with GCC 12 (unrecognized opcode: `wrteei')
git bisect good d6b551b8f90cc92c7d3c09cf38c748efe305ecb4
# bad: [e30727fee2a25176c4558f49a102524eba973d49] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
git bisect bad e30727fee2a25176c4558f49a102524eba973d49
# bad: [36c4dbb3e78602ee750e12c85fadb3da4392eeac] Merge branch 'for-next' of git://github.com/openrisc/linux.git
git bisect bad 36c4dbb3e78602ee750e12c85fadb3da4392eeac
# good: [9db5e69af1f4de043ae962a908fc7ef1a40f7f51] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
git bisect good 9db5e69af1f4de043ae962a908fc7ef1a40f7f51
# good: [62fb295ce7dd9df3e04b48a943f8cafaf1f32980] MIPS: dts: align gpio-key node names with dtschema
git bisect good 62fb295ce7dd9df3e04b48a943f8cafaf1f32980
# bad: [2479c96f5d3db2610a6d463077dd3dad087529fb] openrisc: Add virt defconfig
git bisect bad 2479c96f5d3db2610a6d463077dd3dad087529fb
# good: [a2912b45b0826c6fc0ca9b264d03a2dacb7a72e8] asm-generic: Add new pci.h and use it
git bisect good a2912b45b0826c6fc0ca9b264d03a2dacb7a72e8
# good: [3e2a6fbbbf34d230b9063f1ca885d5d625a0404c] asm-generic: Support NO_IOPORT_MAP in pci_iomap.h
git bisect good 3e2a6fbbbf34d230b9063f1ca885d5d625a0404c
# bad: [48ef4b584af7ba4ecdf2dd58b641fb8d0a9d0c63] openrisc: Add pci bus support
git bisect bad 48ef4b584af7ba4ecdf2dd58b641fb8d0a9d0c63
# first bad commit: [48ef4b584af7ba4ecdf2dd58b641fb8d0a9d0c63] openrisc: Add pci bus support

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5F5A31A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244134AbiHZWA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbiHZWAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:00:55 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6EB2D93;
        Fri, 26 Aug 2022 15:00:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q7so3644188lfu.5;
        Fri, 26 Aug 2022 15:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NJbP7LG9b31evjLDHSY9Sv5bNgDsslZ78cA55vLf+o0=;
        b=ZakPFMHIzlQUDuerILcwgHk0id+7UlwDLYtwZjuVd+gPY9l06PH63bacOjD0pjQ18r
         41X5stpzcwHIpTJT3ifb7FJXuofVDtN/9tEzvGC9hO6dni1G5Qba4HsO/tUJh0Geg1Vx
         eR9NMEyQXDfCh1pwioMzB/gO1wN0m8M0mmvknIFQqg9iP/1Ja35ykeM0AHH0l4hFL1/K
         yv/9eY+DQOId0sjTGrMtO6oaMshqhIVAbO/QkNwNbdCtN+9fySWqD8TbBcUdGwW3rchr
         5J0HINVIV+Jxy5xIK4/9q3O07XqN3NO3za38NJKyxDLRKSLf+gcYT1ONATlbeKiRxPKn
         C1QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NJbP7LG9b31evjLDHSY9Sv5bNgDsslZ78cA55vLf+o0=;
        b=ik8UvvHOVnxIGa0PwAEEzLvtY3MYBDmxgb24I4eHCjwJmqguohZR4NIBioZtZ4EnYs
         XCmXwawvFs3RZKgbP8Uk349BHC6olvrzTSt59rlxDsPjqnsPzLfV0mIa6E2fHOiae9ah
         h5QbjQN5kG26ix44e/VufR+JeipQdsMxHFZR/EVQgXw59clvDJBcU0mzvz+BSqDkfprf
         PGfHnmJVmL391Vw2y+9FLy9yMohK7mv3eqPM8C5O7eRF/kyi3dZSdPdphNEvf1CbXN3/
         P9/XlxJ39tI1F10+NFV/38xCTjfPyYDG8wHmLt4CFv6HB6ZBTEiyRCnGGPjCXn+v9jAd
         bCNg==
X-Gm-Message-State: ACgBeo3bmCmClri6XEhFg6+5Tcj1+iXBilgJ55SsfB6FGMsSa6wCz4Lp
        bcrnRyjcB1qNa+JI2g2XxGs=
X-Google-Smtp-Source: AA6agR5VYoZByro113IAlWjA542jSW9MLpHhvWOWO8/Z2eG8jLSunEwho9iuNGrs223OPoBx3W28iQ==
X-Received: by 2002:a05:6512:3f1d:b0:492:e175:402a with SMTP id y29-20020a0565123f1d00b00492e175402amr2897682lfa.384.1661551249432;
        Fri, 26 Aug 2022 15:00:49 -0700 (PDT)
Received: from localhost.localdomain ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id d1-20020a05651221c100b0048b0ef93248sm491941lft.62.2022.08.26.15.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 15:00:49 -0700 (PDT)
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Marek Bykowski <marek.bykowski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?of/fdt:=20Don't=20calculate=20initrd=5Fstart=20?= =?UTF-8?q?from=20the=20DT=20if=C2=A0'linux,initrd-end'=20is=200?=
Date:   Fri, 26 Aug 2022 22:00:17 +0000
Message-Id: <20220826220017.188066-1-marek.bykowski@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 'linux,initrd-end' property is 0 and 'linux,initrd-start' property
is other than 0, then phys_initrd_size calculated from 'linux,initrd-end'
- 'linux,initrd-start' is negative, that subsequently gets converted to
a high positive value as being u64.

For example if 'linux,initrd-start' is 8800_0000, 'linux,initrd-end' is 0,
then the phys_initrd_size calculated is ffff_ffff_7800_0000 (= 0 -
8800_0000 = -8800_0000 + ULLONG_MAX + 1). On my system, FVP ARM64,
the intird memory region with the (wrong) size is added to the bootmem and
then attempted to being paged in paging_init() that results in the kernel
oops as shown below.

Generally, it is a fault of the bootloader as the kernel is relying on it
but we should not allow the bootloader's misconfiguration to lead to
the kernel oops. Not only the kernel should get bullet proof against it
but also finding the root cause may get lengthy on occasion as involves
checking the bootloader, the chosen node it makes the changes in and
the kernel.

Unable to handle kernel paging request at virtual address fffffffefe43c000
Mem abort info:                                                    
  ESR = 0x96000007                                                                                  
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0                                                
  EA = 0, S1PTW = 0                                                                                
Data abort info:                                                                                    
  ISV = 0, ISS = 0x00000007
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000080e3d000
[fffffffefe43c000] pgd=0000000080de9003, pud=0000000080de9003
Unable to handle kernel paging request at virtual address ffffff8000de9f90
Mem abort info:
  ESR = 0x96000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000005
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp=0000000080e3d000
[ffffff8000de9f90] pgd=0000000000000000, pud=0000000000000000
Internal error: Oops: 96000005 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.4.51-yocto-standard #1
Hardware name: FVP Base (DT)
pstate: 60000085 (nZCv daIf -PAN -UAO)
pc : show_pte+0x12c/0x1b4
lr : show_pte+0x100/0x1b4
sp : ffffffc010ce3b30
x29: ffffffc010ce3b30 x28: ffffffc010ceed80
x27: fffffffefe43c000 x26: fffffffefe43a028
x25: 0000000080bf0000 x24: 0000000000000025
x23: ffffffc010b8d000 x22: ffffffc010e3d000
x21: 0000000080de9000 x20: ffffff7f80000f90
x19: fffffffefe43c000 x18: 0000000000000030
x17: 0000000000001400 x16: 0000000000001c00
x15: ffffffc010cef1b8 x14: ffffffffffffffff
x13: ffffffc010df1f40 x12: ffffffc010df1b70
x11: ffffffc010ce3b30 x10: ffffffc010ce3b30
x9 : 00000000ffffffc8 x8 : 0000000000000000
x7 : 000000000000000f x6 : ffffffc010df16e8
x5 : 0000000000000000 x4 : 0000000000000000
x3 : 00000000ffffffff x2 : 0000000000000000
x1 : 0000008080000000 x0 : ffffffc010af1d68
Call trace:
 show_pte+0x12c/0x1b4
 die_kernel_fault+0x54/0x78
 __do_kernel_fault+0x11c/0x128
 do_translation_fault+0x58/0xac
 do_mem_abort+0x50/0xb0
 el1_da+0x1c/0x90
 __create_pgd_mapping+0x348/0x598
 paging_init+0x3f0/0x70d0
 setup_arch+0x2c0/0x5d4
 start_kernel+0x94/0x49c
Code: 92748eb5 900052a0 9135a000 cb010294 (f8756a96) 

Signed-off-by: Marek Bykowski <marek.bykowski@gmail.com>
---
 drivers/of/fdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7bc92923104c..5f18c175dd78 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -936,6 +936,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	if (!prop)
 		return;
 	end = of_read_number(prop, len/4);
+	if (!end)
+		return;
 
 	__early_init_dt_declare_initrd(start, end);
 	phys_initrd_start = start;
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F25B2C23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiIICeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiIICeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:34:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B0A7FE49;
        Thu,  8 Sep 2022 19:34:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id p7so425940lfu.3;
        Thu, 08 Sep 2022 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FvkyKhuO6YMpCu4RPk+9qOwp6OFIggmy0x2K8NtlShI=;
        b=Rol8pyqq+vW07WbnF0rdsnGFbZUDCQsXGwCD0KyWnzTP+ReRGZeA3oYrfhQul88Jg2
         e5fh04e2Id9xhzzEU3WdzsfD1iz5biFbzwD1WfBFTP6T4YwHFblnB1F4UzgQXDQPaJ1t
         OVVlFiNZUZ46kWD5XVjSiEgGF3sGzNIRUoD0K0/sw7V1kBBxoJK/j3HhqKiTGxT6NCyp
         6NOS+WwJ8PQzKvvAuezbZb3t/ETiBJqhLnyAxjNdf9fvrQxANownmlC6v931I4bK9Ip/
         v7BR2h9faVqDqDD7HPhH9AHToyJxUWg4sbublUirVLnr7B77aYcxjKKJ0oGsgeSopsfv
         wwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FvkyKhuO6YMpCu4RPk+9qOwp6OFIggmy0x2K8NtlShI=;
        b=JB9y+AKZdFVjHW3Mn/o4LkoKMqHREHPn1WsBgDdsIV4l9j7/o8yJSfoueNGbUEBC6b
         5ubz5YnCRnx6mjjHPXcSkEMWcWSbLD0XL0fDpuSIoa1lLeBcubGfElOhU2j2ALQpyT4G
         MU/x/+RmKlUcEUMotewGxHIVCFb1OCh077bBZlPVXp9qMsKGQv4/Loq6NXQVx3jCFT/J
         ac2cJ5g3prCjxe7V+LiYFV4e8a+SLPfyQTVAq30O2BEXo7flg4RJz9owhbK4hU+tOd2P
         HAvhfJ9AgOWdKV0pVoLtRlblC9G+1+Gf0IEB1bTFbhHncbf353GKw9dj/LBwC3vSrngI
         Worw==
X-Gm-Message-State: ACgBeo3DmfdCcv++BtM8f+CRnkm81bctNpP3IVAbReoIW9/rKGvRzhCm
        7P9qJF9ZeMl8D4AWNjL4NPL9MhNr4Pa4/A==
X-Google-Smtp-Source: AA6agR6Rp+5iCeYFPUODi36Z+roKmLLfV1ikdMlf5O8kG8GKIhHS3I3myEf6RO9v+a3TEBXwn/m0xw==
X-Received: by 2002:a05:6512:2293:b0:48c:f602:475d with SMTP id f19-20020a056512229300b0048cf602475dmr4154025lfu.232.1662690852775;
        Thu, 08 Sep 2022 19:34:12 -0700 (PDT)
Received: from localhost.localdomain ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id u28-20020ac2519c000000b0049301e29e41sm66845lfi.233.2022.09.08.19.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:34:12 -0700 (PDT)
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Marek Bykowski <marek.bykowski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] =?UTF-8?q?of/fdt:=20Don't=20calculate=20initrd=20size=20f?= =?UTF-8?q?rom=20DT=20if=C2=A0start=20>=20end?=
Date:   Fri,  9 Sep 2022 02:33:57 +0000
Message-Id: <20220909023358.76881-1-marek.bykowski@gmail.com>
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

If the properties 'linux,initrd-start' and 'linux,initrd-end' of
the chosen node populated from the bootloader, eg. U-Boot, are so that
start > end, then the phys_initrd_size calculated from end - start is
negative that subsequently gets converted to a high positive value for
being unsigned long long. Then, the memory region with the (invalid)
size is added to the bootmem and attempted being paged in paging_init()
that results in the kernel fault.

For example, on the FVP ARM64 system I'm running, the U-Boot populates
the 'linux,initrd-start' with 8800_0000 and 'linux,initrd-end' with 0.
The phys_initrd_size calculated is then ffff_ffff_7800_0000
(= 0 - 8800_0000 = -8800_0000 + ULLONG_MAX + 1). paging_init() then
attempts to map the address 8800_0000 + ffff_ffff_7800_0000 and oops'es
as below.

It should be stressed, it is generally a fault of the bootloader's with
the kernel relying on it, however we should not allow the bootloader's
misconfiguration to lead to the kernel oops. Not only the kernel should be
bullet proof against it but also finding the root cause of the paging
fault spanning over the bootloader, DT, and kernel may happen is not so
easy.

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
v2 -> v3:
- I confused the description I fixed now. I put that we should
  complain if start < end and it should be the other way around
  if end > start
v1 -> v2:
- followed Rob's suggestion that we check on start > end instead of
  for end being 0
---
 drivers/of/fdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 223d617ecfe1..4acb1be8723b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -889,6 +889,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	if (!prop)
 		return;
 	end = of_read_number(prop, len/4);
+	if (start > end)
+		return;

 	__early_init_dt_declare_initrd(start, end);
 	phys_initrd_start = start;
--
2.25.1


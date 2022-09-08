Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D565B231B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiIHQGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiIHQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:06:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14447C275C;
        Thu,  8 Sep 2022 09:06:19 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w8so28463331lft.12;
        Thu, 08 Sep 2022 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nz1fp5lwnD1Y399f3hQjrZY99PTaG/8NW7V7/WFUT8w=;
        b=ieP5BxYKM9UDB4jtymp7DzdBc5lrk4wxFoK2f3w6l28S3pAD6Fd3+hXiECAuQBjYtC
         Bjtgvyi+xGM7NWY7q/GUqtIjQX+uuD2GZfdLPPIsxV9M6Uku0WQZPfAckHmHwtWVV5Q9
         4M2BaOesH6tyOKpzTvWSrThnDyvCMLP8Uv1FSdfnEgWfihM/cULfthZluGJIjmMyHcTR
         f4LEXeJfvkyzQzUcI5PS74X+lWzIbNy0ePSW/3+ioScjs1S/axLi2iUwUkLNP9xMznCU
         KN1PxFeyGZyKdl77ouYhf5RfQIpNE9ffzebjRvHn/aFuTMV5I3ugeINdGV1fwlJ8eDvC
         rMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nz1fp5lwnD1Y399f3hQjrZY99PTaG/8NW7V7/WFUT8w=;
        b=DoGJ7lbfd4jX3SldRqRBHRW9LcI72ZkjBRtB4e3La9zamkxkq/lfR+oQ6jhUiNjOdH
         P/sEdUuezaGbluisy7xwB+2QbUZlzh7+HtLXnpjQLXLoAEIIme9KI3cOpy1on8tGzaBF
         0TmUSH6Wmv+JS9ZoleHMGeO1Cd8s1aRE0zREcfxw2Yf9YlVE1fynrgMsqtbqj9LgGN/t
         S/aPOPoB43Kw8mFpwACaJz5syQ6Qwlh74dpmZhDi9ITkFgcJprdQJg/sOpREHSr4wtTD
         fQjTP2dJVWqGsdXMmaebUV48XQhXq/cysB4OBpCrYqHsKvWLcVoi1V7u+1DfCyuFQeev
         MzBQ==
X-Gm-Message-State: ACgBeo0w8w9acvLQ+kI0nTPn/6N8c/+S4a2lMMzYe/U12B8diqfeKdpa
        SG4lEgGukf0JP+Ig1e/NvPA=
X-Google-Smtp-Source: AA6agR5vQCfiSofF9T6A+rUaSGtgoDWsUQf44jQ2EyEOom0Jm9ZTpCA0G0Y4DvtUa8xEmm5ZPiR5fg==
X-Received: by 2002:ac2:4144:0:b0:492:eb38:d8e9 with SMTP id c4-20020ac24144000000b00492eb38d8e9mr3236281lfi.215.1662653177289;
        Thu, 08 Sep 2022 09:06:17 -0700 (PDT)
Received: from localhost.localdomain ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id u4-20020ac258c4000000b0048b03ec561fsm3086727lfo.150.2022.09.08.09.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:06:16 -0700 (PDT)
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Marek Bykowski <marek.bykowski@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] =?UTF-8?q?of/fdt:=20Don't=20calculate=20phys=5Finitrd=5Fs?= =?UTF-8?q?ize=20from=20DT=20if=C2=A0start=20<=20end?=
Date:   Thu,  8 Sep 2022 16:05:19 +0000
Message-Id: <20220908160519.58041-1-marek.bykowski@gmail.com>
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
start < end, then the phys_initrd_size calculated as subtraction of end
from start is negative that subsequently gets converted to a high positive
value for being unsigned long long.

For example, on FVP ARM64 system I'm running, the U-Boot populates
the 'linux,initrd-start' with 0x8800_0000 and 'linux,initrd-end' with 0.
The phys_initrd_size calculated is then ffff_ffff_7800_0000
(= 0 - 8800_0000 = -8800_0000 + ULLONG_MAX + 1). Then, the memory region
with the (invalid) size is added to the bootmem and attempted paging in
paging_init() that results in the kernel oops as shown below.

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
v1 -> v2:
- changed from just checking on end being 0 to start < end as suggested
  from Rob
- also amended the message description a bit
---
 drivers/of/fdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 223d617ecfe1..e8abec8dcea3 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -889,6 +889,8 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	if (!prop)
 		return;
 	end = of_read_number(prop, len/4);
+	if (start >= end)
+		return;

 	__early_init_dt_declare_initrd(start, end);
 	phys_initrd_start = start;
--
2.25.1


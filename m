Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA8C53F3E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiFGCYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiFGCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:24:12 -0400
X-Greylist: delayed 403 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 19:24:08 PDT
Received: from mail-m17635.qiye.163.com (mail-m17635.qiye.163.com [59.111.176.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF0877F26
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:24:07 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1490:f100:dfad:59db:22ac:33c8])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 769824001F3;
        Tue,  7 Jun 2022 10:17:22 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhc@lemote.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        caizp2008@163.com, Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1]   MIPS: Loongson-3: fix compile mips cpu_hwmon as a module build error.
Date:   Tue,  7 Jun 2022 10:17:02 +0800
Message-Id: <20220607021702.3224369-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUNOHkJWGk5IGklCTE8YSU
        5LVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktITUpVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6ODo6NT00KREoNE4pSEwY
        AlYaFEJVSlVKTU5PTk1DSU9JQkNIVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0JLQR1KS0tBHx0aH0FOQh8ZQUlJGhhBSEgYQ1lXWQgBWUFJSE1ONwY+
X-HM-Tid: 0a813bf3cdd7d991kuws769824001f3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  set cpu_hwmon as a module build with loongson_sysconf, loongson_chiptemp
  undefined error,fix cpu_hwmon compile options to be bool.Some kernel
  compilation error information is as follows:

  Checking missing-syscalls for N32
  CALL    scripts/checksyscalls.sh
  Checking missing-syscalls for O32
  CALL    scripts/checksyscalls.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC [M]  drivers/platform/mips/cpu_hwmon.o
  Building modules, stage 2.
  MODPOST 200 modules
ERROR: "loongson_sysconf" [drivers/platform/mips/cpu_hwmon.ko] undefined!
ERROR: "loongson_chiptemp" [drivers/platform/mips/cpu_hwmon.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:92：__modpost] 错误 1
make: *** [Makefile:1261：modules] 错误 2

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
---
 drivers/platform/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mips/Kconfig b/drivers/platform/mips/Kconfig
index b3ae30a4c67b..c2f1ede1caca 100644
--- a/drivers/platform/mips/Kconfig
+++ b/drivers/platform/mips/Kconfig
@@ -16,7 +16,7 @@ menuconfig MIPS_PLATFORM_DEVICES
 if MIPS_PLATFORM_DEVICES
 
 config CPU_HWMON
-	tristate "Loongson CPU HWMon Driver"
+	bool "Loongson CPU HWMon Driver"
 	depends on LOONGSON_MACH3X
 	select HWMON
 	default y
-- 
2.34.1


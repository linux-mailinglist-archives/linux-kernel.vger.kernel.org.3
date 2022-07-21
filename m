Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272FC57C82A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiGUJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGUJxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:53:18 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 082F881B0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:53:13 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9L9Idlipk0sAA--.307S2;
        Thu, 21 Jul 2022 17:53:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Fix wrong "ROM Size" of boardinfo
Date:   Thu, 21 Jul 2022 17:53:01 +0800
Message-Id: <1658397181-2095-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxv9L9Idlipk0sAA--.307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1Dur4DJF1xKFWUZF45GFg_yoW8urWUpr
        43Aws7Grs8Wrn3u34rX348Wr45KF9xGFn2qa17Ar4xArZxWr12gw40vFyfuFW2y3yrGFW0
        qa4fKa1FgF4DG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUyD7aUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can see the "ROM Size" is different in the following outputs:

[root@linux loongson]# cat /sys/firmware/loongson/boardinfo
BIOS Information
Vendor                  : Loongson
Version                 : vUDK2018-LoongArch-V2.0.pre-beta8
ROM Size                : 63 KB
Release Date            : 06/15/2022

Board Information
Manufacturer            : Loongson
Board Name              : Loongson-LS3A5000-7A1000-1w-A2101
Family                  : LOONGSON64

[root@linux loongson]# dmidecode | head -11
...
Handle 0x0000, DMI type 0, 26 bytes
BIOS Information
	Vendor: Loongson
	Version: vUDK2018-LoongArch-V2.0.pre-beta8
	Release Date: 06/15/2022
	ROM Size: 4 MB

According to "BIOS Information (Type 0) structure" in the SMBIOS
Reference Specification [1], it shows 64K * (n+1) is the size of
the physical device containing the BIOS if the size is less than
16M.

Additionally, we can see the related code in dmidecode [2]:

  u64 s = { .l = (code1 + 1) << 6 };

So the output of dmidecode is correct, the output of boardinfo
is wrong, fix it.

By the way, at present no need to consider the size is 16M or
greater on LoongArch, because it is usually 4M or 8M which is
enough to use.

[1] https://www.dmtf.org/sites/default/files/standards/documents/DSP0134_3.6.0.pdf
[2] https://git.savannah.nongnu.org/cgit/dmidecode.git/tree/dmidecode.c#n347

Fixes: 628c3bb40e9a ("LoongArch: Add boot and setup routines")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index c74860b..8f5c2f9 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -126,7 +126,7 @@ static void __init parse_bios_table(const struct dmi_header *dm)
 	char *dmi_data = (char *)dm;
 
 	bios_extern = *(dmi_data + SMBIOS_BIOSEXTERN_OFFSET);
-	b_info.bios_size = *(dmi_data + SMBIOS_BIOSSIZE_OFFSET);
+	b_info.bios_size = (*(dmi_data + SMBIOS_BIOSSIZE_OFFSET) + 1) << 6;
 
 	if (bios_extern & LOONGSON_EFI_ENABLE)
 		set_bit(EFI_BOOT, &efi.flags);
-- 
2.1.0


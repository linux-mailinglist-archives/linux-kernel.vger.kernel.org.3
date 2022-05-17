Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622C1529FDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbiEQK6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiEQK6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:58:12 -0400
X-Greylist: delayed 360 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 May 2022 03:58:04 PDT
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9E98749906;
        Tue, 17 May 2022 03:58:04 -0700 (PDT)
Received: from jleng.ambarella.net (unknown [180.169.129.130])
        by mail-app4 (Coremail) with SMTP id cS_KCgAHHyIxfoNiwSVaAA--.8062S2;
        Tue, 17 May 2022 18:51:35 +0800 (CST)
From:   3090101217@zju.edu.cn
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Leng <jleng@ambarella.com>
Subject: [PATCH] kbuild: Fix include path in scripts/Makefile.modpost
Date:   Tue, 17 May 2022 18:51:28 +0800
Message-Id: <20220517105128.9720-1-3090101217@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgAHHyIxfoNiwSVaAA--.8062S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Cw43Kr1UXF1rXw17Awb_yoW8Jw1rpw
        s8Cw13CFZ7JrWvg3WxJrZ3J34j93sayw4Y93W0qF17trnFvrs2vr4ayrZ8uw1Sk348ArWU
        W347Ca4xAa48Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAv
        xc0EwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
        Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
        6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY02Avz4vE14v_Gw1l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jrSdgUUUUU=
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwINBVNG3GxzgAAAsf
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jing Leng <jleng@ambarella.com>

When building an external module, if users don't need to separate the
compilation output and source code, they run the following command:
"make -C $(LINUX_SRC_DIR) M=$(PWD)". At this point, "$(KBUILD_EXTMOD)"
and "$(src)" are the same.

If they need to separate them, they run "make -C $(KERNEL_SRC_DIR)
O=$(KERNEL_OUT_DIR) M=$(OUT_DIR) src=$(PWD)". Before running the
command, they need to copy "Kbuild" or "Makefile" to "$(OUT_DIR)" to
prevent compilation failure.

So the kernel should change the included path to avoid the copy operation.

Signed-off-by: Jing Leng <jleng@ambarella.com>
---
 scripts/Makefile.modpost | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 48585c4d04ad..0273bf7375e2 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -87,8 +87,7 @@ obj := $(KBUILD_EXTMOD)
 src := $(obj)
 
 # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
-include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
-             $(KBUILD_EXTMOD)/Kbuild, $(KBUILD_EXTMOD)/Makefile)
+include $(if $(wildcard $(src)/Kbuild), $(src)/Kbuild, $(src)/Makefile)
 
 # modpost option for external modules
 MODPOST += -e
-- 
2.17.1


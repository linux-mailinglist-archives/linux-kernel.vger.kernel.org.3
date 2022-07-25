Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F4C57F83A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiGYCWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYCWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:22:02 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60945116F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:21:59 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 26P2JX9c029536;
        Mon, 25 Jul 2022 11:19:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 26P2JX9c029536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658715574;
        bh=SCnWUTOIqjfB89rOg7Ig7Vg8sxcS4A6+OR94yhgDrEQ=;
        h=From:To:Cc:Subject:Date:From;
        b=uvvfneWPq3Jp9S3lMU+YReM/b5EXCFXzf8KWkZsGnERpRGlKQxhlnMSPxspEpX9VP
         gXJwFXjhqYPD//fvUIz312mXaG8YhPpGPCaUNe26MDKJO5RvxVygsQ/GDSJ9UM7Zuz
         0LQsMVmgk1Ks80IaNgkb9YAaqkgj9GOId+IUMmhnS3BS3SeRmhdM2yYglANswDEnpH
         KQXDmzs4HW1x0sCVod7Tf/atEU8cqxnEJucaN0glYXDvst+Gionle9jGmi2Q4DEl+J
         accDGMlHs7JO59GAYqBZnS4OiWH1g0X8m6dq5HF1tuwu/008nKsn728cZo2wa/U9oQ
         5LUGRLsBFdqjg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] riscv/purgatory: hard-code obj-y in Makefile
Date:   Mon, 25 Jul 2022 11:19:01 +0900
Message-Id: <20220725021902.625630-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purgatory/ directory is entirely guarded in arch/riscv/Kbuild.
CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.

$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
this Makefile for building.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 arch/riscv/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
index d4df200f7edf..c2d14e2f345d 100644
--- a/arch/riscv/purgatory/Makefile
+++ b/arch/riscv/purgatory/Makefile
@@ -92,4 +92,4 @@ quiet_cmd_bin2c = BIN2C   $@
 $(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
-obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY)	+= kexec-purgatory.o
+obj-y += kexec-purgatory.o
-- 
2.34.1


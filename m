Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C884E8C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiC1CuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbiC1CuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:50:15 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F84027CD8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 19:48:35 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KRcXx0j6xzfZHX;
        Mon, 28 Mar 2022 10:46:57 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 10:48:33 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 10:48:33 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <lasse.collin@tukaani.org>, <linux@armlinux.org.uk>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <liaohua4@huawei.com>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>,
        <nixiaoming@huawei.com>
Subject: [PATCH v2 RESEND] kbuild: Enable armthumb BCJ filter for Thumb-2 kernel
Date:   Mon, 28 Mar 2022 10:48:31 +0800
Message-ID: <1648435711-95240-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
In-Reply-To: <20220326203516.1ddb6492@kaneli>
References: <20220326203516.1ddb6492@kaneli>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xz_wrap.sh use $SRCARCH to detect the BCJ filter. However, assigning
arm BCJ filter to Thumb-2 kernel is not optimal. In my case, about 5%
decrease of image size is observed with armthumb BCJ filter:

Test results:
  hardware:      QEMU emulator version 3.1.0
  config:        vexpress_defconfig with THUMB2_KERNEL & KERNEL_XZ on
  arm BCJ:       4029808
  armthumb BCJ:  3827280

Choose armthumb BCJ filter for Thumb-2 kernel to make smaller images.

Signed-off-by: Jubin Zhong <zhongjubin@huawei.com>
Acked-by: Lasse Collin <lasse.collin@tukaani.org>

----
v1:
https://lore.kernel.org/lkml/1637323647-19988-1-git-send-email-zhongjubin@huawei.com/
---
 lib/decompress_unxz.c | 6 +++++-
 scripts/xz_wrap.sh    | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 9f4262e..9d9cb48 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -129,7 +129,11 @@
 #	define XZ_DEC_POWERPC
 #endif
 #ifdef CONFIG_ARM
-#	define XZ_DEC_ARM
+#	ifdef CONFIG_THUMB2_KERNEL
+#		define XZ_DEC_ARMTHUMB
+#	else
+#		define XZ_DEC_ARM
+#	endif
 #endif
 #ifdef CONFIG_IA64
 #	define XZ_DEC_IA64
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index 76e9cbc..3824fdf 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -9,6 +9,8 @@
 # You can do whatever you want with this file.
 #
 
+. include/config/auto.conf
+
 BCJ=
 LZMA2OPTS=
 
@@ -20,4 +22,8 @@ case $SRCARCH in
 	sparc)          BCJ=--sparc ;;
 esac
 
+if [ -n "${CONFIG_THUMB2_KERNEL}" ]; then
+	BCJ=--armthumb
+fi
+
 exec $XZ --check=crc32 $BCJ --lzma2=$LZMA2OPTS,dict=32MiB
-- 
1.8.5.6


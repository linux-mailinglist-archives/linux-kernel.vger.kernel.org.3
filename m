Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537D1533F83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 16:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237623AbiEYOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiEYOqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 10:46:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A45C583A2;
        Wed, 25 May 2022 07:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6743B81E06;
        Wed, 25 May 2022 14:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10057C385B8;
        Wed, 25 May 2022 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653490011;
        bh=MGUAjBfT1CfsgNrG6C6NIIrhHiPumGmBrh4GcIxCtA0=;
        h=From:To:Cc:Subject:Date:From;
        b=hX9yzkErUAL5MhY/2FtubfyBZIkfecq3HKFSPqvL58h1mJ9G/WQDBV6/bKs0xCHZ5
         QK2XzUvIUH4sonpCw0JQs4h/fHNlIlQUdSm8G+b4N7QntzFRlYT/3hGb3wYY73HZ9V
         d/ilw7LuowTXYpPQz3Dywvtxt6m+hoAYgeAp2E+cI8Zq4Wkv9RB2Lic+Xdq+K7TdFP
         AE3wrhA3Y+RQxXQNM1ifKTt1Z1bOZPMVbKslcErHRiq7Hi49MLHq9udD5vni9v2vxy
         4goFv1Iew1MjFsYWCGgRND+POLn4K097Me5NQiUd4/MsVPef4MnF45GVlY/Uj+oiMW
         37kSNjv1+GioA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jiri Slaby <jirislaby@kernel.org>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] Revert "linux/types.h: remove unnecessary __bitwise__"
Date:   Wed, 25 May 2022 09:46:38 -0500
Message-Id: <20220525144638.293934-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This reverts commit c724c866bb70cb8c607081a26823a1f0ebde4387.

Jiri Slaby reported that c724c866bb70 ("linux/types.h: remove unnecessary
__bitwise__") broke userspace, including open-iscsi, because it uses
__bitwise__.

Restore the __bitwise__ definition.

Link: https://lore.kernel.org/r/b5c0a68d-8387-4909-beea-f70ab9e6e3d5@kernel.org
Reported-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/uapi/linux/types.h  | 5 +++--
 tools/include/linux/types.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index c4dc597f3dcf..2415d5dcb5d3 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -21,10 +21,11 @@
 
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
-#define __bitwise	__attribute__((bitwise))
+#define __bitwise__ __attribute__((bitwise))
 #else
-#define __bitwise
+#define __bitwise__
 #endif
+#define __bitwise __bitwise__
 
 typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
index 051fdeaf2670..5908e58c3598 100644
--- a/tools/include/linux/types.h
+++ b/tools/include/linux/types.h
@@ -43,10 +43,11 @@ typedef __u8  u8;
 typedef __s8  s8;
 
 #ifdef __CHECKER__
-#define __bitwise	__attribute__((bitwise))
+#define __bitwise__ __attribute__((bitwise))
 #else
-#define __bitwise
+#define __bitwise__
 #endif
+#define __bitwise __bitwise__
 
 #define __force
 #define __user
-- 
2.25.1


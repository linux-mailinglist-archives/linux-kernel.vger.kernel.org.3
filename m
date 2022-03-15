Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A154D9EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 16:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349675AbiCOPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349660AbiCOPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 11:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86553B59;
        Tue, 15 Mar 2022 08:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7170961214;
        Tue, 15 Mar 2022 15:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F1EC340F7;
        Tue, 15 Mar 2022 15:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647358255;
        bh=nbZcLuFYhFoAwayMU7WIynO05puat2p3vzjHgrWypJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PM/PVXKWXVtTWJsxnf5fg1w0QFtt1G6TWSBgzMfO/n/G7lMpvYDUWVbFQFPKVAvMV
         HtpMIMRyWiOMeSkROx5Srns2JCiG9cn8sPUvzFGjun/bX9XvB09iXduCF8SN26jfyW
         azVUYcR9pm9sDcTu/gkw4PsOJjybZ0fg7XJkUTdc4nbYw97JeUMpeGnQjM0G6GOoLA
         PrWy6avYIJ7HgydjrYB5mNN97TIIjXUvJPP/A+lT9YIrlKnn4gSsj+gLqffsaoDmLA
         QyEzHqWG8BcRBm/DD+Yxrwgoj+RGG/jo5fqyMEdVDSW+NkeLzaWTn2iF0tzsTLv3JW
         e66wm4NJBKlWA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] Documentation/sparse: Add hints about __CHECKER__
Date:   Tue, 15 Mar 2022 10:30:48 -0500
Message-Id: <20220315153048.621328-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220315153048.621328-1-helgaas@kernel.org>
References: <20220315153048.621328-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Several attributes depend on __CHECKER__, but previously there was no clue
in the tree about when __CHECKER__ might be defined.  Add hints at the most
common places (__kernel, __user, __iomem, __bitwise) and in the sparse
documentation.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/dev-tools/sparse.rst | 2 ++
 include/linux/compiler_types.h     | 1 +
 include/uapi/linux/types.h         | 1 +
 3 files changed, 4 insertions(+)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index 02102be7ff49..dc791c8d84d1 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -100,3 +100,5 @@ have already built it.
 
 The optional make variable CF can be used to pass arguments to sparse.  The
 build system passes -Wbitwise to sparse automatically.
+
+Note that sparse defines the __CHECKER__ preprocessor symbol.
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3c1795fdb568..4b3915ce38a4 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -4,6 +4,7 @@
 
 #ifndef __ASSEMBLY__
 
+/* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /* address spaces */
 # define __kernel	__attribute__((address_space(0)))
diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index 71696f424ac8..c4dc597f3dcf 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -19,6 +19,7 @@
  * any application/library that wants linux/types.h.
  */
 
+/* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 #define __bitwise	__attribute__((bitwise))
 #else
-- 
2.25.1


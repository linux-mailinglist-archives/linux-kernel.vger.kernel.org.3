Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2F4D5446
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344252AbiCJWKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbiCJWKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:10:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E14DA873;
        Thu, 10 Mar 2022 14:09:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B14761B43;
        Thu, 10 Mar 2022 22:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40AAC340E9;
        Thu, 10 Mar 2022 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646950180;
        bh=nbZcLuFYhFoAwayMU7WIynO05puat2p3vzjHgrWypJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbqrCE4jXmfgTJyo13N2P9AnUUqV53HHGqmjPA3cx5b08Ri4OJUnE9Q4OqHY5PeD8
         NWws8QrfwaOztwnMhv8QUcPEk4r8MFwrYU+tXWGVIp7xUU5BakKICBMFEMUWWz2icn
         MxxqIfETRUt7eAqy1gZX8lCFFOKzS3cDcxLj+kvGAIDN1UqIDlrc1Eioe3lwiKn1Jz
         YJoD8RoOPu6ARD/+Ia5KWGfC28xGXIQ5YwoS3aHCYMYRs6qV1pNoY4EQ83gH11zPsr
         cWE7WkSAdJjEC1tKr3aabgbmJV0hDrG6cRh+bzzKDuO0zPgt+OnuwKBnG5UEwOz5sH
         iTlGGjDBG+wfg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] Documentation/sparse: Add hints about __CHECKER__
Date:   Thu, 10 Mar 2022 16:09:27 -0600
Message-Id: <20220310220927.245704-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310220927.245704-1-helgaas@kernel.org>
References: <20220310220927.245704-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


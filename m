Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C73500972
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241588AbiDNJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiDNJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:16:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E613B0A;
        Thu, 14 Apr 2022 02:14:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EFD1D1F746;
        Thu, 14 Apr 2022 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649927659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HBZ9ag92vmSkbFZGj+8KyYeKwAJ+IyyeUDHDn026V54=;
        b=SsizxRShb0DalAHnZsiLhRQUoCZ9HSV0NdQguKLc3u5/6z8lHfxaG7Jznimz/wH0SCII1f
        qLfZRkfPnG0EtoEz1AFgPhYp3vICKrA/KMuxc4c+NTcBx78UmwUk67QMIwXtWbJsw1CCq2
        gd2zlZLo74H4vzB/AIT/8EuJXc0Za1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649927659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HBZ9ag92vmSkbFZGj+8KyYeKwAJ+IyyeUDHDn026V54=;
        b=BOZ9bmdrt8+j0bZ7Hs5lKQKZPoHn2lJ56RtVkGerOwtEllCEM0kw6+TRHIHeRrXHceZsa6
        pOpKAxCETUJ+EOBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B1F8BA3B82;
        Thu, 14 Apr 2022 09:14:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] scripts: dummy-tools, add pahole
Date:   Thu, 14 Apr 2022 11:14:19 +0200
Message-Id: <20220414091419.7654-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PAHOLE_VERSION is a part of a config since the commit below. And
when multiple people update the config, this value constantly changes.
Even if they use dummy scripts.

To fix this:
* add a pahole dummy script returning v99.99 -> 9999
* call it in Makefile taking CROSS_COMPILE into account.

The latter happens only if $(CROSS_COMPILE)pahole really exists. This is
because a cross pahole likely exists only in dummy tools now, not in
real cross tools.

Fixes: 613fe1692377 (kbuild: Add CONFIG_PAHOLE_VERSION)
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Makefile                   | 2 +-
 scripts/dummy-tools/pahole | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)
 create mode 100755 scripts/dummy-tools/pahole

diff --git a/Makefile b/Makefile
index ecbd42f3451a..2ef722ba0a41 100644
--- a/Makefile
+++ b/Makefile
@@ -502,7 +502,7 @@ RUSTFMT		= rustfmt
 CLIPPY_DRIVER	= clippy-driver
 BINDGEN		= bindgen
 CARGO		= cargo
-PAHOLE		= pahole
+PAHOLE		= $(if $(wildcard $(CROSS_COMPILE)pahole),$(CROSS_COMPILE)pahole,pahole)
 RESOLVE_BTFIDS	= $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
 LEX		= flex
 YACC		= bison
diff --git a/scripts/dummy-tools/pahole b/scripts/dummy-tools/pahole
new file mode 100755
index 000000000000..53501a36fa71
--- /dev/null
+++ b/scripts/dummy-tools/pahole
@@ -0,0 +1,4 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+echo v99.99
-- 
2.35.2


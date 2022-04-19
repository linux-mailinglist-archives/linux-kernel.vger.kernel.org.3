Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAB506478
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243809AbiDSGcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiDSGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:32:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD7B245A3;
        Mon, 18 Apr 2022 23:30:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2EB092112B;
        Tue, 19 Apr 2022 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650349811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6PYEpXZsrPHI6tYDMP1XXwHhfvjOKvkuw7nJcNvq5q8=;
        b=SfnPTskw+hZk4LM2kg8KkOlyP7BhXGlSPOVHYjwmLMiK+/0QYvrMd7BZVUne9l1GSX1yXp
        eu3ZqqPD1V9yGDSgW1pB3i9PjPHbzVVDqFiOVNPsEb2y6Yb2WSwj18Te0LXBSKYLhik+HC
        2kEv+uRbkQk7LnNR/S1ab5/C8dIbnVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650349811;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6PYEpXZsrPHI6tYDMP1XXwHhfvjOKvkuw7nJcNvq5q8=;
        b=sI6M0cRzuNarUU3nQojlroLXlQKq3tfkJQpFLgfZF/djiEKqsjWCRkZNRCqvJqLrcXc618
        7ylbmjR9Z9JdfZCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5155A3B83;
        Tue, 19 Apr 2022 06:30:10 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH v2] scripts: dummy-tools, add pahole
Date:   Tue, 19 Apr 2022 08:30:09 +0200
Message-Id: <20220419063009.25352-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.35.3
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

To fix this, add a pahole dummy script returning v99.99. (This is
translated into 9999 later in the process.)

Thereafter, this script can be invoked easily for example as:
make PAHOLE=scripts/dummy-tools/pahole oldconfig

Fixes: 613fe1692377 (kbuild: Add CONFIG_PAHOLE_VERSION)
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
[v2] don't touch Makefile, add only the pahole script

 scripts/dummy-tools/pahole | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100755 scripts/dummy-tools/pahole

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
2.35.3


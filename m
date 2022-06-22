Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CF55542CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350894AbiFVGT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349890AbiFVGT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:19:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D203B6385
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:19:55 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id bd16so19927892oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAy9ZdzvNSqiyUXWluLmSPaqA8dh70j3sUF3U6zADKk=;
        b=EgCwz4ToIzmDReUQZu4sgbTH8NVQgNV/mGmgD9Uogk1pUe5LSTCpeYU4oOqXz6Hxwp
         LvAWt1dbO6XTjENzyGU/yL9v2HBzJ31zoRCXqZqboseI4G+tOFjvDV3FxIdYqmpKviKo
         U1FXkfHCPZ4Z2Y86F1BbvTxt88xWjgNxjxE6LFl4Pku0wreiVEdj25C1WFch38yvc6XF
         G93ENQwzCk1vL+gCwIjVHEa+X40FW2XzONNTlwgi5bingDO7ll5Y5J8VFy8lkUai6Sgr
         fMk1UH9mNxRTiv/IWoTSR2gd0Vukf4CAReiRszmT+6qxKIyPwSanNME4nhvWwrVfxNwV
         zlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAy9ZdzvNSqiyUXWluLmSPaqA8dh70j3sUF3U6zADKk=;
        b=2ybmxvPtny63pwmqGcLD8t0G9ei6Vw5gBO4mP9enO6XVXKERZPCW0lm/WlCncyiTl5
         PGBu6ltiX7q2hjMsC03ouG2kgT4v3Xhjg5IlIJosH8YiW/88GRCK20R0a4aeEDhI3jYC
         HLw2sR66HxpdVmnwxU89XAF01Z5qlljZvS9YnqKrEOR4jUeMzf0lfs3EsNVltVDNNqNp
         WtvkmRZx5kmzCViHtyMFKTzTIMECEMrXwfOPirLOzjds0pEWyvj+D6d1zuAMMogpHe4c
         sQOMb867JWsZJcDVSJJGGUr8mePQnbWjaKR3obENAdvIlARLW0KCJHsJW+hL+BGeRvmg
         WIew==
X-Gm-Message-State: AJIora9aBjSThOqpToKCKIhQ5pEbROgZI5MTYTU/z5kO7rIRX8TZZCEg
        uwpux2NmbwTFPSSFfGV1Zvw=
X-Google-Smtp-Source: AGRyM1tlMQqlFeAttobvlVxOJEaTC1uYWNJH7Yn4A+sxt3w8PY1HoPtyx+na2nTWcMh7n41trh4bSw==
X-Received: by 2002:a05:6808:ecf:b0:2f9:f0b1:7ee8 with SMTP id q15-20020a0568080ecf00b002f9f0b17ee8mr1007855oiv.225.1655878795148;
        Tue, 21 Jun 2022 23:19:55 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id s24-20020a4adb98000000b0035eb4e5a6b2sm10835340oou.8.2022.06.21.23.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:19:54 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/4] memblock tests: add user-provided arguments to Makefile
Date:   Wed, 22 Jun 2022 01:19:29 -0500
Message-Id: <7deb3d3d4c05c884d3830325c816862ce927133f.1655878337.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655878337.git.remckee0@gmail.com>
References: <cover.1655878337.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VERBOSE and MEMBLOCK_DEBUG user-provided arguments. VERBOSE will
enable verbose output from Memblock simulator. MEMBLOCK_DEBUG will enable
memblock_dbg() messages.

Update the help message to include VERBOSE and MEMBLOCK_DEBUG. Update
the README to include VERBOSE. The README does not include all available
options and refers to the help message for the remaining options.
Therefore, omit MEMBLOCK_DEBUG from README.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/Makefile                 |  4 ++++
 tools/testing/memblock/README                   | 10 +++++++++-
 tools/testing/memblock/scripts/Makefile.include | 10 ++++++++++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index a698e24b35e7..9fde49ad73bd 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -45,6 +45,10 @@ help:
 	@echo  '  clean		  - Remove generated files and symlinks in the directory'
 	@echo  ''
 	@echo  'Configuration:'
+	@echo  '  make VERBOSE=1            - enable verbose output, which includes the'
+	@echo  '                              names of functions being tested and the'
+	@echo  '                              number of test cases passing'
+	@echo  '  make MEMBLOCK_DEBUG=1     - enable memblock_dbg() messages'
 	@echo  '  make NUMA=1               - simulate enabled NUMA'
 	@echo  '  make MOVABLE_NODE=1       - override `movable_node_is_enabled`'
 	@echo  '                              definition to simulate movable NUMA nodes'
diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
index ca6afcff013a..058146b528a5 100644
--- a/tools/testing/memblock/README
+++ b/tools/testing/memblock/README
@@ -34,7 +34,15 @@ To run the tests, build the main target and run it:
 $ make && ./main
 
 A successful run produces no output. It is also possible to override different
-configuration parameters. For example, to simulate enabled NUMA, use:
+configuration parameters. For example, to include verbose output, specify the
+VERBOSE flag when building the main target:
+
+$ make VERBOSE=1
+
+This will print information about which functions are being tested and the
+number of test cases that passed.
+
+To simulate enabled NUMA, use:
 
 $ make NUMA=1
 
diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
index 641569ccb7b0..4401f79bed4c 100644
--- a/tools/testing/memblock/scripts/Makefile.include
+++ b/tools/testing/memblock/scripts/Makefile.include
@@ -17,3 +17,13 @@ ifeq ($(32BIT_PHYS_ADDR_T), 1)
 	CFLAGS += -m32 -U CONFIG_PHYS_ADDR_T_64BIT
 	LDFLAGS += -m32
 endif
+
+# Enable verbose testing output
+ifeq ($(VERBOSE), 1)
+	CFLAGS += -D VERBOSE
+endif
+
+# Enable memblock_dbg() messages
+ifeq ($(MEMBLOCK_DEBUG), 1)
+	CFLAGS += -D MEMBLOCK_DEBUG
+endif
-- 
2.34.1


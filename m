Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2C55CF75
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbiF0WfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242689AbiF0WfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:35:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8515186DD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:13 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so6618362otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzFZy7EobE569rOuuG/ggjMqoyz7vEjB3IIrzWyAvt8=;
        b=Xh27ketfaXEFOC6DK+tiYw5iMMoL/8r1KDSWyHu9v+GhHyClT1FLNSK4ljf9Y7opT3
         v/E9krxlR5R+3Po9ayj1brra3jRWV7Gg3G/w9YXFAJHKr+PlLsUVMAbqwlcpIYska0QE
         bPNG87vmig13yB02ng9WgITScuYvnQCF7R29/blPfnzf+7uiaxqn0EiO+tPji3P0Bkyu
         3QzsOt0/pixEt/PYrZqtMlnLax3JHtov76tNg7JpP+gplIdXd5U/iewKIT5qUlRP2Yvl
         B/aSqffVOJRBVOMqbaXZhW2ybGWM24YpYQsOpNP0gI1p0tfDjtbt9I93BnaXBhF5yIfC
         y7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzFZy7EobE569rOuuG/ggjMqoyz7vEjB3IIrzWyAvt8=;
        b=vw9CBQSOSMxhcDUm4dX6PoCMgmxwO6qHa9uGtsw1fHMcaKeofPYrH91srvAwRUanvp
         OUZUVGv4wZt1KeYhueVVB8jB2nbMGfNO+ItlXUrBtr1m3j2wuH9WRcxs3LgWCTLNr10B
         TZRRXF1wYCCWDAsV9KFk7mXI71AvgvOcn3pExx+2CQYe7v9vfujiJjpzNSLIk2lpGi0D
         rnl6WSWAWmewGqDO0+Yf+XvPfHWR3IxL2Vqov7hYT7tAnsblwsgTQYngCBH+A0TXYv7f
         elpB9zIaxTzzWvHfub0uyUEU2ItAnOytf6BuqUrbETK1NBz8EzHG1RFTi01ivOlJzHA/
         lA9g==
X-Gm-Message-State: AJIora+CS2ACtYSD80kgA8X5verhp44LYF4er7HgTRGaJ+kQcMgIabnF
        ySifUD90cGPzhLzrEU32IzTuMiYH8U4=
X-Google-Smtp-Source: AGRyM1s34ggEikw34W5Mov+HOaasnI898DPmxdgNgkQk0hun/YjDp5qnH9KAnLWB+U4TtjKK/hFk8w==
X-Received: by 2002:a9d:2da4:0:b0:616:8feb:6293 with SMTP id g33-20020a9d2da4000000b006168feb6293mr6788371otb.222.1656369313117;
        Mon, 27 Jun 2022 15:35:13 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id o7-20020a056870524700b0010897986b82sm3470666oai.2.2022.06.27.15.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:35:12 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v4 1/4] memblock tests: Makefile: add arguments to control verbosity
Date:   Mon, 27 Jun 2022 17:34:27 -0500
Message-Id: <5503f3efe82ecef5c99961a1d53003c8ad06cf27.1656368930.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656368930.git.remckee0@gmail.com>
References: <cover.1656368930.git.remckee0@gmail.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>
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


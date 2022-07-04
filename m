Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47B564C54
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 06:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiGDEHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 00:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiGDEHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 00:07:17 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708262BDA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 21:07:13 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i126so11599483oih.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 21:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzFZy7EobE569rOuuG/ggjMqoyz7vEjB3IIrzWyAvt8=;
        b=pDC6G+ylT6GCLesFQgbp2Ge9boWhnSINpjbk7Uo0/j4LFTOm8gEIUm6xkX6GQVswCF
         zJgm8t1pBT/v0OKuu9kKkhGurvZ0Ej1IMbsMWe8ogMJC1ASs24GqKGUH/oDkKF9t6aJx
         IUXW241TZB0XMoqTljoce/taPMGn6gRq7gavWHbFyzuaRc945V0ctrpvHv2a6t35iG/+
         3ZvxU0SBL47O/B/SEXIMqnEu146FhR9M/dOFUvpchu8cq0d8ptBKiPxyb4XnIGIv5Xh8
         9utZciN2Nte6s8VjtbhOq5FPRcv9xlKQLpBGrTx7gy0Cpewo+pwIlDpjpgL2liVayNjf
         Dm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzFZy7EobE569rOuuG/ggjMqoyz7vEjB3IIrzWyAvt8=;
        b=qbmwvfhIxl1FtlB5cl2iX6Xi/m+YzHi9y8O6z4BzqHafT/9WbmNNvlkyhE9F6vHXIG
         W823YOK/qt3yvFHZf6Tho63F7iMDgofFW5pMcXztQA8sIub7E5uyK2xaIEdFYIAGP/+R
         /X+EbI9zXlveowCYIjxZ1HHLueo0hE/Tb2CyTl8ivvzjfb8DOokBOEwo72L+o++zwCjv
         PMZiN4xzC/OmlvM9GaaBgB5tF9s23QP1EW4NiYAStG9knz3NBs8RW+K0qS1SYoA0Y4gK
         vYCGA2icae8ZMdCFkmDRwk5srHfwsDwNRU4KEH8Z3bgcpUkk7vkTABotyM+zcST+aNNh
         MVBQ==
X-Gm-Message-State: AJIora/1YxjZoVhursMCH0uw7mjpV8uTCzqRYKLkhx6IZjmsdANsGTla
        g3hCmQF4X/HWaRTb01eHvEE=
X-Google-Smtp-Source: AGRyM1t0Qd6auPky+T4yghJZafEwEdynJg6Upmpp/8MKTVj6y1IjCJxmJXdMmgdGxOFeSK34NeXhAA==
X-Received: by 2002:a05:6808:23ce:b0:335:5aea:8e62 with SMTP id bq14-20020a05680823ce00b003355aea8e62mr16357426oib.253.1656907632601;
        Sun, 03 Jul 2022 21:07:12 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id t5-20020a4aa3c5000000b0035ef3da8387sm15161005ool.4.2022.07.03.21.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:07:12 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v5 1/4] memblock tests: Makefile: add arguments to control verbosity
Date:   Sun,  3 Jul 2022 23:06:55 -0500
Message-Id: <5503f3efe82ecef5c99961a1d53003c8ad06cf27.1656907314.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656907314.git.remckee0@gmail.com>
References: <cover.1656907314.git.remckee0@gmail.com>
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


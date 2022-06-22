Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5E6554684
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354732AbiFVJ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355742AbiFVJ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:29:19 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472223669F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k24so20427501oij.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzFZy7EobE569rOuuG/ggjMqoyz7vEjB3IIrzWyAvt8=;
        b=Yi2rupt2gqO0TXPAhwMzEoXicOGPWzkZYLtKaqwX5sv5fjgIYq3rZb3R/vgBXYmIjq
         giyViDEHu+DCwEPCXcny9wrQgUo0AtT4tMBMiXpAlPLpARr1X5ZNFdxuf39m9miwt0QP
         AOgTSvfi6Bn8v737usTipbLNyeA2oPBzM+vR/bVl4/ABFZT2VIarzXwTaunUbFYIpf+q
         cmRrkYX4ZVJcBznk5CsEbbqXT9EC2zdVg/4CNrtbtZw9bN0IZS9h9FUXIiw9wtXveqO9
         tgkGxhBfAgbSaOJQzWi/w0ERFqJyEmsof4c7r6ExDzYMEHlnMU/jd4khiWK3l5NUBxId
         3wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzFZy7EobE569rOuuG/ggjMqoyz7vEjB3IIrzWyAvt8=;
        b=Un++GP1NdgsV0xOdac6+THx+6i9EDRcbUDyHh8o23DSCXZHa3eK1FrrQ+U1Eq+ESyP
         f418HyNc6n06qA3WJyREC3+stjSt/PyH07iTkuHr+l2YoKQO2HVB+/H1EkjhXHxEDbZq
         +ANJT/3E5EXDCjco+krfbmaTIjp/g/NMgyRDL6aWdYeQ3uk837sg37LdcGQ6cCsoq4Qi
         h8OUOgyWPr60jnCH97cfw6S9QudLrQ3R/PKUSta97NlMOCVW4izbv12TVKupbJLbRxwF
         2rRhu+yqmttBGCqMjIjwaHVbjFUeY52aiUkXQRLztTQP6OwYg7iI9AUPhZnmBge478FM
         DQsA==
X-Gm-Message-State: AOAM531+r3i/NnZoI4DrpJ4bqlCHsDFtXlOk3RG0NCKbhNZzGSLeihe+
        dyEDMePM2O/Fz9VE/2ahWsIwqMY6GSY=
X-Google-Smtp-Source: ABdhPJwXl4mJ3gLaWz5a2mal8GQQEvRZB4IXNkgmCdIoGKbfL20IbEcvlw+rsFyYz12pL5dSVHvcwg==
X-Received: by 2002:a05:6808:1598:b0:32e:ff1f:1dbf with SMTP id t24-20020a056808159800b0032eff1f1dbfmr20777596oiw.259.1655890157618;
        Wed, 22 Jun 2022 02:29:17 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id dt13-20020a0568705a8d00b00101afc7b263sm8584818oab.9.2022.06.22.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:29:17 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 1/4] memblock tests: add user-provided arguments to Makefile
Date:   Wed, 22 Jun 2022 04:29:06 -0500
Message-Id: <b7e8e89dbbd7acdf41d62f1528f02d1dc2283e4b.1655889641.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655889641.git.remckee0@gmail.com>
References: <cover.1655889641.git.remckee0@gmail.com>
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


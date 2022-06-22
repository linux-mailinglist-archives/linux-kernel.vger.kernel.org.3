Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24493554984
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352963AbiFVJMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357447AbiFVJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:11:48 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705D3B28B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:09:59 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l81so20356462oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bAy9ZdzvNSqiyUXWluLmSPaqA8dh70j3sUF3U6zADKk=;
        b=cOTsT1YVhVh0vkiXD++aRy96KHVOOHRHKXGg7xddPMsOTW6M0doY9svJL16vx3M4Pd
         AFEdmta071zwCGiJlsizK/Uw2yCswwabxfv6pKk+t6z3FrykswUgayWtbnMoWMorhEl0
         nuFSGG93wCVON04nYFatRjEznqf9HGBUBE7YFk07im2B1eohqU5CKX2Mn0BoQmAlDlXZ
         4kczOYwc9637ZzwGLXbXbsdNRp48kNhfMOl4X56Sc65WWInZB5s3R0JExotPwOvdlkLI
         ednyfGwPl5YjEFq6CItvYCb/rk6Ff2WncMl/86jBoA1EBRHnEq6FYPh1pVs+B/1mbQ68
         KK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAy9ZdzvNSqiyUXWluLmSPaqA8dh70j3sUF3U6zADKk=;
        b=utOFc0Ps9u8sNLLgLZY8LoGFRJVcMrje//jYb7UHn+KyFXpRp6byVLXXAZ48HqE515
         3BKycDUa1uJ+bdcdhLmBx/1mK1tbwXpfdzrbdk1te7Vx7XdpATYgWuze6BO9C1ZsnxeY
         zA7tIIyjZZQ8Eb7HAHnFD5Xbnho3HhpHlnBybDDFl7BdN8QIc/AB9W5W+63W6eTiRX39
         ExX9wmbrk0+/AslAodF+Hx/w/a1AaWeI7uXd+oqQNgu69q83uVMIjluluIBJuxBF84Rg
         8qnhIhC3p2dVDdKVv3Pk5wTdEbiQADcWWPUFO5q52Jc/JvmeMKgLmN1Vp6gjrVC9e7E3
         OYWA==
X-Gm-Message-State: AJIora97L0FnNkFyxLi2NvLojlNS51psII12c+kCmQJwn3oqoNaXbtNF
        iIhQTOr2dCL8AxQvIFkdIq4=
X-Google-Smtp-Source: AGRyM1sIl8cNamJruw3MajKB4JJPMqWvDvkYDtHyjNNwcg20jYiIEq+C/au8hBaIeoi6za32+BV1zQ==
X-Received: by 2002:a05:6808:17a4:b0:32f:f5f:be1 with SMTP id bg36-20020a05680817a400b0032f0f5f0be1mr1251982oib.26.1655888998341;
        Wed, 22 Jun 2022 02:09:58 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id y14-20020a056808130e00b00325cda1ff8dsm11098128oiv.12.2022.06.22.02.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 02:09:58 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 1/4] memblock tests: add user-provided arguments to Makefile
Date:   Wed, 22 Jun 2022 04:09:43 -0500
Message-Id: <7deb3d3d4c05c884d3830325c816862ce927133f.1655887571.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1655887571.git.remckee0@gmail.com>
References: <cover.1655887571.git.remckee0@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF5553D862
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiFDTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiFDTbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:49 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FDD50448
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:36 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id az35so1177947qkb.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmYk1E0nlrVwRWwFSUC/a4yoPMG0X4XicsKq1hOz6KU=;
        b=PJoje00985N6oGb/Y7bGsu79gRdWGwWmNVnvrX06a4qBWEHiGWQMqbbjrBD0FWF2C9
         hSxat3cFEp6yEukLVpR44SfZoxpFuoy8AW0TgKufz1DdZL5g4kNAzKJx0SPBApiG7uu9
         5iJ5dC8D+KXHkXvGpc8je01NDyf1w/bitToUoQPbJleWS5Aihp4Z6oeD3doWmT251/Cp
         rh9gw83EVSkHrRClNO/OBunWbwOxu/mC3V+aooYZnVFQS+qMckTUvctDbOhw6s9TmWyO
         II1dLerx3Cqsh6cZ78WG0pNY2U19ON3i0qzCmNq4qNtFUNIlU8RatEylhTfDZWObcyZz
         JZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmYk1E0nlrVwRWwFSUC/a4yoPMG0X4XicsKq1hOz6KU=;
        b=drX+fwuhq8RLSL9bGneFPl/2UIBFihyc3nyoUgNs8Ikx5jIX1NbuLM2jjBBra3T6px
         Mn7vKP73GXhiH4ur9bDpmZShgpi7uc9Wrr7AioIgGfKoAptPuf8zM/CNpKQe2pQoTttJ
         ftyK2ZsoPDLPZ8Qn4YzisPA83XRL4buLuq+6YUKuVbllHp2k1Txcff+XO6isoT/mgWYV
         b3ybm5OWPiK/fXInAxUdyM/T5lXXZZEgeULQHDWx/gWwENnMKMrbTccR/1iiohjsk/iz
         ldRnYo1WVfY4s8IYSgEf8nOwDi6v6sIBzEUXDGfhszWEyHkRE6YKKqSzAoAxggRE+DZ4
         UXSg==
X-Gm-Message-State: AOAM533GsLZs8SP8iIfMOEoZecQsLUuZcWpYXfFxav1hASG+DBVCBxAZ
        CFtwlxN/1VeHpwia+YqJn6/mHzn9rf1j
X-Google-Smtp-Source: ABdhPJx+3SHYROOTVTOhx/1YUWQwQKfJsM6CjtyyJSI2BNjTj2VGslnIUXruGHfNZ1OR/0E4gZ8QFQ==
X-Received: by 2002:a05:620a:2586:b0:680:f846:4708 with SMTP id x6-20020a05620a258600b00680f8464708mr10998237qko.654.1654371089527;
        Sat, 04 Jun 2022 12:31:29 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:28 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        nvdimm@lists.linux.dev
Subject: [PATCH v3 26/33] tools/testing/nvdimm: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:35 -0400
Message-Id: <20220604193042.1674951-27-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts from seq_buf to printbuf. Here we're using printbuf with
an external buffer, meaning it's a direct conversion.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: nvdimm@lists.linux.dev
---
 tools/testing/nvdimm/test/ndtest.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 4d1a947367..a2097955da 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -12,7 +12,7 @@
 #include <linux/ndctl.h>
 #include <nd-core.h>
 #include <linux/printk.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 
 #include "../watermark.h"
 #include "nfit_test.h"
@@ -740,32 +740,30 @@ static ssize_t flags_show(struct device *dev,
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct ndtest_dimm *dimm = nvdimm_provider_data(nvdimm);
-	struct seq_buf s;
+	struct printbuf s = PRINTBUF_EXTERN(buf, PAGE_SIZE);
 	u64 flags;
 
 	flags = dimm->flags;
 
-	seq_buf_init(&s, buf, PAGE_SIZE);
 	if (flags & PAPR_PMEM_UNARMED_MASK)
-		seq_buf_printf(&s, "not_armed ");
+		prt_printf(&s, "not_armed ");
 
 	if (flags & PAPR_PMEM_BAD_SHUTDOWN_MASK)
-		seq_buf_printf(&s, "flush_fail ");
+		prt_printf(&s, "flush_fail ");
 
 	if (flags & PAPR_PMEM_BAD_RESTORE_MASK)
-		seq_buf_printf(&s, "restore_fail ");
+		prt_printf(&s, "restore_fail ");
 
 	if (flags & PAPR_PMEM_SAVE_MASK)
-		seq_buf_printf(&s, "save_fail ");
+		prt_printf(&s, "save_fail ");
 
 	if (flags & PAPR_PMEM_SMART_EVENT_MASK)
-		seq_buf_printf(&s, "smart_notify ");
+		prt_printf(&s, "smart_notify ");
 
+	if (printbuf_written(&s))
+		prt_printf(&s, "\n");
 
-	if (seq_buf_used(&s))
-		seq_buf_printf(&s, "\n");
-
-	return seq_buf_used(&s);
+	return printbuf_written(&s);
 }
 static DEVICE_ATTR_RO(flags);
 
-- 
2.36.0


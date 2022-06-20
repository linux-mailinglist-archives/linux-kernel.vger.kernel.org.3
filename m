Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1C3550E1C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiFTAo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiFTAnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:49 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DFB85C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:36 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id n197so6891429qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c+8VrBQ9WReeZhxiPy4cLYIhVweEbjxzP+O3PD/upkI=;
        b=hG1zSXlqMLSt6C53e/b9Mbo0SIVK2m3R3jUS+uuyLNSYU7h0hemVP+PRCJbhYgLMX7
         FyNfHr+aW+bfF+gBFHQVtjYmTqBlPCmff2HDumH0thLuIMmi+5xTZif5rFBJ+/Im7rAY
         1iX2kT7GRCrIcIEadxyY1d1XK2xwI+VfWhMkRQQXdVqaQ1Fe0sWfvN1U4Bkz0s0EOCFP
         8abRX4B1TCxLaNePhLqRU6tlIUx0JP4G+9qFcUhjmBSi/tOCHoHYoFp9xNjydTdju9/h
         wJokcyg3abuBPNvUSNp4Rqz/gHfQqlC/+laxZ12aplYKKmjtUIHJTaMhGSQZkwxGp0ta
         ffZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c+8VrBQ9WReeZhxiPy4cLYIhVweEbjxzP+O3PD/upkI=;
        b=JoE5hvaHUJOnponFisbxZakcA1E/2FNNrmNeZBpo+MQE1N05w6b7bOLX5nFJGEyvIX
         sR3Dsi+sZ+RBA5IiVsD6AjUWUElobFvxDxo6lo1ey+ImDZQsi00AzOn34yQ1LkizjHVx
         YWh9/MHSakC9OsPzy2V7siYpnXuoN4eN+FCM/OS0uazpQdMeS4xZ0XAEL5/iqHxbDJ/N
         e/H0E9/IBiiofMc6KiR1rq507fNm9TMsbeILS/Bix81RSjMCUqlojshauPgxyGM/DDjI
         9MyBIKtITj4dtQp8vBVfzGzQACU9XrZOC+xEvAiP1KqyY2HrgL9x+OIrAopcKsP6zrTu
         3OEA==
X-Gm-Message-State: AJIora8xVICR4Px32s3s+GTqVoUNZ5g/qaXW75A1kA1vU6SUU/czdIh9
        Duo3MXq61bNfeVzbPgd4gmzbNDZK+8vUwrQ=
X-Google-Smtp-Source: AGRyM1sebw4W5sjFrt3VW++8K/4IO2JYqZAC0xgWvLT2GDMfU7O1Du2uxp+uMD8HWJJW0TKREzVJcA==
X-Received: by 2002:a05:620a:f05:b0:6a9:7122:edb1 with SMTP id v5-20020a05620a0f0500b006a97122edb1mr14790338qkl.82.1655685814618;
        Sun, 19 Jun 2022 17:43:34 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id y17-20020a37f611000000b006a69f6793c5sm9944488qkj.14.2022.06.19.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:33 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        nvdimm@lists.linux.dev
Subject: [PATCH v4 26/34] tools/testing/nvdimm: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:25 -0400
Message-Id: <20220620004233.3805-27-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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
2.36.1


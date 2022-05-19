Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE852DB43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbiESR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbiESRZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:52 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DB5AF31A;
        Thu, 19 May 2022 10:25:35 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w17-20020a17090a529100b001db302efed6so5828315pjh.4;
        Thu, 19 May 2022 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QRd1Hj7z8PQ6OGAWnpJxYHyy9vDcMOmiRfmbwhyjgQ=;
        b=hRwvBgiXo+VzZn4+ZMIuphIGy3cRF1TZwhoAN7s4erqo0CFUk1qb6ydVp88d+2ipZi
         yJUJi0Vh+xqciOv/aQqybtbFA0SnHgW11kIpK7xCdSLq/JtOf56mzXpce/OevP5i8ryj
         RpxcKm3CLN2X/5r7tX2qLHOrtwgaScLaFuzYtEEMVLbqgiN74TV36cmO3hF12CqtCQ9C
         DaNjTFnJRzNK8zou/DzS9HANilhYaiwS4DrM4QaSv9VKBFLV3uzkMAxedajyr7YJS54O
         mz5s5WeLD5t36bFXc3CHmj6/16zZj8DfbVv8OsRa3DOkYQT1g2sPgZL2y5nd/1mksJZS
         GRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QRd1Hj7z8PQ6OGAWnpJxYHyy9vDcMOmiRfmbwhyjgQ=;
        b=Nx+ghqadCXiMw3XLPVVFJeheBcao1If5nqDgjCqc3OKTM3zTAmOm96KxukoYHzbwbv
         Fl9xRj2OGpnpRrvxlPIT8Dx9YWW/k7g840AI/wN3ksaAZHegWMIbUPOw6zspe+nJFaQ0
         U4rKeJ/Ica4hmuFGYlnCONLV8R/PFsHZg91nk6FdFgVbcGD2qg1VJ7e+gVsubj7cXyv/
         36+WMVmPc8iSVf2wXk29TRn+TlKCTfgUSl2a54Diq5DAls4xa051vFvShvxYF1AWXLVI
         7wHqU3D9hbmJ7olRwKDi/Yd/GCAcGM2kdnRazejvAXGWGNZGHbVmQcGIcAiD3KRRfRa2
         e6VQ==
X-Gm-Message-State: AOAM532bWHwubfXUfCLTqe1+fCflafci9W2/ZgmsUvXN2rlwO11LjkTe
        xmZ3XBTZHnYb6tR59ST5fuGBCx5BPodr
X-Google-Smtp-Source: ABdhPJwilFeifO0CVAPkBmNZUYBAAIobtr791UrG2yrXWCxaxjHkGeXGvgtvvCY54ifcmkoBoEresA==
X-Received: by 2002:a17:90b:3e8b:b0:1dc:e471:1a69 with SMTP id rj11-20020a17090b3e8b00b001dce4711a69mr6878682pjb.60.1652981134105;
        Thu, 19 May 2022 10:25:34 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:33 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        nvdimm@lists.linux.dev
Subject: [PATCH v2 25/28] tools/testing/nvdimm: Convert to printbuf
Date:   Thu, 19 May 2022 13:24:18 -0400
Message-Id: <20220519172421.162394-26-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
index 3ca7c32e93..e9b642f7f8 100644
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
@@ -797,32 +797,30 @@ static ssize_t flags_show(struct device *dev,
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
+		pr_buf(&s, "not_armed ");
 
 	if (flags & PAPR_PMEM_BAD_SHUTDOWN_MASK)
-		seq_buf_printf(&s, "flush_fail ");
+		pr_buf(&s, "flush_fail ");
 
 	if (flags & PAPR_PMEM_BAD_RESTORE_MASK)
-		seq_buf_printf(&s, "restore_fail ");
+		pr_buf(&s, "restore_fail ");
 
 	if (flags & PAPR_PMEM_SAVE_MASK)
-		seq_buf_printf(&s, "save_fail ");
+		pr_buf(&s, "save_fail ");
 
 	if (flags & PAPR_PMEM_SMART_EVENT_MASK)
-		seq_buf_printf(&s, "smart_notify ");
+		pr_buf(&s, "smart_notify ");
 
+	if (printbuf_written(&s))
+		pr_buf(&s, "\n");
 
-	if (seq_buf_used(&s))
-		seq_buf_printf(&s, "\n");
-
-	return seq_buf_used(&s);
+	return printbuf_written(&s);
 }
 static DEVICE_ATTR_RO(flags);
 
-- 
2.36.0


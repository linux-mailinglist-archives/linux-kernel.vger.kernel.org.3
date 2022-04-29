Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE83F515568
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380659AbiD2UVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380648AbiD2UVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:21:34 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F37CA0FE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:18:15 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e922e68b0fso9244880fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnE47zkhbqWUJCOF0oFEixfkiu1ztx/JWB/tGri5YXI=;
        b=a9eja63UZsOz8EDkYCqgng2hYRK9WULHVEyppQTAGE6xiRQ32CQn6CFl2j4IpY4D/A
         T/SILFH1b9jXsHfFF5EPdcHdjPOQ9tzsyECf/C+2FrfimR8jZwXFDAoZPcRS1M6y+YZU
         wqaNac66Z0pUqdAQgcZpXr/lksm1XFEayCYcjPohjvqxfH61LHyxYLHEC3VoBP/SSzw6
         +d1offiCPqehXEje4lXOw68Qk4XWAXNcjzTeC5lZsbpYcAnKW0lB9/YmgZkZTuGojgMQ
         nFGLT6sdanVPtlGuzu30Ol+fmyRWCBmYGhBBv1OwuLHUY5MzLq8ev+Bm6J9a8H06rP/0
         QQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnE47zkhbqWUJCOF0oFEixfkiu1ztx/JWB/tGri5YXI=;
        b=JY8KyzeeHC08vH59U5ZBbGTzs+dREYnzoxXXZYAkdev96zJyS+Ic0g+xGxUABMy0+l
         TlAy9GE3RTdFRhg/WS/Bf2rps6vqgVHlV9FUFagIpsAxCmP4OJ39Hypnz/mIlHKoZbQJ
         BP6dal+4QPL7Ddvf4hyY62QFCSyhpiZxBt/mJc1AFoVBEIWVc7KYfm7xpUmPkU/Lk8xN
         1GYEHhmNLacwVhupRPeiA5s9p+i5Y9xP7u9VT6pE1pR+sorWjkyp+Fy70SXaf1t+PQVp
         dBVD0jC0gY+mLfG+VbJ5k3/TEZ+yYzBb6k3E5gr/VXHJ1F6LPI4FPTJ7qCD0TsjuyyqD
         CoNA==
X-Gm-Message-State: AOAM532BUxsDTxQ/snPE57Ysq0QMVF8Xhh3ryK1BxN/SZ2VK50csOc/N
        iYhEMzZx9m+Nf23ksnaXc06bXO3hOedD/RY4lb1+0yOUXHOUf5H498gboR9E5u+etGylWx4u/Lj
        I2HU8V7AfDXvcX4GNR61JTXCaNtj9IfxOWLwDm5pBYvtyuI+2Zm54cA6f3kCpNiAAiLbgltA+C6
        nSdkWSN6kRllU2jIQS9yU=
X-Google-Smtp-Source: ABdhPJxofcGdrQu7m+cL6vOtGym7ome4qtIu2YMefSz1hnwtbmQ4+6AReZ8mcS6ebQmZ4VwoWkIanA==
X-Received: by 2002:a05:6871:28a:b0:e9:16de:c70d with SMTP id i10-20020a056871028a00b000e916dec70dmr477455oae.113.1651263494682;
        Fri, 29 Apr 2022 13:18:14 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id p4-20020a0568301d4400b0060603221248sm85961oth.24.2022.04.29.13.18.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:18:14 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v8 5/8] x86/e820: Refactor e820__range_remove
Date:   Fri, 29 Apr 2022 17:17:14 -0300
Message-Id: <20220429201717.1946178-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor e820__range_remove with the introduction of
e820_remover_data, indented to be used as the void pointer in the
e820_entry_updater callbacks, and the implementation of the callbacks
remove a range in the e820_table.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 94 ++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 36a22c0a2199..0e5aa13ebdb8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -669,66 +669,54 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size,
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
-/* Remove a range of memory from the E820 table: */
-u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
-{
-	int i;
-	u64 end;
-	u64 real_removed_size = 0;
-
-	if (size > (ULLONG_MAX - start))
-		size = ULLONG_MAX - start;
-
-	end = start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
-	pr_cont("\n");
-
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry = &e820_table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
-
-		if (check_type && entry->type != old_type)
-			continue;
+/*
+ * Type helper for the e820_entry_updater callbacks.
+ */
+struct e820_remover_data {
+	enum e820_type old_type;
+	bool check_type;
+};
 
-		entry_end = entry->addr + entry->size;
+static bool __init remover__should_update(const struct e820_entry *entry,
+					  const void *data)
+{
+	const struct e820_remover_data *remover_data = data;
 
-		/* Completely covered? */
-		if (entry->addr >= start && entry_end <= end) {
-			real_removed_size += entry->size;
-			memset(entry, 0, sizeof(*entry));
-			continue;
-		}
+	return !remover_data->check_type ||
+	       entry->type == remover_data->old_type;
+}
 
-		/* Is the new range completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			e820__range_add(end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_removed_size += size;
-			continue;
-		}
+static void __init remover__update(struct e820_entry *entry, const void *data)
+{
+	memset(entry, 0, sizeof(*entry));
+}
 
-		/* Partially covered: */
-		final_start = max(start, entry->addr);
-		final_end = min(end, entry_end);
-		if (final_start >= final_end)
-			continue;
+/*
+ * Remove [@start, @start + @size) from e820_table. If @check_type is
+ * true remove only entries with type @old_type.
+ */
+u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type,
+			      bool check_type)
+{
+	struct e820_entry_updater updater = {
+		.should_update = remover__should_update,
+		.update = remover__update,
+		.new = NULL
+	};
 
-		real_removed_size += final_end - final_start;
+	struct e820_remover_data data = {
+		.check_type = check_type,
+		.old_type = old_type
+	};
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * the size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
+	printk(KERN_DEBUG "e820: remove [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	if (check_type)
+		e820_print_type(old_type);
+	pr_cont("\n");
 
-		entry->addr = final_end;
-	}
-	return real_removed_size;
+	return __e820__handle_range_update(e820_table, start, size, &updater,
+					   &data);
 }
 
 void __init e820__update_table_print(void)
-- 
2.30.2


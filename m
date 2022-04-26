Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D8510902
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354210AbiDZTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiDZTen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:34:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7DEDB52
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:30:44 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l18so11472278ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ank2mYd3nSanKxmSKtm5nAH75fQy/ZfiLRmnMjWOP70=;
        b=hljtTzJZV5Vpzx7ZO/4Vrk6T9shB81K8wF8W8pjg9AeZnKBiAosysk/4y7WsUSm7jL
         NhuUJP/F5a40XCHB0ORRdbWVXxqgyjYecHAIbRUs0jCCijSxny6QSWOq1nmneLfK9ryT
         CYhnjcQHYMNTyk8is9BShruZMqmowZ4HIExB6MJpj7HUARret27yD62Yoz51eqjnZvYv
         5+xIJDzT0QLc9ANImAuavrFXO/MIrTz/1kKXuD0vnJVWLqLk5dR+oih+rc/9MUTEXpvs
         D+WBExvgsYwQjxIeya5YU3GQ1ZPgie/W4N6GysfgPmWi96RLsxVoBFKQUNUWSFzQokyE
         +t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ank2mYd3nSanKxmSKtm5nAH75fQy/ZfiLRmnMjWOP70=;
        b=t5y32su3wIc49ReluBWOfy7LjKR5lngxE+m8nwNA2jbZVmyqdtsybFYegxD5Ew33TA
         HyCEJs1+eQ7d9z07JrbJYJIbBTr1EFoKHZaKeC3GcCQYf2+ks8sedkbrKKxfHQcbgXu0
         X/UIwDxfpfMRJaDY1Gy1G7hS6jJr0gWGgPsRVJe+E6Yyn4AHFUYohRi+z9cHhCwnLysX
         oKaEwY9OoPjAAcXCH7CvPaKHsuonHKHaNYZ/rYYTSV39Jx7D6P3p15wbqjYGJG4zmVaA
         3uwM/oEykMKpkmLb0tuGGkKn4wc4kl+qU1UFalnHb6toraRp3OvzexfbaVvkY0FU1ARX
         iC8w==
X-Gm-Message-State: AOAM5308zZhbIRTflit1VVbqw3/Ta7dDjMMkNZ/DItiRdz0tBHaFcEm3
        AfpHcV8YT2CRtRSBUZBnCys=
X-Google-Smtp-Source: ABdhPJyGAKs/1fi8OP0JmZVoAeRo5gj73FlEUM++3oj7p/D5a1GiB7hWfafMbvunvxZ9VCI3cStydw==
X-Received: by 2002:a17:907:2d24:b0:6f3:91fd:db8f with SMTP id gs36-20020a1709072d2400b006f391fddb8fmr11905250ejc.150.1651001424316;
        Tue, 26 Apr 2022 12:30:24 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709066c8200b006e4e1b1f875sm5406140ejr.199.2022.04.26.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 12:30:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] mm/highmem: VM_BUG_ON() if offset + len > PAGE_SIZE
Date:   Tue, 26 Apr 2022 21:30:20 +0200
Message-Id: <20220426193020.8710-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VM_BUG_ON() bounds checking to make sure that, if "offset + len>
PAGE_SIZE", memset() does not corrupt data in adjacent pages.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 6b2d59e025c5..d54dbaae9a5e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -380,6 +380,8 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 static inline void memzero_page(struct page *page, size_t offset, size_t len)
 {
 	char *addr = kmap_local_page(page);
+
+	VM_BUG_ON(offset + len > PAGE_SIZE);
 	memset(addr + offset, 0, len);
 	flush_dcache_page(page);
 	kunmap_local(addr);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6764EAD72
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 14:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbiC2Mnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 08:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbiC2Mmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:42:54 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD285211ED2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:04 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id j39-20020a05640223a700b0041992453601so8687090eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=km5owwejhlOXuN0CdtXT+rH3PwGCxkXBDIlOmz8F8mM=;
        b=BPBN+Gp/HybRIj+tr7lmAPtZ/gaSTg17YfV70uHe6dI4D03YCmDJ28J1xxu73jh2dk
         lunM+tJfRxIWWCTitc1zqeGcNO6ui2olt/ToR74zTeetb2t645zaZRfbXnEBWBeufQcz
         UZFI/a7dadkwv9KhIIRq4n83fNxSMacV6CuDKWLbiQmxkp72N4gUGhDLhrX/ZY/tzqb+
         wwmGDuW3C5VDusIt/9kLL08QT9f400t0JOILiCvI+CWdGaKJ8/8ZTha18LD969Vanzph
         EmE7KmmpEFFeSjxO/yybRJOhoovSm59NPOFmQeJCjBwZk6WuGl9hl0wb88xwAHT3OeLk
         9zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=km5owwejhlOXuN0CdtXT+rH3PwGCxkXBDIlOmz8F8mM=;
        b=eJD693b5qoUoNhtpy3Bw5+go/DrdVNB/H4y/x1QM8gzmBVDjKnFG4l7aMk0Rz5iChH
         d37sv4qj+I5QFOK63Ho4gU5GjwWGY4RVYWymITsDujSrICyefEG0giFhFUtbBrGdrMvA
         QRuFQBBN3cWEYsFJe0T3w8n9mkG4jDt75Aq8/JZwGxa0IPYAm0PA8nYp4kTxtGaKyGNJ
         +woz/YsybxEzfwMAPeoaTtcqTrqjjVELs1Uy6osShE5BdQoE090JqUVuR179V6gWxiZi
         WtHjG1SIGy3qipbmgCtgPU5yYUV5NRSwHPkF41N3K9+i2iCSJ+xqo/sW8BPMDr5BJb49
         TuOQ==
X-Gm-Message-State: AOAM5327aAmArZacX0gWgc4On4KlpL4jehrN4gn7Hv+ReSpLjm0xM10g
        RBJrYcHjHgSfo/iozQ91OXWHIheKCZk=
X-Google-Smtp-Source: ABdhPJxTFdKgNMHXnOGxM/ndXx2ll4nIIoJnFlW5u5FSX6vDALAQ8Bv8xnOw9ZMBkOj50HuqwBsroT31ous=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:36eb:759:798f:98c3])
 (user=glider job=sendgmr) by 2002:a05:6402:27c7:b0:41b:51ca:f542 with SMTP id
 c7-20020a05640227c700b0041b51caf542mr3174378ede.149.1648557657545; Tue, 29
 Mar 2022 05:40:57 -0700 (PDT)
Date:   Tue, 29 Mar 2022 14:39:40 +0200
In-Reply-To: <20220329124017.737571-1-glider@google.com>
Message-Id: <20220329124017.737571-12-glider@google.com>
Mime-Version: 1.0
References: <20220329124017.737571-1-glider@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH v2 11/48] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN adds extra metadata fields to struct page, so it does not fit into
64 bytes anymore.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I353796acc6a850bfd7bb342aa1b63e616fc614f1
---
 drivers/nvdimm/nd.h       | 2 +-
 drivers/nvdimm/pfn_devs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 6f8ce114032d0..b50aecd1dd423 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -663,7 +663,7 @@ void devm_namespace_disable(struct device *dev,
 		struct nd_namespace_common *ndns);
 #if IS_ENABLED(CONFIG_ND_CLAIM)
 /* max struct page size independent of kernel config */
-#define MAX_STRUCT_PAGE_SIZE 64
+#define MAX_STRUCT_PAGE_SIZE 128
 int nvdimm_setup_pfn(struct nd_pfn *nd_pfn, struct dev_pagemap *pgmap);
 #else
 static inline int nvdimm_setup_pfn(struct nd_pfn *nd_pfn,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index 58eda16f5c534..07a539195cc8b 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -785,7 +785,7 @@ static int nd_pfn_init(struct nd_pfn *nd_pfn)
 		 * when populating the vmemmap. This *should* be equal to
 		 * PMD_SIZE for most architectures.
 		 *
-		 * Also make sure size of struct page is less than 64. We
+		 * Also make sure size of struct page is less than 128. We
 		 * want to make sure we use large enough size here so that
 		 * we don't have a dynamic reserve space depending on
 		 * struct page size. But we also want to make sure we notice
-- 
2.35.1.1021.g381101b075-goog


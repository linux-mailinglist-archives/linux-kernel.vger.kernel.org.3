Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E865121A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiD0Swy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbiD0SwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:52:25 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FA2DF48F;
        Wed, 27 Apr 2022 11:38:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so5167958ejw.1;
        Wed, 27 Apr 2022 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k75/spXS+k5a5+DVquVFeCXg9KobdD3U49dRA56k3UQ=;
        b=JLJR2+S/v6It9gJr/TiqMLTTFSv6DyRzzADGLWON1JCaOTnKzH1+VU8NynzjGGEipx
         IlwiMQmQSKbsYYZe2TAFZgbSeO1Iq2WRI84k2hkmS2IpVtJszMvFtZQSWdoaIZ17hVOw
         WmGVbkfKSC2S3Xgkjxyk6XF2dvpCFcHT9541Hr4aYXwUXRLvUaYcRBxuC7jVD5OwGJDj
         z4YbZyRk26qXUV04MGxMJaonQm8WpIderszxaLStgxJxo5mM147I4snLrhdjIx1Zi0RV
         VQah7SZoLbHghWu1MBCQsIcP2UYYt7X/ORDcNTIXwlk0qdjmhnxNnLmlUB4eKqNAB2vu
         KcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k75/spXS+k5a5+DVquVFeCXg9KobdD3U49dRA56k3UQ=;
        b=T5aVOd5ND+Te8wbV8EbVvxQpUvLSGfueN6bxa6t+Gr1cfXFOWR9/T0wOdcuZRaxDXM
         MtErKKe+tR768yxgYjb/5WDI9qY93h3B6K2y+8+VMd8FI7ggzIqvOEuaUAq6vIAToxGc
         bvYM8Xzp3FIBGO+pk/pCNNMyVBi8l2SHmfSLDD/lRr2VXBErhDz5mjlj+O17DPZqP0F6
         DhkUU6SqTBBcrTPFN34yoOcKH4F4U/LRkw82SSvylhWPK9/KgJ8EtN3glnmpCf2hO/UH
         qCcIzyoMVWw0wVguHi2gI/XWMLFaNQ5qKnvVUzdxtu4XBJ36rnA2GOTBprw3JYhd/R32
         axhg==
X-Gm-Message-State: AOAM530oaYJq3AVzgob/BiSBKVFAh6NV0fQ/Q1pjvoFanYwqlkjzSJ/E
        9Wp4AX7g0vYC472VUZ1RNao=
X-Google-Smtp-Source: ABdhPJyqxAnZeuQdR1Pu7yQd2w8qzvmFZ+4CsZFyBpbjMJsQDuf9u3iTk+0FzzF16gNHyfq2yp+3/A==
X-Received: by 2002:a17:907:8a0d:b0:6f3:a595:6136 with SMTP id sc13-20020a1709078a0d00b006f3a5956136mr12551715ejc.54.1651084710853;
        Wed, 27 Apr 2022 11:38:30 -0700 (PDT)
Received: from localhost.localdomain (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b006f38f2e9ebesm4691667ejc.64.2022.04.27.11.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:38:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        outreachy@lists.linux.dev
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 2/4] Documentation/vm: Include kdocs from highmem*.h into highmem.rst
Date:   Wed, 27 Apr 2022 20:38:19 +0200
Message-Id: <20220427183821.1979-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220427183821.1979-1-fmdefrancesco@gmail.com>
References: <20220427183821.1979-1-fmdefrancesco@gmail.com>
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

kernel-docs that are in include/linux/highmem.h and in
include/linux/highmem-internal.h should be included in highmem.rst.

Use kdocs directives to include the above-mentioned comments into
highmem.rst.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 0f69a9fec34d..ccff08a8211d 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -145,3 +145,10 @@ The general recommendation is that you don't use more than 8GiB on a 32-bit
 machine - although more might work for you and your workload, you're pretty
 much on your own - don't expect kernel developers to really care much if things
 come apart.
+
+
+Functions
+=========
+
+.. kernel-doc:: include/linux/highmem.h
+.. kernel-doc:: include/linux/highmem-internal.h
-- 
2.34.1


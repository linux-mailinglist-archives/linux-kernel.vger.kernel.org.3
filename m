Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52527584389
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiG1PtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiG1PtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:49:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE756C13F;
        Thu, 28 Jul 2022 08:49:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ez10so3815900ejc.13;
        Thu, 28 Jul 2022 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u10tCeHxgugC+7t5c4hTzmt45MJlA8VbgBQ6EKUnR90=;
        b=KlmTRWeLKmwBcROEHkHZbITGTJuNYP8SrVX0Tn0EsDoDE333WrbzpPWF4Lgl6DQXUO
         xFQ9n/SzPBNJljSIlhrn4Dm6zHEjB9uqMp9GOrAHYOc8fiHKCKG3CSi/60P9INq59WN9
         NV8Pk4H9K4sv/IilYvuPueF/cGVnwwrWbA2ZYFpmv+a5zlnq9/Um2F38ZFNa0L3Tbk2/
         yFtsqEEW3KLLZ77jKRf0+D+J+36JH4ZotQMmnOLLhjxb65tpKnOgCubNmZ4RnoZNNP7w
         V1QPzb3pAHcCTswGtNGq5sT6kDOk7RQUx25/pziHB9dakj9atDC5DPLgRTzP9O/+8p+N
         c6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u10tCeHxgugC+7t5c4hTzmt45MJlA8VbgBQ6EKUnR90=;
        b=7DJSJTvxDesvbXjpZoQt4hphR98mjzzdDPymQKyNwYFTr9vB8g8i1J1/Fy4EBawArx
         8d8Ft8Qk2tLbAood4L+7UZ7bK7Ws3dhF9BlHndMZE1rx8kCdL+a7ROU5/erFwQDNf+3u
         175/QBIxuWEpCxsqvJUlrAq88BBJ2CFD+LzKNvXgowuMsTxQ0vc4dEWIlqNKm0lT8B77
         DakWhWgL5xMknRXw33o81SibExmj++Po8/GiL5SPRAZ6n/m5wh65oIhNgsRjAuZo/pbg
         O+J+dqzdhneRb+14+oIxtaEf3wvu6u+Nu0DZ44iUgw+Rsy3XEKrIx7t+lRB3t724WuFG
         3z1g==
X-Gm-Message-State: AJIora/MJZ9mqtmLKpBubTQ0EVS0GZksL+Zodr7Ub6Pt79J6u1l8Ekkg
        N85j4ahCxI0S97eb1nyoknI=
X-Google-Smtp-Source: AGRyM1uTMEeSgDG1fIOeuAPXXAmYDAa7aYZ2/ZW2ZMjpMF8d6d+ZnfyC0wlCzm8mPzPzj0lOPqgvtw==
X-Received: by 2002:a17:906:dc8d:b0:72f:2993:ed84 with SMTP id cs13-20020a170906dc8d00b0072f2993ed84mr21031444ejc.251.1659023343545;
        Thu, 28 Jul 2022 08:49:03 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:49:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 6/7] highmem: Delete a sentence from kmap_local_page() kdocs
Date:   Thu, 28 Jul 2022 17:48:43 +0200
Message-Id: <20220728154844.10874-7-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728154844.10874-1-fmdefrancesco@gmail.com>
References: <20220728154844.10874-1-fmdefrancesco@gmail.com>
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

kmap_local_page() should always be preferred in place of kmap() and
kmap_atomic(). "Only use when really necessary." is not consistent with
the Documentation/mm/highmem.rst and these kdocs it embeds.

Therefore, delete the above-mentioned sentence from kdocs.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 include/linux/highmem.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 0ba031ad29c2..63f25dfc6317 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -86,8 +86,7 @@ static inline void kmap_flush_unused(void);
  * temporarily mapped.
  *
  * While it is significantly faster than kmap() for the higmem case it
- * comes with restrictions about the pointer validity. Only use when really
- * necessary.
+ * comes with restrictions about the pointer validity.
  *
  * On HIGHMEM enabled systems mapping a highmem page has the side effect of
  * disabling migration in order to keep the virtual address stable across
-- 
2.37.1


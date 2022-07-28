Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FC558438A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiG1PtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiG1PtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:49:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003026BD75;
        Thu, 28 Jul 2022 08:49:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v17so2727327edc.1;
        Thu, 28 Jul 2022 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8APnMmesitYfUJOHbYKV3UsYyKDlX27FBCb0ow0nRC4=;
        b=BKt6O3q2HbkDhrr8HwxREKaSTHKfqeVpD9X1eWdRIPGxTR9YOTZDJ9La8CrKUIVHcU
         UaC+aK0PPN2aTNyoJ6+HH/16E/igJFEmuLkra8P6NAha1eFq/8oD5IrKEw1WFOnGlhAe
         6yLbU9XedsMRIROtlGW4rgB4NrKgF+stWc23t0qRVTaeKvibRjaS8+yzLHO48C0LPlZN
         EKqOx8OUCXrO/MhSPjwQnzcHggyU9KzPltUTYh8+1mdKqShH1zQZmuko+eobtVn1gjYP
         /GLXSoTjMzMivBqcY+BxYfeyyGGQxbCYJ36JvwazuE1a7frXROwO4q5N0MP86dUlTuTi
         6+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8APnMmesitYfUJOHbYKV3UsYyKDlX27FBCb0ow0nRC4=;
        b=wZIwoHK0p8B3PotgJHtJqjT7q7Q9+jdRu2NZ/iO0EooFznxKqHDcnAuil3ceIJ6K4d
         twvVk0zLaoVcFk+oJSGDPet4YvrfIzH3t1iJ3Urxzt/cak1wU+odhxBU0E1nGmQyYb80
         b8znUKDmZWJFvzAAWPmXwxXgWnF/LGhx5GjjOb2YHvB5jo6NmZw/4Gr7UJiwZPxYLqU6
         F62u+0hQw5X6B1pATPVqlg5S9HKsbodYRpOLPm6Psu+12nusdq+tZdg1CbSjUzipqnj+
         59MgFMHBOK54HdTD9GYJfeCZaaggJLnV7/tbTEjq52KdUvqmhM+f+9QpRS2jcNniN5Y6
         qprw==
X-Gm-Message-State: AJIora9SZv/rJqWCJB1mM8RseUvTnajRJpIb4oc+PbBKec2LOOSbjhy5
        HUxrCnM682IUm4bpkyfZQHE=
X-Google-Smtp-Source: AGRyM1t872rB7bx3zD4Ue8eElwqOoi9+d0jeAoDI7eLvHKJm/Ffzc/5rp5Mqz97IjgW/zLeHRUuMQQ==
X-Received: by 2002:a05:6402:e0f:b0:43c:f9f9:37c4 with SMTP id h15-20020a0564020e0f00b0043cf9f937c4mr2092484edh.196.1659023341364;
        Thu, 28 Jul 2022 08:49:01 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:49:00 -0700 (PDT)
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
Subject: [PATCH v2 5/7] Documentation/mm: Prefer kmap_local_page() and avoid kmap()
Date:   Thu, 28 Jul 2022 17:48:42 +0200
Message-Id: <20220728154844.10874-6-fmdefrancesco@gmail.com>
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

The reasoning for converting kmap() to kmap_local_page() was questioned
recently.[1]

There are two main problems with kmap(): (1) It comes with an overhead as
mapping space is restricted and protected by a global lock for
synchronization and (2) kmap() also requires global TLB invalidation when
its pool wraps and it might block when the mapping space is fully utilized
until a slot becomes available.

Warn users to avoid the use of kmap() and instead use kmap_local_page(),
by designing their code to map pages in the same context the mapping will
be used.

[1] https://lore.kernel.org/lkml/1891319.taCxCBeP46@opensuse/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index 71dc09563ff8..e045a4b7b3da 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -84,6 +84,11 @@ list shows them in order of preference of use.
   be absolutely sure to keep the use of the return address local to the
   thread which mapped it.
 
+  Most code can be designed to use thread local mappings. User should
+  therefore try to design their code to avoid the use of kmap() by mapping
+  pages in the same thread the address will be used and prefer
+  kmap_local_page().
+
   Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
   extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
   because the map implementation is stack based. See kmap_local_page() kdocs
-- 
2.37.1


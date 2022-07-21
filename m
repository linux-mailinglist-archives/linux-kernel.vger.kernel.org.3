Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31D057D572
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGUVCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiGUVCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:30 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5B90D89;
        Thu, 21 Jul 2022 14:02:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d8so3935556wrp.6;
        Thu, 21 Jul 2022 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DaR5sQH4yLBlK+oiJh3kpc8qiO8mkIw02kY3ZSEU9aM=;
        b=Svx2QVXXAhFOsHMBl04OUx/8AH/SG8+a/6HoVoUzdmGUfegov4t0WWTiRz9A7hp5Xe
         eJDfdyW6IjWHg5Z9jluI0zkt5sh4YHjFYhGoS4tUCx+0+zG04U407WG8jpt7b6LcD2Es
         dSNkWkvMYYX6lqnS0xnLKS8kAP9r68vTN+CEs8uJJjDac459A0LS9oZss5eqSsN6wdqJ
         wM8ox6zdURucIg5uWetpw+MoBZa89Rb5bNK1/a2tzAT2qLu4opiHLBtOxbEooapeR4Pm
         qB+BSLLfeoofTBvRykK1ySfFEUde0iPS/8bEmGD6Z799U04nH104PXYA/zbtsaU2k65l
         s8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DaR5sQH4yLBlK+oiJh3kpc8qiO8mkIw02kY3ZSEU9aM=;
        b=zE+Nt9x0gTbyy/vwRxAp8dhKYyMRv0CEH+saLLzIIlSEp/84q14IvmeswlyXBjQ8Cp
         QKjeuvUQZoul2DKZc0BBOkAE7erbP41C3FQbYzBvLXYQHxmiY42T09WynYkmUWfuhs49
         /x4m/KMv91EgFLqHjF3jaxxiuS+v4317xIPFmZ7hkvfOZ+ygbW3Fix7URCp4gOZIPozK
         TMYzkXtAI82KPo+fkxGrQOr8EhUyNNkaIs1d/3qveWhonLua695oscY4Q1ZBC2JZ1wVv
         FdbSIvYtLUXfDVkUxVxUGbc2TaCqjtfJFE+pjwU4AtmjTp4uLthERVhgQtMxa+LFZYRG
         987g==
X-Gm-Message-State: AJIora+uvP/DqYSO96R+2WvMFlhxTN2+p4SC6N3jIDMYypXLS4IdlrGp
        nfb1xBHpSlqYe3j0BqmgsP4=
X-Google-Smtp-Source: AGRyM1tzyvjyOaIkGk7ATDdnIRPrKCAwM4oq9G4LVQJ0fzqhAevt+Z0aFxLrHUZ4bk20RnZ5wwQm9A==
X-Received: by 2002:a05:6000:178d:b0:21d:a3cc:54c8 with SMTP id e13-20020a056000178d00b0021da3cc54c8mr192475wrg.602.1658437348013;
        Thu, 21 Jul 2022 14:02:28 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:26 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5/7] Documentation/mm: Prefer kmap_local_page() and avoid kmap()
Date:   Thu, 21 Jul 2022 23:02:04 +0200
Message-Id: <20220721210206.13774-6-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220721210206.13774-1-fmdefrancesco@gmail.com>
References: <20220721210206.13774-1-fmdefrancesco@gmail.com>
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
index 50d2b1fac24a..564017b447b1 100644
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


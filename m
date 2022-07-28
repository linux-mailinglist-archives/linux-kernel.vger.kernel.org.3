Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9C584388
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiG1PtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiG1PtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:49:04 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD716BC15;
        Thu, 28 Jul 2022 08:48:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id b11so3827895eju.10;
        Thu, 28 Jul 2022 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMEv2tnkJHQoNeinZVr2aA1AzEdF5MIKyUzDsdgs4R8=;
        b=WqKewVXGOxgoft0f+QZJEd1nYoSyTawCHG/6Wbt3TY4yByC5y+bgxM2WjaLjow2zl/
         RNUA5iLhQkx0xOUGc+QZ+sPE3/zP20Q68LI8llerJgL0rOSL9s/2U+Oj5yVB9PxV1TTK
         Ao+2rFu1sbI08zlXKsPowSMZ9B25xImb/UeQpNWsYzTtS4rNipMVmYgUwTiS+QiAiF6/
         rNOgRmZytKtpoYSUKIsfGvzoCfwrYCGDsJShamktEnF1E8GF4JuW360K55KwfbPl9HBX
         4nUZL1wpvEzhawozc6XOJrbFnlJhQdrtGfyyWAglnzWM/WHzqrLIdhTPqb1coJRQ+Jut
         O3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMEv2tnkJHQoNeinZVr2aA1AzEdF5MIKyUzDsdgs4R8=;
        b=lZKCeu/utrFbGZjMuHMrjptuGUd/gHl4Fbg9SKyH6bwqo5fRSBvJ9TPKCB2MlA5j16
         Grc7fHzbBLA6YwA8PYoxuRqPMu8fwrb9lP/QzdIIb6nkyYZ4Ohm9rroX5g2y6ujXTCbR
         b8eQKRAtUb8cbFqcPsKIHsN8eQBBe4EHb/h/ei1zq8M/S/qHQ5DWSJq6R2/pIYr+Wo0g
         J24q8i1d7Mn+f3v0UGvJGQurVFeQSmt4qbnJg2Uup8Cx/u06r2qr+eNBbk9OMivojeKd
         htZ+xxb+5o7lnzNGykBIe1xiB+TE9GsVAFi2eXoBhjLHIzWoNEvRd9WxAXKFhCCXZS6u
         XCpA==
X-Gm-Message-State: AJIora9zdpR2tLtdQQkaVfiDT64X7lQtZ8b3ioesWbrQILOnLMoQC6w1
        16mxjqp2z1a8pSnJcbx1pxw=
X-Google-Smtp-Source: AGRyM1saWlx994orvUgLkY9NXlF2Oi0bNF3EQ0dvBg/rPXPifykSCqYgf3Bwuyx0uaAkpo+W+3SF+Q==
X-Received: by 2002:a17:906:9b14:b0:72b:313b:2df4 with SMTP id eo20-20020a1709069b1400b0072b313b2df4mr20887101ejc.99.1659023336626;
        Thu, 28 Jul 2022 08:48:56 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:48:55 -0700 (PDT)
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
Subject: [PATCH v2 3/7] Documentation/mm: Don't kmap*() pages which can't come from HIGHMEM
Date:   Thu, 28 Jul 2022 17:48:40 +0200
Message-Id: <20220728154844.10874-4-fmdefrancesco@gmail.com>
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

There is no need to kmap*() pages which are guaranteed to come from
ZONE_NORMAL (or lower). Linux has currently several call sites of
kmap{,_atomic,_local_page}() on pages which are clearly known which
can't come from ZONE_HIGHMEM.

Therefore, add a paragraph to highmem.rst, to explain better that a
plain page_address() may be used for getting the address of pages
which cannot come from ZONE_HIGHMEM, although it is always safe to use
kmap_local_page() / kunmap_local() also on those pages.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index c9887f241c6c..34d7097d3ce8 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -71,6 +71,12 @@ list shows them in order of preference of use.
   kmap_local_page() always returns a valid virtual address and it is assumed
   that kunmap_local() will never fail.
 
+  On CONFIG_HIGHMEM=n kernels and for low memory pages this returns the
+  virtual address of the direct mapping. Only real highmem pages are
+  temporarily mapped. Therefore, users may call a plain page_address()
+  for pages which are known to not come from ZONE_HIGHMEM. However, it is
+  always safe to use kmap_local_page() / kunmap_local().
+
   Nesting kmap_local_page() and kmap_atomic() mappings is allowed to a certain
   extent (up to KMAP_TYPE_NR) but their invocations have to be strictly ordered
   because the map implementation is stack based. See kmap_local_page() kdocs
-- 
2.37.1


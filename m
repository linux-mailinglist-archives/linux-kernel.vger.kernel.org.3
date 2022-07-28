Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41BA58438C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiG1Pte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiG1PtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:49:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0B46D2EF;
        Thu, 28 Jul 2022 08:49:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id os14so3875234ejb.4;
        Thu, 28 Jul 2022 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4EkCm6C5nf+QegmjlHeacbbo0A11Yc7aT2xPtr0I2M0=;
        b=MTY21uOSVJ606b1H+dzV0+Mbqybso010MmD5/Mqd+4KHa7NFo4zGxveQhikjlPLS7h
         2phxbbJDUvchSme1J5Jik2CP0ZBsOsxpvkPe1FHbdyu7VFSd/kv0MvMC25HIzXGTOBp4
         /K9AasJlOVTvwE6f1/htME1MI6gL/vxL6z9RxBmO2MlifW66PnCF74F85H3u4kfURf9g
         BTD6UB40+0jyyFXceP/L7SB272OfCR4ZGC7SPSvbeyKnRt5/2CEWpXaLkBNxTVCN0L7S
         LSRHmCEA6epfBbpoxRnBnVd6cMsMw8Zba/bVoIaL0EOfXEpDfkXDBDIqsuy5KpzyPG/Z
         rc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4EkCm6C5nf+QegmjlHeacbbo0A11Yc7aT2xPtr0I2M0=;
        b=CMs7bfqlyfPzboAn8a8420jvmjJqRs/c+TPADjRa5+R/BSAuoiK7bhHTQj/aSpAAde
         bMF2S4ri15FR1JhbLSZQw9TY6TFek5tkuNqrhxN5mBaR1MQEUiIGK9qAdfZqO+/ITRuZ
         BRe+2p3/vXCgSLJcQKH20+nkhai2rCfpx5NCBGPI22Tcb86qST+3LKJa8Zny/fuK0nKU
         tdtgU3cw2n8QuGUnbq0drEaFRVc861EYWlEtRoZA+YJbebxI9+hhLigV9qy4TWJ0Eh56
         uCoE6af0umKUxQyMaMTRGOKGeUwHLaVqWhqPqBHSkirWwzRXAgdWBrB9J0ajHMsAgy37
         5PKg==
X-Gm-Message-State: AJIora8mch5XgU8KwI6aYZ/2ItcP0W9NN8fQl944QuZfC04lWXvWXSSO
        emua07GKfmXfj8drjpSLyIY=
X-Google-Smtp-Source: AGRyM1v8gE4WJQVj8oN3MLDAqwXgZheR9OSc99+pl1Vd0PVtErruRQgyCcsLPy5Km8V3lKWx68ifSQ==
X-Received: by 2002:a17:907:720a:b0:72b:549e:305a with SMTP id dr10-20020a170907720a00b0072b549e305amr21291979ejc.691.1659023345797;
        Thu, 28 Jul 2022 08:49:05 -0700 (PDT)
Received: from localhost.localdomain (host-79-56-6-250.retail.telecomitalia.it. [79.56.6.250])
        by smtp.gmail.com with ESMTPSA id f7-20020a056402068700b0043adc6552d6sm902487edy.20.2022.07.28.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:49:04 -0700 (PDT)
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
Subject: [PATCH v2 7/7] Documentation/mm: Add details about kmap_local_page() and preemption
Date:   Thu, 28 Jul 2022 17:48:44 +0200
Message-Id: <20220728154844.10874-8-fmdefrancesco@gmail.com>
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

What happens if a thread is preempted after mapping pages with
kmap_local_page() was questioned recently.[1]

Commit f3ba3c710ac5 ("mm/highmem: Provide kmap_local*") from Thomas
Gleixner explains clearly that on context switch, the maps of an
outgoing task are removed and the map of the incoming task are restored
and that kmap_local_page() can be invoked from both preemptible and
atomic contexts.[2]

Therefore, for the purpose to make it clearer that users can call
kmap_local_page() from contexts that allow preemption, rework a couple
of sentences and add further information in highmem.rst.

[1] https://lore.kernel.org/lkml/5303077.Sb9uPGUboI@opensuse/
[2] https://lore.kernel.org/all/20201118204007.468533059@linutronix.de/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 Documentation/vm/highmem.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/highmem.rst
index e045a4b7b3da..0f731d9196b0 100644
--- a/Documentation/vm/highmem.rst
+++ b/Documentation/vm/highmem.rst
@@ -60,14 +60,19 @@ list shows them in order of preference of use.
   This function should be preferred, where feasible, over all the others.
 
   These mappings are thread-local and CPU-local, meaning that the mapping
-  can only be accessed from within this thread and the thread is bound the
-  CPU while the mapping is active. Even if the thread is preempted (since
-  preemption is never disabled by the function) the CPU can not be
-  unplugged from the system via CPU-hotplug until the mapping is disposed.
+  can only be accessed from within this thread and the thread is bound to the
+  CPU while the mapping is active. Although preemption is never disabled by
+  this function, the CPU can not be unplugged from the system via
+  CPU-hotplug until the mapping is disposed.
 
   It's valid to take pagefaults in a local kmap region, unless the context
   in which the local mapping is acquired does not allow it for other reasons.
 
+  As said, pagefaults and preemption are never disabled. There is no need to
+  disable preemption because, when context switches to a different task, the
+  maps of the outgoing task are saved and those of the incoming one are
+  restored.
+
   kmap_local_page() always returns a valid virtual address and it is assumed
   that kunmap_local() will never fail.
 
-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188C57D576
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiGUVDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233794AbiGUVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:02:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958CA91CC3;
        Thu, 21 Jul 2022 14:02:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so3936859wrx.12;
        Thu, 21 Jul 2022 14:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSYPcrbVTzgClSZXRMYRyVvkc6OfsxqUTpv5KCNWl3U=;
        b=p5uPLEeZkNHeCfs0C/ALizG2/6Ja3FGzmfJSLjC5OvjBkH1b8Vgh2AFSvqsmzRNLuL
         7jg9QFe09SsA5V4BH8n7jK/mxpbMggRUAJ+tGCfMm5Wyi23XbmTk09PvizfK1rOUoEdT
         zSB6p+IdrV9M5zpB4zgjhcKx7X2A2tek7GgX3kNPsNprN7JVXJCU09vW3XfFSWqdGZff
         jc+GtN3Cx7xpyrXDtN6EQYevs4zn+lDtYqEZ7/YZNtFypf/TpsmIdgJjfnOj2iolRBYt
         etiLygZfp5CelF7+5of+tBHfW0xLMfubKv1EwTaUqH/g65uSfoGBgwSuSLUgbcmkY4dR
         2USA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSYPcrbVTzgClSZXRMYRyVvkc6OfsxqUTpv5KCNWl3U=;
        b=IdTi5E1ickO6z4/HL24Fzij9AUMmdnF7v/1A61tAsYas8aBW/ctuEX8ggz15ot3k9F
         NaldXCAS9Reki4WLvouEd5wLvE7+i2wRXkGpet8jv53R3pnpJhOmqsM5RyAB0Wq57zW2
         gk+jiwjy/9bvu9gfBzUsMhTQXrgDMX6zp7eARL5xWr6r7kwtTSCW64vZW1hgDZ3sh8Sm
         pXPvZzGZG7Bl0S6ytpHSbn9lqlEeHq1hXQ4WV8sUv1r69X/053xY0df4mgKXoJLL34yY
         Yf//CISWFkpa51KtaBTlT2uwZQzPA9Y6Ets/Ym+HYSXUqw2mX9WfKBKvhMEg3JyunRRx
         o4zQ==
X-Gm-Message-State: AJIora/3y2Q6EgECYb2oavsNwpU9C3vPFiul290I66Who9vRAMpGwXEc
        GpZmzpg887l0K67WeIjCASo=
X-Google-Smtp-Source: AGRyM1s/7UEwOZfzWdNMMaLR/ZiIdGlNAPfmvyAVgWnQNsHUG6r20o491RZHqNrFSTFFX70ogSY/3w==
X-Received: by 2002:adf:f245:0:b0:21d:a39a:bed5 with SMTP id b5-20020adff245000000b0021da39abed5mr190359wrp.508.1658437353314;
        Thu, 21 Jul 2022 14:02:33 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id d12-20020adffbcc000000b0021b8c554196sm2884383wrs.29.2022.07.21.14.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:02:32 -0700 (PDT)
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
Subject: [PATCH 7/7] Documentation/mm: Add details about kmap_local_page() and preemption
Date:   Thu, 21 Jul 2022 23:02:06 +0200
Message-Id: <20220721210206.13774-8-fmdefrancesco@gmail.com>
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
index 564017b447b1..8ce43965ddef 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDE56A2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiGGMxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiGGMxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:53:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5029A2CC97;
        Thu,  7 Jul 2022 05:53:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 73so2926575pgb.10;
        Thu, 07 Jul 2022 05:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OkXjFR+NYH0OoqXK6diEul5vRaNtuMp4IaWe2/sFDXI=;
        b=nuqQ+wJ5o95y7jGGqpjCELTfPjPUHgi7E7FTZs0gaGOCcqFLscKyTXuknhl2r0Tr8i
         GOKY+oU6XKhO8aGgFKaqc5b+9pKcLFKJ7RiiUd+QY6xRysPA/boO7vrt9gotnDM1k9VM
         zIFmA8SksMiiE9HHckgX6o3SgQiX8ApGKfCA6UHTrz2tEszAPlMUEjm835NOJBg9WeDe
         CzWBlbfIOMzbr9uTof81U+ft8J7xcwV9GCdQefl3HC72cHN8J4/cN0Wni9gPCz5OCWIl
         olZjBjGuiap0t573baIhDwmeLQibM5GcnlMYqdobD9no36jFTc8y4Ce7Val9hIgEyvo+
         VDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkXjFR+NYH0OoqXK6diEul5vRaNtuMp4IaWe2/sFDXI=;
        b=xDfBu1WYtW4bi2uZAltdY/BMqrDR4eg/nOLObgDYTu33ryFzHLCRFtWf7scU5nDNca
         p3as1bh4uj790tra1qkEXrEev/dAnyx1LL0SXzXVZHuAHdplrkylm59iYnsfsGf/WhzC
         tL942duvc+D5Uy6DI/SaT8xrPhEZN4NP1YXWu3CW46doElDGoRGUvDUry7Khhkjpxsce
         sLrkMg+R81tdIskW4QV5Q/mfzC7Hj44SKItXcCnmhyGqUb0dRJKwk7NZzsRrKnrCGuBN
         M7uNfIJXHFIcK7mY+O2MP3MwaauU3POPhOLaOJFyQWgUUOSzvtANA1+m24Mgp4/qBg/g
         jzJA==
X-Gm-Message-State: AJIora9TLtiMH10hzo4Bes8wOrbgNEugaj1iv06v03Tw39UrqoRzHxtA
        GmUOvroDoXbXnCZ3EVS+uB4=
X-Google-Smtp-Source: AGRyM1v1964MD/IIcSfx/8Y5slyYPx4KMBqa/W04tHsO/yrwZoWnhZV8fVssXI0+aMYp8g1qivWNHw==
X-Received: by 2002:a63:f415:0:b0:408:808b:238f with SMTP id g21-20020a63f415000000b00408808b238fmr38849185pgi.469.1657198390801;
        Thu, 07 Jul 2022 05:53:10 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b0016a3b5a46f0sm27907831pln.241.2022.07.07.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:53:10 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com,
        Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
Subject: [PATCH 1/4] Revert "Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't apply to ARM64"
Date:   Fri,  8 Jul 2022 00:52:39 +1200
Message-Id: <20220707125242.425242-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125242.425242-1-21cnbao@gmail.com>
References: <20220707125242.425242-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Barry Song <v-songbaohua@oppo.com>

This reverts commit 6bfef171d0d74cb050112e0e49feb20bfddf7f42.

I was wrong to say batched tlb flush didn't apply to ARM. The fact
is though ARM64 has hardware TLB flush, it is not free and could
be quite expensive.

We still have a good chance to enable batched and deferred TLB flush
on ARM64 for memory reclamation. A possible way is that we only queue
tlbi instructions in hardware's queue. When we have to broadcast TLB,
we broadcast it by dsb. We just need to get adapted to the existing
framework of BATCHED_UNMAP_TLB_FLUSH.

Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 Documentation/features/arch-support.txt        | 1 -
 Documentation/features/vm/TLB/arch-support.txt | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/features/arch-support.txt b/Documentation/features/arch-support.txt
index 118ae031840b..d22a1095e661 100644
--- a/Documentation/features/arch-support.txt
+++ b/Documentation/features/arch-support.txt
@@ -8,5 +8,4 @@ The meaning of entries in the tables is:
     | ok |  # feature supported by the architecture
     |TODO|  # feature not yet supported by the architecture
     | .. |  # feature cannot be supported by the hardware
-    | N/A|  # feature doesn't apply to the architecture
 
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 039e4e91ada3..1c009312b9c1 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | N/A  |
+    |       arm64: | TODO |
     |        csky: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-- 
2.25.1


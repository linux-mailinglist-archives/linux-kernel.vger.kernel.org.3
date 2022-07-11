Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7310456D37D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiGKDqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKDqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:46:47 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DFB18B0F;
        Sun, 10 Jul 2022 20:46:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso3786823pjh.1;
        Sun, 10 Jul 2022 20:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zH1rOKwt+eppc4uRJ3wzEb3jlVxvSJQcRh3p/hoLlMo=;
        b=ePx9tw2qDorWxYzPWcGRLOvGkwfDV4WFpjno1bzwsIkpBxrJHAnbnXDd+9TSQPIZWc
         rB8vctJmdtvbZmL7h6HXuBkhUVLcRj4hr5D8Xao8ADv5y3VOodNZydMQYF/4GMGusm5B
         AITvvCsvM4Fymc4mIY+V5NWWdLdN5dTrkn7xmybz4zKiKBZrzDwmWdMdWUAOQVASHsYU
         cWoYrJVQQwEh8W4X1CL7RJ+zQhdG9+qfpNmkK52I5z3wiRZLGNEEimJp5XIALeYrky8b
         md0dtPDDjYyabBKb/WuxSnQ+6lF4nSZ8gZYRptwvwsM03yDen/D8SIE11lqmoUisCWjs
         XneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH1rOKwt+eppc4uRJ3wzEb3jlVxvSJQcRh3p/hoLlMo=;
        b=Jg0LI16ORaZfkW3b2OekZktfRMSU8evWmFYQMxMOJ/Iw1GTHurGg1Gk7SEpT/kmyMP
         7RUeLhhMrQ0SCuyWh9daLrw73UO3bjGc+Xk7qgBowmSr4mOil2V9EumDTV9DSf7pABgZ
         ERw9gIYrSrheepOGvPy4SflZtTMAXGBDEDtrGYmrWc5cIMICP34sUjkpJFk8Lw34EqcM
         LtJU3K8nilE95QDviOUCrh6MkKWM3PSUMp9tLutJuCddD726Aq5j9InaG+epyOSwEZYJ
         yeUfseo3UFBOh218JjAOyV8Yf6+YXpsYdOS8V0YE6DRbR7ey8LYWUZL2aC24mcmqa5pB
         isWQ==
X-Gm-Message-State: AJIora8rd49etJOwGr6VRxxnzuuL1kYBzKvr1I9wdL8PQK1D3bX/cGyW
        luTQ5250QyUJUfkpQM6Unoc=
X-Google-Smtp-Source: AGRyM1t+IjLE84wZXwipeZB/XUo7NKGO7BarDvcoewmact2teddnhHzQthXl8IiBONeN1GAjHbnetA==
X-Received: by 2002:a17:90b:4b4a:b0:1ef:fc95:3c4f with SMTP id mi10-20020a17090b4b4a00b001effc953c4fmr15058701pjb.138.1657511206386;
        Sun, 10 Jul 2022 20:46:46 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902eccd00b001664d88aab3sm3447949plh.240.2022.07.10.20.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 20:46:45 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v2 1/4] Revert "Documentation/features: mark BATCHED_UNMAP_TLB_FLUSH doesn't apply to ARM64"
Date:   Mon, 11 Jul 2022 15:46:12 +1200
Message-Id: <20220711034615.482895-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711034615.482895-1-21cnbao@gmail.com>
References: <20220711034615.482895-1-21cnbao@gmail.com>
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

I was wrong. Though ARM64 has hardware TLB flush, but it is not free
and it is still expensive.
We still have a good chance to enable batched and deferred TLB flush
on ARM64 for memory reclamation. A possible way is that we only queue
tlbi instructions in hardware's queue. When we have to broadcast TLB,
we broadcast it by dsb. We just need to get adapted the existing
BATCHED_UNMAP_TLB_FLUSH.

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


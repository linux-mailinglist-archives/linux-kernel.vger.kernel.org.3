Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A29056A2E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiGGMxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiGGMxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:53:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0B2CDFF;
        Thu,  7 Jul 2022 05:53:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y141so19172522pfb.7;
        Thu, 07 Jul 2022 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KohxSBlyb2gPjZjQOuscJE9srXX9sKJcN9WDxnjJeNE=;
        b=Z/4G+j0uofz5mjT+m2wBBS33jHt4uCc2grw6vajzycA8dAivB2I1E1uYK99jJIfo3O
         +QVMHgjhpLcxM5rK9KyJLhGd/2RG7WG+m+aIuZ3X5Dg4EPoe2WAdSN9T1oNWhnIRZCdt
         ZtoFweBV2b0oTa0dw6ht0oMasl/SwPv6uthPPSyM3N0RJ0saHZLDz4W90bArUtgevKYX
         m4cfQNFxf1WMKIGk+78eEF2P//QSs/IM5W/9lyROXPgyN8uTHDD7SQNwWbsVEYeSgcNq
         xvvHmPTuceHpBwtGmhSs2cQ4RtAGjDNqkq+j6cmwe55l10OUsxpR+oO0AVJ7Iz/bxSVX
         mLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KohxSBlyb2gPjZjQOuscJE9srXX9sKJcN9WDxnjJeNE=;
        b=cvbqJSSfSsjGidSP1hJphxXmVRX340kNxEWxRqzjeg7YoQ08zd6PJrntmaWDlCw969
         Xjsev7bFQu9Dm4mTrwmck1VyeAFRhjdOlbdjywDkqpHrOOe0A3QGALKMrENcjehu+/1P
         h75tJ146a9uAwmOHRhGMRj+P95VJ3n/3KpHVUqc/+K1W1UwiCkoRURzKipJM40vhQZpG
         Kox97XlnvI4zUh9aWbA/8MwtkDIPm1R1eH1tz9JWP8fPTI53j6ao2UxLkczlPoDpvOD6
         sN2PYw9oK3kH/aahZSSx5vJ/Kedonehn+XrnZAdKmP/3X2kwCzruBgPoBKqYpyZBQ0LT
         EqVg==
X-Gm-Message-State: AJIora9H8OvWdp6Ms1WJrgdR9EUk1yjlBCiT+8f3tmSI1ohXsijvrdlU
        H0wRmUuF309DQjtw1qqqhJE=
X-Google-Smtp-Source: AGRyM1tvGgyyQudlC4LStAUoiLkQLMqA8RlR3btbebQT65iLnPCQfEEP4u4looKoNOsGSkmoEtUiHg==
X-Received: by 2002:a17:902:e809:b0:16a:22dc:d23a with SMTP id u9-20020a170902e80900b0016a22dcd23amr53568912plg.119.1657198397970;
        Thu, 07 Jul 2022 05:53:17 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709027e4b00b0016a3b5a46f0sm27907831pln.241.2022.07.07.05.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:53:17 -0700 (PDT)
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
Subject: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
Date:   Fri,  8 Jul 2022 00:52:40 +1200
Message-Id: <20220707125242.425242-3-21cnbao@gmail.com>
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

Platforms like ARM64 have hareware TLB shootdown broadcast. They
don't maintain mm_cpumask and they just send tlbi and related
sync instructions for TLB flush.
So if mm_cpumask is empty, we also allow deferred TLB flush

Cc: Nadav Amit <namit@vmware.com>
Cc: Mel Gorman <mgorman@suse.de>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>>
---
 mm/rmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..d320c29a4ad8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -692,8 +692,13 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 	if (!(flags & TTU_BATCH_FLUSH))
 		return false;
 
-	/* If remote CPUs need to be flushed then defer batch the flush */
-	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
+	/*
+	 * If remote CPUs need to be flushed then defer batch the flush;
+	 * If ARCHs like ARM64 have hardware TLB flush broadcast, thus
+	 * they don't maintain mm_cpumask() at all, defer batch as well.
+	 */
+	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids ||
+	    cpumask_empty(mm_cpumask(mm)))
 		should_defer = true;
 	put_cpu();
 
-- 
2.25.1


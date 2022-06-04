Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B553D56F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350496AbiFDE3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350473AbiFDE3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED703C4B4
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id u18so8152138plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Itr786U0bNQsTn9HxoMNJVLfUK0SwX/2+UygpwWJQU=;
        b=HRrqkSj5jFDX3oMdC1b9v6uPAqX/It6MRcEmj5Xxq9SmXB740LQdQ0XK56Rip58K2N
         iyVPOXcR4/24EcInYwZz6mOBPcEyuUfcofWoYnyqNVDsMWiIbjOHIYOFglDE9C8Vk4lp
         n/Br/AdLC8qZp9sQLK4oio+rHwYCvXa+QG81PjO7mVeq6WlUzkKitg0M2ZIWjBkbVzm6
         MMYTJkAXvaU3hKMX5oKllQHiDzyxILYIMnedbAI/49PKj3HIzJdbBYmRFQ/Nmjf17i9Q
         4pqdfmL1YmcR/z9ZEIs6ncfC3OR/gLid8xbqcOAeUD7FGEwXOI2JqCWCUGRvpko9kBC9
         xuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Itr786U0bNQsTn9HxoMNJVLfUK0SwX/2+UygpwWJQU=;
        b=GTZfeHh9b4zMEcdbtks+e1UsCDoT6X39AF+fIJOFihXTgcHjLtbI7SpqJNb10d6MxV
         sgbreDtEYsKlnbd7M1VO3S+8FwQTkyl5LTOHHaXAZGeMVz1g+Mv84fFV5iPM4EL3x9f1
         DAsTkKo/CQdgzikftZ8DbUAKbPamMGdWxV3rdwynhUjTMAC98ffADP4l8fRkSuJyCxZY
         DuADBCLB3p846DYT4uss7bEZX/y0kKH1hk4/KXHA88C1XOmPieQ0HKHyy6cpuX6UIW1G
         B3d+w/gm6Eusw574NfSS3Sc/MMIN+UjRKTVqLvpUopE9HLY9YyKxbrI0YNBIke1pwXoO
         u6Hw==
X-Gm-Message-State: AOAM531x0iJz4v9DHsx+gXdxywgvzaP78KmUNIzDEsVcd6Qn62JF94yH
        QbeyzVnJBt+HftqmNE+Ux3dfXQ==
X-Google-Smtp-Source: ABdhPJwcVD8GDGMqWVcKhZsnjvsdvpCLQ7ZPeHk9MVEH18VB3jqs5x0IRE/k2dPvQfmz6M3PqL0egw==
X-Received: by 2002:a17:902:b683:b0:163:4ef2:3c40 with SMTP id c3-20020a170902b68300b001634ef23c40mr12758423pls.123.1654316945603;
        Fri, 03 Jun 2022 21:29:05 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 04/17] perf arm-spe: Don't set data source if it's not a memory operation
Date:   Sat,  4 Jun 2022 12:28:07 +0800
Message-Id: <20220604042820.2270916-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except memory load and store operations, Arm SPE records also can
support other operation types, bug when set the data source field the
current code assumes a record is a either load operation or store
operation, this leads to wrongly synthesize memory samples.

This patch strictly checks the record operation type, it only sets data
source only for the operation types ARM_SPE_LD and ARM_SPE_ST,
otherwise, returns zero for data source.  Therefore, we can synthesize
memory samples only when data source is a non-zero value, the function
arm_spe__is_memory_event() is useless and removed.

Fixes: e55ed3423c1b ("perf arm-spe: Synthesize memory event")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/arm-spe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 1a80151baed9..d040406f3314 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -387,26 +387,16 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
 
-#define SPE_MEM_TYPE	(ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS | \
-			 ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS | \
-			 ARM_SPE_REMOTE_ACCESS)
-
-static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
-{
-	if (type & SPE_MEM_TYPE)
-		return true;
-
-	return false;
-}
-
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
 {
 	union perf_mem_data_src	data_src = { 0 };
 
 	if (record->op == ARM_SPE_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
-	else
+	else if (record->op == ARM_SPE_ST)
 		data_src.mem_op = PERF_MEM_OP_STORE;
+	else
+		return 0;
 
 	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
 		data_src.mem_lvl = PERF_MEM_LVL_L3;
@@ -510,7 +500,11 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 			return err;
 	}
 
-	if (spe->sample_memory && arm_spe__is_memory_event(record->type)) {
+	/*
+	 * When data_src is zero it means the record is not a memory operation,
+	 * skip to synthesize memory sample for this case.
+	 */
+	if (spe->sample_memory && data_src) {
 		err = arm_spe__synth_mem_sample(speq, spe->memory_id, data_src);
 		if (err)
 			return err;
-- 
2.25.1


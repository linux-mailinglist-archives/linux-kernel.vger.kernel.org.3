Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF36A52D74C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiESPTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbiESPTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:19:20 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D030BC8BF7;
        Thu, 19 May 2022 08:19:19 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id k16so5437673pff.5;
        Thu, 19 May 2022 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT0kkxr3l7Smdfz7QQHdxfYn2KhaYO5/l1cDmP3/Ufs=;
        b=YtuRrPnUI7swcPgA3Zu2ElkHew2HgZl+zsd7IdLtJrBpUuVpRSF2VkFhc2iflGXR2e
         nLoM+Kt7EQ2e8rJAJyYXV1HC3YRv6rRS11b9D3jb+bUURGBWiRBPvKHUW+d4In8HJQLt
         5bSlzNt6FS0vprUh3t5O35ifXy6YSrDOkYKRPY/ahydyRJfOVT561Jq4K3GobNYtm4LN
         o9ei7ED7kb99tdPTWKJ/BeW/7Tdip3b+uBOKcYiBTAFO6cRXxc8ZH00ip0vRr/gHnBdw
         VU8AjyeChVuZxRO/QnQSMK0e+TVWDpoQ3pjobRxZ0/LV1HpNDxfaU+RJtAaH2AwKDHBN
         6WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZT0kkxr3l7Smdfz7QQHdxfYn2KhaYO5/l1cDmP3/Ufs=;
        b=eKfvpCnfTsma/r2TySKtsBvvCUV9v5KmP3NaG5ebfOgOqu+e9VV5hqRJy9Z3W0pwAN
         JAunmYIzAA1mOqGiD6u/wgzNQJ6PL6MLeBKQt9pH7EdGCin4+y1mzzQyJl6BGTxlhgWG
         y+Wp881uCiFAAnWWCVT6Hb5MxHfQxDVVP17OMrx9rLLWvY0hr/xLZG5GmtB7fFozwjVZ
         g7sqBCDOKV3hcHpPwjeqJ1ctjPEtKXs3t7OL/qxGiDtAcykcrOzX2xLzbmsy6Pn4kZsV
         iljc5duQtx4i6zQNACTWPj/1Lb+N9EdbXA/RABqDwZDHcdzVD0EWLJbbdvCkSkzEru1f
         ObuQ==
X-Gm-Message-State: AOAM533n4oamrpxMR3KQf4LDfC4SOZsR7/2p63ziQLq91vsCf7TevAj6
        P8goVcbbEb6hvUnrdeJjYYw=
X-Google-Smtp-Source: ABdhPJzOrS+WKCfgn7ft56kSqt+DA5VzlJnQ4qMcPoRVulIbVbZTqqOqHiS3hZwi5a/A2e1N+6K/HA==
X-Received: by 2002:a63:6b86:0:b0:3f6:6563:f222 with SMTP id g128-20020a636b86000000b003f66563f222mr487857pgc.3.1652973559348;
        Thu, 19 May 2022 08:19:19 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.83])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090ac90800b001df54afccb3sm3676540pjt.6.2022.05.19.08.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:19:18 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/events/intel/ds: Enable large PEBS for PERF_SAMPLE_WEIGHT_TYPE
Date:   Thu, 19 May 2022 23:19:13 +0800
Message-Id: <20220519151913.80545-1-likexu@tencent.com>
X-Mailer: git-send-email 2.36.1
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

From: Like Xu <likexu@tencent.com>

All the information required by the PERF_SAMPLE_WEIGHT is
available in the pebs record. Thus large PEBS could be enabled
for PERF_SAMPLE_WEIGHT sample type to save PMIs overhead until
other non-compatible flags such as PERF_SAMPLE_DATA_PAGE_SIZE
(due to lack of munmap tracking) stop it.

To cover new weight extension, add PERF_SAMPLE_WEIGHT_TYPE
to the guardian LARGE_PEBS_FLAGS.

Tested it with:

$ perf mem record -c 1000 workload
Before: Captured and wrote 0.126 MB perf.data (958 samples) [958 PMIs]
After: Captured and wrote 0.313 MB perf.data (4859 samples) [3 PMIs]

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Reported-by: Yongchao Duan <yongduan@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
---
v1: https://lore.kernel.org/lkml/20220519104509.51847-1-likexu@tencent.com/
v1 -> v2 Changelog:
- Use the PERF_SAMPLE_WEIGHT_TYPE instead (Kan);

 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 21a5482bcf84..1ca6200ca135 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -136,7 +136,8 @@ struct amd_nb {
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
-	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE)
+	PERF_SAMPLE_PERIOD | PERF_SAMPLE_CODE_PAGE_SIZE | \
+	PERF_SAMPLE_WEIGHT_TYPE)
 
 #define PEBS_GP_REGS			\
 	((1ULL << PERF_REG_X86_AX)    | \
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E86B4FF391
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiDMJfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiDMJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:35:28 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F853E33;
        Wed, 13 Apr 2022 02:33:08 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bg9so1273716pgb.9;
        Wed, 13 Apr 2022 02:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71rejMLUOpE9jq6515Gy00CkulFrob9qebd7+EUnqFQ=;
        b=R0+gpZkREyDs1i9PSyA6T9OmKO18FnN82EapnK44lsAXWBIIvUDjjantw+t/ZbT/lo
         kTyErA6DZx4l8ssmupcZ0WJoS1YUcmgGQSqoYMq2d0DiaBz9nxATUGo2SxVEfORD4NRc
         MlLSLxvFjSnR161Ee+mTKh0DbK5nvI+ZlsldZDjHvNeAvpEpOF9ceX+xBw/Iw8+g/qSq
         OlZ7OHk1GwUx4mC6FLB2J/ksBD9lbL2C3yH17bwc4779ALvCxw0YqLb6xFJoNgj+JBVp
         CLh0ECVEF3fsmwx1Cgcvy8QNKv2uI3Kn0lG23XP4Q/7TRnCGXIGHAyhk7fXNr+dZ7uXI
         S5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=71rejMLUOpE9jq6515Gy00CkulFrob9qebd7+EUnqFQ=;
        b=0CigAMzbO3c8dX/XaWCdjYaG9UWkZOW+Vt0Q2o9BBvEvrCpjeLkkQ8fdqknLG+a7QW
         Yn24/OG7zE7NiRQfE+ILyCezrkYgdFUrm4YSBo8i+1TeB3ex/fXhhWQkTgMM0dWCUq0q
         iyVf0nAI+WJ++E3qa6/un4JMpOfwYsqlKVL1NtxF9Ngp8A5yPWv41IxBxZmHwPUXeuqK
         RdfJYsmdNlnmW/lt6/FN5EuOrZnHOLzdxqmDpGg7KMZOXzX4LZsMia718t1Lrl20du/n
         HZpnepq0FsWpMtBYMcr0jMWKArVYAuhVwRMuKbgZOMPTPcADgPnacTijhnjtYaStv8Kh
         JaZA==
X-Gm-Message-State: AOAM531vpbtZf8PJuSfl9MOrVNb7slFqaLol+gn3KcPC/4SgC9nlZxjo
        oYGX3GmLzAW0KQPYM6q6MsU=
X-Google-Smtp-Source: ABdhPJyJviGGDXGauLUSmhS1nxXWoDSj3bD5zchrj+1BZ3Yyxk0KclX/bwrUAWptbn+aq4Sgu7WKLg==
X-Received: by 2002:aa7:843c:0:b0:505:7943:63a0 with SMTP id q28-20020aa7843c000000b00505794363a0mr8828509pfn.71.1649842387804;
        Wed, 13 Apr 2022 02:33:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0f0200b001cb6621403csm2332678pjy.24.2022.04.13.02.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:33:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com
Cc:     peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, lv.ruyi@zte.com.cn,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] perf stat: fix error check return value of hashmap__new()
Date:   Wed, 13 Apr 2022 09:33:02 +0000
Message-Id: <20220413093302.2538128-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

hashmap__new() returns ERR_PTR(-ENOMEM) when it fails, so we should use
IS_ERR() to check it in error handling path.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 tools/perf/util/stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index ee6f03481215..817a2de264b4 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <linux/err.h>
 #include <inttypes.h>
 #include <math.h>
 #include <string.h>
@@ -311,7 +312,7 @@ static int check_per_pkg(struct evsel *counter, struct perf_counts_values *vals,
 
 	if (!mask) {
 		mask = hashmap__new(pkg_id_hash, pkg_id_equal, NULL);
-		if (!mask)
+		if (IS_ERR(mask))
 			return -ENOMEM;
 
 		counter->per_pkg_mask = mask;
-- 
2.25.1


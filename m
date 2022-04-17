Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D975047C4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiDQMsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 08:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiDQMsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 08:48:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F2EBA
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 05:45:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y10so5362818ejw.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0NpqGl1oKuCDKK6YqMWlHFLPk05EK6v3fjoJIR9AXE=;
        b=fy3aoVSpwgXrwvuWPVrID/wRU5DAyDrjgPET4pnQzlQkWUzL/6IHK75YRxiU9gB8UK
         eQMrqDymbyy58EHlQubtSZwd1rpkx919MmPUScKBpIJ4uzDACjv87qWFpE1Nzk393F6H
         /eAg4/6fMcxBQIZTUgoE/oKtnlFL/whOe8X55JU84NZaPsIr9UqKOm4MLzi4nW0yVoTA
         tcpAQO61px1Ub4W4ryNnzCmHd3fJCBj5wS11rLSjhHv1mscepcCAEeSweRoexjBHr55E
         JeVKlFq7i6IjC3hhpxU+u8vpjCwvNKy8TIPU5kyXY1G9xmiaBLOFdxgyEhd2GCcai9wJ
         9mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d0NpqGl1oKuCDKK6YqMWlHFLPk05EK6v3fjoJIR9AXE=;
        b=txgvkiCXYdcMdTyngqfYNaKUtUuc6P/7vT7C5Os/7rsNmCIqrX9BVKzy9Jhaw+79Kf
         eJC8OkDBSZdruCO3NWwO50zPmo2xrSfnkJpT+bEGtZ/AEPaZDtblxjb7ZF0FNB+rYn7F
         XuyGBmCnEZqYEyUEcdjOcF5ebeje8gI6UoaWacgQSnxQJ3JYDbTeOrNDq55H+kQ80sqV
         HAm5MXrwJCj70q3VWMmJwZxwVaJsG9ARjaUR/5TZuDW3F3SIu/dnoovFh8NeVCi2M30K
         fauLNklij7n1oaBqHeEmSN8LG6cgN1Ew8XX5O2Z1/i1Wqmsm7tXR3Y7Jm1+9XlPu7HV8
         gu8w==
X-Gm-Message-State: AOAM531Z7jTIm5GuFsmuAyGpBruScemdq8ZoRz57iBJYebaVn5hpjgB5
        Gco5cdk0IbcGrEuVDiSkh4cgYw==
X-Google-Smtp-Source: ABdhPJw8J7hshp/T+PkBbUWSdEGyBv+bsgA/yAvMw1/l87P9f/Wd4fOR8sTbzNaiX4sjBSIbLxAwgQ==
X-Received: by 2002:a17:907:6d10:b0:6e8:8fbc:310c with SMTP id sa16-20020a1709076d1000b006e88fbc310cmr5455154ejc.530.1650199536410;
        Sun, 17 Apr 2022 05:45:36 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id ee17-20020a056402291100b0041fe1e4e342sm5485527edb.27.2022.04.17.05.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 05:45:35 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf mem: Print memory operation type
Date:   Sun, 17 Apr 2022 20:45:24 +0800
Message-Id: <20220417124524.901148-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
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

The memory operation types are not only for load and store, for easier
reviewing the memory operation type, this patch prints out it.

Before:
  ls 14753 [011]  3678.072400:          1      l1d-miss:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
  ls 14753 [011]  3678.072400:          1    l1d-access:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
  ls 14753 [011]  3678.072400:          1    tlb-access:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
  ls 14753 [011]  3678.072400:          1        memory:         88000182 L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])

After:

  ls 14753 [011]  3678.072400:          1      l1d-miss:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
  ls 14753 [011]  3678.072400:          1    l1d-access:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
  ls 14753 [011]  3678.072400:          1    tlb-access:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])
  ls 14753 [011]  3678.072400:          1        memory:         88000182 |OP LOAD|LVL L1 miss|SNP N/A|TLB Walker hit|LCK No|BLK  N/A ffffa7c22b4b2a00 [unknown] ([kernel.kallsyms])

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/mem-events.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index e5e405185498..f8f234251f92 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -314,6 +314,30 @@ static const char * const mem_hops[] = {
 	"board",
 };
 
+static int perf_mem__op_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
+{
+	u64 op = PERF_MEM_LOCK_NA;
+	int l;
+
+	if (mem_info)
+		op = mem_info->data_src.mem_op;
+
+	if (op & PERF_MEM_OP_NA)
+		l = scnprintf(out, sz, "N/A");
+	else if (op & PERF_MEM_OP_LOAD)
+		l = scnprintf(out, sz, "LOAD");
+	else if (op & PERF_MEM_OP_STORE)
+		l = scnprintf(out, sz, "STORE");
+	else if (op & PERF_MEM_OP_PFETCH)
+		l = scnprintf(out, sz, "PFETCH");
+	else if (op & PERF_MEM_OP_EXEC)
+		l = scnprintf(out, sz, "EXEC");
+	else
+		l = scnprintf(out, sz, "No");
+
+	return l;
+}
+
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
@@ -466,7 +490,10 @@ int perf_script__meminfo_scnprintf(char *out, size_t sz, struct mem_info *mem_in
 {
 	int i = 0;
 
-	i += perf_mem__lvl_scnprintf(out, sz, mem_info);
+	i += scnprintf(out, sz, "|OP ");
+	i += perf_mem__op_scnprintf(out + i, sz - i, mem_info);
+	i += scnprintf(out + i, sz - i, "|LVL ");
+	i += perf_mem__lvl_scnprintf(out + i, sz, mem_info);
 	i += scnprintf(out + i, sz - i, "|SNP ");
 	i += perf_mem__snp_scnprintf(out + i, sz - i, mem_info);
 	i += scnprintf(out + i, sz - i, "|TLB ");
-- 
2.25.1


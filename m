Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFA53D573
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347660AbiFDE3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350443AbiFDE3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9103438797
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w21so8612125pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jgh8b65aqfDEBjEikwGcRqaRvkh9OcNpE8mI3ojB+kM=;
        b=eHTIYKX2niB3+hcP6wkl/Ab0BStnMoeg6znyPP0NaviP8TEk/n7XNEUbjNJHOoiV0n
         gJSIq3ZOnqSw54Nzk3eGDl9fjqiBsVuv+4wTU2DlZd3BrMMHTqzzlPldz5VKkmgHb+qr
         VEsXHpvbgSsRe+y+fQuiEPji+bh9d338QBs9CDUdFo7QI5wETtkfmjUUBV26AAceXmkt
         uazuORxQrtqXGo7ynlBx/2OC7eJX0vcjrQ61Z34G1PdzSuqGjf6CLdl7y+HwGhF/LMMa
         AQUrEADwLrrk3qDIBwGWyozxWRA8M+tCPmxMhOBea54xatxhUXFjlgSnlIPjQiCaQhn3
         Rv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jgh8b65aqfDEBjEikwGcRqaRvkh9OcNpE8mI3ojB+kM=;
        b=4V+sZ237Y50uOhEQHvm3UwEf2lUFXN1tdzA/rsniz5HHZIk9S57Wn08A9dWT9at0Oc
         WgeukPNXBQORv76ShZt+z57UXDb2HImfmhKz/dmamBe0pRkWrJIPK+pJDbzWqDRmJXEh
         6hI0KfOhri6ZFQgOe11NStZDfwALA4dbZfV1zTz+rzsOIaqsndIhV/W3xj5ATd1q5L5b
         ojxSE08AhdmViyt015XmcU5LD3w6gYwyXyLFTn7XpTzawUqFivddRlmSeJo9kPORJ1dN
         SefXW4+D23DqmjVQcLFKe7gjqEBEsbA5sAPxWl3+Q6LjWkP/5QPnbpFNE7/PosvX8c0x
         MTCQ==
X-Gm-Message-State: AOAM533Rs1DKPhrt3+47g0reDiR6pAiHEx/sOrJUOhX3/vwTTBoVRgrf
        //tSurtKuX+XHQTlGqjJ9oh+JA==
X-Google-Smtp-Source: ABdhPJzAquLSZIkdXHtL/r22pGnyGKY54qLAVIemNxP5n+EXK/Qmnar4Uj4qudeFDUO32PighxLreA==
X-Received: by 2002:a05:6a00:15cd:b0:51b:c838:127c with SMTP id o13-20020a056a0015cd00b0051bc838127cmr11301457pfu.30.1654316940169;
        Fri, 03 Jun 2022 21:29:00 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:28:59 -0700 (PDT)
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
Cc:     Leo Yan <leo.yan@linaro.org>, Kajol Jain <kjain@linux.ibm.com>
Subject: [PATCH v5 03/17] perf mem: Print snoop peer flag
Date:   Sat,  4 Jun 2022 12:28:06 +0800
Message-Id: <20220604042820.2270916-4-leo.yan@linaro.org>
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

Since PERF_MEM_SNOOPX_PEER flag is a new snoop type, print this flag if
it is set.

Before:
       memstress  3603 [020]   122.463754:          1            l1d-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          l1d-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1            llc-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          llc-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          tlb-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1              memory:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP N/A|TLB Walker hit|LCK No|BLK  N/A               aaaac17c3e88 [unknown] (/home/ubuntu/memstress)

After:

       memstress  3603 [020]   122.463754:          1            l1d-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          l1d-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1            llc-miss:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          llc-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1          tlb-access:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)
       memstress  3603 [020]   122.463754:          1              memory:       8688000842 |OP LOAD|LVL L3 or L3 hit|SNP Peer|TLB Walker hit|LCK No|BLK  N/A              aaaac17c3e88 [unknown] (/home/ubuntu/memstress)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
---
 tools/perf/util/mem-events.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index c3c21a9c350b..5dca1882c284 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -410,6 +410,11 @@ static const char * const snoop_access[] = {
 	"HitM",
 };
 
+static const char * const snoopx_access[] = {
+	"Fwd",
+	"Peer",
+};
+
 int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
@@ -430,13 +435,20 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		}
 		l += scnprintf(out + l, sz - l, snoop_access[i]);
 	}
-	if (mem_info &&
-	     (mem_info->data_src.mem_snoopx & PERF_MEM_SNOOPX_FWD)) {
+
+	m = 0;
+	if (mem_info)
+		m = mem_info->data_src.mem_snoopx;
+
+	for (i = 0; m && i < ARRAY_SIZE(snoopx_access); i++, m >>= 1) {
+		if (!(m & 0x1))
+			continue;
+
 		if (l) {
 			strcat(out, " or ");
 			l += 4;
 		}
-		l += scnprintf(out + l, sz - l, "Fwd");
+		l += scnprintf(out + l, sz - l, snoopx_access[i]);
 	}
 
 	if (*out == '\0')
-- 
2.25.1


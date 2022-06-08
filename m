Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01A5427AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245015AbiFHHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352606AbiFHGQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:16:11 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C02E102765;
        Tue,  7 Jun 2022 22:51:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so25623300eda.6;
        Tue, 07 Jun 2022 22:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mio4H98TBZiyhR3Y6s7gDVrKgKOCAgzU0ua21Oyqqc8=;
        b=M68WzYv+xAKyLyHNR9dcFOgSiIWourr8cL3AVYp/zEFFXLjWXGyil1FFnRBBuUBa63
         1uPSrVAuSOeSfYGf2OYadBhuWnyD4zKD1ie3BT4NEvgE7EXrgP240inOIqH21Wk0o8lE
         3yUtXcX6i+muMb08Jys5r2o4TrZkgKTg55Ym+lbuHVEloVXpc9vXyfdnqW+NRbA5bYCo
         hNGaxJodNIMf3pn88VOL2YX4iM/YVGAvjSUsnPRhbCMDPqDiMfy8G/jytAV9KmGbFaox
         RC6ox1Yr1BIC3F0JiXKy94/SfHjolqMQntqeSIpjO7O5uYMJyfs/ztL4lGfiyUB7wq0n
         lq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mio4H98TBZiyhR3Y6s7gDVrKgKOCAgzU0ua21Oyqqc8=;
        b=g4k+NkLxe1EuH3Cw+d3ie8Vm1S+QAX1moRqtipBiKo6eFxN1IFQl0aD+00682rqtm2
         2mZ/6WyzJnFClT1opLvpUilm79HVXFmW2hBrk3v9sPRTlOxPKsPlBkgA8anLG3xNkgmG
         9TLqmy3WTYc0Ff5lmcHqQA9QndrNzxYwDrMF0S5AXcN2MHo23Pu23/BVMZUVc2phjdHf
         s8/dN4m0ULxa7cVzit2bRfGc3C8/wWMia6d1FjvGh7U05gCrCPw4XrB/7ShP71Y3b6Tq
         7XjMpd1vguXSccHV2X3v255RxdzoH0eblYP3qTMH6EB238MSmeLiRTCwOb6jmH1v2oSM
         mRKQ==
X-Gm-Message-State: AOAM530EX2VlY5abgpagWLy5tfKW81OyalGpaBjKIk64cprpFd5ajsDa
        fjJODKcyI1hR1prDJow/rvt34/5hnCw=
X-Google-Smtp-Source: ABdhPJy2Q6HOGlFK6VIg9yY00JMqgPHzxVKMj6gHKAoEbNANGUN5xiTOQhmoBgdyI2zZfgS1lYNt+Q==
X-Received: by 2002:a05:6402:14c1:b0:42d:d6f1:ac3d with SMTP id f1-20020a05640214c100b0042dd6f1ac3dmr36724907edx.223.1654667516241;
        Tue, 07 Jun 2022 22:51:56 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id m11-20020a056402050b00b0042dd7e13391sm11576518edv.45.2022.06.07.22.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 22:51:55 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] perf report: Skip symbols for idle symbols
Date:   Wed,  8 Jun 2022 07:51:46 +0200
Message-Id: <20220608055146.1446-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Displaying idle symbols is rather useless and makes reviewing "real"
symbols harder. perf top already skips them so perf report should
probably do the same.

BEFORE

# Overhead  Command          Shared Object          Symbol                             
# ........  ...............  .....................  ...................................
#
    75.04%  swapper          [kernel.kallsyms]      [k] arch_cpu_idle
     1.05%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___inval_dcache_area
     0.78%  ksoftirqd/0      [kernel.kallsyms]      [k] __netif_receive_skb_core
     0.75%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_table_lookup
     0.58%  ksoftirqd/0      [kernel.kallsyms]      [k] __dev_queue_xmit
     0.56%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_start_xmit
     0.55%  ksoftirqd/0      [kernel.kallsyms]      [k] __skb_flow_dissect
     0.53%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___clean_dcache_area_poc

AFTER

# Overhead  Command          Shared Object          Symbol                             
# ........  ...............  .....................  ...................................
#
     4.21%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___inval_dcache_area
     3.13%  ksoftirqd/0      [kernel.kallsyms]      [k] __netif_receive_skb_core
     3.01%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_table_lookup
     2.32%  ksoftirqd/0      [kernel.kallsyms]      [k] __dev_queue_xmit
     2.23%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_start_xmit
     2.21%  ksoftirqd/0      [kernel.kallsyms]      [k] __skb_flow_dissect
     2.13%  ksoftirqd/0      [kernel.kallsyms]      [k] __pi___clean_dcache_area_poc
     2.00%  ksoftirqd/0      [kernel.kallsyms]      [k] eth_type_trans
     1.86%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_poll_rx
     1.73%  ksoftirqd/0      [kernel.kallsyms]      [k] __local_bh_enable_ip
     1.63%  ksoftirqd/0      [kernel.kallsyms]      [k] fib_rules_lookup
     1.61%  ksoftirqd/0      [kernel.kallsyms]      [k] bcm4908_enet_poll_tx
     (...)

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/perf/builtin-report.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index afe4a5539ecc..7e31af009d44 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -316,9 +316,12 @@ static int process_sample_event(struct perf_tool *tool,
 				     &rep->total_cycles);
 	}
 
-	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
-	if (ret < 0)
-		pr_debug("problem adding hist entry, skipping event\n");
+	if (al.sym == NULL || !al.sym->idle) {
+		ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
+		if (ret < 0)
+			pr_debug("problem adding hist entry, skipping event\n");
+	}
+
 out_put:
 	addr_location__put(&al);
 	return ret;
-- 
2.34.1


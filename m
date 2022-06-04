Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB6153D578
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350511AbiFDE3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiFDE3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:24 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8E38797
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:23 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id cx11so8736398pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8Ap7FR359+LVmOW7dWyoVzLBfvKdGYXWerLwv/ikLM=;
        b=TPHCrVO1/y3Q2tZD3YRceWQi3hi3GcxlLJWeyI2NA7bT1CenfZ5kbsmlv8uKCWYRW0
         M2MBjc9t6osl4+RB6J9n9QtzlFGSy7Hy4pJhoTnebNhwZ4dV1DI5MintAc13KAD+UBQG
         kJWkwQTrqUAdvO31Azw4zhmylMX7IOWbQHM6bWrbDb/QL8gyoOzfgDK9vsMRfHnWPNJR
         9K5EYEudHvWD+pfoH+5CqMkn+cedzllkmnx1otoe+kj9GwwRnytAl4A4bkAF5x12LFWv
         QncNRlM+AWDDjBUAJvq/k89lV7aJfDCHyhYeHDHiNj+1WztP3UFmbXPVw8eLktXyqbQG
         lPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8Ap7FR359+LVmOW7dWyoVzLBfvKdGYXWerLwv/ikLM=;
        b=0QdhM3ANRrD3IcLgE1l2XQkdENR0wpsSl3SjZz8uGrCGm4RYpKK+t1d1K3d48aTZO2
         e+0ZQWCA4ajXNVs517wEzgUa3KsVHkKbADY8QgT7ARRjsuaPXSQY37YREm57ghsGzNhQ
         OoPY9IhRbVx+P4c4SGVDdPuEcDcMb6D7dx/TRQrqEEtt7jrtQW/s9AIWZSeh1Gc8n+pe
         Chp43ZaCxstLyep03OUfInzEn6TsdT4OF2XSfRAy8VuCqdDAeZDuIpsp4zVhT2kojgHd
         S9AU6VfeY6+KLmV7u8XWMhN5dC2VPc46QgLK+lgIwON3Q1Vz9Vpl0JNqhAymjpHIHh8/
         SuOA==
X-Gm-Message-State: AOAM531C8W3njHvmVNuPSL8WDpxi7/1SRHS9fWMF2ZirsOI7nZM+yAys
        DlqH1IaKbpE8MUCMFxwF25XFjg==
X-Google-Smtp-Source: ABdhPJxxYRt3x8gx/ICRCeLcEppFaWtqoPMk/6x7MxTBELCPfaApUfWHdyrdE/CoUy7jpcbR9w0m1Q==
X-Received: by 2002:a17:90b:4b02:b0:1e2:ff51:272a with SMTP id lx2-20020a17090b4b0200b001e2ff51272amr14173646pjb.56.1654316962610;
        Fri, 03 Jun 2022 21:29:22 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:22 -0700 (PDT)
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
Subject: [PATCH v5 07/17] perf c2c: Output statistics for peer snooping
Date:   Sat,  4 Jun 2022 12:28:10 +0800
Message-Id: <20220604042820.2270916-8-leo.yan@linaro.org>
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

This patch outputs statistics for peer snooping for whole trace events
and global shared cache line.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 4898ee57d156..37bebeb6c11b 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2202,6 +2202,8 @@ static void print_c2c__display_stats(FILE *out)
 	fprintf(out, "  Load LLC Misses                   : %10d\n", llc_misses);
 	fprintf(out, "  Load access blocked by data       : %10d\n", stats->blk_data);
 	fprintf(out, "  Load access blocked by address    : %10d\n", stats->blk_addr);
+	fprintf(out, "  Load HIT Local Peer               : %10d\n", stats->lcl_peer);
+	fprintf(out, "  Load HIT Remote Peer              : %10d\n", stats->rmt_peer);
 	fprintf(out, "  LLC Misses to Local DRAM          : %10.1f%%\n", ((double)stats->lcl_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote DRAM         : %10.1f%%\n", ((double)stats->rmt_dram/(double)llc_misses) * 100.);
 	fprintf(out, "  LLC Misses to Remote cache (HIT)  : %10.1f%%\n", ((double)stats->rmt_hit /(double)llc_misses) * 100.);
@@ -2230,6 +2232,7 @@ static void print_shared_cacheline_info(FILE *out)
 	fprintf(out, "  L1D hits on shared lines          : %10d\n", stats->ld_l1hit);
 	fprintf(out, "  L2D hits on shared lines          : %10d\n", stats->ld_l2hit);
 	fprintf(out, "  LLC hits on shared lines          : %10d\n", stats->ld_llchit + stats->lcl_hitm);
+	fprintf(out, "  Load hits on peer cache or nodes  : %10d\n", stats->lcl_peer + stats->rmt_peer);
 	fprintf(out, "  Locked Access on shared lines     : %10d\n", stats->locks);
 	fprintf(out, "  Blocked Access on shared lines    : %10d\n", stats->blk_data + stats->blk_addr);
 	fprintf(out, "  Store HITs on shared lines        : %10d\n", stats->store);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A5558F78E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiHKGZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiHKGZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E94647B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s206so16352916pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lGL3k6KMKNuuvCiNMMqmkjK+KHFue89a80+crwcLhLw=;
        b=siYZ7oObouKZe+Tl/6XzHMY3IpQsgRALZu6IC0Yq2QRYGRPKc6zd+acOHHNfQEceRR
         mkymjyUwE68caQrNDICPSDsBgi0gtE3nzFiS1BJGNH7dL3VYnyqYczi3RaGBtIf+0eFa
         Gj8Nzw6UYtQYUyGotMrfhRQtvIezVexYBIkvb4jrrnRRrtEIAjoyPjprNa8F8VATt3po
         pPfdiUnxmI/zfhJOMdHzXShRJt13bdxU6Od3zm5BRdemmVeBRfyBhAZ2HgokdOznSX+f
         +Pj+HwQbfUxAyUp3v+IHroS/VDLpyfvfRwl3pMrGtvuK/NDwN9JrjtP3Ut3rUkG2dGhl
         JCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lGL3k6KMKNuuvCiNMMqmkjK+KHFue89a80+crwcLhLw=;
        b=X+6ejbDFR4iDhVnRY106sIRNj17++T/Rd9pzBoovwEjEBRdYtS+sZoM4NdGe55K2u7
         kT+lQwMPfHUBJbZyHtr3j+/UFr4PM+NWrG5qHL4sa/cjfWr7qWzYVbMlPNsHKxXbb4bj
         h3TsFvNL01NV9E/WmC2DeXeBd/cdbFZmKprnpvQu9FqWs/FI7kBZv5mZEF3hU9BR9ST6
         Yy82OhrQyUSbL5iWIDD5XXsFjkkzu5FvY+/6astRYVE9JuJx/SXdgTgCngsFro3CKyuE
         21JQpk/ipvDJXwzHP68TTx4C+xtUu6tdVg2OYZXTjllFNWjHpbc2ClTm2sxd2IjUoG3H
         2cIg==
X-Gm-Message-State: ACgBeo37vRiezQIptM9eAbExdfqlyx5GW9dcSyBtzpyO+3SOA8MyOyro
        L90zBPjDypV/7ftb34L2cz0RFw==
X-Google-Smtp-Source: AA6agR5Cyo4gGNQg0rN+ywPMpC98QtzuyaxEieKzNGXrILRnjv3itrOud8aM2347BC0GsxQ+WH/bSw==
X-Received: by 2002:a62:544:0:b0:52d:946c:b884 with SMTP id 65-20020a620544000000b0052d946cb884mr30025243pff.72.1660199111736;
        Wed, 10 Aug 2022 23:25:11 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 01/15] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Date:   Thu, 11 Aug 2022 14:24:37 +0800
Message-Id: <20220811062451.435810-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
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

From: Ali Saidi <alisaidi@amazon.com>

Add a flag to the perf mem data struct to signal that a request caused a
cache-to-cache transfer of a line from a peer of the requestor and
wasn't sourced from a lower cache level.  The line being moved from one
peer cache to another has latency and performance implications. On Arm64
Neoverse systems the data source can indicate a cache-to-cache transfer
but not if the line is dirty or clean, so instead of overloading HITM
define a new flag that indicates this type of transfer.

Signed-off-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
---
 tools/include/uapi/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 4653834f078f..e2b77fbca91e 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1310,7 +1310,7 @@ union perf_mem_data_src {
 #define PERF_MEM_SNOOP_SHIFT	19
 
 #define PERF_MEM_SNOOPX_FWD	0x01 /* forward */
-/* 1 free */
+#define PERF_MEM_SNOOPX_PEER	0x02 /* xfer from peer */
 #define PERF_MEM_SNOOPX_SHIFT  38
 
 /* locked instruction */
-- 
2.34.1


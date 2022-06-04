Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93F53D56D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350467AbiFDE3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiFDE2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:28:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B31A37016
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:28:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so13523593pjl.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1GFA/G2sq7Z7tV5kUwDR4JNQSunfwujtW0Pzethicqk=;
        b=dd5N4KgOOFen57SswJKMlpRQyZoOXZwv6XG6ilJNw4tVJiHvKVjis+OTi+zzt+nGwQ
         kIByE3Gg9CVnPsWv1hLXqeQPZuryFe3qt9EHPKnlhynd7asQ64gBQl1upPd2aITKm/uy
         VxGaUvrXSMrlwgz9bzYyTLjDkIBewZ/kYvJti5UVfHFet/C/gIk+ipcclx0vmHcKyUhw
         52n3cOlRbwBqkcbYLGXDyQKXyZmstWrYuwxa9+1eqE9ea8yHRJ+K9GOIWj1a2Xrs+37z
         lqdtJVAxGQWQyg//p6/dYRrrC7Wn2YtAtbotdUARaXJAxdqkI1qFLvT46dkDxDGEMXsW
         bNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1GFA/G2sq7Z7tV5kUwDR4JNQSunfwujtW0Pzethicqk=;
        b=ZlO4wqkvnCnCvxJXvnQLvlVW9m3ci5lNVP6H/P+znVtky1dTLrX8Hvxb8uvQQ9e4BT
         NE232QjusDaOKsnKWzhrgAv1MlsmMLGHb9J+9jwFmDI+v7P0kjkYwv/CwEuQLiRCdvT4
         z8YDNmZFxfZ6gAExBLabhpq+zGOCFbJd1ALgETE07+0Fclr8UABo+2z7m6e+rjYW5gql
         8q3NRwX50tZPb5Nex4KKddtQq7dXNNOq2WBdGSiI8NdXqjyjf7OpapM0llC/IMRRynar
         hfhFX+XsuK9iRU6HZTpnJbvwYQ1YythUvHedTSsbzg51Pnzc1exJ0zDNiEtN1zKYX9P8
         26zQ==
X-Gm-Message-State: AOAM5303abq8hUiu/NWRuLZINwUGYH+R0Ro4ZC/ekMTEwxLfhSf/G6zd
        e8EuuI47UDGzZ83wnBelEbPf8w==
X-Google-Smtp-Source: ABdhPJw+tOYyDFUf+277NXZH+SE7nfaTTpIOiGfuiMRFRQJf1KdhW3jfVV02quE2xe+Nks49lWYAAg==
X-Received: by 2002:a17:90a:fd87:b0:1e2:cdfc:cbd3 with SMTP id cx7-20020a17090afd8700b001e2cdfccbd3mr35605758pjb.28.1654316933882;
        Fri, 03 Jun 2022 21:28:53 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:28:53 -0700 (PDT)
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
Subject: [PATCH v5 02/17] perf tools: sync addition of PERF_MEM_SNOOPX_PEER
Date:   Sat,  4 Jun 2022 12:28:05 +0800
Message-Id: <20220604042820.2270916-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index d37629dbad72..7b88bfd097dc 100644
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
2.25.1


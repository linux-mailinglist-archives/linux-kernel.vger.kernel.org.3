Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3965AA083
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiIAT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbiIAT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:57:45 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4B4883D6;
        Thu,  1 Sep 2022 12:57:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id c24so47263pgg.11;
        Thu, 01 Sep 2022 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=db/ALraqmP8bgCYrW21ZT7akOd/xlQBQhbt9mvTG2TE=;
        b=oXuXqM+8utkNlBWMslw5SNT9QFBA/xgxjoPqcI+S1z7LiiLr4oLlGZ3tC9rAF6H0cE
         zdQVlcrpOPTJNj4JL2q+jBVUiTF9jFCD7+xJ7iAtL8Ecgg3T7/1NuWy5J/3Ai9+p9RO5
         RAmN7uOph0EuwOIjNT6xJ9eicU/S75CCS8qgmXrLmuj0Cs8SqS+5sReAqfUBdi++Fe6y
         sTIH9ZbgzuJmu9ANjRT0oZIf8W9p8x+HaAA4s7YJQsssiZ49UHNJ9YnGY+9yKyFyteUu
         7G2K9iwD3LNkMHIF0irPfXrnevNLAkhASpG+atBFSt8IC/KyUF1ooCXMvwcY+isolLJ8
         PDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=db/ALraqmP8bgCYrW21ZT7akOd/xlQBQhbt9mvTG2TE=;
        b=d5/AQKwnAnvbeUXD2zCoKHXioRwsNrubOKKkKAVvkZcgFL/W3R4fXJQEyr4D+kBLJ3
         TBpBs9A1iYnPwE8gLdphgXRaEz33txDnUGXESsU8kP9Z+jc19dhcp6Ad3YAy1D7Hwim8
         eRmBEe3CEQkCitX09wSCiuIpkwSgDkJACVk+pQojSzSdClflmUWxgCQ0N5nwRWipy1gA
         7QifTsFcTqYA+zptn8Qs1seHuVvWD9kOG1zs3srXMnQwDaifcc9aqMPaG/bPTFyNNDnu
         R/d5z5mc0vqgTlDrDpKK9jb6YOTY+jX32uIpG/6xxSWga/CqP1SWLOI5OImR2rjvCVgi
         HxXQ==
X-Gm-Message-State: ACgBeo2ASF0V05S+EDQkdw9+qhb7cftle+QYSnpYgv4esjIbvbBAUHZo
        X/icEGiErezhPpbiXP0xPBPKq7HnnMw=
X-Google-Smtp-Source: AA6agR7+YpSkZLfcLSxsA22CCZq3GDrCvWlYYfu5fxneWKerYpaAGY96RCVvOfdOIaWpxDj6t76zMw==
X-Received: by 2002:a05:6a00:1691:b0:53b:3f2c:3257 with SMTP id k17-20020a056a00169100b0053b3f2c3257mr127360pfc.21.1662062263789;
        Thu, 01 Sep 2022 12:57:43 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:87ff:65c0:eb6a:d2b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fb23c28e9asm3728500pjz.2.2022.09.01.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:57:43 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/5] perf tools: Print LOST read format in the verbose mode
Date:   Thu,  1 Sep 2022 12:57:35 -0700
Message-Id: <20220901195739.668604-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901195739.668604-1-namhyung@kernel.org>
References: <20220901195739.668604-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that we can see it with:

  $ perf record -vv pwd
  ...
  perf_event_attr:
    size                             128
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    exclude_kernel                   1
    freq                             1
    enable_on_exec                   1
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/perf_event_attr_fprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 4b0db27b7199..7e5e7b30510d 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -64,7 +64,7 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 #define bit_name(n) { PERF_FORMAT_##n, #n }
 	struct bit_names bits[] = {
 		bit_name(TOTAL_TIME_ENABLED), bit_name(TOTAL_TIME_RUNNING),
-		bit_name(ID), bit_name(GROUP),
+		bit_name(ID), bit_name(GROUP), bit_name(LOST),
 		{ .name = NULL, }
 	};
 #undef bit_name
-- 
2.37.2.789.g6183377224-goog


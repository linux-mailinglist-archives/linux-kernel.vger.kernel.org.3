Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544CA5A87DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiHaVED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiHaVEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:04:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9EEC4FC;
        Wed, 31 Aug 2022 14:03:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l5so11381432pjy.5;
        Wed, 31 Aug 2022 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=db/ALraqmP8bgCYrW21ZT7akOd/xlQBQhbt9mvTG2TE=;
        b=BQhyBGB+TaHIpwhlilcAY22pHxzQzJpIZjFcqP7OV589Nx94IRtS/MEePXmQhFayYa
         ORFwzhmDAaN3YxwSMHXUO7XU3lT8QWwEWsUrlahMHWbyMu4LtbSrzoWdYjXDL+JTIAfh
         phhCKp1M81dy3HURbTAONRfWMdlO9b3Uo0OB7TX03Fp/axyTAXLBHNphGkPJRihOCYAf
         D31nwbrOQJaG5GEdJctcmTBMa9cKE2dE5ylSOQXiiiAwFAem8Lu7u7vkg+sJmf/pGHa/
         yv3uoGBVeyKqYkSQrhqBkN6a6npMWlmjTVX9n8hn08TUfkeebPFLjRTzhtvKxkRLNIsT
         aDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=db/ALraqmP8bgCYrW21ZT7akOd/xlQBQhbt9mvTG2TE=;
        b=Jy4bvKTrb982uJk3lIqsHRMCOdeHk8z/GVstDHvi0RoO/pi4rsgBwF2miMaCGcTNiE
         jBUUV3zF0+c/FY+xwO90o5nEDhfg6yHQyhq6doxMBjdgo6UqGSg8K0o+RuxkaxLykvA0
         fg0efILQUnzWPFkU1gBgGUYRGBnC6vQhnI4qU42rjAYoNvoJGDPNR4TTmKfHBdizsdKf
         pIBaFFWW3qDtP5zKOnn4G1xZDxOA3vpKJTlUjDTykBi9ojcZ53CZePZXMshKFNbop1yC
         Jp4D9ypcc4hZPgxO2wk/N2fSI+15kIhjcdGDh0/m4HzLfbcCG6agUXuoP7idrKBEFf7R
         Ea2g==
X-Gm-Message-State: ACgBeo2E960AwggxYjU7+19Hg9+j78pdbTxYXtSrHnPacLF2rHTgC8CM
        +4BDXeDevfObn7UNtQMwwig=
X-Google-Smtp-Source: AA6agR4F++o+g1sbAOGmKDHcFrWF58RzT4m3IRz/P7oihwJ8NezfGVWCMhJFuvUDWF+1fEaFFCWF7Q==
X-Received: by 2002:a17:90b:3ec9:b0:1f5:7e38:1fd1 with SMTP id rm9-20020a17090b3ec900b001f57e381fd1mr5050178pjb.101.1661979838987;
        Wed, 31 Aug 2022 14:03:58 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0053ae6a3c51asm528931pfj.186.2022.08.31.14.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:03:58 -0700 (PDT)
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
Date:   Wed, 31 Aug 2022 14:03:48 -0700
Message-Id: <20220831210352.145753-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831210352.145753-1-namhyung@kernel.org>
References: <20220831210352.145753-1-namhyung@kernel.org>
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


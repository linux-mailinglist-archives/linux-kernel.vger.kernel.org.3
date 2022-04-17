Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDB15047AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 13:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiDQLvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiDQLvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 07:51:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7A4344E0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 04:48:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y20so2509865eju.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Sb5MwZlN2yMxpkxo8ReoYsChI1LsnLBd53l7qgtB8w=;
        b=JTBU4huSWjw4WvyksFXfBs27pd8RjBvsyNEFTQzVek49lRGs1jiwoFrXWbVnlsBKlg
         oCy71aLpG2lUS0ALxfq3/6RI6bCm7jOW3mDd9XMt2Iu0caeRjEv3AYCjvKpClOkK6gn2
         1fOcnP9VGPe52CYu8TLDUmntewJg4pxf2GGVdJDp+cZt67aJmf/Z88hHYlVzwy9K7Z2i
         nzvZ3MsP8HL1gIb61hhYbRsb+5n8xEe4/+H6LA9537ePpzyLTqy+9CxNPIlBGSVuJq1v
         0JfILfnGGvUg0jm23ydC8fWxH+022UxHoHyqe+fOVWDl5xPGPrRcLwOycDC4Py4qEFq2
         PVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Sb5MwZlN2yMxpkxo8ReoYsChI1LsnLBd53l7qgtB8w=;
        b=ZGRoIGkOV1vzL0LCBZaA5Dmlv8R2vVJwJrcezL5McqY8UQGL1TMn4N0hptZTJktCrl
         oRSMghA8zLzUGqEdDV8Su03XCcK6q0kmJ2FfjXYxaiLPjS77G33yls9hJNIYuzsvMTDN
         AoMQ55nJc26QUdYZ4CL0co6gGyHR/6T8cvfqLdjlUs54e8pFNMJHOw+jFQ7dmTS019aV
         /E61ZZdfPG6TzwgOjEtXQJ+g+o3V3cXev0Db95yb2C8+HWJPf8pw4B3G96PbdW6jWpUZ
         ZE/82Nn1iJZK9l5SyS4pxaOpekXkwLw/SuqFzikditJ/C4T6JTiVTCxPOUyaYdqCRYrx
         Uz0g==
X-Gm-Message-State: AOAM533ZqL610QcGpATMfra/S4RSosqwbbZSQI1yzJLATURQyglwXaab
        fL3l1OEFKYdcaE8BW/1+v9zd9w==
X-Google-Smtp-Source: ABdhPJywdz0cASNHVewBWwUezqR/0l3LQF0BqQXVnJx7pQzrjX6eK/IeXLoBuBLaSaz4iyUJcASnDg==
X-Received: by 2002:a17:906:dc93:b0:6e8:8d81:b4bb with SMTP id cs19-20020a170906dc9300b006e88d81b4bbmr5526764ejc.32.1650196134186;
        Sun, 17 Apr 2022 04:48:54 -0700 (PDT)
Received: from localhost.localdomain ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709064a0100b006e89334f5dfsm3510574eju.136.2022.04.17.04.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 04:48:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf script: Always allow field 'data_src' for auxtrace
Date:   Sun, 17 Apr 2022 19:48:37 +0800
Message-Id: <20220417114837.839896-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
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

If use command 'perf script -F,+data_src' to dump memory samples with
Arm SPE trace data, it reports error:

  # perf script -F,+data_src
  Samples for 'dummy:u' event do not have DATA_SRC attribute set. Cannot print 'data_src' field.

This is because the 'dummy:u' event is absent DATA_SRC bit in its sample
type, so if a file contains AUX area tracing data then always allow
field 'data_src' to be selected as an option for perf script.

Fixes: e55ed3423c1b ("perf arm-spe: Synthesize memory event")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a2f117936188..cf5eab5431b4 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -461,7 +461,7 @@ static int evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 		return -EINVAL;
 
 	if (PRINT_FIELD(DATA_SRC) &&
-	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC", PERF_OUTPUT_DATA_SRC))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC", PERF_OUTPUT_DATA_SRC, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(WEIGHT) &&
-- 
2.25.1


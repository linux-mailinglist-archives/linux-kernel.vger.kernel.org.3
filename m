Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B134E5BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbiCWXEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbiCWXEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:04:36 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685D2BDC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:03:03 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k14so2424833pga.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AwXd36Kb4ncstiI6jgaf/ZZpqyzrM3OK+6ilNHWSDv4=;
        b=OVOdlRePK2UmF+sNkI30EYWxi1jxPsirLw5AIfUhrpbsSuBjxw16f0ulLHlTvGxw0x
         eDcdmHrq9kRv2F6Ms2neGqqLDaf6xPkpgOg8o00uUcDiF24wJb7jQDJAL/vxvwbO1r9R
         68rS7DPsmegDpjRwa8E+NrFFifRw7+k8AY4prDSGss2JS9mptPSSzEJMmHfn1ZE8QXIO
         uIcIEEMi1ZTpRMyI50NYk6ocD0BuU5IZ4LbOmPIrET1M91mQd0w4dY+YuxtWPje0t2/1
         OTeJtfyDG/9v5qMFfWPddU1s2g7MVZdyYGq7Z67qiK1RtC8jJ3hcKpOOoVzi6AffMQfJ
         Notw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AwXd36Kb4ncstiI6jgaf/ZZpqyzrM3OK+6ilNHWSDv4=;
        b=q6tB9OockCzlmzpFnEYuTD38ML5/F1m0q55mbRoF83tN1ZbTnkCF87HU8lzpndm2z1
         C/mA1Jv0yRIApwv+f5YYmkWU0YpRw0A0OSXaFfkGKVcK0KyDZKU/z8B4gkYJBOrY/5w5
         S4ixG82D2O6FzPeYhtnzXtA9SoEU4GAyUQ4fEywvrQawV/gCfd/CvJL2TzJQhFchMwAE
         6eTmiPRLIgA7OAEduyt6GdLhqGMvCYj9zU5sNZdcSuzW1vaoXdCNk5jEUCIp36aebMj4
         +mGXSD9cHI3B19BQCD/W/CYIuosmSBrm6fS8e3zkJHNgLA6qSgixdZi03SUiqPLfv3n1
         HoQA==
X-Gm-Message-State: AOAM531XZ/h+BbPNsPPWdL2nbACb3ZAyIw/4knvZsWeSFmivLEp1Tnzj
        qZulEAS/xOE1tiZy7ZVgmLNaV7Memuo=
X-Google-Smtp-Source: ABdhPJzD2QCizJnHH8uJtL9YnInm/2y9gIO+XSz87ezQI759qdmsZYESTNkMMaiSA2ifp570PxNvtw==
X-Received: by 2002:aa7:8004:0:b0:4fa:c50c:1ffe with SMTP id j4-20020aa78004000000b004fac50c1ffemr2221339pfi.40.1648076582336;
        Wed, 23 Mar 2022 16:03:02 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:3540:3d99:beb8:c76f:446c])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm637382pjx.42.2022.03.23.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 16:03:01 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/3] perf lock: Add --synth=no option for record
Date:   Wed, 23 Mar 2022 16:02:57 -0700
Message-Id: <20220323230259.288494-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
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

The perf lock command has nothing to symbolize and lock names come
from the tracepoint.  Moreover, kernel symbols are available even the
--synth=no option is given.

This will reduce the startup time by avoiding unnecessary synthesis.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 57b9ebd7118a..1ebff88bc5ba 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -990,7 +990,7 @@ static int __cmd_report(bool display_info)
 static int __cmd_record(int argc, const char **argv)
 {
 	const char *record_args[] = {
-		"record", "-R", "-m", "1024", "-c", "1",
+		"record", "-R", "-m", "1024", "-c", "1", "--synth", "no",
 	};
 	unsigned int rec_argc, i, j, ret;
 	const char **rec_argv;
-- 
2.35.1.894.gb6a874cedc-goog


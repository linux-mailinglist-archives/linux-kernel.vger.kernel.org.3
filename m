Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA995A89D3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiIAAcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiIAAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:32:00 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B340112E4E9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:31:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id t129so16006479pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fvDQMxNZIv6hw6AbESq/vbcgXuymsRN4QUVLdGE1Nvo=;
        b=bvuyxn8QDYEpREdEC0OyjtHGo7RiROSYE6ipfcmbdb0Zn9VTPONozNrWTV0JgdBCC+
         Bx2kWll3Eg24v1Ig9sSgFQ1xWvRM7B5mmBi5lfl21IB1sPFHqEp3/ZzfOcnflmc3h9WE
         TRd6TtN8pySoz4/KT4x3bwZfZ5hTLPw+twnHg3rsuFg8ORTEcwXB8QCYrymUFXTELJzN
         Mo6n3oNBCSwzRDpcbz3NRB/MPUICFXY9c3WuUmTHmNmw0/o2QVY14snMlm9wpSRZFWnA
         +YdZhMSwg/uqMyh5UFplftW1N+d6DTCuT+pgg3GtUTdSOxYGeIojTQ89/MmsvIS9ykPd
         TY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fvDQMxNZIv6hw6AbESq/vbcgXuymsRN4QUVLdGE1Nvo=;
        b=Y9Ne+ct2GJKQ1M9PXnrNwxShbcVTcumZLXWrK/mBO2rr3aEVGk/RtdIvbFMC9+JF1m
         9XhiiqD0mprqYLt/UkijX4anX8E8YJHvUzRCQsyt4Hkwbt+NiwkWbAXkF1CXjlxEav3N
         12CK1DNLzSjIeWx0ldZEqOoZz6vQj595kVJ/sAUNAfPE2QeCZhngQnSFiEw000bCcak0
         /IYusHfVEJAradE7I8w0isRNu6tXBD+7VkjyKRqWutD0F4f266rC9+W3hjobRNEqsWUx
         IWcPUFTiaE+p4I8m5cpF1yml2VV6VHza3mjm4IkETEIIKMmfuKDVRQylIZfd9GlPj1iH
         mQ7A==
X-Gm-Message-State: ACgBeo2TwOGV9t0Z85UqpeDDjQHQAFB++Yg2J0OXRcG0lQSzmfq8C82M
        AZzuT1m+HbkTZuz0bxGEcdOgYgTq/sw=
X-Google-Smtp-Source: AA6agR65Eb3x5vZic2TqYN5/OVxoLVaMV4eQaEE/MiRwXITzS7LwbsfQXqM8y1P6Te20S6bWKIERuA==
X-Received: by 2002:a05:6a00:1991:b0:53a:8bd9:d36c with SMTP id d17-20020a056a00199100b0053a8bd9d36cmr8482205pfl.81.1661992288157;
        Wed, 31 Aug 2022 17:31:28 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id o18-20020a63e352000000b0042c4d257083sm3926930pgj.25.2022.08.31.17.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:31:27 -0700 (PDT)
From:   wuchi <wuchi.zero@gmail.com>
To:     hch@lst.de, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] profile: simplify redundant code in profile_setup
Date:   Thu,  1 Sep 2022 08:31:21 +0800
Message-Id: <20220901003121.53597-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to parse option string "schedule/sleep/kvm" of cmdline in
function profile_setup is redundant, so simplify that.

Signed-off-by: wuchi <wuchi.zero@gmail.com>
---
 kernel/profile.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 7ea01ba30e75..8a77769bc4b4 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -59,43 +59,39 @@ int profile_setup(char *str)
 	static const char schedstr[] = "schedule";
 	static const char sleepstr[] = "sleep";
 	static const char kvmstr[] = "kvm";
+	const char *select = NULL;
 	int par;
 
 	if (!strncmp(str, sleepstr, strlen(sleepstr))) {
 #ifdef CONFIG_SCHEDSTATS
 		force_schedstat_enabled();
 		prof_on = SLEEP_PROFILING;
-		if (str[strlen(sleepstr)] == ',')
-			str += strlen(sleepstr) + 1;
-		if (get_option(&str, &par))
-			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
-		pr_info("kernel sleep profiling enabled (shift: %u)\n",
-			prof_shift);
+		select = sleepstr;
 #else
 		pr_warn("kernel sleep profiling requires CONFIG_SCHEDSTATS\n");
 #endif /* CONFIG_SCHEDSTATS */
 	} else if (!strncmp(str, schedstr, strlen(schedstr))) {
 		prof_on = SCHED_PROFILING;
-		if (str[strlen(schedstr)] == ',')
-			str += strlen(schedstr) + 1;
-		if (get_option(&str, &par))
-			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
-		pr_info("kernel schedule profiling enabled (shift: %u)\n",
-			prof_shift);
+		select = schedstr;
 	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
 		prof_on = KVM_PROFILING;
-		if (str[strlen(kvmstr)] == ',')
-			str += strlen(kvmstr) + 1;
-		if (get_option(&str, &par))
-			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
-		pr_info("kernel KVM profiling enabled (shift: %u)\n",
-			prof_shift);
+		select = kvmstr;
 	} else if (get_option(&str, &par)) {
 		prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
 		prof_on = CPU_PROFILING;
 		pr_info("kernel profiling enabled (shift: %u)\n",
 			prof_shift);
 	}
+
+	if (select) {
+		if (str[strlen(select)] == ',')
+			str += strlen(select) + 1;
+		if (get_option(&str, &par))
+			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
+		pr_info("kernel %s profiling enabled (shift: %u)\n",
+			select, prof_shift);
+	}
+
 	return 1;
 }
 __setup("profile=", profile_setup);
-- 
2.20.1


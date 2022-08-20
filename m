Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3207D59ACA8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbiHTIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 04:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTIdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 04:33:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2EDBCC08;
        Sat, 20 Aug 2022 01:33:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y4so5912183plb.2;
        Sat, 20 Aug 2022 01:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=GXMlBTj8rp/1n/HAGZvUMfQREbty/R31f1moliWBoWA=;
        b=T8HQDdiGofhR2v7BqB3ArKm+chR0aJu0YhKXqtgF9rHeE8kPvQ5CZYUoWAQyg5dkma
         mc7Vr8EtMFf0AnKDfymQZVONZuIocyzqs2gKg2T8b4jiCLNy3a8L3nZH6Pe1LjLQbnZt
         8bWEuTn6ck3SLlq4RbCj6rpgHo7mPsmDmCO3Q6ImciJuDJjjzkMaghJN729MTpwO6yYd
         u7YROk0Jgx748O806xs6zx2oxMD9Xk9rRshe5NaRX4GickiIodDtYQNYMwDITe+iktTG
         Q4vCJp1ozAatF9Y57rocCTh5Viqm0+NQYfCw64knp9UWgKEi5YhzczbypbXO7H8RuzSB
         y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=GXMlBTj8rp/1n/HAGZvUMfQREbty/R31f1moliWBoWA=;
        b=fMiiL6wJJ2Jdl6KTMWeEUYagzfu4/xzTpqHdxjuxoXhRYmkrn8sBu23kz1bsN0xChu
         1YjBpDfvEYHZ5BvR3L66wBnhDhBESbFZLW0IEh6z3Z4hpj/QzMFx/sdtOYrpEWfSauDW
         cKVW+Pa3be8Ba6zD8nGoS7h6zE9F4fzOgSjYrskaxgagMSc7KioG8J6Puzi+jLn/47nd
         vrS0ltslCd6SQZ5hc3SQOp27Lg0ZrUnkR1UGSMyUKvO6RNxSvbH5ydus0nUcrg9fW6GT
         VhmGCpRu1xH0mOSV8CCnz7pW10tGulzc7WhoanLZIlHOIlXu/PhlqmHh73HeqSM2dTgl
         ui7w==
X-Gm-Message-State: ACgBeo18+x0p8vyksoaQMPuxthupts2MGveNBsLPfxq19xrW5DyCk19e
        iJOah9j8ver5p9o90OcE84Y=
X-Google-Smtp-Source: AA6agR5GF0Y5mkSIz6CGZOo1MvejXLJSQwOAWf5XeE1t9MEyHxUYvmdM/d0Dpg0bpAyNv0vRd/PG4w==
X-Received: by 2002:a17:903:32c9:b0:171:2846:eef8 with SMTP id i9-20020a17090332c900b001712846eef8mr11768765plr.117.1660984382172;
        Sat, 20 Aug 2022 01:33:02 -0700 (PDT)
Received: from ccs100203-Sabre-15.home (2001-b011-7006-189e-d048-0cf2-8a80-70a2.dynamic-ip6.hinet.net. [2001:b011:7006:189e:d048:cf2:8a80:70a2])
        by smtp.gmail.com with ESMTPSA id x24-20020aa79ad8000000b00528c8ed356dsm4857614pfp.96.2022.08.20.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 01:33:01 -0700 (PDT)
From:   Shao-Tse Hung <ccs100203@gmail.com>
To:     corbet@lwn.net, paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shao-Tse Hung <ccs100203@gmail.com>
Subject: [PATCH] doc/rcu: Update LWN articles at the beginning
Date:   Sat, 20 Aug 2022 16:32:44 +0800
Message-Id: <20220820083244.28338-1-ccs100203@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

This patch adds LWN articles about RCU APIs which were released in 2019.
Also, HTTP URLs are replaced by HTTPS.

Signed-off-by: Shao-Tse Hung <ccs100203@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 77ea260efd12..682529123b9d 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -6,13 +6,15 @@ What is RCU?  --  "Read, Copy, Update"
 Please note that the "What is RCU?" LWN series is an excellent place
 to start learning about RCU:
 
-| 1.	What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
-| 2.	What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
-| 3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
-| 4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
-| 	2010 Big API Table           http://lwn.net/Articles/419086/
-| 5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
-|	2014 Big API Table           http://lwn.net/Articles/609973/
+| 1.	What is RCU, Fundamentally?  https://lwn.net/Articles/262464/
+| 2.	What is RCU? Part 2: Usage   https://lwn.net/Articles/263130/
+| 3.	RCU part 3: the RCU API      https://lwn.net/Articles/264090/
+| 4.	The RCU API, 2010 Edition    https://lwn.net/Articles/418853/
+| 	2010 Big API Table           https://lwn.net/Articles/419086/
+| 5.	The RCU API, 2014 Edition    https://lwn.net/Articles/609904/
+|	2014 Big API Table           https://lwn.net/Articles/609973/
+| 6.	The RCU API, 2019 Edition    https://lwn.net/Articles/777036/
+|	2019 Big API Table           https://lwn.net/Articles/777165/
 
 
 What is RCU?
-- 
2.25.1


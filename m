Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCD74D730E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiCMF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiCMF4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:56:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E78456754
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:34 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso11637643pjc.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=exfznBY+8JaiqjcDeRUubcAF4qIYlFp8JUbTCkFqZ5M=;
        b=MhMvtLvpQJWvNVTUIsimGCFiMnhO17PlQOSbHa1pVzGpCBXKJSO9eYMDQY99ENqKDO
         z8a0bTEav96SfAg9Xf+JdUs8Qkka9rU3toWCQwDrlPKkjVfSIlTE0MwRLn41dGG9/SWX
         SdpNcu6ogCgiwUxMDPZsNxacJSYUW5kNHb24Im+q2HbgOaE6XR6s+c/SaZYRExm8eO6+
         VeVti0x8MhS/2jZYl90RuUs32iDHks9uJN/fLVRUmTVufw9H7dMyka+aLd/DvuPT3f3T
         qST4L48iIrP2owBmWbfj8DqP1UkcORLJ3DowTTqyygq3slmQJD281ZAt2f9ZeBqrCuoJ
         z4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=exfznBY+8JaiqjcDeRUubcAF4qIYlFp8JUbTCkFqZ5M=;
        b=q5UVBlbBFH1SB2hgj72dvf3EOixoFXfyielm5Xt0myFjryGgwLeb34lij9tes36us2
         Fwt+5Rm79h9zEi8ZsT9xCikaozqgAz2WCEMpIYkDIgwl4s7C2OeVh2EJxYFzwIhnpJ9O
         FK0CA28NXsNd4ekdlfU1LOvK8BDhn38CDGKRYISRd7wsqwoikuNm/tGpmDo2JzBM34Nz
         uGzps7HGL4ae8ROELEA99ih3IoHrWECTf51/dIcqyebPCrufT5ZZyTSQbLN+Bj0H+sgR
         kNbTtCOHo+j2dGx3IXZT7iuUSwln3q64cD/BbFOEOisM80TYcupuN/+d9silROgiF5Ex
         sMuA==
X-Gm-Message-State: AOAM531n0mvHSKkt4Ro44NGHzl89MbCu8fUkw9BVvW9Ug3ypBVirkN/D
        a6uWUng7U71AhueVZZzkLJllB9qRuXzTzWHE
X-Google-Smtp-Source: ABdhPJyOK+qFktZuiPxUZjxTeitrjLe/+UsVD0eU1EpOK6RKocPEjcoE0FAT8+CG23cjszCMULLz8A==
X-Received: by 2002:a17:902:ce05:b0:14f:8cfa:1ace with SMTP id k5-20020a170902ce0500b0014f8cfa1acemr17779214plg.149.1647150933943;
        Sat, 12 Mar 2022 21:55:33 -0800 (PST)
Received: from localhost.localdomain (104.225.159.237.16clouds.com. [104.225.159.237])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm14792447pfk.26.2022.03.12.21.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 21:55:33 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/3] arch_topology: Correct semantics for 'cap_parsing_failed'
Date:   Sun, 13 Mar 2022 13:55:10 +0800
Message-Id: <20220313055512.248571-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220313055512.248571-1-leo.yan@linaro.org>
References: <20220313055512.248571-1-leo.yan@linaro.org>
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

As described in the DT binding document [1]: "capacity-dmips-mhz
property is all-or-nothing: if it is specified for a cpu node, it has to
be specified for every other cpu nodes, or the system will fall back to
the default capacity value for every CPU".

In other words, we can accept that cases that "capacity-dmips-mhz"
property is specified or not specified for all CPU nodes.  The only
failure is the DT binding is inconsistent for all CPUs nodes, e.g only
part of CPUs have bound the "capacity-dmips-mhz" property.

Currently kernel only considers all CPU nodes having "capacity-dmips-mhz"
property as a parsing success; for the other two cases, one is all CPU
nodes without "capacity-dmips-mhz" property, and another is inconsistent
binding crossing CPU nodes, kernel considers them as parsing failure and
set 'cap_parsing_failed' flag as true.

This patch makes more clear for the semantics of 'cap_parsing_failed',
it only takes the inconsistent binding case as parsing failure.  So it
sets the flag 'cap_parsing_failed' to true only when the array
'raw_capacity' is not NULL and current CPU node doesn't contain the
property "capacity-dmips-mhz".  It marks 'cap_parsing_failed' as
a static global variable to allow it can be used in the source file.

[1] Documentation/devicetree/bindings/arm/cpu-capacity.txt

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/base/arch_topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 976154140f0b..b81777ae6425 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -234,6 +234,7 @@ static int register_cpu_capacity_sysctl(void)
 subsys_initcall(register_cpu_capacity_sysctl);
 
 static int update_topology;
+static bool cap_parsing_failed;
 
 int topology_update_cpu_topology(void)
 {
@@ -291,7 +292,6 @@ void topology_normalize_cpu_scale(void)
 bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 {
 	struct clk *cpu_clk;
-	static bool cap_parsing_failed;
 	int ret;
 	u32 cpu_capacity;
 
@@ -331,9 +331,9 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
 				cpu_node);
 			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
+			cap_parsing_failed = true;
+			free_raw_capacity();
 		}
-		cap_parsing_failed = true;
-		free_raw_capacity();
 	}
 
 	return !ret;
-- 
2.25.1


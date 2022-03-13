Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9BF4D730F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbiCMF4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiCMF4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:56:44 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7900E5C64F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:37 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso11637701pjc.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RoUZCESpVak/+s5nDva9vIyHAPScWiyh0Htj7zHIWxk=;
        b=dbrQWgCvpao5bpKsgabNyuQl7n+KLu0erxIIC+VyQTMy5PYHC2x1tproIsCaoXdNjP
         enSAgXnHVsbuqwh8g3leH5yayk+IHu2TF/3JrAOO9EbcYd/tfy2l6FrVBY03X0n+/oez
         5RMboM8nWN+bYjS9tQRd7rLcR4ZLClsVTNpgtmzL1cD8GnNc005YOSQUlbT7H09Qi75d
         cR+hItwwF9Vlg04pynhV1iowFCDIMQ7Gqjuzh6hedIkW6Nj695FwOLVdXzCe1D7LjOIs
         VchRnbZt5dtm0JnYD2uDoT+z0cWoHh5Uw6mpNyZqbhSWaJjjvpNR9YLKHGkl7CuxGiLl
         aumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RoUZCESpVak/+s5nDva9vIyHAPScWiyh0Htj7zHIWxk=;
        b=bSQUNl5IRlBbotEubzj31uNBe7wN/TK5pr/fQuwDl4haa1EtCdJgKCD+Mzpx+27zSy
         n0r52v+kINbR9xOtDywi1vFJmLZdUNS0G1fCBttAvZ+BE4d6DXOlovVDpd0E1EsJR5JT
         96fzolHmemxFbgLiDqGUU3WW+bBpGZ25mo1OuAwa4OXWsvDCF5h/g462lzPtqzk+tULs
         oQG6ZagW4DRy9vbEyuNslXs5SVLzW71CxhMRRlXWEr412LayXStMym9iNkseq4X9O6/Y
         M9Yv583maNbMKlCizf90z4zQbyLscxOIkH0T/v30V0PdYkejXrsxk15iNJszBNIOm2NV
         pVcA==
X-Gm-Message-State: AOAM532tw2UsCKgXvhF6IefjulIXQ8fHJnaMoLBONpgEKfcPJFbydS+o
        FJXemM0URed6GxZFDFuSr+YAmw==
X-Google-Smtp-Source: ABdhPJyxMxe8oMdlaQF42Ft12F68YNmEg9/wp3cIe9ei2q/SPjhJh6S68VwX0tS32LdQLYkhxfqpLw==
X-Received: by 2002:a17:902:c7c5:b0:153:3a41:aa45 with SMTP id r5-20020a170902c7c500b001533a41aa45mr9400958pla.88.1647150936905;
        Sat, 12 Mar 2022 21:55:36 -0800 (PST)
Received: from localhost.localdomain (104.225.159.237.16clouds.com. [104.225.159.237])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm14792447pfk.26.2022.03.12.21.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 21:55:36 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 2/3] arch_topology: Handle inconsistent binding of CPU raw capacity
Date:   Sun, 13 Mar 2022 13:55:11 +0800
Message-Id: <20220313055512.248571-3-leo.yan@linaro.org>
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

There have a corner case is if we use below DT binding:

  cpu0: cpu@0 {
  	compatible = "arm,cortex-a53";
  	device_type = "cpu";
  	reg = <0x0 0x0>;
  	enable-method = "psci";
  };

  cpu1: cpu@1 {
  	compatible = "arm,cortex-a53";
  	device_type = "cpu";
  	reg = <0x0 0x1>;
  	enable-method = "psci";
  	capacity-dmips-mhz = <1024>;
  };

In this case, CPU0 node misses to bind "capacity-dmips-mhz" property,
and CPU1 node binds the property, this means the CPU raw capacity
binding is inconsistent across all CPUs.

This patch introduces an extra flag 'cap_property_miss' to indicate that
any previous CPU nodes miss binding for "capacity-dmips-mhz" property,
and any new CPU node contains the property, it detects the inconsistent
binding, and sets 'cap_parsing_failed' to true and frees raw capacity
array.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/base/arch_topology.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index b81777ae6425..0687576e880b 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -294,6 +294,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	struct clk *cpu_clk;
 	int ret;
 	u32 cpu_capacity;
+	static bool cap_property_miss;
 
 	if (cap_parsing_failed)
 		return false;
@@ -301,6 +302,20 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	ret = of_property_read_u32(cpu_node, "capacity-dmips-mhz",
 				   &cpu_capacity);
 	if (!ret) {
+		/*
+		 * A previous CPU node misses binding for CPU raw capacity and
+		 * current CPU node finds its property "capacity-dmips-mhz",
+		 * thus the DT binding for "capacity-dmips-mhz" is inconsistent
+		 * across all CPUs.  Set 'cap_parsing_failed' flag and drop the
+		 * CPU raw capacity values.
+		 */
+		if (cap_property_miss) {
+			pr_err("cpu_capacity: binding %pOF raw capacity\n",
+				cpu_node);
+			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
+			goto parsing_failure;
+		}
+
 		if (!raw_capacity) {
 			raw_capacity = kcalloc(num_possible_cpus(),
 					       sizeof(*raw_capacity),
@@ -331,12 +346,18 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 			pr_err("cpu_capacity: missing %pOF raw capacity\n",
 				cpu_node);
 			pr_err("cpu_capacity: partial information: fallback to 1024 for all CPUs\n");
-			cap_parsing_failed = true;
-			free_raw_capacity();
+			goto parsing_failure;
+		} else {
+			cap_property_miss = true;
 		}
 	}
 
 	return !ret;
+
+parsing_failure:
+	cap_parsing_failed = true;
+	free_raw_capacity();
+	return !ret;
 }
 
 #ifdef CONFIG_CPU_FREQ
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8DE4B0A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiBJJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:59:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbiBJJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:59:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090D8BD3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:59:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id c8-20020a17090a674800b001b91184b732so5530869pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gofrZqTIBkgz5SLWbhUQiAL3m8Y+/YRS4bR0i4YI5o=;
        b=rvKrxFXYmksqKc5m2C4MPny/Hthz+x+tedeK9MaiScMAiFEuahGKKjFzrg0XcXpmDe
         Ho4a5it3bAIDtgTPFr9nE3ARh09ALX9htRNRPfrSCObCNZM1QtklJH3HKmn7TV8iWJH7
         I30ah9vvBGwX+EjuwODvIQl/gKfr09Mw8hAdiWc68H9Xh4e6U7YhjbMMgeMe6CArN9H9
         i7BnDesJUg0TClTD4pA32GoL+xYdMMgNyL3wf7AphQ62LQiTgwZqYVuKVwKee8YqA226
         8wgHBWvqRP1TY8lMFydkE4qQm0h64yvWhS+9Q2HOeSVifkn6aB2tk6NHQk3wRh0Wl5pj
         cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7gofrZqTIBkgz5SLWbhUQiAL3m8Y+/YRS4bR0i4YI5o=;
        b=X1uHCFVbOBjkf6YzMxnkx+nz4QbUaSFMnuFis2ikynFu8AFx07WfT15D9ZgHIfKYXI
         jRDYyK8+dlDSMVmhHYE0czqZPQufHBv4djZFeoPMSfEd6xzcbydeltbY2gFt4eqsUYIO
         KN4RFAk4A6WST1iwOxRZfnwgdeSxyouWG4D2lOP1myEYC+dv6AVqJX7RYo6Bh6syk9Ne
         PhNCc89fceUR2Cx12AzgZPS3vFoa+tvM+exjl85q+ib6IJ7j7xQxD/RAHPBpXufONnhT
         PW0Sa4z3IBJgTs9B5Y7f38Nfx3q3Au44KJAivZ1Hnxj2pfab62sEcrNzwf7bzO0c2OQk
         WY2g==
X-Gm-Message-State: AOAM533pPPSeZZyUMaN3VXF00YFpdW6vJUjUsyO/97p2Vox8xrrzGXex
        PIeUinGKXRsABNKjK4f9Dyowng==
X-Google-Smtp-Source: ABdhPJzhDO0SjwU5TgL6RSHNZhZeL+f2jB/4+cb53R9723EThEk1MscgPnApL1llkLz1kk3V85EkFA==
X-Received: by 2002:a17:902:d4d2:: with SMTP id o18mr7051619plg.70.1644487170538;
        Thu, 10 Feb 2022 01:59:30 -0800 (PST)
Received: from localhost ([136.185.132.167])
        by smtp.gmail.com with ESMTPSA id gk15sm2017082pjb.3.2022.02.10.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 01:59:30 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] opp: Expose of-node's name in debugfs
Date:   Thu, 10 Feb 2022 15:29:26 +0530
Message-Id: <6d4ebbbe09f97c9f97834c293a70f6a8a4d36709.1644487134.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

It is difficult to find which OPPs are active at the moment, specially
if there are multiple OPPs with same frequency available in the device
tree (controlled by supported hardware feature).

Expose name of the DT node to find out the exact OPP.

While at it, also expose level field.

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/debugfs.c | 5 +++++
 drivers/opp/opp.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index 596c185b5dda..b5f2f9f39392 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -10,6 +10,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/init.h>
 #include <linux/limits.h>
 #include <linux/slab.h>
@@ -131,9 +132,13 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
 	debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend);
 	debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
 	debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate);
+	debugfs_create_u32("level", S_IRUGO, d, &opp->level);
 	debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
 			     &opp->clock_latency_ns);
 
+	opp->of_name = of_node_full_name(opp->np);
+	debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
+
 	opp_debug_create_supplies(opp, opp_table, d);
 	opp_debug_create_bw(opp, opp_table, d);
 
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 407c3bfe51d9..45e3a55239a1 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -96,6 +96,7 @@ struct dev_pm_opp {
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
+	const char *of_name;
 #endif
 };
 
-- 
2.31.1.272.g89b43f80a514


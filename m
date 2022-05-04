Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2B519311
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 02:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244832AbiEDA52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 20:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244835AbiEDA5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 20:57:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E741617
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 17:53:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso700037b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 17:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Zjy1zldFe0wiYm64BfTZJoZffZUDVwmNgVMbmELSEVA=;
        b=CDFKPs6JLf14N04jueEBqVgsL/B703C6qgz2wtNjlBiHpL2X2FlbWMs+g4/XvnvaeI
         NeGhz0HypR8RmipRHsNSU/X4SJP0Lmoq/6IlMWSc4vEUoKTY8WdOSNCi5wV8exM3kBwl
         kg0amoMbKg4Jn3jwc5qDmdhJKUOFs2ClXmHOREcZgR9B9YJ7AZoRQklzBP5PBbrGlLcg
         g0NAB80SGMNpCJ5LqGkMJegJXCuQUC7t0LW/qQ7x58UE9kBZISiu+uOA2WzOwf0ANf/W
         Ko4G3LeR7PMb5EaNT2uqbr4fjGBU4DN81Fu+hy1piTefgLeOOvsI6flaFT5k6Elh5nt/
         /y5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Zjy1zldFe0wiYm64BfTZJoZffZUDVwmNgVMbmELSEVA=;
        b=IumOzEjMUaTLDSMfzSa7awvvYG1d9eojZUxvGtRTh52M+mqZ3U4KZiO1df/UJMCfNB
         G+GmqL87joa63YdtKh6a9GGk7qPg29Q4J/+QsO4M9q2EqH5L99HKcuayO7JGz0YDooxj
         l+k6AdIAb8wj8+RsHjIv5lqgjbahK4QPhJzZ1lqgnjWlujhnPfhaW+Cqm3eynaeWO8t3
         pEQM0UmEwOwSCHGQ8crud7T5AAa+Ozdr92n3etZrEZx/AgpBtwmgBv/LtWPXTX8x+Qij
         XL5fzllRbKKJeLrsDq8+JTnSJFbcI9rfj57Kc1dih/AivUZCLcy3E8Iwb0MyMrTtmcAB
         50Zg==
X-Gm-Message-State: AOAM531KUWFtb+thNgizSbAZ9J7iascT8fsmPI/l7NKPaKtUEnEuJq7l
        tNomd/Ceonrk2CBPIsDGfTDQ39k1zZUGJac=
X-Google-Smtp-Source: ABdhPJzc3WCN5rO4CtJhQBFGtSPSf731hgUQt1rvPpYEeYtPcc5rPO1lQQ2nznwbD+j8M/xq6gNhgmDnmMNhudI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:963:1a62:7ffd:7111])
 (user=saravanak job=sendgmr) by 2002:a25:a0d4:0:b0:645:77c8:979a with SMTP id
 i20-20020a25a0d4000000b0064577c8979amr16847021ybm.484.1651625628114; Tue, 03
 May 2022 17:53:48 -0700 (PDT)
Date:   Tue,  3 May 2022 17:53:43 -0700
Message-Id: <20220504005344.117803-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v1] driver core: Add "*" wildcard support to
 driver_async_probe cmdline param
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Tang <feng.tang@intel.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's currently no way to use driver_async_probe kernel cmdline param
to enable default async probe for all drivers.  So, add support for "*"
to match with all driver names.  When "*" is used, all other drivers
listed in driver_async_probe are drivers that will NOT match the "*".

For example:
* driver_async_probe=drvA,drvB,drvC
  drvA, drvB and drvC do asynchronous probing.

* driver_async_probe=*
  All drivers do asynchronous probing except those that have set
  PROBE_FORCE_SYNCHRONOUS flag.

* driver_async_probe=*,drvA,drvB,drvC
  All drivers do asynchronous probing except drvA, drvB, drvC and those
  that have set PROBE_FORCE_SYNCHRONOUS flag.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 ++++-
 drivers/base/dd.c                               | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed..c7513d01df82 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1076,7 +1076,10 @@
 			driver later using sysfs.
 
 	driver_async_probe=  [KNL]
-			List of driver names to be probed asynchronously.
+			List of driver names to be probed asynchronously. *
+			matches with all driver names. If * is specified, the
+			rest of the listed driver names are those that will NOT
+			match the *.
 			Format: <driver_name1>,<driver_name2>...
 
 	drm.edid_firmware=[<connector>:]<file>[,[<connector>:]<file>]
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 152d3e6bfc06..16bd8957be61 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -60,6 +60,7 @@ static bool initcalls_done;
 /* Save the async probe drivers' name from kernel cmdline */
 #define ASYNC_DRV_NAMES_MAX_LEN	256
 static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
+static bool async_probe_default;
 
 /*
  * In some cases, like suspend to RAM or hibernation, It might be reasonable
@@ -796,7 +797,11 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
 
 static inline bool cmdline_requested_async_probing(const char *drv_name)
 {
-	return parse_option_str(async_probe_drv_names, drv_name);
+	bool async_drv;
+
+	async_drv = parse_option_str(async_probe_drv_names, drv_name);
+
+	return (async_probe_default != async_drv);
 }
 
 /* The option format is "driver_async_probe=drv_name1,drv_name2,..." */
@@ -806,6 +811,8 @@ static int __init save_async_options(char *buf)
 		pr_warn("Too long list of driver names for 'driver_async_probe'!\n");
 
 	strlcpy(async_probe_drv_names, buf, ASYNC_DRV_NAMES_MAX_LEN);
+	async_probe_default = parse_option_str(async_probe_drv_names, "*");
+
 	return 1;
 }
 __setup("driver_async_probe=", save_async_options);
-- 
2.36.0.464.gb9c8b46e94-goog


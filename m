Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86BE586186
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 23:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238497AbiGaVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 17:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbiGaVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 17:09:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB9DF83
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:09:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E7B5B80D81
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619DEC433C1;
        Sun, 31 Jul 2022 21:09:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIGBv-007GiH-1E;
        Sun, 31 Jul 2022 17:09:39 -0400
Message-ID: <20220731210939.214097203@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 17:09:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [for-next][PATCH 1/4] rtla/utils: Use calloc and check the potential memory allocation
 failure
References: <20220731210918.097591536@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jianchunfu <jianchunfu@cmss.chinamobile.com>

Replace malloc with calloc and add memory allocating check
of mon_cpus before used.

Link: https://lkml.kernel.org/r/20220615073348.6891-1-jianchunfu@cmss.chinamobile.com

Fixes: 7d0dc9576dc3 ("rtla/timerlat: Add --dma-latency option")
Signed-off-by: jianchunfu <jianchunfu@cmss.chinamobile.com>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 5352167a1e75..5ae2fa96fde1 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -106,8 +106,9 @@ int parse_cpu_list(char *cpu_list, char **monitored_cpus)
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-	mon_cpus = malloc(nr_cpus * sizeof(char));
-	memset(mon_cpus, 0, (nr_cpus * sizeof(char)));
+	mon_cpus = calloc(nr_cpus, sizeof(char));
+	if (!mon_cpus)
+		goto err;
 
 	for (p = cpu_list; *p; ) {
 		cpu = atoi(p);
-- 
2.35.1

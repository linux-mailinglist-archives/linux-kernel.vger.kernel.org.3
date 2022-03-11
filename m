Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEFE4D622F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348827AbiCKNPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348815AbiCKNPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:15:38 -0500
X-Greylist: delayed 426 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 05:14:34 PST
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65651187E23;
        Fri, 11 Mar 2022 05:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647004472;
        bh=FMOnkqFTBBpJisQx6U/1gR7mxTpSOznVSYK5PoP3F+c=;
        h=From:To:Cc:Subject:Date;
        b=ZS2gADM4N8v2ST1GI+D1QX93H59VX4fS5by1ERURatD7CIRa5cPnIyjW/ouJdpDLT
         e6ccy8bs5zyDvBPheHeYR81fRWRMnR0FugDHG+P4bdwj1rvu6eABQajEj66xyjRcRD
         NZq42QUrMOp9MrRM875bSJcEP9euF7WbJt0CUxXA=
Received: from localhost.localdomain ([111.193.130.237])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 1BA1C83E; Fri, 11 Mar 2022 21:06:58 +0800
X-QQ-mid: xmsmtpt1647004018tqcywn45w
Message-ID: <tencent_DF39269807EC9425E24787E6DB632441A405@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/cwTgMFAUfw9FhKeGEvyQDBTgYfUA/0Iolu5DLZmltTiXFOspWq
         D8b7yMzM9b4kcp0p6hf/jhmGA7Hp32uKKVBnqCMiXT9t5mQ1PyCO61YgxIOmxOBjSDSebimxQrI3
         gAOyx+iliyrpIt72aSiIsyiXhcs0crj8shO04OZjUm9crV8W7fRi+vfa94pHhVQ6mTs45FNIFrLi
         C8kvtVRLTFIZfb2/X6Uz6MGPK+5aUAz0TDzZVw3xiLH2WKcokeHhM+iLeb/deQFqnQIeDF70yMvw
         pyVMs/rb2OKNKX46ZSDseRcehOzArfRL18o4TI/3WKmISHl7326ptR9AhtLmkvBRL0iaLWGMnVPG
         xYyWKJmoe9VpXZ8gnaZfvqZOAOomGq/QFB5bz/H5tPYUbM/YqYxPZVOYoHvwL5+M5I0EZ2BccaBr
         F3h+9+Up71oSZDMoJ3nLuFBunQ9h1V1Ybj+mRio8Bg5yOfqt/qPTDwW5RSJsyyMcLAXg+zAKyEu7
         gGwwUwTvIFQ78oh/z14TjpZVPKBIazVUXzLw6s0yfR2RDnrQnCaCXosBExaz1HMaxOxcmKROJyGx
         FSsRB7NXgYtRcdjBMt78sbIQzlTgRolpdgAomvK2qMOVPUF23iTmSAvYprL/TRtk/qZZSbvyAjJI
         6z08Z1QkzZAEJ9HX0FVK6wAlX8TRgUhVhpq3VRzLdyJqrq1e7mDYSVhazpUtKoOpSIWysF/92+bV
         UsURJX++S8hHd7qlkU24H7+nhZjy6xEEtWCjKqB6gEqflHvFJrdB/be9jJqt6gJ50Z7AAu7YXRID
         5pmcPVJx9V8WcptHIlgfGN7MNTQKhuDXZ59avBTlRQKS4K4CAq6hmHT49g+7L4KRodajHG295MfM
         CgkVdRqbuauau8HdyNx12lkyUBaBcI2M6/A/kl4eeeItHnbvD7KrA6QfCbFVCoYZRKtNgaDaI0
From:   Weiguo Li <liwg06@foxmail.com>
To:     john.garry@huawei.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf parse-events: Fix null check
Date:   Fri, 11 Mar 2022 21:06:57 +0800
X-OQ-MSGID: <20220311130657.257353-1-liwg06@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We did a null check after "tmp->symbol = strdup(...)", but we checked
"list->symbol" other than "tmp->symbol".

Signed-off-by: Weiguo Li <liwg06@foxmail.com>
---
 tools/perf/util/parse-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 9739b05b999e..dfb50a5f83d0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2193,7 +2193,7 @@ int perf_pmu__test_parse_init(void)
 	for (i = 0; i < ARRAY_SIZE(symbols); i++, tmp++) {
 		tmp->type = symbols[i].type;
 		tmp->symbol = strdup(symbols[i].symbol);
-		if (!list->symbol)
+		if (!tmp->symbol)
 			goto err_free;
 	}
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7257754507E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbiFIPSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiFIPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:18:15 -0400
X-Greylist: delayed 1849 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 08:18:10 PDT
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7C0349F16
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9jmiY
        Z8pRS/uF1eNB9/cdQDjDlfV/hTLDW6XrEdWyxM=; b=QIUfBDoMM6uG/b+UyRtV1
        09Z/AYUPPVjNPFIKRSWuokn6epR/6uXPw8pRRPlO1WwJ6S5nwT2LfhtbRAFfpqBS
        yMmD5zkvzhI7O/1PoJ+sPSFT9eVsr0863tP104Ar8nMOXy23iRRopi0P/C1kYnIB
        r0LFaSjXu3z8Bg4MQkslpU=
Received: from localhost.localdomain (unknown [117.174.18.188])
        by smtp3 (Coremail) with SMTP id DcmowADX3mrVB6JiHxKeCw--.14055S2;
        Thu, 09 Jun 2022 22:46:49 +0800 (CST)
From:   cxbing <zhangkkoo@126.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
        cxbing <chenxuebing@jari.cn>
Subject: [PATCH] delayacct: Remove some unused variables
Date:   Thu,  9 Jun 2022 07:44:59 -0700
Message-Id: <20220609144459.86379-1-zhangkkoo@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADX3mrVB6JiHxKeCw--.14055S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFW7Zr4DCF43Xw1xuFyxGrg_yoWkArbEq3
        yag3y8CrZ5Aryjka18Ja18XrW0q3WrW3s7CwsrtrW3Xr1xWa4FyFWDZr1DA3Wruay7AFW3
        JFsYyr1fC3yUGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbaZX7UUUUU==
X-Originating-IP: [117.174.18.188]
X-CM-SenderInfo: x2kd0wpnnr0qqrswhudrp/1tbi2hob-VuwMKhWjAAAsP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cxbing <chenxuebing@jari.cn>

Drop the unused variables *done* and *count*.

Signed-off-by: cxbing <chenxuebing@jari.cn>
---
 tools/accounting/getdelays.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
index 11e86739456d..ea54ee53a802 100644
--- a/tools/accounting/getdelays.c
+++ b/tools/accounting/getdelays.c
@@ -45,7 +45,6 @@
 		exit(code);			\
 	} while (0)
 
-int done;
 int rcvbufsz;
 char name[100];
 int dbg;
@@ -279,7 +278,6 @@ int main(int argc, char *argv[])
 	pid_t rtid = 0;
 
 	int fd = 0;
-	int count = 0;
 	int write_file = 0;
 	int maskset = 0;
 	char *logfile = NULL;
@@ -489,7 +487,6 @@ int main(int argc, char *argv[])
 				len2 = 0;
 				/* For nested attributes, na follows */
 				na = (struct nlattr *) NLA_DATA(na);
-				done = 0;
 				while (len2 < aggr_len) {
 					switch (na->nla_type) {
 					case TASKSTATS_TYPE_PID:
@@ -503,7 +500,6 @@ int main(int argc, char *argv[])
 							printf("TGID\t%d\n", rtid);
 						break;
 					case TASKSTATS_TYPE_STATS:
-						count++;
 						if (print_delays)
 							print_delayacct((struct taskstats *) NLA_DATA(na));
 						if (print_io_accounting)
-- 
2.25.1


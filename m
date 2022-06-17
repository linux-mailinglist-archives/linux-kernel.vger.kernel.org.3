Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE3C54F760
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381309AbiFQMU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbiFQMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:20:25 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58A5F4D6BC;
        Fri, 17 Jun 2022 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=8kX2g
        PaQQUBFGChfB1VheAAwH9ZwON9dzg5HDq5fFVw=; b=D3lsRpMFzcDxd3YgDLkci
        UvvegT1syjAq3rh+UKN6W5KHpoL2uoEEdTwv5+9Ky1NUK1ZpQgfNxvKSltPy9L1f
        tWMVikDo2UA0cDTw3ezepsMqo+uR0GB1l5B+404cdUMY3cFcm62UPv75pqIr9mMW
        oWpL95HK5CrnBedqz1LKwM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgBX6IRvcaxi5hJwFw--.39068S2;
        Fri, 17 Jun 2022 20:19:59 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     john@phrozen.org, tsbogend@alpha.franken.de,
        xkernel.wang@foxmail.com, wangborong@cdjrlc.com
Cc:     windhl@126.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mips: lantiq: falcon: Fix refcount leak bug in sysctrl
Date:   Fri, 17 Jun 2022 20:19:58 +0800
Message-Id: <20220617121958.4047910-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgBX6IRvcaxi5hJwFw--.39068S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyfGr18WFyxAryfuF4DJwb_yoWDWrgEg3
        Z2gr98GryrCF4rurWxZr43C3s0y3sagrZ5A3Z7Jw4aka4ava4UXFy2vr95urWUZw4Fy3y7
        ArsxGFWY9rW29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUURBT7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3A8jF1pEDvZK5QAAsu
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ltq_soc_init(), of_find_compatible_node() will return a node pointer
with refcount incremented. We should use of_node_put() when it is not
used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/mips/lantiq/falcon/sysctrl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 5204fc6d6d50..1187729d8cbb 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -208,6 +208,12 @@ void __init ltq_soc_init(void)
 			of_address_to_resource(np_sysgpe, 0, &res_sys[2]))
 		panic("Failed to get core resources");
 
+	of_node_put(np_status);
+	of_node_put(np_ebu);
+	of_node_put(np_sys1);
+	of_node_put(np_syseth);
+	of_node_put(np_sysgpe);
+
 	if ((request_mem_region(res_status.start, resource_size(&res_status),
 				res_status.name) < 0) ||
 		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
-- 
2.25.1


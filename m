Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B99B54F6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380407AbiFQL3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbiFQL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:29:11 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 315036CA81
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=O/gfj
        iM+/dFXgLyDX8wONUfp/rIAwYsakkpB/GaAurk=; b=Vr3o8xiieKrrrlgnddW/w
        s9lxmQXAdM8azHPs8X4zP73tsYyzzomAKFUaoodb8Koskz0K52ppxEOXFj7WjG3s
        gj/Bmh67ql+61IR+ujsnV7CXfostj9RwIDUyOm4NdpUn7UlVV80Y1PAnLYLzxZV2
        PVenFWunVvRjV+M2z4PweA=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowACn5_bsZKximyZLDg--.20485S2;
        Fri, 17 Jun 2022 19:26:38 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, rppt@kernel.org,
        christophe.leroy@csgroup.eu, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, aneesh.kumar@linux.ibm.com,
        dmitry.osipenko@collabora.com
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: kernel: Change the order of of_node_put()
Date:   Fri, 17 Jun 2022 19:26:36 +0800
Message-Id: <20220617112636.4041671-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowACn5_bsZKximyZLDg--.20485S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF48Jw1UWw1UAFWUur1fXrb_yoWxKrX_t3
        yxX3ZI9r4vyrsa9rsrAF4fXr1Dtw4kXr1Fk3Wv9w47t3Z8Xw4UAr98Z3WkJr9xuryUt39F
        934Dtws8tF40vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM-eo7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3A4jF1pEDvX86gAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In add_pcspkr(), it is better to call of_node_put() after the
'if(!np)' check.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index eb0077b302e2..761817d1f4db 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -563,9 +563,9 @@ static __init int add_pcspkr(void)
 	int ret;
 
 	np = of_find_compatible_node(NULL, NULL, "pnpPNP,100");
-	of_node_put(np);
 	if (!np)
 		return -ENODEV;
+	of_node_put(np);
 
 	pd = platform_device_alloc("pcspkr", -1);
 	if (!pd)
-- 
2.25.1


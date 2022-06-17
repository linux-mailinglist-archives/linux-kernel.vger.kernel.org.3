Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5656254F27D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380782AbiFQIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380252AbiFQIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 04:05:40 -0400
Received: from m15113.mail.126.com (m15113.mail.126.com [220.181.15.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2954647052
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 01:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6hHSq
        JJtvj2gXC96rqDa7qDMN11c7zQ1mP+RJraEK9o=; b=Z6soNT8ycgZZEqp9j5xAu
        3qSelUpbBFUjwYHL8Lq50VOFX8zGklRg5jIQTVV7dlmMy6odEz9+nJcIWzbwheCa
        6gvoshjgX/XbLM2RdxBbjPNnDrcOLaZrq8UfoeUaGDgTRIzOEwLYb0cvSq8xgEWy
        8npL4v72GUVzGBMp3nrQJ0=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp3 (Coremail) with SMTP id DcmowACXMJKYNaxic+FcDg--.36620S2;
        Fri, 17 Jun 2022 16:04:41 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        nick.child@ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: powernv: Fix refcount leak in opal
Date:   Fri, 17 Jun 2022 16:04:39 +0800
Message-Id: <20220617080439.4010786-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowACXMJKYNaxic+FcDg--.36620S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw43XFW7Wry8ZF1ruw48WFg_yoW3Zrg_tw
        n7XayDur4rJr4vy3yDZw4fGFnrC3sxWF4DXr12q3W2kw13ta9xG39rtrW7G3WUurWjyrW3
        GFWDJrWDZaySvjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRM3kuJUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BkjF1pEDvTRHwAAsb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In opal_imc_init_dev(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
--- 

 arch/powerpc/platforms/powernv/opal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 55a8fbfdb5b2..d86cc48a10aa 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -952,6 +952,7 @@ static void __init opal_imc_init_dev(void)
 	np = of_find_compatible_node(NULL, NULL, IMC_DTB_COMPAT);
 	if (np)
 		of_platform_device_create(np, NULL, NULL);
+	of_node_put(np);
 }
 
 static int kopald(void *unused)
-- 
2.25.1


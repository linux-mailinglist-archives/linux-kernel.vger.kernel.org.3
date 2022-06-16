Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24A54E1FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbiFPNao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbiFPNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:30:41 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03D6D286D1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lt4cZ
        XCiaVcjGvhuT4ufqgA61fK3nl/LsSYLL/GBPXI=; b=XDNa0blq5lRe7Gk3wyjyI
        Sefm5EB7e9LHXt3544UvMIyDR3cALbRtuhodZtrvlBk7DQQ/r+NRa3COXXrSr0zy
        WH3oYsio2xoCpPhOC9b9w2eU6exS3e78wtpCPETyk4wH7TNo7Q06opgzxRVaUNHP
        mgRwif0MnZ4KoyAMYw8O/g=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgCH51szMKtitIMkEw--.42762S2;
        Thu, 16 Jun 2022 21:29:25 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     oss@buserror.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu
Cc:     windhl@126.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch: powerpc: platforms: 85xx: Fix refcount leak bug in ksi8560.c
Date:   Thu, 16 Jun 2022 21:29:22 +0800
Message-Id: <20220616132922.3987053-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgCH51szMKtitIMkEw--.42762S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4UXry8JryrKryfGFWDXFb_yoW3CrgEkw
        n3Aa1UCrs5Cr4ktF4qyr1rKr1jq3yrWFWUGr1Ig3W7JFy5ZanxGwsrXF4xu3W5Xr4IkrWa
        qFZrG3s8CasakjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMa9-UUUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGg0iF1-HZT6SiQAAs6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ksi8560_setup_arch(), of_find_compatible_node() will return a
node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/powerpc/platforms/85xx/ksi8560.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index bdf9d42f8521..a22f02b0fc77 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -133,6 +133,8 @@ static void __init ksi8560_setup_arch(void)
 	else
 		printk(KERN_ERR "Can't find CPLD in device tree\n");
 
+	of_node_put(cpld);
+
 	if (ppc_md.progress)
 		ppc_md.progress("ksi8560_setup_arch()", 0);
 
-- 
2.25.1


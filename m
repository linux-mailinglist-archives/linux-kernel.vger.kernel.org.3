Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D701F4E726D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357221AbiCYLvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiCYLve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:51:34 -0400
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C52D3AFC;
        Fri, 25 Mar 2022 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648208996;
        bh=IPtd5NBJKkBEY0L1pQtW4blGnh3srn/WBBwWRTexlrw=;
        h=From:To:Cc:Subject:Date;
        b=r+WJMRLGw2sGKSgekix4f2uFMbge+HYA0TlkB4dDAiBWo+DDAjTRmgE+NGvz+/9X5
         rsPVWUq9HeH0xNEFQWW/W47Mx7gSZT05ui5IOecyz+zAI/kpRsbxaZ9ZrABUP04qRl
         qxhijTneYrdHD0kosTf06f2NRhRko8uCBaBg8LF4=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id C732ECB1; Fri, 25 Mar 2022 19:49:51 +0800
X-QQ-mid: xmsmtpt1648208991turlnigp0
Message-ID: <tencent_3E071B85643888D2C8BF388804334CAE2706@qq.com>
X-QQ-XMAILINFO: MZ7OTbK+3aE5SaqPAIQeWKjDXnRL7UbB0WYL4yx1oTafA5+9iJBprA7gZQLM/c
         Px2EHDjur6vcGFMz1zZzST7o0PemfNlrw3+G4fbJXUitmxn0SpQ/QpCOkDsQnQ2ZQEO4gU/Wx5sv
         CnOncfyRJDWFilZxE//u+3/HLjPrZFDjV5pqDuPj6GELM61xA6Z9wiowoR/TdBAzs+++ydswqPlS
         tuqxGPe5x/gnjAEWoqR/QU5+gk1IPmMeFh+7mZJ1fQ/on3TqG6qAp6hMjckhSbKC523IHyZzPYb+
         anKXUKNVssZ2EjpQ849qAf+NBEmJfocABJlFATBspj+bfdCpQuOlcNdjrTJf5l6vrWxJRWW6SkKl
         lwZGFfixdFw3kLvUhorn0ypHU6h0NQZ/3SOfSHfSSpSnxtyowWqnXVK9v37B2sU6r6NtaATEHqtF
         qqucgY96CvGchHorApMW2vJfCLgiYHTf6srOH1/GvclsUNfw8CL9+iUaqt922zvRUsXXSrWDlhW/
         67V1Qi7rqJR39VST2GOnHuYq+/ac8qzUCEKGJuLfdKJtnPbgixdN3D+3ga4z2uts/4w/ouuOlxpW
         4Zf0Ii3a9dJiBJQDjtiU2bJVPFtw3ZLj1KPiqqjR+3kPAhxXiQJDKoMeqYDAbMru6gll4DYET1W+
         5aFLW5BGIkMGvkfoWWN8OfHyL/rHhNpqdrpOyv+KmOXA3fv1+GiMh7H6FUaFh+sRx2mLt7+mbfl3
         6kS+t/T6UjnRiGiEfemzc8e95Ccrq6we4xOGLO3Dd7K8CRyCW9bEzRpR6D3gOF/gXEE54pA017/G
         qbYgvaE1Gz/Sc2PHk/5mSR+LZKYrfJcpDx5/5NiXOPzlQlMWhDutduEke4pQLJY4a1HvmPHmv7XD
         XcpSb1G3pF8b7LRc/YxNUxQ9W8MtW+kVY0y5LAhkZ7Tw/yE+cFNL5ecPyUMuL16nwj5qMQvL3buB
         pXgfYzh141TIT1StdOog==
From:   xkernel.wang@foxmail.com
To:     john@phrozen.org, tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] MIPS: lantiq: check the return value of kzalloc()
Date:   Fri, 25 Mar 2022 19:49:41 +0800
X-OQ-MSGID: <20220325114941.4648-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check the
return value of it to prevent potential wrong memory access or
memory leak.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 arch/mips/lantiq/falcon/sysctrl.c |  2 ++
 arch/mips/lantiq/xway/gptu.c      |  2 ++
 arch/mips/lantiq/xway/sysctrl.c   | 46 ++++++++++++++++++++-----------
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 42222f8..446a253 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -167,6 +167,8 @@ static inline void clkdev_add_sys(const char *dev, unsigned int module,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev;
 	clk->cl.con_id = NULL;
 	clk->cl.clk = clk;
diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 3d5683e..200fe9f 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -122,6 +122,8 @@ static inline void clkdev_add_gptu(struct device *dev, const char *con,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev_name(dev);
 	clk->cl.con_id = con;
 	clk->cl.clk = clk;
diff --git a/arch/mips/lantiq/xway/sysctrl.c b/arch/mips/lantiq/xway/sysctrl.c
index 917fac1..084f6ca 100644
--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -315,6 +315,8 @@ static void clkdev_add_pmu(const char *dev, const char *con, bool deactivate,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev;
 	clk->cl.con_id = con;
 	clk->cl.clk = clk;
@@ -338,6 +340,8 @@ static void clkdev_add_cgu(const char *dev, const char *con,
 {
 	struct clk *clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
+	if (!clk)
+		return;
 	clk->cl.dev_id = dev;
 	clk->cl.con_id = con;
 	clk->cl.clk = clk;
@@ -356,24 +360,28 @@ static void clkdev_add_pci(void)
 	struct clk *clk_ext = kzalloc(sizeof(struct clk), GFP_KERNEL);
 
 	/* main pci clock */
-	clk->cl.dev_id = "17000000.pci";
-	clk->cl.con_id = NULL;
-	clk->cl.clk = clk;
-	clk->rate = CLOCK_33M;
-	clk->rates = valid_pci_rates;
-	clk->enable = pci_enable;
-	clk->disable = pmu_disable;
-	clk->module = 0;
-	clk->bits = PMU_PCI;
-	clkdev_add(&clk->cl);
+	if (clk) {
+		clk->cl.dev_id = "17000000.pci";
+		clk->cl.con_id = NULL;
+		clk->cl.clk = clk;
+		clk->rate = CLOCK_33M;
+		clk->rates = valid_pci_rates;
+		clk->enable = pci_enable;
+		clk->disable = pmu_disable;
+		clk->module = 0;
+		clk->bits = PMU_PCI;
+		clkdev_add(&clk->cl);
+	}
 
 	/* use internal/external bus clock */
-	clk_ext->cl.dev_id = "17000000.pci";
-	clk_ext->cl.con_id = "external";
-	clk_ext->cl.clk = clk_ext;
-	clk_ext->enable = pci_ext_enable;
-	clk_ext->disable = pci_ext_disable;
-	clkdev_add(&clk_ext->cl);
+	if (clk_ext) {
+		clk_ext->cl.dev_id = "17000000.pci";
+		clk_ext->cl.con_id = "external";
+		clk_ext->cl.clk = clk_ext;
+		clk_ext->enable = pci_ext_enable;
+		clk_ext->disable = pci_ext_disable;
+		clkdev_add(&clk_ext->cl);
+	}
 }
 
 /* xway socs can generate clocks on gpio pins */
@@ -393,9 +401,15 @@ static void clkdev_add_clkout(void)
 		char *name;
 
 		name = kzalloc(sizeof("clkout0"), GFP_KERNEL);
+		if (!name)
+			continue;
 		sprintf(name, "clkout%d", i);
 
 		clk = kzalloc(sizeof(struct clk), GFP_KERNEL);
+		if (!clk) {
+			kfree(name);
+			continue;
+		}
 		clk->cl.dev_id = "1f103000.cgu";
 		clk->cl.con_id = name;
 		clk->cl.clk = clk;
-- 


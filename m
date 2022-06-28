Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB99C55E8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbiF1NxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbiF1NxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:53:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B1B7650
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:53:01 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LXQwN0hKQz1L8k5;
        Tue, 28 Jun 2022 21:50:44 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 21:52:59 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:52:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>
CC:     <michael@walle.cc>, <arnd@arndb.de>, <shawnguo@kernel.org>
Subject: [PATCH -next 2/2] soc: fsl: guts: check return value after calling of_iomap() in fsl_guts_get_soc_uid()
Date:   Tue, 28 Jun 2022 22:02:49 +0800
Message-ID: <20220628140249.1073809-2-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628140249.1073809-1-yangyingliang@huawei.com>
References: <20220628140249.1073809-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_iomap() may return NULL, so we need check the return value.

Fixes: 786dde1e59d7 ("soc: fsl: guts: add serial_number support")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/soc/fsl/guts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 8038c599ad83..6bf3e6a980ff 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -126,6 +126,10 @@ static u64 fsl_guts_get_soc_uid(const char *compat, unsigned int offset)
 		return 0;
 
 	sfp_base = of_iomap(np, 0);
+	if (!sfp_base) {
+		of_node_put(np);
+		return 0;
+	}
 
 	uid = ioread32(sfp_base + offset);
 	uid <<= 32;
-- 
2.25.1


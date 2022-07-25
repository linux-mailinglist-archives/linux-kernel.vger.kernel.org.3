Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC7C57F84C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiGYCie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiGYCib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:38:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F98DF87
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:38:29 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lrkdf58wgz923g;
        Mon, 25 Jul 2022 10:34:30 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 10:38:17 +0800
Received: from huawei.com (10.67.175.34) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Jul
 2022 10:38:16 +0800
From:   Ren Zhijie <renzhijie2@huawei.com>
To:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <tanureal@opensource.cirrus.com>, <rf@opensource.cirrus.com>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <sbinding@opensource.cirrus.com>, <vitalyr@opensource.cirrus.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        Ren Zhijie <renzhijie2@huawei.com>
Subject: [PATCH -next] ALSA: hda: cs35l41: Fix build error unused-function
Date:   Mon, 25 Jul 2022 10:36:11 +0800
Message-ID: <20220725023611.57055-1-renzhijie2@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.34]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM_SLEEP is not set,
make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:

sound/pci/hda/cs35l41_hda.c:583:12: error: ‘cs35l41_runtime_resume’ defined but not used [-Werror=unused-function]
 static int cs35l41_runtime_resume(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~
sound/pci/hda/cs35l41_hda.c:565:12: error: ‘cs35l41_runtime_suspend’ defined but not used [-Werror=unused-function]
 static int cs35l41_runtime_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [sound/pci/hda/cs35l41_hda.o] Error 1

commit 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros,
deprecate old ones"), add new marco RUNTIME_PM_OPS to fix this unused-function problem.

Fixes: 1873ebd30cc8 ("ALSA: hda: cs35l41: Support Hibernation during Suspend")
Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
---
 sound/pci/hda/cs35l41_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 28798d5c1cf1..93cf039abb02 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1439,7 +1439,7 @@ void cs35l41_hda_remove(struct device *dev)
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_remove, SND_HDA_SCODEC_CS35L41);
 
 const struct dev_pm_ops cs35l41_hda_pm_ops = {
-	SET_RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
+	RUNTIME_PM_OPS(cs35l41_runtime_suspend, cs35l41_runtime_resume, NULL)
 };
 EXPORT_SYMBOL_NS_GPL(cs35l41_hda_pm_ops, SND_HDA_SCODEC_CS35L41);
 
-- 
2.17.1


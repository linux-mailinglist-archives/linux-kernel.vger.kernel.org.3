Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61AB530F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbiEWM3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiEWM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:29:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D24162B;
        Mon, 23 May 2022 05:29:32 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6GqF0zsjzDqL2;
        Mon, 23 May 2022 20:29:29 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 20:29:30 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <ak@it-klinger.de>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: srf08: Remove redundant if statement
Date:   Mon, 23 May 2022 20:27:55 +0800
Message-ID: <20220523122755.90638-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(!val) has been checked outside the loop, remove redundant (val &&)
from loop.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/iio/proximity/srf08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index ac1ab7e89d4e..7ed11339c31e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -354,7 +354,7 @@ static ssize_t srf08_write_sensitivity(struct srf08_data *data,
 		return -EINVAL;
 
 	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
-		if (val && (val == data->chip_info->sensitivity_avail[i])) {
+		if (val == data->chip_info->sensitivity_avail[i]) {
 			regval = i;
 			break;
 		}
-- 
2.17.1


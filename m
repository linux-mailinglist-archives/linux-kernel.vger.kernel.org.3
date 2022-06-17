Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFC554F979
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382851AbiFQOnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382876AbiFQOnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:43:47 -0400
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D9924F9ED
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oqTFS
        HQR0LyoKRjMr2/vnSyFVI269+kRaqPVQCinquA=; b=YUbWt5fwnt/qeuRUmA3ks
        eVCpZ2psR0iXF1+SWD6egNuCcjodxyAm8GSiCgo5o0xD45yq6mZpxNt31gJUPPWs
        4Zu2nyVGceNZd+r9Q4L5CpPrlk6Q1FOH/wELEeUK5ApmuVtgj2z/Y/aZJBdZbCFY
        jMmJxz4160rAY0fqjpIZ7A=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp7 (Coremail) with SMTP id DsmowACHJv+Ckqxin0VlDg--.21214S2;
        Fri, 17 Jun 2022 22:41:07 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     jic23@kernel.org, lars@metafoo.de, joel@jms.id.au, andrew@aj.id.au,
        p.zabel@pengutronix.de, lgirdwood@gmail.com, broonie@kernel.org,
        billy_tsai@aspeedtech.com, colin.king@intel.com
Cc:     windhl@126.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: Fix refcount leak bug in aspeed_adc
Date:   Fri, 17 Jun 2022 22:41:06 +0800
Message-Id: <20220617144106.4050677-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsmowACHJv+Ckqxin0VlDg--.21214S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF4fWry3Gry7Cr4UZr15XFb_yoW3CrcEgw
        s7WwsxXrnrAFZ0vrWqvw1fXr909Fy8WFWkuF10v34fWa4UArZ7AryDWF4YvrWUZrs2va45
        ZF4DX34xJrnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjn2-3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuA0jF2JVj6h7ygABsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In aspeed_adc_set_trim_data(), of_find_node_by_name() will return
a node pointer with refcount incremented. We should use of_node_put()
when it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
---
 drivers/iio/adc/aspeed_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 0793d2474cdc..9341e0e0eb55 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -186,6 +186,7 @@ static int aspeed_adc_set_trim_data(struct iio_dev *indio_dev)
 		return -EOPNOTSUPP;
 	}
 	scu = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(scu)) {
 		dev_warn(data->dev, "Failed to get syscon regmap\n");
 		return -EOPNOTSUPP;
-- 
2.25.1


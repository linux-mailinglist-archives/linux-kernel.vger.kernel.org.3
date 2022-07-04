Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048E565654
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiGDNAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiGDNAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:00:03 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 723796462
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=w39Pq
        2DmWEWjcTsIwK+1m9Pu/MO56ER0XvIIEHXf8Mw=; b=iaiPsIjMbNoM9IHCL+5jI
        7JXNnFCodiHjvHqePjlofT09r1JVAq38UpGKVyTDncADo99LNR2MRiJMxzgdyBcg
        jsjlSdx5zoPinyKrG087j39HrElnBdlpWmk4yhFyRQHIvSweKz0VLAUHkJahcNPW
        DIt0oK8txCPPAqTU0gB8iU=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp5 (Coremail) with SMTP id HdxpCgCHlTAr5MJiBdGUMQ--.44107S4;
        Mon, 04 Jul 2022 20:59:34 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     iwona.winiarska@intel.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] peci: fix potential memory leak in devm_adev_add()
Date:   Mon,  4 Jul 2022 20:59:22 +0800
Message-Id: <20220704125922.2240585-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgCHlTAr5MJiBdGUMQ--.44107S4
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyDKF1xGFW8try3KFykZrb_yoWfCrb_uF
        1a9rZ5Xr1DGanxtw43J3yrZrySyF10q3yxZF4SyFyfAay5Xa17uayqqrZxJ345Ww47uFZ8
        Zr9rtryUJwn3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_L0etUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQxY0jFc7acgiiwAAsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_adev_add() allocates a memory chunk for "adev" and "adev->name"
with adev_alloc(). When auxiliary_device_add() fails, the function calls
auxiliary_device_uninit(), which doesn't release the allocated "adev"
and "adev->name", thus leading to a memory leak bug.

We should call adev_release() instead of auxiliary_device_uninit() to
release the "adev" and "adev->name".

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/peci/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/peci/cpu.c b/drivers/peci/cpu.c
index 68eb61c65d34..de865997ccde 100644
--- a/drivers/peci/cpu.c
+++ b/drivers/peci/cpu.c
@@ -248,7 +248,7 @@ static int devm_adev_add(struct device *dev, int idx)
 
 	ret = auxiliary_device_add(adev);
 	if (ret) {
-		auxiliary_device_uninit(adev);
+		adev_release(&adev->dev);
 		return ret;
 	}
 
-- 
2.25.1


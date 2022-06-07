Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E0453FE4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiFGMHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243365AbiFGMHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:13 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48C4FF5534;
        Tue,  7 Jun 2022 05:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cuOJ+
        EnOHMkX51iPE9y80C6s7and7tUcive9YqXs8/I=; b=UpNWtAjEaL6rAB7JjwoaQ
        0lZjknXPXetIdiQv8XlLbKh2tIiVR6pNj/2NLk1njl6QmrQKjrYg17KTd/CCXMKC
        bCsCPSOjaKm/2XJ2PAZcmaTb8TwseFWoIDD0aFaICGWomIkk6jzeLFErWXkMbIwf
        kexetpk65Dsuek2BG/O568=
Received: from carlis-virtual-machine (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAAXqSNaP59iuAYyHg--.30257S2;
        Tue, 07 Jun 2022 20:06:51 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>
Subject: [PATCH] rpmsg: convert sysfs snprintf to sysfs_emit
Date:   Tue,  7 Jun 2022 20:06:49 +0800
Message-Id: <20220607120649.78436-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAXqSNaP59iuAYyHg--.30257S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW7AryDtw43Gr4fuFWfKrg_yoW3CrcEkr
        y0yw4xAF1vvrn5uFnrXFnxZF9avw15Xr1vqw40vFy3CFZYyws8ZrZ29F48J3yDC345JF9x
        Cw1kJryFyr47ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnZjjDUUUUU==
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/1tbiWxwZhWI0U54-sAAAsP
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
drivers/rpmsg/qcom_glink_native.c:1677:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 07586514991f..62e741883222 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1674,7 +1674,7 @@ static ssize_t rpmsg_name_show(struct device *dev,
 	if (ret < 0)
 		name = dev->of_node->name;
 
-	return snprintf(buf, RPMSG_NAME_SIZE, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static DEVICE_ATTR_RO(rpmsg_name);
 
-- 
2.34.1


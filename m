Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDBF52CD26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 09:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiESHdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 03:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbiESHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 03:33:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7072493993
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:33:35 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id b32so5227464ljf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yuktspFNrt5rjI2kzGLngt2z3t8Z3KhsCnQp62xNRg=;
        b=PpMvb9vLCRNbJjwWDqpUhsyrLAsP3JdmHhc2qOJ0FHvml1OmBXSyPkwbrY2o3ZNEJe
         rnvDE40QT+vJoBjpsQvuoBYe6QpFD/ckHyOGp/3fZIwOBjnIFnJ4oUGLldo5MFHtUMUr
         0DPXmPQTxl01e1ATP3FspsXFP2MoCrmsW2iRLMoQYnacPYyoe2en6+U+9GqtD8QN0gC4
         tFwzON0dHDvtDTI0mNSgRsVQnZoPC6BnVWEqci3hpI2VLPogC4D3j88uIkUqC2seF8sz
         YHG/HiJsphdbz8VFCJuByVWlWqDp67cLPHgnq1ieHvl+F0E6U1lCxKxzQL+Dc+IjByH0
         rIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1yuktspFNrt5rjI2kzGLngt2z3t8Z3KhsCnQp62xNRg=;
        b=C+9wqu9eiVlU1g2vNMmpDivbxbfMw8Kw5lwMgNXZJYeCIlXa+t3s3ZIH+nBxKg+cRT
         xsdnXkoQjCDikJqfhnauXMelK5zPpTSNjkGrEiOBnBVX7sWJQAtMTA+iz4ESOmfxR8kf
         gzrskmy7Dkf6G/zPuPzwjJd+BXKht9rhcqQIXqU/KQTFCz2l2gSx61/eHkGaowgjRKYS
         YmGuuyH5LxhOQ461ZgpTnlGEzAZrKA5FjVpsyvEU+qROW0VlHn7imfmzZTA/Xj9QPcLE
         VWzuLFQF5ZA0w2fG9jUlOxHMiJ+CYd6FFXxaSw1cBXhzmqSShKBzLudlAoRcFmCFoSSM
         Hsww==
X-Gm-Message-State: AOAM532WYA587nYC/phVYluMrgxbNXE4fVmqIiYlImLT347d6IN2RBOR
        aPf2eLSoXW9oFq+VUuDRkXSQ+g==
X-Google-Smtp-Source: ABdhPJzLdpHMqhVMYhLA7IMeAJT9C0ozOcKgRLPjTWSOI2XTkdxgw3y5UZ36wVtkQyYXaaCK8CLQBQ==
X-Received: by 2002:a05:651c:505:b0:24f:5248:3018 with SMTP id o5-20020a05651c050500b0024f52483018mr1837332ljp.45.1652945613804;
        Thu, 19 May 2022 00:33:33 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a16-20020a056512201000b0047255d21159sm187484lfb.136.2022.05.19.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 00:33:33 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/3] rpmsg: qcom: glink: replace strncpy() with strscpy_pad()
Date:   Thu, 19 May 2022 09:33:28 +0200
Message-Id: <20220519073330.7187-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of strncpy() is considered deprecated for NUL-terminated
strings[1]. Replace strncpy() with strscpy_pad(), to keep existing
pad-behavior of strncpy, similarly to commit 08de420a8014 ("rpmsg:
glink: Replace strncpy() with strscpy_pad()").  This fixes W=1 warning:

  In function ‘qcom_glink_rx_close’,
    inlined from ‘qcom_glink_work’ at ../drivers/rpmsg/qcom_glink_native.c:1638:4:
  drivers/rpmsg/qcom_glink_native.c:1549:17: warning: ‘strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
   1549 |                 strncpy(chinfo.name, channel->name, sizeof(chinfo.name));

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Split series per subsystem.
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 drivers/rpmsg/qcom_smd.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 07586514991f..5bc5a0a6a8a7 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1546,7 +1546,7 @@ static void qcom_glink_rx_close(struct qcom_glink *glink, unsigned int rcid)
 	cancel_work_sync(&channel->intent_work);
 
 	if (channel->rpdev) {
-		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
+		strscpy_pad(chinfo.name, channel->name, sizeof(chinfo.name));
 		chinfo.src = RPMSG_ADDR_ANY;
 		chinfo.dst = RPMSG_ADDR_ANY;
 
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 6ccfa12abd10..7c8c29f6c91d 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1089,7 +1089,7 @@ static int qcom_smd_create_device(struct qcom_smd_channel *channel)
 
 	/* Assign public information to the rpmsg_device */
 	rpdev = &qsdev->rpdev;
-	strncpy(rpdev->id.name, channel->name, RPMSG_NAME_SIZE);
+	strscpy_pad(rpdev->id.name, channel->name, RPMSG_NAME_SIZE);
 	rpdev->src = RPMSG_ADDR_ANY;
 	rpdev->dst = RPMSG_ADDR_ANY;
 
@@ -1323,7 +1323,7 @@ static void qcom_channel_state_worker(struct work_struct *work)
 
 		spin_unlock_irqrestore(&edge->channels_lock, flags);
 
-		strncpy(chinfo.name, channel->name, sizeof(chinfo.name));
+		strscpy_pad(chinfo.name, channel->name, sizeof(chinfo.name));
 		chinfo.src = RPMSG_ADDR_ANY;
 		chinfo.dst = RPMSG_ADDR_ANY;
 		rpmsg_unregister_device(&edge->dev, &chinfo);
-- 
2.32.0


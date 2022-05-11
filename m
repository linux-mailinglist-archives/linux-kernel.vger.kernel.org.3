Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DA35232B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbiEKMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241925AbiEKMJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:09:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1723CF68AD;
        Wed, 11 May 2022 05:07:46 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id i24so1804779pfa.7;
        Wed, 11 May 2022 05:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56+DPsjLCWIXnMFTS6urdo6Sa/aYQ/f5L9qithdpcbY=;
        b=Xwc9q/vYLZyd5OxtUTp2jA8G9MWkLDQkKh/2m4QIBExigtpXTfXTrJw5+vWnZ7Z35i
         up0G7LPQxC3OPxmjLQN1turtWupOCc3kEpl+cA8jCNT2TJLmSl7Qxn5VoCVUxej2ezbg
         MQi9faKxZ/p4a12SRtHuiCe7cRIP/pCZ1GZcKklw730rqEb/nmtoPwt+IF9jfCyciHRZ
         gOZEJmaFDB3y8bjryGMrUEERv3Mj67EwomPYQpACYc2pPZKdegzRStt32/+rgdu5s+Y9
         ib9rujvehQfAcfdW2f8a8qWm8mdpyJx0l/RStGgDHdR0l0UCQ5prJ2GTpEfUO/rR9JZs
         jeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=56+DPsjLCWIXnMFTS6urdo6Sa/aYQ/f5L9qithdpcbY=;
        b=dfjxPCe8kffc/rJJ9oEW0xZBTA9Lys9d5neq1M3mTI8FPD2C+fKzfVpFrivqpV7c+l
         mc56SDP5zoM4J5CUwyur1dz1lFB+sp2R7bAbtrub401ROrefdJoNnHNWN1G22aXaYXxh
         vgHN8m14n0/YJ2Zm1+bgbSn5D2jXNBTIXqYB/UEGwVzvnJn8SwD+Xiy6k7e8Cw8mWOWb
         yUx9pzi3WvBLkbCCbWuM/JWoroa2KJ1lhPUh43JhnivpIdkOGd98tU/dmOLsQX+NdARm
         GxK7i32ihtWuPPKC2OknEmedGDnQHTNIfU3GcjUFtnMVepWDtVbAQjoYbnJMbXVrPPLv
         tvtw==
X-Gm-Message-State: AOAM532mTgH+BDzMhkhDytBOlJPwHxg1JSLWShYkCv/B9AGDF8EF4q5K
        ebSG1XQ59i3YyBs+5LqyAwCgP3VvqAQCNdIMsWE=
X-Google-Smtp-Source: ABdhPJweH4nbeVPEIduNamjHzGab/QU+6yP2eOi6bMT+xFKn1qs/s54IW+rS3Brmk9Urv8KyPeJXEQ==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr24904554pfu.6.1652270865593;
        Wed, 11 May 2022 05:07:45 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n24-20020a62e518000000b0050dc76281desm1531733pff.184.2022.05.11.05.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:07:45 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge
Date:   Wed, 11 May 2022 16:07:37 +0400
Message-Id: <20220511120737.57374-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.

Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/rpmsg/qcom_smd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 764c980507be..e559c8e468e3 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1383,6 +1383,7 @@ static int qcom_smd_parse_edge(struct device *dev,
 		}
 
 		edge->ipc_regmap = syscon_node_to_regmap(syscon_np);
+		of_node_put(syscon_np);
 		if (IS_ERR(edge->ipc_regmap)) {
 			ret = PTR_ERR(edge->ipc_regmap);
 			goto put_node;
-- 
2.25.1


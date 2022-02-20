Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4774BCF61
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244182AbiBTPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244137AbiBTPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:15 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEB34BA8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l123-20020a1c2581000000b0037b9d960079so11963000wml.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pf5vtF70QE670/zy9x2D9iO6InpzY2CVU4NmEaKqKg8=;
        b=BMMOl1xMnBQf1ucf5/yvGfCNwbTEvqry0jwNgBq0Xd4MhaMPMgdCHZ5+lp3hqFomhC
         3aur/ibsios9v6rS8YHQ4vntpZhwSv+vndrGjmxW21rBa7+htjyFDJ6yKE4o6HDj7/bp
         q+FkxLqcUUo50jZXZg8Q34upkxT6PcNxRLYLsRaufFIyyQIKjW+AegEuSXS8WdQ3pziN
         6/pSO1m8w1HgiHRQqq51JtfA40ZLod5uuxq8ooHDLWYc4KNn1FFq39f9quZ0ATkxwzcI
         jtmg2xjAuB713l1gCbsGrpThpw5KnYiu5EgidTG+C/qdT+kt88B3k0cP/jm0WS4rxcCM
         f24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pf5vtF70QE670/zy9x2D9iO6InpzY2CVU4NmEaKqKg8=;
        b=Oc2QXPdn3mLW5zHg/GQRJVvEBJpIRMBSqCnFFHAEaEfGKnotHH9uvrz4QEUMpbNq3G
         Fehf+iO4PstnEeNtJH2OXXQQfWXJe20hL8CDsgAjnv7QAuvS3S7oU6/UQUx0/6RIdrvT
         RLBE6qMVzwJXKPuAvb4Qz8Av1OBKEApHOKXtnrfbdg3xylWKCnGZ5kZDrVy0MqpP6oiz
         8lqHpKCT8HgJshm9lbEvJbS7aDhCcAVQUsWk4FwH6OYcrz8MKOrbM88n4dtDkcfuPek4
         eJ3eTYWwwMuz/zkgLXOh0x8M1qzRvGVScd7VPW55hEyaxoucT7M/RzNYP9qVLzbla2b3
         iQ7w==
X-Gm-Message-State: AOAM533zfwmsm3QQvoqesTOdla4jiVbHELdy3k0qvutnirLIU2R+/G76
        /MFNEVEn6+vTsB1kalttZNzqgoQcOYi92A==
X-Google-Smtp-Source: ABdhPJzDWjwCBaTvu+yfVT9JaXW+sRUidaWczhorhNHafST4svo0ybZoy+srqTY9RNNzsRg/3AtYng==
X-Received: by 2002:a05:600c:3c8e:b0:350:5358:99bb with SMTP id bg14-20020a05600c3c8e00b00350535899bbmr15071548wmb.13.1645370152634;
        Sun, 20 Feb 2022 07:15:52 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:52 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/13] nvmem: qfprom: fix kerneldoc warning
Date:   Sun, 20 Feb 2022 15:15:18 +0000
Message-Id: <20220220151527.17216-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below kernel doc warning,
warning: expecting prototype for qfprom_efuse_reg_write().
Prototype was for qfprom_reg_write() instead

No code changes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index c500d6235bf6..061293f9136b 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -244,7 +244,7 @@ static int qfprom_enable_fuse_blowing(const struct qfprom_priv *priv,
 }
 
 /**
- * qfprom_efuse_reg_write() - Write to fuses.
+ * qfprom_reg_write() - Write to fuses.
  * @context: Our driver data.
  * @reg:     The offset to write at.
  * @_val:    Pointer to data to write.
-- 
2.21.0


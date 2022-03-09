Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C24D2B99
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiCIJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCIJPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:15:50 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291015721B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:14:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b8so1765539pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=beOK8LcrpNIYxKGHWeVR9pv2W0RzrKRTl8AZ7GHaXos=;
        b=jBqEWkQU5UX4HEI5ow+RV02EDbId1BdW1x9Y/br/jcsO/GwOar1x2/mlXrIDYYc/9Q
         HhRLqkbuxhyPlBwYBO8rBYy5oD3lqG9YlC3+lVdhv8+D8XI98xA4G+7x2mSmpfDJenQl
         CxRlT+T7gPZHDCO0shUM689V+DexdKc62yZ6hlGoSA4xZHbcDq+1F29SDYGO8R8Km92v
         wIjVVVzjzu7ttBIBaWem6u77RcLC3596PDbqoCJZjHoA8PwJbbqf+EcTb9QcoF8xtF4o
         GTqz7Sy5L5yfWQ4HApsqXLMK3RMfvX5/XpRXucWoMFQoUbfERVU2fnE6Zyoa+KUQ+HZp
         vfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=beOK8LcrpNIYxKGHWeVR9pv2W0RzrKRTl8AZ7GHaXos=;
        b=K3Mt3JypvqyuPng4jPzx+N3lykt/sndLRCtl0D5t2MPpE1vvEmXf2XcYnTxtRoKEWn
         +uEA4obD6zxA5yzw0rWlbCurBXxNc6tQEAKmjnQ0mCqII9AZ6XiTz/SNvKF4/kGOHud1
         fvAb0N3wcBYVOLmIvUnCRIjMQA9CW5vhEUEH/97tEK1HrgB6pDWF7DDQNu9UZq1jAeCS
         1Ud2ITb01AhwSo4y2iXGD4gRL3PsJpd+kk+4qy2kgGdum6dXIXk7GJq2swxJ71FHS/1S
         tv+OABdRO7sxcC+Smr4TWlN+Pob1sP05KuaFX7f1TNmca6jBbJ1YlHCsUxmAhFWJl0Cq
         CEZw==
X-Gm-Message-State: AOAM53211UcMgLpV1i+MHXWUCWK4Ex5pW54FADTwBVo25wv4n3IXCmez
        tODxjYR6+MRUHrn2oA7siwQ=
X-Google-Smtp-Source: ABdhPJxxLHSCqMw3qJsOgKLX0VzKOjKXq0movyQleTGzWe0eovbbdZ9wvpBmqv1zB4cE+bDlh4ZIWQ==
X-Received: by 2002:a17:90a:3e42:b0:1bf:53ce:f1ef with SMTP id t2-20020a17090a3e4200b001bf53cef1efmr9294168pjm.33.1646817291893;
        Wed, 09 Mar 2022 01:14:51 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id v24-20020a634818000000b0036407db4728sm1619625pga.26.2022.03.09.01.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:14:51 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Li Yang <leoyang.li@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: fsl: rcpm: Fix refcount leak in copy_ippdexpcr1_setting
Date:   Wed,  9 Mar 2022 09:14:46 +0000
Message-Id: <20220309091446.2420-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: e95f287deed2 ("soc: fsl: handle RCPM errata A-008646 on SoC LS1021A")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/fsl/rcpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index 3d0cae30c769..06bd94b29fb3 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -36,6 +36,7 @@ static void copy_ippdexpcr1_setting(u32 val)
 		return;
 
 	regs = of_iomap(np, 0);
+	of_node_put(np);
 	if (!regs)
 		return;
 
-- 
2.17.1


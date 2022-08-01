Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59382586276
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238044AbiHACRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiHACRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:17:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66339B1C0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:17:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso3600160pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=s20z8eRXfLEIUD3TINiPPAOn8hB094Z2GTQDorgQNA0=;
        b=GcqNGo61T+Iz/hk9Q3x+3++vCMbycqOiy104QVmU03CUrAWIK4XOylLKghQZXeRC7r
         xCA7d1dVi5PsY7sUfuq5vtMrnYzBYnMcGzu+R75yBDgksM1D9kj0uDYrbhC/dXiVnzES
         uy+UfrvaAwA4/qIHAEwpYGmu1vN5n/mVgMczm6+2dwmFok84T3p52uGupFzhNt/QjZYd
         i90/yXdYUHBJdRJdfEzoXj/OuZWiIhNF4/ZOSS1kW9w8jnaS3iT43p6B+2/up1OT0tfA
         l8EipeCcOpFCm6urFpy3pj1c/GSLruZvv8e1z6VKOC2AeZ4l4gtv2Mh9hcMzCA+NMPtL
         qWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=s20z8eRXfLEIUD3TINiPPAOn8hB094Z2GTQDorgQNA0=;
        b=n4Js/u/rr3acTvzaoiR5HoBWcsvKH4JJkTtRgTmE41Y5YhX45uhWoLrC2BfUDetrb2
         5Zwu8cTqeF3Q6GKCBpw8i5Ps7eUikhq142wssPHs99ucmvO9/07RnPsGkTgZ6AtrVKUY
         VVVdQfjI+1gOOpWCl2E1SFCBjNokmdKsOGATzozqnpYQ9Osz5vrtI0Yq6ol3wkHlCBN2
         3x5N6KNTeQtRumi1DMHbAMM6rfZ80NUf+neyuopUAc7zwJmzSxGRZahYG/Xzy7cikpBD
         pisOF50H79t7LdYqrCE0v41IXIWGXsQaeDxdtU+w/Sl3xluUyPeD6UFjgf9A9jA5nwkQ
         0ufQ==
X-Gm-Message-State: ACgBeo1XlzGYSge8NUBB3UyrylVX+c6pabKqkDmcUXf+EAA7GAZ6aE0/
        M80xXmiovHci/OKZibFwwQmaPW5HRtk=
X-Google-Smtp-Source: AA6agR5ndQPWZliMM6KyBvbrkposaaYWFJMKFJgxh/rBbp9+WvDbf8ns6/UxlKA/U7/kqfCyIwe9yg==
X-Received: by 2002:a17:902:ef48:b0:16a:1d4b:22ca with SMTP id e8-20020a170902ef4800b0016a1d4b22camr14342008plx.6.1659320261820;
        Sun, 31 Jul 2022 19:17:41 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b0016e8178aa9csm3107562plx.210.2022.07.31.19.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:17:41 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] rapidio:rio_cm:Remove the redundant  'flush_workqueue()' calls
Date:   Mon,  1 Aug 2022 02:17:36 +0000
Message-Id: <20220801021736.1593949-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

calls 'destroy_workqueue()' already drains the queue before destroying it,
so there is no need to flush it explicitly.So,remove the redundant
'flush_workqueue()' calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/rapidio/rio_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rapidio/rio_cm.c b/drivers/rapidio/rio_cm.c
index db4c265287ae..f2c0d6aa911f 100644
--- a/drivers/rapidio/rio_cm.c
+++ b/drivers/rapidio/rio_cm.c
@@ -2198,7 +2198,6 @@ static void riocm_remove_mport(struct device *dev,
 	if (!found)
 		return;
 
-	flush_workqueue(cm->rx_wq);
 	destroy_workqueue(cm->rx_wq);
 
 	/* Release channels bound to this mport */
-- 
2.25.1

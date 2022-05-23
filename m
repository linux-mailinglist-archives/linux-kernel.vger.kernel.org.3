Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB8530F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbiEWLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbiEWLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:13:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D355D42A1D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:13:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso13412468pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MU4ldY/KKQ7x6HdyLyTzK8+POLvoalMzKBDpRuqN3A=;
        b=O6isjJisF8zfVoHMH/V6SL7/PB3Dpl6+Q2VFqxdLBL02mOK+Irmi3ZOPSuoWxm2oGu
         k6vdLLillOLOj0i/rYSECI6W4B8RnqjxN3zyrEMnimOVsy3wHHqxZfEX6YmW/AyGNmCq
         vhK+tKjAH5k6tC8KAyyXH82J0xOTlLT3fbt0cS6QzEr+Vlx0/NXSjh963sRw2M5t3hX5
         7JmkzdIDYmLwgEs0SQBxMlQJ2abGbw+4L5Njo/1dm4sZm/vgIn2RLJhENbNvAOeGTjYr
         C5/0ghQirO4ZMsO808l23MM2oZz3jx7+crb962eBYCaxycnPAY91/9LrbdBqPxC/182+
         fPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6MU4ldY/KKQ7x6HdyLyTzK8+POLvoalMzKBDpRuqN3A=;
        b=45vPFVV6Jg5U3fWL+/xVATQ57BfxOeNBJGXdGA/7J7n8JvW63h5+FhG5uCrUmN7lCE
         P2NjGJqMzIqn0BirRmyhVlgxpXOMyWs/3C31xvCJWxpefbqKstqpinpZdBb72un9I3Rm
         4nd5UphohOXZP6w8uzCAyLGwtjQKGgAO2xGrmw96Oi7XCIsoBtwsTybbWbGSkXIk7CR9
         VE6qEgvXnwc/+lr43ZMsizLIVenSK2Mm549BFKQwFg4FnG+vO0Pl+3X0A9f0wI2Ar+/r
         nmFs0AuiuEjQ9IoBZ24F+b0UijtKcHREHpwJ0IzoJqLkQEEz5pzzPrh3tjdmHcAg+3yZ
         uC0w==
X-Gm-Message-State: AOAM5329bSdjJgJ30N3hpZHeM3RFtbYGV0udxYEG2FCowPnYlP/c9tm4
        OTHupnTC/Nzhe9HZTKKmQeX1MpI3wbE=
X-Google-Smtp-Source: ABdhPJw8BU3yPCHMkeCKE3uBujzra32Cuop6EPOK1TrvuC1BucPXSiVwwRcIpj/Ir5lQAuWlvrHBrg==
X-Received: by 2002:a17:902:eb86:b0:162:1654:4a08 with SMTP id q6-20020a170902eb8600b0016216544a08mr7475066plg.72.1653304407301;
        Mon, 23 May 2022 04:13:27 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i123-20020a628781000000b0050dc7628150sm6953126pfe.42.2022.05.23.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:13:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] firmware: Avoid leak OF node on error
Date:   Mon, 23 May 2022 11:13:23 +0000
Message-Id: <20220523111323.3183-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

The OF node should be put before returning error in stratix10_svc_init(),
otherwise node's refcount will be leaked.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 14663f671323..3facd5dfb617 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1109,10 +1109,10 @@ static int __init stratix10_svc_init(void)
 		return -ENODEV;
 
 	np = of_find_matching_node(fw_np, stratix10_svc_drv_match);
+	of_node_put(np);
 	if (!np)
 		return -ENODEV;
 
-	of_node_put(np);
 	ret = of_platform_populate(fw_np, stratix10_svc_drv_match, NULL, NULL);
 	if (ret)
 		return ret;
-- 
2.25.1



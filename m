Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B014B0605
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiBJGET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:04:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiBJGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:04:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CEA1C1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:04:18 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id y8so4118206qtn.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IguWedCfgYcNS4qqgdsH8hKCfOP9gHJvHTgKmsnzDo=;
        b=qkDCU8kTDf9D6+ZTpxLGrT0JfQ+PJhEBRB1E+iQIpQQxlhevHiq0V4j3bPXeetlVa8
         +/mwbpdkKxM5I6XJMX1Burn20+acMhiclCQK08f/0Tubw46VekO285B6J+4xR8p5Vgk6
         cXZZNhnExGpkIc1O80V0549vD59AjJKPg4hMF/MTn+WDk0UVlYhCAtwz2QivXXka8xGi
         cdr/wgtmE46mCeBbccH0FXbBAism2M/nCey1DS9LgIb65977c/+Qfrngq69rGnw1MWJd
         G3jcBiUrAi6gK9V0t/pAR6D6HALGy2IxV5bZ++0zpiWHtbYlKx8tCHbd+gKXxD3+j3O6
         +JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8IguWedCfgYcNS4qqgdsH8hKCfOP9gHJvHTgKmsnzDo=;
        b=GAoGDjIRTFsJP5UhLp6pd1zWJoewKSJ3Az+wGWAfR6D0Gezh9EgDDYwt9uyDPQhDpr
         i7buqP7kucPv6NilJLLaT16+rXLQh25UjZaVzMfNmKc9Dd8MglejsOJVNdLv/99DRX1w
         BFdHP2GPudCAqsLxYYVRs4i6bw/tR51ypvEwQHL/1Vdw498NucLSsjIW9jS6M5ivZxWP
         QStQzDuS7133CpHCvssphNb9v9jDcTJZzilkqN79OOx433JOumNoYoHepCrZOXimG2Bn
         03rftqH70Q7aQkqmkejf2ndAzIElHavqp4iB+nCCsHTlzrgDFYu1Ql1xIbQT1PAsrEtx
         Neeg==
X-Gm-Message-State: AOAM533GZA6jIh2iRO2/76SN3V+otPfiKBMDmHswUWW3F8XuygUMPGOw
        IuIV39/IWOByptuL/ntka/I=
X-Google-Smtp-Source: ABdhPJzVOlJFWyeIEgnZABXxPt5TemSYedk7zgAGGRMXt1qPyKyK9DYyPdgIIi1ViolAo7T/o1pX/g==
X-Received: by 2002:a05:622a:1348:: with SMTP id w8mr3956850qtk.216.1644473057357;
        Wed, 09 Feb 2022 22:04:17 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y20sm9234632qtw.28.2022.02.09.22.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:04:16 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging/ks7010: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 10 Feb 2022 06:04:11 +0000
Message-Id: <20220210060411.1607928-1-chi.minghao@zte.com.cn>
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

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

'destroy_workqueue()' already drains the queue before destroying it,
so there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/staging/ks7010/ks7010_sdio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 98d759e7cc95..9fb118e77a1f 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -1102,10 +1102,8 @@ static void ks7010_sdio_remove(struct sdio_func *func)
 	if (ret)	/* memory allocation failure */
 		goto err_free_card;
 
-	if (priv->wq) {
-		flush_workqueue(priv->wq);
+	if (priv->wq)
 		destroy_workqueue(priv->wq);
-	}
 
 	hostif_exit(priv);
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A9D4B0603
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiBJGCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:02:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiBJGCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:02:12 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF51DF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:02:14 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id s1so4109638qtw.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKrz6bApi0/dsmE95e4g0zGa9CuMMOhYtsPE3YuMXWE=;
        b=hQw2cIl4ZF4Usav+Wpu99AIfOMknmyChe7N4wleG0Aqh84i0EYKXwuPtxfprUWsYro
         hwrHjwskZM9feaFA9SQatg8ZnR5P28T83p4u9EJ5AjCcAq6GdGsyS5v3J/gazY1Nhr3M
         4maSe8esqQGnkPir68BRJ0qCNDBKkF1Hu64pyUgT5hjQ07vPp4GNv4kekFM9kiVuUJgm
         qjbZllq/DvUx79jgGssoHGVzOWKOJDTOgu/So2qLGky7Cir2ogq/3oG98uKEJIQBjm4m
         BKcIBRmToGjo/HI7f7Uq+VJrjLfXCfspfcDpxCcc1cxKmUj/DcF7VIcqrCJTw+4nu7K0
         zeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKrz6bApi0/dsmE95e4g0zGa9CuMMOhYtsPE3YuMXWE=;
        b=a75I64vHI2vVKTC8p7fyB80Iyr8oBhG7xkjHTfTPRz9yjVpeKWRKU+Rhl3pMZo9n2Z
         3HXQAIstNxmzzYB+yXE+ea3CDxHmrcK6ZlY0oO2WKvZxKsbFv8n5DskHMk4Urj8aJ00x
         X6OQL1vEybtrf9+OSShAsVjei7OZ0cGE+YbUs1O+cjnloa4I0+fRxVjyrS7hcHVrkdsX
         bxlFc3uX33XFIjlsEwTNQO2Pq1yH6Bj/f2ZJVesUWN4VNLt44mCCN8Oay28OCaoFsmaa
         bijQz1uwbD/xRT5VZ8EUVp9PtjeecJfOobWgaqu+ctAUfe9YX4/HMKDiAJV/m5cwsYfQ
         Mylw==
X-Gm-Message-State: AOAM533FTNaaiXGDVb/VhUepMITJSQJdKeQ45Hh6vMcaU2Z9qDZdht9d
        sDb7J2vRVNDcgvuCzKS7WSg=
X-Google-Smtp-Source: ABdhPJwsJcp4q7PEnSA447KhyLtwRARtizksuTwP1Dav6tE4wkPVKCyLIGMnuqsMHDXS0p0l8STZrQ==
X-Received: by 2002:a05:622a:64e:: with SMTP id a14mr3689197qtb.212.1644472933488;
        Wed, 09 Feb 2022 22:02:13 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h9sm10009584qkn.121.2022.02.09.22.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:02:12 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     rmfrfs@gmail.com
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] staging: greybus: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 10 Feb 2022 06:02:05 +0000
Message-Id: <20220210060205.1607792-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

'destroy_workqueue()' already drains the queue before destroying it,
so there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/staging/greybus/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 37bf04c22dbc..25bee5335c70 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -858,7 +858,6 @@ static void gb_sdio_remove(struct gbphy_device *gbphy_dev)
 	gb_connection_set_data(connection, NULL);
 	mutex_unlock(&host->lock);
 
-	flush_workqueue(host->mrq_workqueue);
 	destroy_workqueue(host->mrq_workqueue);
 	gb_connection_disable_rx(connection);
 	mmc_remove_host(mmc);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48145A04D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHXXwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHXXw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:52:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C36A66A7F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:52:29 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x26so779011pfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 16:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=P01vQ2JoR/cM4D+rwWuj6mVSlL9X74ZSvC3QMeu2a8E=;
        b=TZ34PH53vQZrTsICY9qFnL84MauGTrc07dOBsJc2OGqbJ/4z8bu4E9n6EZp3prNNz7
         z4gfmp2ITAiEQht6HdlmtLyMQtttmE3db6sL/juAUaJSj5EzYkfCwAD2pWvlyEKkLS5z
         SslGg3VYRw0x99+9Nh/V2QO/gL6z62G+DEvRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=P01vQ2JoR/cM4D+rwWuj6mVSlL9X74ZSvC3QMeu2a8E=;
        b=t0dw7KQYFF0ks3uwroP7cmkjN1BmyM3Ih7DvOpDNcb6jmkfZUDq6zGkeUi1iLJ/wVS
         dmcPeUIuFL5glMeDArJlGADuLbKgfzBq5nP76fWamM483IoLIJQ39wnEm3ZCgL5mRF3j
         byUzkLNc2mXVeeXonoA+PArGL0SEQRvvVefJkqY6POKLNCT2jQTzST4h6WNFoqdZ9K3r
         do0ZiUtyNkHlVPeWqN5jd9j4MLRX1lAivoSCPq/FdT/HLFZ4JPQMm/TwswqTvmDggyOZ
         FD3kHYKBHg2EJImVKxm1F/T3Pw1iXPOjkUAJBoXc5Nm+ZZabh3NUBl5ESI5k90FxRZby
         wRTg==
X-Gm-Message-State: ACgBeo0XwzDw1zSDwEKcpHGVelUmEVQWDgPzjlh4h2W2G70nl72pDMO4
        QmfGAqDvgxKiMAK3Z/99kD0h5A==
X-Google-Smtp-Source: AA6agR6TF1fyhY/TfS+Vh5mVLXYztqpQzvQ486UBYIe1rb9aucrxhOqGeHgm9BMDH/f7NbykghxETQ==
X-Received: by 2002:a05:6a00:21c5:b0:52b:fc9c:295b with SMTP id t5-20020a056a0021c500b0052bfc9c295bmr1513014pfj.56.1661385148815;
        Wed, 24 Aug 2022 16:52:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:b7d8:1c85:ef67:47be])
        by smtp.gmail.com with UTF8SMTPSA id q7-20020a170902a3c700b00172bf229dfdsm11380069plb.97.2022.08.24.16.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 16:52:28 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] drivers: base: Print error code on synthetic uevent failure
Date:   Wed, 24 Aug 2022 16:52:16 -0700
Message-Id: <20220824165213.1.Ifdb98af3d0c23708a11d8d5ae5697bdb7e96a3cc@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we're going to log the failure, we might as well log the return code
too.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 753e7cca0f40..fd0410329046 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2509,7 +2509,7 @@ static ssize_t uevent_store(struct device *dev, struct device_attribute *attr,
 	rc = kobject_synth_uevent(&dev->kobj, buf, count);
 
 	if (rc) {
-		dev_err(dev, "uevent: failed to send synthetic uevent\n");
+		dev_err(dev, "uevent: failed to send synthetic uevent: %d\n", rc);
 		return rc;
 	}
 
-- 
2.37.2.672.g94769d06f0-goog


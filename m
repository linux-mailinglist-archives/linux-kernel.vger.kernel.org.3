Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35D8506968
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350869AbiDSLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiDSLIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:08:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D5326112;
        Tue, 19 Apr 2022 04:06:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x24so3436434qtq.11;
        Tue, 19 Apr 2022 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHLaG6wzlg3DS+2jvTJoEHffFZEl1r2h8qVh3D0y4MQ=;
        b=mouJCdDLuf3Ivi+HYlCfFAto6/lHYZ0nbBuS3xrYq8FUHkeHqcdG8mhfyQJ30IFrEK
         AYRC4Fm7Wb3lg1/kOvK+cwvyWAsfglUWwCAgh1LCYsw4nnvDSk7Jka6CC0qFW1OiBdl7
         8kA22PqvKCTeuSOki3gaZwx8NgbVwTBpTE2AXfWl80MfloHKQMKfhpAzdgQjbIdkAPYC
         pnYjCxNXGF59tXvzG3+ec6X2SSb1ymzcbSqzNDMgoyiffpvLCdHTHjYu6+MNcC9r3hBv
         1teZ1+Tv+FUAkv/xMBZKrv7+I0bIlVt+W9/VzUsut1HdfjFjl77zo9syM7gCAcJVbzO1
         72TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHLaG6wzlg3DS+2jvTJoEHffFZEl1r2h8qVh3D0y4MQ=;
        b=1+H9zvwCtUcxEcf+RK2mxQm/zFbWgs54QPGOTC7C1ba1W96NHC1IG5ZtpQkZxh3bxs
         H1y+E8Is0XDYTd9o6a2x1UjaVCRg09lFXk5oKNB7x79r/wjoW55kn/hk0TndhJ18THcY
         zSCzZCdBFaczWk5SP4dMVMJW0US58o0xZtfx+iTX+xnlD38OkfoWtnM2b+3y4iN3NIDH
         Tm1S76FhzTTwxQ6rHCoUEnsZAww1wSjSCvdzg8JpWK+7wP9ZfjNyPM2oz85dXSLM2WLO
         Y/vRO7hcDcOlDkiET7o1D1W6ZtA7Bd9VoP8alRTEMkO9SUkDWoLE2Xkx5VL5hsmz/Ebc
         uexA==
X-Gm-Message-State: AOAM532c3q0ojJlGuo4kZUMwRIXIrNkLij6LhJoFlwblgPN6rugUYq6D
        1EikW2uGswnvRdNCX9+hsP8=
X-Google-Smtp-Source: ABdhPJxiwokIB9jE5P6wQF8qmYX/o7CWvc+ZXkIiw2BVXhf4krm0mE6yrl4jSEBsuKLO93BIWdoQdw==
X-Received: by 2002:ac8:5f54:0:b0:2f3:353d:76c7 with SMTP id y20-20020ac85f54000000b002f3353d76c7mr2042916qta.366.1650366360447;
        Tue, 19 Apr 2022 04:06:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b0067d47fb5aa4sm7906519qko.63.2022.04.19.04.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:06:00 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     hadess@hadess.net
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] USB: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 19 Apr 2022 11:05:53 +0000
Message-Id: <20220419110553.2574548-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/misc/apple-mfi-fastcharge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c b/drivers/usb/misc/apple-mfi-fastcharge.c
index ac8695195c13..fba102245d8f 100644
--- a/drivers/usb/misc/apple-mfi-fastcharge.c
+++ b/drivers/usb/misc/apple-mfi-fastcharge.c
@@ -119,11 +119,9 @@ static int apple_mfi_fc_set_property(struct power_supply *psy,
 
 	dev_dbg(&mfi->udev->dev, "prop: %d\n", psp);
 
-	ret = pm_runtime_get_sync(&mfi->udev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&mfi->udev->dev);
+	ret = pm_runtime_resume_and_get(&mfi->udev->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9A650696C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 13:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350879AbiDSLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 07:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346610AbiDSLJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 07:09:30 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D902613A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:06:48 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hh4so4435448qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bIvZjQJaLySDI3kb1qd8szSRM+su5jG098wLkG3YjNw=;
        b=oyj3cJVHZEt9SADkIqYCINJZl9s4Boy7THU+iOTgUHqIoB1BDWXeombf/dlSs3dgGZ
         TWNMKMeu2Mj/YDEFX6UD01QUm9WHn3tdqMVU9d3nARmo3Mw+z5kky6RMU1l6q2vyIg6K
         2TxA5bs9McwrJEG8cUpCHbUytcJsK1Ek0SFxXnqBECAfVBYxaxsvWZnKYTpRA37izSE8
         w+brg1xr67l7xrBgB/Y/4+LsOHTTZADLqDxliNvk2+5TVTRoBBhEEcYdjkzJ3yUv2rMT
         kQN1iCixjyRmiOfp6nvU+qLnBtRJSVlQxQdY7+W2ckwDQV9lalo6j+jCbhcHEOUaj2oU
         GQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bIvZjQJaLySDI3kb1qd8szSRM+su5jG098wLkG3YjNw=;
        b=wY2SiGKNpZqFekublmcrQIm0F3d1k9W7A3aYY5tlgkkcOaT8aiWFk/yB8ce4nTgbwi
         QYg7CSBUpd8EcGv3KC4HQKJJYva0po0Xz3h7mGgp559GSGQCHE0xdPKI/saPqjfeNW+a
         NNz29Hy3Z/rRWdyz71on7KCIITr44wK2E9B7gNCCcpfT+BkNn1oMjwWfBHDm85YDg+Ql
         VxYqZEIZSSXlTkZ1xyYkGdej4IwEB6Ss/grs8xUyLumdiVV2/Ywqyu989Nzak3p08/E3
         wu/WNMTqsE8ZfyoTSUROR0n2I5TqgGDDn13l7eazYG4C+u6BaAXZ5ofp/ZBWhIXfFqa0
         Pq1Q==
X-Gm-Message-State: AOAM532KR92f5gci7nQPUd2LD1102Uqr1AZmbtERL2kNYtToul+mXUL3
        IRG2JpMm2RlrLan8Qcv6M2Q=
X-Google-Smtp-Source: ABdhPJy21MbNrUsUO7ej48H7XCvbDhoGMvLv9d1+jMAbBaWEXgqF56DG5F62ptskX8U2bBfkvE+nvw==
X-Received: by 2002:ac8:5a90:0:b0:2f1:f1c0:e0db with SMTP id c16-20020ac85a90000000b002f1f1c0e0dbmr9811200qtc.620.1650366407749;
        Tue, 19 Apr 2022 04:06:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a070900b0069e60da45aasm5783721qkc.60.2022.04.19.04.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:06:47 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] gnss: Use pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 19 Apr 2022 11:06:42 +0000
Message-Id: <20220419110642.2574612-1-chi.minghao@zte.com.cn>
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
 drivers/gnss/serial.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gnss/serial.c b/drivers/gnss/serial.c
index 5d8e9bfb24d0..afa7a08d718e 100644
--- a/drivers/gnss/serial.c
+++ b/drivers/gnss/serial.c
@@ -32,11 +32,9 @@ static int gnss_serial_open(struct gnss_device *gdev)
 	serdev_device_set_baudrate(serdev, gserial->speed);
 	serdev_device_set_flow_control(serdev, false);
 
-	ret = pm_runtime_get_sync(&serdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&serdev->dev);
+	ret = pm_runtime_resume_and_get(&serdev->dev);
+	if (ret < 0)
 		goto err_close;
-	}
 
 	return 0;
 
-- 
2.25.1


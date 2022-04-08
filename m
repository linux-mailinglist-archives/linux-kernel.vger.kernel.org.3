Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0304F9084
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiDHIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiDHIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:16:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A95D1A3;
        Fri,  8 Apr 2022 01:14:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 75so1386172qkk.8;
        Fri, 08 Apr 2022 01:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pM1bFLWfOo7rc/PnxLcp8zaWNFzjr+zhCEHz91chh40=;
        b=nHxmqdAMU5kYkZ+xk23GvmNIHGA1r1hKprfaDP/jAh5gRzKafrdO5qxPj81lyLwIpn
         ZDTvTP+htIGkY2YkIrjjl4QbBd3Eux873VZ+47Uaz/qBLjWtfVMHDxc/YmEV168pVYRr
         3ESk4BERDCpwsqFmV45tmpm3ht+3v+sjk/RVqJZrCvy7JO6WREWnDRB2kA9NgqyZ8kzs
         ZP9yoAWOR0H1sKyyPtO9uokR9GJyStfmlhQ5Vf3y3uWyDc+DeorH3OXTSMf44Sxjj3o9
         07L1g3WQuQIp3UJjrznawPKfJTyUiFTgHs8okUGxiAHarjyt6OUqIFrDPUS5fOH3c0f4
         +Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pM1bFLWfOo7rc/PnxLcp8zaWNFzjr+zhCEHz91chh40=;
        b=UK5j67f7lu/v6zF6YlsZLOLcwMflUkdIbHUVvERYp3gNlVVa/nr0Lg9waMy4rv9ad7
         6x+c+4iSoIhDDGsyX7ddjUKB+AGQdpCyk86+BrbmbEQQ9LqZ5uAhI4RQ9vh8UMDKXS+B
         HZGbf2M9QpeFMg5T1BVGmuG0GUWq9JPKNbyohv87VPVfsjup68/kEe9yqBZMZNQgRZQ3
         2SJ7DV8pRBfMTif/K4VK5EI4Nep2YWArd4gcuvOts59Xh8EQcvDI3Vgpqq01Gs6jCJHK
         c3HsfAdowJVgPDAgMLHo58jcOFIm1QHnXER5oVTc/MJgyKZwmq5+LP0jZ0FDfd1D6bNI
         cbzg==
X-Gm-Message-State: AOAM5303UPkMof61g19FqP9TrfKl+hKuwIG81GYRtDtK4usCF6rKPrZv
        mk6ao1rItan2cu+2Gb3leHoodGPr3no=
X-Google-Smtp-Source: ABdhPJxIW2IohQQIj36AwOCxSzJA+8EWW/MIQiRq9IktWUF2+nkYqMxdvTWKAKdIiD6SwhOVFrgnhQ==
X-Received: by 2002:a05:620a:4541:b0:67e:4bb7:c11b with SMTP id u1-20020a05620a454100b0067e4bb7c11bmr11580005qkp.194.1649405671028;
        Fri, 08 Apr 2022 01:14:31 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b17-20020a05622a021100b002e1f86db385sm17225753qtx.68.2022.04.08.01.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 01:14:30 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: musb: dsps: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Fri,  8 Apr 2022 08:14:20 +0000
Message-Id: <20220408081420.2494650-1-chi.minghao@zte.com.cn>
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

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/musb/musb_dsps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index f75cde0f2b43..ecda7bf73589 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -980,11 +980,9 @@ static int dsps_suspend(struct device *dev)
 		/* This can happen if the musb device is in -EPROBE_DEFER */
 		return 0;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	del_timer_sync(&musb->dev_timer);
 
-- 
2.25.1


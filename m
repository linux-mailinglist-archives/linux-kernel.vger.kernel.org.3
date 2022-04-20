Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0675508466
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351415AbiDTJGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351414AbiDTJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:06:20 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9B237CB;
        Wed, 20 Apr 2022 02:03:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id a10so866256qvm.8;
        Wed, 20 Apr 2022 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnFxtwRRJ1hmS1nIOnNEgnSU72d6SNowHDJpVfEGbmg=;
        b=qELw7eNtgoerIzK6DFQqUH/yXRLuhxRa48XKr32rEV9ZJekXNSEHvOhf/L9pf8VtsM
         W1hXo3L23/LA9S3kD8An1OzwknHO7tFjAHQogOAtP9MbivLuOhH7CBY5Vu6rpV1a4pnQ
         6vczdpsgMgTNQGdzYziHw34pZcIdgdCZwmSUB+9wYj937uYwgBSmX8qgz9LWuMu/h9Ok
         JnB+PkFE87TN/lMnXNC4nrV/Iesv9OKdfwJNUWt3uKHT6t0S57OmVYU5/D8xL8qcpVsg
         2EoHGA6UG/lLQSecYHOu6dZGpmLyFHbC5P4ESSGVxOP6Hju0aWTN7iVzUFBZx/zaLj4j
         5bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnFxtwRRJ1hmS1nIOnNEgnSU72d6SNowHDJpVfEGbmg=;
        b=Y0iCN8Pg02hRotSlYunfDj4cldIBEoddujhmmm5IBG7EmQmT/BpJjpspS/C9i78K68
         mbqGrf+xs4pyIw9XyQ5SbQZXAznr3tz+ejYDxIzfqx+BOkyA93cAuPJ81YqPF+OrmXZ4
         BXJdS7p8rvDv5EwKK6qPPsFhByR9Tv12tQzSmHVq+6klcjt8mZ+pHSsouVu/xOpS90xr
         BPZ76P49/WFbvaSxgSAYBpWFEH1nA1j3tqMKBEElPSjCJFiwTgPXgUKWrQODllkRBFyY
         BRXQIIjl+dF+hR/82mFRmjEwCzLechP8uXhDwAFyOd0Tp2RMjNVyemKLgw3tc5BT5Sqy
         u+eg==
X-Gm-Message-State: AOAM531iBDT6iWG89Z4PYQevd0QMbDYJkWq4DtAKoFoUtd25z6Ejzelg
        9QrAiVyez9LpKknhdNi2qyE=
X-Google-Smtp-Source: ABdhPJwldVtKiFVgIYqhTFdpdxu00eMoOmeOJGylcIMm6/A3WyY2U+4MVMxqyMReppoUpW1MjBVO8g==
X-Received: by 2002:a05:6214:5189:b0:446:7268:f127 with SMTP id kl9-20020a056214518900b004467268f127mr5361855qvb.114.1650445405673;
        Wed, 20 Apr 2022 02:03:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k20-20020a05622a03d400b002ec16d2694fsm1413163qtx.39.2022.04.20.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:03:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] usb: musb: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Wed, 20 Apr 2022 09:03:20 +0000
Message-Id: <20220420090320.2588742-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
pm_runtime_put_noidle. This change is just to simplify the code, no
actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/usb/musb/musb_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index f7b1d5993f8c..6f7b37f5fccc 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2828,11 +2828,9 @@ static int musb_suspend(struct device *dev)
 	unsigned long	flags;
 	int ret;
 
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	musb_platform_disable(musb);
 	musb_disable_interrupts(musb);
-- 
2.25.1


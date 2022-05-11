Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498865228F2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbiEKB2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240612AbiEKB0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:26:33 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BF162CFF
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:26:30 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id y17-20020a637d11000000b003ab06870074so247070pgc.15
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ig6i6dNhVe/qcoJ1HNSo0z9Um+d3/NggOmR3Lpj39AQ=;
        b=KnDXrQUvoNUQaZe8xxoAp5TDnt+NTGd3w8Bh2DXzfn9va0GGG1yDyijlP1z4pHYCDr
         q0/J0Mvd+rfET6FX4me1NnNakdlFH+tnyIiImKO/5KUouHBNoYLEwyQaHNzyBzRpYt8b
         Ve3G90Ua5YvtQKpz3KZ3/VD6h337G0qqs+XVp770+A6JpTIoRKag7dnlJOkZeuK9Znxe
         mon3Bfl05UPg2hOWF0NjrPbma7fk6EyIu4nig7VVPDZ2E2Iaj8sCv1p5czyY0OY2hxpG
         tR+s0krOIoyZ5KXcSOY3juSQMHmGDf7vYPcm/qhMOHHpO+O+XCfKX6xIcqV43puCcJPW
         jMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ig6i6dNhVe/qcoJ1HNSo0z9Um+d3/NggOmR3Lpj39AQ=;
        b=yUYb3B8LKBolQ5aGD4ABulZ1YtjP043prkH+vuY+ZZZmzbuA5Bjw7mA8AuU6Vsk3Wg
         FrVLKDgm+CI186XDY4Hp9hspKXspS+t/F/V3Nn8HMtuRFKICH4UlUwfh5VxbPiiyQ+CR
         Yh6SdZ5c602x+UC4lusvX1gxzsdBjgjESC7RAiATy5/nZpgaFvHLG/1f8ETz07AHTAWl
         k3bfIR3u0nrG/s5qD3P/RSB/PhqhSoit5GRKCdBoWgeTmuDpWPmNpcKGv6OeMNJ2KqRP
         yquzOfvpfKC3qo868I0N1eh/ejkaSNaYGpl3+b98LKM+/L90ny1mKxOPp9ZJkhJK4Ec5
         Qh1g==
X-Gm-Message-State: AOAM532eNdfbOz43kgAOXsrTAIyAs5k7mQwvHs0I05QhLpk7RVqqhMb+
        3ZH+/T9x+j8TffzqKnNFlOuJPhDlS2uKDqHlVLw58+5GEm2BRZ9X380WpTUnoCOXGeJS3TM5Apx
        QiKdhZ5++/lKOLEwwuEq8Dk601KPrkZzIVePbHXMOW6UB5J9e4dYDraoMer4MM/U88vjKckA=
X-Google-Smtp-Source: ABdhPJz9EUji5AJvHklur+5wq4SmsV8ZcWb6i5z9oBeLAtJ5IY0BtRUGAXkxVKOXx4Q2EgbVeVEsAZuNjizH
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:90a:8d83:b0:1dd:258c:7c55 with SMTP id
 d3-20020a17090a8d8300b001dd258c7c55mr72472pjo.1.1652232389782; Tue, 10 May
 2022 18:26:29 -0700 (PDT)
Date:   Wed, 11 May 2022 01:26:12 +0000
In-Reply-To: <20220511012612.3297577-1-jstultz@google.com>
Message-Id: <20220511012612.3297577-2-jstultz@google.com>
Mime-Version: 1.0
References: <20220511012612.3297577-1-jstultz@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 2/2] drm/bridge: lt9611: Use both bits for HDMI sensing
From:   John Stultz <jstultz@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Peter Collingbourne <pcc@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Robert Foss <robert.foss@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 19cf41b64e3b ("lontium-lt9611: check a different
register bit for HDMI sensing"), the bit flag used to detect
HDMI cable connect was switched from BIT(2) to BIT(0) to improve
compatibility with some monitors that didn't seem to set BIT(2).

However, with that change, I've seen occasional issues where the
detection failed, because BIT(2) was set, but not BIT(0).

Unfortunately, as I understand it, the bits and their function
was never clearly documented. So lets instead check both
(BIT(2) | BIT(0)) when checking the register.

Cc: Yongqin Liu <yongqin.liu@linaro.org>
Cc: Amit Pundir <amit.pundir@linaro.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: kernel-team@android.com
Fixes: 19cf41b64e3b ("lontium-lt9611: check a different register bit for HDMI sensing")
Signed-off-by: John Stultz <jstultz@google.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index bf66af668f61..a11604a56e08 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -584,7 +584,7 @@ static enum drm_connector_status __lt9611_detect(struct lt9611 *lt9611)
 	int connected = 0;
 
 	regmap_read(lt9611->regmap, 0x825e, &reg_val);
-	connected  = (reg_val & BIT(0));
+	connected  = (reg_val & (BIT(2) | BIT(0)));
 
 	lt9611->status = connected ?  connector_status_connected :
 				connector_status_disconnected;
-- 
2.36.0.512.ge40c2bad7a-goog


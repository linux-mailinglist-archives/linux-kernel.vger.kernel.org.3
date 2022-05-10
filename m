Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6F1521C45
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbiEJOdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344266AbiEJOHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:07:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455A821333B;
        Tue, 10 May 2022 06:42:06 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv2so15904481pjb.4;
        Tue, 10 May 2022 06:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0UajMzXFBNf7cUMuc7pmjx3pa00PRDw60cm0sn0muk=;
        b=lgt9ntka8XC6Yi2GBLVPGUc7IL9mqeVrgCUn+a495s7WoVDLZsuLi8UBqCVFBGR4gl
         CXJ6XZlsjCnYG/dPov2d+syOxEJD9983PlWVPtDJO2w6qjp+j23q9pHTEgbgsLoF/sXi
         6FVIqlso1nwB6AVxDNCM6TuCDpAlcK8DyBLW39KMkw2X5GPwaG4L/d8pWoA5oQyfYGpI
         2YZ9JPS375oUN3AvwfnXyALr+6YVzOmI/Q51+h90/MtQQV4XHqibYRRYWBGbD/nWcRqZ
         nAJG9MvA8fvA+Dxd6ZmMGEApfljXC5eQopjE1jdfILLO2IhaAcEoHZVcK9W+3zxOy1ZD
         tuow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V0UajMzXFBNf7cUMuc7pmjx3pa00PRDw60cm0sn0muk=;
        b=tk8oiFyf6U94Wtdz1KNGzPkMjRKLdOV0u7U7486AHHvCuEefuwEGCQRdYnjWTX0uA/
         7b9TAGrMCC4sRgjes/PfkiSnwdNhEqZ7dCyGLZI2AovWm5sWOSONhdpHIGRFfylI+MxX
         Pi0lfrRS9G8ehywj+eM6bCH5RGxv2oEvCwUe1MrpEZl4k3XvaAx5C6IckD/l0MURMJJN
         FP+oBBCV05s5aGGwq1uxdjmLKOr/AtQ216OZqdD0y8fbj4fwvv3qHkt6F9/IW+w4fvMP
         D9W8H1psIToqnoh7t+p7GMHzqOy6qbVURpSF5mGFAVVONpL8JMY8BbAzYlrVpn3vcn+I
         opfw==
X-Gm-Message-State: AOAM530V8MrzlJFn1ww4mBcROCYxu+hsCI2+j3/R6Jy7c3NOC89IW27O
        sIsCOYckSV3l7jzWydfcYw==
X-Google-Smtp-Source: ABdhPJwTz7s06PP6uRYb/QITkzoElavq6dzKxWX4Lw0gWua0HhSDOW5UhhcaCyvj/T6uUDIIyNWGXw==
X-Received: by 2002:a17:90a:d3d2:b0:1dd:30bb:6a45 with SMTP id d18-20020a17090ad3d200b001dd30bb6a45mr88985pjw.206.1652190125550;
        Tue, 10 May 2022 06:42:05 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id a13-20020aa794ad000000b0050dc76281desm10768620pfl.184.2022.05.10.06.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 06:42:05 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     tharvey@gateworks.com, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] media: TDA1997x: Fix the error handling in tda1997x_probe()
Date:   Tue, 10 May 2022 21:41:46 +0800
Message-Id: <20220510134146.1727701-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver should disable the regulator when failing to probe.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/media/i2c/tda1997x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
index 8fafce26d62f..0de7acdf58a7 100644
--- a/drivers/media/i2c/tda1997x.c
+++ b/drivers/media/i2c/tda1997x.c
@@ -2798,6 +2798,7 @@ static int tda1997x_probe(struct i2c_client *client,
 	cancel_delayed_work(&state->delayed_work_enable_hpd);
 	mutex_destroy(&state->page_lock);
 	mutex_destroy(&state->lock);
+	tda1997x_set_power(state, 0);
 err_free_state:
 	kfree(state);
 	dev_err(&client->dev, "%s failed: %d\n", __func__, ret);
-- 
2.25.1


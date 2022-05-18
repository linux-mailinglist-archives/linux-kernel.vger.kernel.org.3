Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4052B4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbiERIc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiERIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:32:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856ED4EA10;
        Wed, 18 May 2022 01:32:22 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n6so707586wms.0;
        Wed, 18 May 2022 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z+PQb5MQz4Hi46TApUGBFaL5pik2KHkz+IdCi2pk9E=;
        b=nY5N7FCiiLTLIDrAVVBNIomteMVrETYaVXuYS6S6dWlVkrDwFrzMMCy5pZRw1FpyLb
         lXvOLdTFOPDufB1lDxHXiNeCc4voonWSxAyhbdIogQCX8LWGNHkdJa+GBnORF97VIDHq
         Pkn65y9YJkCKnNZ469oZZAJtaVT9HFFPSgCkdUtjiPa0zET/KOPV8NUPlWH44wEUt6L2
         AkgRMSgAn+PYPsBFIhoKlMTP46fKDPzI5UUlxI1MqNYM8ScXfPUxbpwqdAzHh/EaS59h
         NDHaUcsiYR8A6HI/7Wfd6Cgzl135bPI7I70l7n0Dz1AfAmCjOW+SrY9XxkTWV5Jl1taG
         shcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+z+PQb5MQz4Hi46TApUGBFaL5pik2KHkz+IdCi2pk9E=;
        b=IVdsHasFRr48lerTqkabr8wT+WDhxTEs7eqojPUSwqHrLjMFfRsLdnxFGEFh1shp0v
         av+TIIK/FEphwQS4pQDg4DaMcJ8qEC3lc1N6Q5oPlDqQW7VGBz/BLoGnX1vD8v5tqFUi
         RFho4LTpwUPLNC6fuU08hIxfcYGlgNpew6nXiope/kfzkx8kjqsTNljsZOwSwentP+Gz
         A+DTPnUBeLcgO1SEtdqIEIw7yeyS6j9Zyc2uH9nn9z1dqE16x9l2dCiuUX2u06PXXoQ2
         r8yhLPXUlSKX40gfOQ6PYEdKrCizt3DYHCn2FtRniPtFARU8s37wkgNy69tJ3Z/kKKZZ
         iNKg==
X-Gm-Message-State: AOAM5316bnsoGlhmXd3mi6GgI+nsrCTBjzQTErkSEGciUqGKKabvYpT8
        zQnIXc9BL7lCAbNdSaqlDvgxqxw+jtOpgZ8t
X-Google-Smtp-Source: ABdhPJzXrAx8whtDX8CJHaQ830Cxos71neUjKQZK3vabF5JDnUvkzjkhqIlJ4DYqBPqGl4C/Op+VsQ==
X-Received: by 2002:a05:600c:4fd4:b0:394:8e96:6d3b with SMTP id o20-20020a05600c4fd400b003948e966d3bmr24819426wmq.180.1652862740991;
        Wed, 18 May 2022 01:32:20 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j35-20020a05600c1c2300b00397220a9354sm611048wms.30.2022.05.18.01.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:32:20 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: platform: exynos-gsc: remove redundant initializations of f_chk_len and f_chk_addr
Date:   Wed, 18 May 2022 09:32:19 +0100
Message-Id: <20220518083219.507716-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variables f_chk_len and f_chk_addr are being initialized to zero and
then being re-assigned in the next statement. The initializations are
redundant and can be removed. Also initialize s_chk_addr and s_chk_len
at the declaration statement.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/platform/samsung/exynos-gsc/gsc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/samsung/exynos-gsc/gsc-core.c b/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
index e3559b047092..b147c645ae0b 100644
--- a/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
+++ b/drivers/media/platform/samsung/exynos-gsc/gsc-core.c
@@ -339,8 +339,7 @@ static int get_plane_info(struct gsc_frame *frm, u32 addr, u32 *index, u32 *ret_
 
 void gsc_set_prefbuf(struct gsc_dev *gsc, struct gsc_frame *frm)
 {
-	u32 f_chk_addr, f_chk_len, s_chk_addr, s_chk_len;
-	f_chk_addr = f_chk_len = s_chk_addr = s_chk_len = 0;
+	u32 f_chk_addr, f_chk_len, s_chk_addr = 0, s_chk_len = 0;
 
 	f_chk_addr = frm->addr.y;
 	f_chk_len = frm->payload[0];
-- 
2.35.1


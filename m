Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9AB574134
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 04:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiGNCEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 22:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiGNCEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:04:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AAFFD37;
        Wed, 13 Jul 2022 19:04:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r186so258490pgr.2;
        Wed, 13 Jul 2022 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3ezKfKuttZ9LUnd9ggWi+OcNmPhSUPS/idvxlrAh6+E=;
        b=oFpcvFolbR0BzEiSZSTs9f7Vki+PGH+9tCEEweuLSg/05jvonNlkUjjnawMfe0Jsyp
         MZ/Dz7257b/PLyp2g8AYTDp5bZu2ERpIP+SAYEoiVOBqiNtFviRFU87mIaW6nyUi5uv9
         xvGBDnyOuxsKNXpWw9olToEOUTGOpxPSqqhOEGQYsCw8gjPXKc2qsw2F+sRa//G+viSb
         /iIuG2CxKHvnSCIQzEsUuCXM3wAekt+6y+X2RFzDq/HGAMhbA8zm29lb3ki86oTdVCLH
         QrJr8W71Dg1ew/E8IpXMd0mTcKJ+CcK35ul033ABStUuz+JCSybaBoZboiRxMpCzJNkM
         Qhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ezKfKuttZ9LUnd9ggWi+OcNmPhSUPS/idvxlrAh6+E=;
        b=gtvwoLiRu2aoaHi8/jL1pla+0Q3EYtuTbEuNXDZ0x63zyzLWmo/QXLUjjko3+A1Rzb
         orvVOr56h1eJRP9MQ1FxmTpmlv7FZOOeiZRPAdtzjafo+cGrUe/djjVM3FSadQKvT7ny
         HNjL6Vq20dNu26iQrNnrhB/DnE7ZXAtlw7ZEf7xUepo3FqFY7X/BCczhpkvJWichKr5C
         jIQrXDrshtBfuyOpxUH9YWC5f7dz7RJDGuYAa1vVPMoHd7jagkP0zDiIokMoM4r6Qvwj
         y9vtMT4s8lLGztzyKsD60acBxmwWUPEwpDlx1A5FsdXtDvtaBi92z/drP8s+svCFUMsh
         QKlg==
X-Gm-Message-State: AJIora/BpPoSle3MBZV9Dic8X3HgHKDfpI83lKD2/su2j5SynL9Tq/Dc
        Vweu+iIcClY2E2Qdyy85vXwfE8B2dx0=
X-Google-Smtp-Source: AGRyM1tEkuYSnMumATLYJnFWdCW4zj69nCT2L2TTiB2XiPgWc/EIrx04SoKK8WHhUxphOeOROXuvyQ==
X-Received: by 2002:aa7:8e17:0:b0:528:9f8d:ad38 with SMTP id c23-20020aa78e17000000b005289f8dad38mr5960225pfr.4.1657764239896;
        Wed, 13 Jul 2022 19:03:59 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id i137-20020a62878f000000b0052542cbff9dsm230886pfe.99.2022.07.13.19.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 19:03:59 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com,
        andy.shevchenko@gmail.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 2/6] gpiolib: cdev: simplify parameter in call to hte_edge_setup
Date:   Thu, 14 Jul 2022 10:03:15 +0800
Message-Id: <20220714020319.72952-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220714020319.72952-1-warthog618@gmail.com>
References: <20220714020319.72952-1-warthog618@gmail.com>
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

Improve readability by using the GPIO_V2_LINE_FLAG_EDGE_BOTH instead
of combining the rising and falling edge flags.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b44526e3630e..f635bbbb6a6d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -885,9 +885,7 @@ static int debounce_setup(struct line *line,
 				return ret;
 			line->irq = irq;
 		} else {
-			ret = hte_edge_setup(line,
-					     GPIO_V2_LINE_FLAG_EDGE_RISING |
-					     GPIO_V2_LINE_FLAG_EDGE_FALLING);
+			ret = hte_edge_setup(line, GPIO_V2_LINE_FLAG_EDGE_BOTH);
 			if (ret)
 				return ret;
 		}
-- 
2.37.1


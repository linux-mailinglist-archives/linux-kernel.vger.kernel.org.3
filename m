Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B05A572AED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiGMBiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiGMBh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:37:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1374FD1EF7;
        Tue, 12 Jul 2022 18:37:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e16so8954811pfm.11;
        Tue, 12 Jul 2022 18:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFuFTJ6///jG0KZPUhwIRXXZOS5xQ/c4Fir9HnFbWXc=;
        b=dnkFcTRur3dm/P56d3vsr4Ipj1WYfVwtYUn/N9TtnB7+crjyHEB+Nbylpd4ZqaJG+C
         0f0fTp/Oov5GZS0oRBAhRxivj/zNe19rOvCv0Pjmi2uz9QxBYlNk5BEG4ayb2TAwzDJ6
         Vs6Y5oxQfcG0TaCErM1hraJ4osfK4cWEmVKThQmDwmzsuQSL4E1XCDLnZLwYCu1Ir0w7
         c8PDKBt3g3DpgYQieJQi7tfp4MXGVur4uAV9TBE6sNtBmDyRMVCC3CWVwuLBdyWlg3X7
         eHG8PR60T36y7AgePmENAEb+hdZX1B48iC4jD/GBFuWyoBqxy7Acd7xI1uicxeRv9KC+
         pBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFuFTJ6///jG0KZPUhwIRXXZOS5xQ/c4Fir9HnFbWXc=;
        b=dVdGyLqUb+ZTA8R304Fku6R8wJB5Z83gklFTNh5GtAW64TI/MsqU/R8qXYgp70uri8
         aRI1LYn2ZTsUok/bUGozVvKGGTkdI/VZazESCXIwAA8Hwnnv2PRIt/nIcMmNTRthfMuT
         o9FZub8oFVr7tD/EkAuzCXTePJelJT9Un5TIe0DcViSlF3JpiljerBNjVRtQbF7Nlh1F
         IWLEyhgsNBcgL/MHmXB7ymRntHzygcWTLf+pYhpIugdah3BQRqyzQ+LVxVvFYWH6stLz
         pOboYu3/XbGzHDCjbA8y7CH6aiiSA+3+3EHkyEZgEFz2tsPuumRDxrMlhmlXywsMb3Rb
         wyqw==
X-Gm-Message-State: AJIora+KAB5FLRmMI8dr2zm8n17TJNCG8O0fnZfZLbMJwv+OVg4c18Ql
        q3m4bHkspL2q/rbkyi45niCvM2C1Nhs=
X-Google-Smtp-Source: AGRyM1tyzj0MsGl84bHr9l8WfxlZSgF4N6+cwPM/01Oo1yRef2fMBK+OnVPmBxmWo0p6gzxJm65Kcg==
X-Received: by 2002:a63:d809:0:b0:415:5265:687c with SMTP id b9-20020a63d809000000b004155265687cmr975590pgh.372.1657676277997;
        Tue, 12 Jul 2022 18:37:57 -0700 (PDT)
Received: from sol.home.arpa (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id ob2-20020a17090b390200b001ef76dbae28sm225879pjb.36.2022.07.12.18.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 18:37:57 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, dipenp@nvidia.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 2/6] gpiolib: cdev: simplify parameter in call to hte_edge_setup
Date:   Wed, 13 Jul 2022 09:37:17 +0800
Message-Id: <20220713013721.68879-3-warthog618@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713013721.68879-1-warthog618@gmail.com>
References: <20220713013721.68879-1-warthog618@gmail.com>
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
2.37.0


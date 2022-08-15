Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B1592ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiHOMXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiHOMXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:23:12 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4842926557
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:23:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id ct13so5197788qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=HJU13VU6sPMNx2vMpQ7iyH8mwDUaKEzoIu1jb38Mz0g=;
        b=XwYgU1clufjCXeEvSkwKDxpVa/cfR9WCF3msMf5G7dUTgSIqLDMO+r4URX4BrCTgwS
         +bhOo6cdBDN+/XQLUi1pcs7PNJ51nOYzFnJaEyaBEXJp8AQN3aT4HCw8bEeVurvl6atT
         xAKX1UgIvy5aNPcvs2mxcdAn9lspwgVAXIP8bHAA4IDEaZf+grUGPX9ncZzpIoeDXwJK
         x7JXqXzDjU/UJMIDLKeDQp28Ab+eUsplB3RmxN63EgvLSiy4rQaCUnEL74rDOf4Ra2P2
         yHCSa73Qrr4Mxl1Ua37rrk6ESrNkl4Hf+MasHjnErE2Ezj6vxdep0R2ZJWJTsr8v7bT8
         m6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=HJU13VU6sPMNx2vMpQ7iyH8mwDUaKEzoIu1jb38Mz0g=;
        b=TpwhGHwONf75TUS4yoSGQwKclra4W8ZyIhjfDbD9fKluT0hnISLjP1ARGdi82/2D46
         es/P+3TB3F8szsfeEGzSbfvYmJ7YKHbsZjxRIE0YmpYGhIFOQ68EX6H9E4v9dUwI5S3L
         p58+roflxxDkj3YoWPirqJ3oMGov3cw8qIC+/sZjsB0bBGwGAxAWYrNJPoyt15Ga5t7E
         zSQk99mO8eFpVfkPppViD/1mGhhTNZCLMWw5TimmcatGqnBqHAaVHw0O2+Q0oaKXsi2O
         rXyvm8quoIymTNKxon5EqvLNmQRsAJZiMgB/fWxPLZXqaq5zgJeGUArirm9MAR36tGZO
         MStQ==
X-Gm-Message-State: ACgBeo1PGb6GZm/KrqQCdCn+5+5cGQFSKW0aUJHrq4vdbhrwMtTZHFUC
        xOjkLIbU/FxqKCt+UZpyIBvI2dl4GSK2/Q==
X-Google-Smtp-Source: AA6agR5FA59iIRXJUl4l0yT3gXB+I3K7nxKloVt8hJ4M/r21AmvxgiP96g7B4r8PIAnWObcEO4h/CA==
X-Received: by 2002:ad4:5dc7:0:b0:476:a281:5335 with SMTP id m7-20020ad45dc7000000b00476a2815335mr13529297qvh.1.1660566187412;
        Mon, 15 Aug 2022 05:23:07 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id e6-20020ac84e46000000b0031ee9afafccsm8378729qtw.14.2022.08.15.05.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 05:23:07 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH] counter: 104-quad-8: Fix skipped IRQ lines during events configuration
Date:   Mon, 15 Aug 2022 08:23:01 -0400
Message-Id: <20220815122301.2750-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ trigger configuration is skipped if it has already been set before;
however, the IRQ line still needs to be OR'd to irq_enabled because
irq_enabled is reset for every events_configure call. This patch moves
the irq_enabled OR operation update to before the irq_trigger check so
that IRQ line enablement is not skipped.

Fixes: c95cc0d95702 ("counter: 104-quad-8: Fix persistent enabled events bug")
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/104-quad-8.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 62c2b7ac4339..4407203e0c9b 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -449,6 +449,9 @@ static int quad8_events_configure(struct counter_device *counter)
 			return -EINVAL;
 		}
 
+		/* Enable IRQ line */
+		irq_enabled |= BIT(event_node->channel);
+
 		/* Skip configuration if it is the same as previously set */
 		if (priv->irq_trigger[event_node->channel] == next_irq_trigger)
 			continue;
@@ -462,9 +465,6 @@ static int quad8_events_configure(struct counter_device *counter)
 			  priv->irq_trigger[event_node->channel] << 3;
 		iowrite8(QUAD8_CTR_IOR | ior_cfg,
 			 &priv->reg->channel[event_node->channel].control);
-
-		/* Enable IRQ line */
-		irq_enabled |= BIT(event_node->channel);
 	}
 
 	iowrite8(irq_enabled, &priv->reg->index_interrupt);
-- 
2.37.1


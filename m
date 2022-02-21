Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2E94BD70F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346182AbiBUH1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:27:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346194AbiBUH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:27:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD734BC86
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:27:02 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so1910131pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ipk+8/mlA1NjmkQRafVe5UUgweeUMHcfSc70vXhbhjQ=;
        b=TyoVbY66fvQxCeXg8TMNaUcCinlupskoUJ4snoNuoaLlCP6dykgNslOrF6mx1MTm/C
         b7rALqk7AiCilwr8DjyYfG+m195eGx3N4iARlopsqFL+FexfvJNiWcnuPypfb8Sru8PU
         WvcKVrdBBfR+TkslM0SQXL09z1tDTY4cExhObhxk4uNJ6LmsRgLWjbYd0/SBAlfBVz5K
         q/VfSairHUYt5z1o1c8bEcsf5FkNrbTzouTlOtuMZXZYujxW2+NqLZbjODSWzWdGgAKc
         OpazycFpg0eHjZ2jxOjt0tcEP1uA+f7MaJoytqiNdFTVXOX0k2twVR8a8AzbxS1nRaWB
         goXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ipk+8/mlA1NjmkQRafVe5UUgweeUMHcfSc70vXhbhjQ=;
        b=1+nNar5DG0SXbvoNLCv8m4jWCeIP4tTzBWqKFdEWsmHSAmCdnv3p3Qa8uudxbDHxx0
         tQu6IWuNDikx5ndC6itS6bBHoafpnCMgPUmjXnnyfCWmpf8WfNcptPUYYpMQTNE7H0hN
         oTkDXmpZPv66ToiI2zW5IzDQ4Ln6cPsEXuSLkLBw8rQo9IGx+MfG9jN2/5yC73duO+WJ
         nDpf3lm04ybVfcx0CjGzCFJ4kwhWvHJJHMI1zuFX1SirYdAo14RvM08gjzKQgswsqtH/
         AcX2D0vP5NgTGluiFzOqpDrA6nH9blrsEUIGKpA8VHOArEap+sG8R5UeWHpl+UfIQaWk
         B+sQ==
X-Gm-Message-State: AOAM530Ks78OaCBHS/pPg2LUVufNi1gKClG8+ah+REYSwitic57UWQ5y
        Bf3F15Ygw5vzOSdHp4swc6Q=
X-Google-Smtp-Source: ABdhPJzP0BqaeRV+QI20CJzA8511Nabhe0/l0dZux3kbK8JsR7rVq/00K+Bnys4V/2S/uKQ+8OTOgg==
X-Received: by 2002:a17:902:ccce:b0:14e:ed3f:e3a1 with SMTP id z14-20020a170902ccce00b0014eed3fe3a1mr17926312ple.12.1645428422187;
        Sun, 20 Feb 2022 23:27:02 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.14])
        by smtp.gmail.com with ESMTPSA id e4sm16379204pgr.35.2022.02.20.23.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:27:01 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: simple: Add AST2600 compatible
Date:   Mon, 21 Feb 2022 17:56:50 +1030
Message-Id: <20220221072650.129348-1-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the 2400 and 2500, the LPC controller has some simple reset
lines that are used by the UART devices.

This is already documented in LPC bindings document.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/reset/reset-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 4dda0daf2c6f..361a68314265 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -144,6 +144,7 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "aspeed,ast2400-lpc-reset" },
 	{ .compatible = "aspeed,ast2500-lpc-reset" },
+	{ .compatible = "aspeed,ast2600-lpc-reset" },
 	{ .compatible = "bitmain,bm1880-reset",
 		.data = &reset_simple_active_low },
 	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
-- 
2.34.1


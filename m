Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C6F4D37D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiCIQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiCIQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:30:25 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED9E38BF;
        Wed,  9 Mar 2022 08:23:44 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8BB61240007;
        Wed,  9 Mar 2022 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646843018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M0HituYqQRivyyV2wX1PQGqGHVagZ4qG+Bl9gSVspFQ=;
        b=ph9Ui+x8HEmsL9yXEIba7dKLGPopB+ptKLifoC/4urYDK5p0JaoLxPZhGEjJ09Ap56k5wv
        qcjD8wZIiFQkffiQPvzFxNX7dAexNKX882CHQyKJOYCZjQpQeq7JzYCloOy9z7vgt29UnP
        0LGq5FekMLH84furiFu721gK8cykAS8yuXo1eQ035QVkkEqkr75z9sv4HFSQM2WyupBJWE
        SUQtXKivU5X0xHLBcgfRLuuyi1WnozXoyoytizkRK5fPekXtnNIgYRUb10TsomGKtMqOH3
        gTDLw+Z0gsBVUMfqnEAk7TgZQAG1eaWZOFdZgluD0pXv/xj/IEI72gz04Ktw8g==
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/29] rtc: xgene: stop using uie_unsupported
Date:   Wed,  9 Mar 2022 17:22:59 +0100
Message-Id: <20220309162301.61679-28-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bogus use of uie_unsupported.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-xgene.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index cf68a9b1c9eb..d3d0054e21fd 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -180,8 +180,6 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* HW does not support update faster than 1 seconds */
-	pdata->rtc->uie_unsupported = 1;
 	pdata->rtc->ops = &xgene_rtc_ops;
 	pdata->rtc->range_max = U32_MAX;
 
-- 
2.35.1


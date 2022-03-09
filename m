Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5B34D2B88
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiCIJN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:13:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiCIJNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:13:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDED3F339
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:12:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id r13so3482979ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GrpiBmBSXkB7/9MU5wDlEMtPnHABc2Wv0BpZPJ75IQ=;
        b=RKIldFmxBs3HJTqLMfBrIiz9WPIwldE8DxqjOh4J5kKMHYaUJYDdMshRBUSRbiqT90
         aIe36AVrwx5RCbTHcxk/daCrqzyxzw1g21zGbGU/Yb3EtLa/jFPi9ScPChtsTVkFvW+0
         ErZYaBUcMAGYr+71kKCMTKwty4iqTi/7eeRR5QPRAaS8oa7VEOrJZbxxRRa+IIbJvRpD
         VptwJKXru2UmOjuC0WU7ZSECqawVgoOE9XDQFbko+caFQr3FPtSIc81wgDuzfC02hjBT
         2PES5WwWQ3tkNDCZwTUoHPxyIqT0MwNpgvyZwhTo4JISKQ8uT1iL6uATbBfMVxgfGJ49
         bqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+GrpiBmBSXkB7/9MU5wDlEMtPnHABc2Wv0BpZPJ75IQ=;
        b=GLnLjab5Ichzx3Il/+bGTkxK6aZPQNgNAHqyAr0ncGshjjl285JunVqLwwEF93JmYs
         0QrFBmEGL30DW/fJwGTvYs0+/ft91ABimXABgcCZOwyj3oFz6bGX0EYlccLposDScsE4
         zRAWIv49Qs2a8kYqaRQ2tLSR6aQocVqYRj2AnLCY00o0Qr6UOQSA/v67JRIjSY5d6ktP
         CMm8OaotafYwCy3g7mD0Fu4LObfU5Bx1Jpx0f0VEYPO1pR5uB00AM+RKaapZYOSG9f81
         tgj0+mt/PEWI2WyjNZboHzGnMFG5C7o9SFfFcT1P4crzlWIeWPYgriXnzPWCzgqvptR3
         CUlw==
X-Gm-Message-State: AOAM531/3p5MrrOCJ3tqwQ9PsXGBAQZF95dt7HYMi/AQxAzgBcswQmF5
        oSDrimPWH1IFUflS2xhiJQ+gDFm2n/A5u2pK
X-Google-Smtp-Source: ABdhPJxBLD6zuYTx3baEvggBGetAnEBSXqWLrkbmDk9T+V0zqzZQLxUNnwopQmcUBIXnYu1nxUQRtA==
X-Received: by 2002:a17:906:b56:b0:6da:f8d8:aaef with SMTP id v22-20020a1709060b5600b006daf8d8aaefmr17070725ejg.67.1646817175099;
        Wed, 09 Mar 2022 01:12:55 -0800 (PST)
Received: from localhost.localdomain ([102.126.147.138])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906520f00b006cd07ba40absm476099ejm.160.2022.03.09.01.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 01:12:54 -0800 (PST)
From:   Hatim Muhammed <hatimmohammed369@gmail.com>
X-Google-Original-From: Hatim Muhammed
To:     linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, abbotti@mev.co.uk, hsweeten@visionengravers.com,
        Hatim Muhammed <hatimmohammed369@gmail.com>
Subject: [PATCH 8/8] Constify comedi_lrange struct pointer
Date:   Wed,  9 Mar 2022 11:12:50 +0200
Message-Id: <20220309091250.13290-1-hatimmohammed369@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hatim Muhammed <hatimmohammed369@gmail.com>

Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
---
 drivers/comedi/drivers/das16.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
index 937a69ce0977..d1eeb5896f2d 100644
--- a/drivers/comedi/drivers/das16.c
+++ b/drivers/comedi/drivers/das16.c
@@ -956,7 +956,7 @@ static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
 
 	/* get any user-defined input range */
 	if (pg_type == das16_pg_none && (min || max)) {
-		struct comedi_lrange *lrange;
+		const struct comedi_lrange *lrange;
 		struct comedi_krange *krange;
 
 		/* allocate single-range range table */
@@ -990,7 +990,7 @@ static const struct comedi_lrange *das16_ao_range(struct comedi_device *dev,
 
 	/* get any user-defined output range */
 	if (min || max) {
-		struct comedi_lrange *lrange;
+		const struct comedi_lrange *lrange;
 		struct comedi_krange *krange;
 
 		/* allocate single-range range table */
-- 
2.35.1


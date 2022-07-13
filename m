Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723CD5739E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbiGMPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbiGMPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:20:11 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487845071;
        Wed, 13 Jul 2022 08:20:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p9so12479795pjd.3;
        Wed, 13 Jul 2022 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfcwLMN8Ewi+9XLJ414pnukT/pEOQ51tGjnru+yDZWI=;
        b=Q6pScKlpaBVzK+JhActGi643lCDIiwN0l+n2gIcAtZx5pBGqUzKfxOz0UjVpEkdLyR
         JXSoXaySG7xX6nsyKKQEldFXS5iIXnQf9dHBxzhz6HIa23M+4gm5b8DIdlkt5stEMGk7
         e53fdGWomOfTKAaoihiYCWx5GC3T/WApV1sN6MxqMvFkizFpIO8NwGGdzH1f679cQ1xm
         Pv5nr92Yf9f7K4Qj5BAY5jImxaamdo9DEwbIbX4v+SLvJwU09unPsPdRN9rWR3h2+MfZ
         oUMfXU2SkzbvM5jIqsXz81pHGDhak32fDYg9CkWaSPv5GmXTQ0bkUtqSs6bCCNMCezL9
         Qjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfcwLMN8Ewi+9XLJ414pnukT/pEOQ51tGjnru+yDZWI=;
        b=1rlu3j0XQy49jTtfTKDPmM/VDTabLMn70lTFbvoKkHVFL1WntASxkJsLo7yQkVhfw2
         PsE1JTithbYdQ9INtcRx2I1WdS/oZiR2qA0YpGXv3uZiiTHb0p1v0dBfW4tNNkkbPufX
         wHfpsrEOotp+FiaPpFlgdlvEqKGD/5bPsYmxFdj0gWi5G0GEmxCVWRoMckx4FW/GCfB0
         IJnpUfn4pXOxLcFRhrlNPUfz0lnMV16pY+mqW/BeCkF2Avu4Wrk0Z53VUBUenweCsGd5
         14syENBY/ZL2fuyLeKE8skOKEyqVgBBFBSvKw9hs91zGKuqYx9vSthhpIRe/q4WQncUW
         G9gQ==
X-Gm-Message-State: AJIora+YJcyn5v5vLdXHHsWaZ4jh5CVkjEGCN142roffN6LoRGPRMzwH
        4yYT9HPutOfLMhuzXOGiFiY=
X-Google-Smtp-Source: AGRyM1t2S8VoCUJrWmORCeo5mfBdRIAcU+wdvHCqqj7G7C9PJ54IKMLzXkyUHrvKhpv+pg3WS+nwFQ==
X-Received: by 2002:a17:90b:17c9:b0:1f0:5678:5142 with SMTP id me9-20020a17090b17c900b001f056785142mr4418118pjb.205.1657725610103;
        Wed, 13 Jul 2022 08:20:10 -0700 (PDT)
Received: from localhost.localdomain ([136.185.227.196])
        by smtp.googlemail.com with ESMTPSA id pi4-20020a17090b1e4400b001df264610c4sm6891758pjb.0.2022.07.13.08.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 08:20:09 -0700 (PDT)
From:   sumadhurakalyan <sumadhurakalyan@gmail.com>
Cc:     sumadhurakalyan <sumadhurakalyan@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Subject: Fix 'void function return statements are not generally useful' warning
Date:   Wed, 13 Jul 2022 20:49:52 +0530
Message-Id: <20220713151953.9547-1-sumadhurakalyan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix 'void function return statements are not generally useful' warning
---
 drivers/rtc/rtc-as3722.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-as3722.c b/drivers/rtc/rtc-as3722.c
index 0f21af27f4cf..e19a68e4d128 100644
--- a/drivers/rtc/rtc-as3722.c
+++ b/drivers/rtc/rtc-as3722.c
@@ -48,7 +48,6 @@ static void as3722_reg_to_time(u8 *rbuff, struct rtc_time *tm)
 	tm->tm_mday = bcd2bin(rbuff[3] & 0x3F);
 	tm->tm_mon = bcd2bin(rbuff[4] & 0x1F) - 1;
 	tm->tm_year = (AS3722_RTC_START_YEAR - 1900) + bcd2bin(rbuff[5] & 0x7F);
-	return;
 }
 
 static int as3722_rtc_read_time(struct device *dev, struct rtc_time *tm)
-- 
2.25.1


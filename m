Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31952557236
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiFWEsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiFWEjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 00:39:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C534B99
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:39:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so2654773pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtCc+UQQpUTja7HKmiItYlG8yACqKBWw8JAx2Em2Ros=;
        b=gh/igH2UBmB6266V7qY6S0bv21sMThSqiv6qST2OQV19Ker6WZI12/ZPsn5LmqqWMh
         t6B8o2aZQ4nJA7ak3aUREkh7KGQ2hNRtyoR81bZ+A8Fi4z4McsyrgQekTQcMCI70UI2n
         3RQWqjbp2T4yiGZpV+UYo3SmGTABIUT9W/o/7PhDpLAGwt+LqOCdHqUxWN8rIWno2h1A
         yaR7HwLh5gimH4pkP8R4TyB0BRQgj5Vk/qAzYMVTFTvdrtlzi9MU2P0Ov9lbzA5ajnZ9
         JG6THSs9MWkC6Ho5PsIOCjSN6xRoh9MdEFq94l8qNCd/kXfvxnaFM83nULrqV7QslcN2
         EuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XtCc+UQQpUTja7HKmiItYlG8yACqKBWw8JAx2Em2Ros=;
        b=VJK2Nrx2rxQygESeN5HxpesKD7gq6K8BSY7N+IQqwjOi7XXQzWn1HSHUWFOo1dsA1I
         EZg5/lWIYyKgmvthyweYhKOrQ+BIR83fb0Mb4WHHYtjWN2qgbHxoU83f+ZZcjwYuch6B
         WAUkNpH/J/X/WFUmOKL6NWZMYv8laC4ofm24GKW8Ary4cBxeetqQQQfYu29Ol9jqJulB
         +9tET6louEkmb9Ci2M7Dt/sJAA9uEq/ouytnVpDGmhC3fd1DjZdYMsW2k1h7XCP5GJmS
         ZLh34BkRb9yOAGZiDCsutfJXlWrEkhn9Mu7zsHrX0mzNiFhwVEDaw/81rcuaZzE1Ewst
         Ku0Q==
X-Gm-Message-State: AJIora+oRLHSixOlhVmdo2sRRPeJRnAnoGpdiSKpHbUPXqk8Nv4EEFHJ
        i4P7z2wtEtdmcPl6u5tbSaVrtxwAWoHTSg==
X-Google-Smtp-Source: AGRyM1tjtG0nx/M7CuMI6QIDU2GQemBYxqdzHLv+78X41ahZcFZtCvvQIaaUbp3aAN3pC5NPVKezhw==
X-Received: by 2002:a17:90a:c984:b0:1ec:747b:da32 with SMTP id w4-20020a17090ac98400b001ec747bda32mr1975850pjt.216.1655959154953;
        Wed, 22 Jun 2022 21:39:14 -0700 (PDT)
Received: from localhost (c-67-180-87-133.hsd1.ca.comcast.net. [67.180.87.133])
        by smtp.gmail.com with ESMTPSA id a66-20020a621a45000000b005251759afbasm9041385pfa.65.2022.06.22.21.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 21:39:14 -0700 (PDT)
From:   Chang Yu <marcus.yu.56@gmail.com>
To:     Larry.Finger@lwfinger.net, philipp.g.hortmann@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Chang Yu <marcus.yu.56@gmail.com>
Subject: [PATCH v2] staging: r8188eu: Make rtw_signal_stat_timer_hdl a static function
Date:   Wed, 22 Jun 2022 21:38:55 -0700
Message-Id: <20220623043855.407208-1-marcus.yu.56@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Make rtw_signal_stat_timer_hdl a static function instead of a global
function.

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
Changes in v2:
Added static for the definition as well

 drivers/staging/r8188eu/core/rtw_recv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index cc91638a085d..6564e82ddd66 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -24,7 +24,7 @@ static u8 rtw_rfc1042_header[] = {
 	0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
 };
 
-void rtw_signal_stat_timer_hdl(struct timer_list *t);
+static void rtw_signal_stat_timer_hdl(struct timer_list *t);
 
 void _rtw_init_sta_recv_priv(struct sta_recv_priv *psta_recvpriv)
 {
@@ -1794,7 +1794,7 @@ s32 rtw_recv_entry(struct recv_frame *precvframe)
 	return ret;
 }
 
-void rtw_signal_stat_timer_hdl(struct timer_list *t)
+static void rtw_signal_stat_timer_hdl(struct timer_list *t)
 {
 	struct adapter *adapter = from_timer(adapter, t, recvpriv.signal_stat_timer);
 	struct recv_priv *recvpriv = &adapter->recvpriv;
-- 
2.36.1


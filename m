Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EF74CB042
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244280AbiCBUuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiCBUte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:34 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0076E3A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:28 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 132so2639856pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2yCZ0MwzJLAtB0wdzpP2V0zRLEwcqRB7kcixjR8EmM=;
        b=fjdZBTlhSpaVYrPZ66957zXOnwQ8S+NBlz4ykN1LkFfbuiZiwTXIl9hckI/+/XA4B6
         txRJ3Paso2bXVKKK7X0vn21t6QeoWZsZAK3z5B2nI9K5ybzBi8fCKD9XqkJQYSQrI1YE
         VqYW5jMZopBcklJ1Bk6y3FmbEbHrJfYOtFkq+zR/oRBQymythIh+B16T9FQ63cJDKeiW
         BISa2TVRZDIWTzii8gp1t2rm+kJCu1jq+CRAITJISvsENdrSQp1SJMClHp3w/xPw3xkI
         L4Lx1ZeQqXBHL8p5XlluG8Yeu4ro0B7fu1XTngGHSw7m9JeJ3QGWX5b7OuK4qoKFXRm2
         EChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2yCZ0MwzJLAtB0wdzpP2V0zRLEwcqRB7kcixjR8EmM=;
        b=qCzE0CNtESqt2FQrv1YbqApuvbjkStT0CgeZ+YingJyW+K719BJ2MA8xTkCXBFNwDo
         GojMATk5yBlX3zrRIWBbWdN6imbfnXcapZeRpy/ubqSpqfMuFYBTk5K1EUQ4+HoMjVDt
         U8JSIuphN9B8Oyu5AoAyCXQFF6g2ssKO74dcI19WlaL5f8AfNGbGLxeVkjEdS6T4fULG
         o6p8L7L06X2XrrcgypXB2zFJfXkwm+z4DFAVof9Ry260LMkvZ1ThjZkZziJTV1vJWxUC
         iHZlC3VDEQhdu4zwVuVuDDKs9CKYY4735R1J0mQ3YkIPtZkRxDNabw2sysEFAi3HPhvp
         fxWg==
X-Gm-Message-State: AOAM532VReszDa/9BjtnPRMpP+vnGGNRqPPYqqJCSqSEJjtvJgds7/fm
        u3AFV2gncus6+2xHMLLHCQA=
X-Google-Smtp-Source: ABdhPJyLq+DPObg9qYBqsbRRyDs4NSTt8YlfmUplm7re8TiGIWZMCnZc7Ru6TWhO8HcrCXLWEI5YoA==
X-Received: by 2002:a62:770a:0:b0:4e0:2547:9219 with SMTP id s10-20020a62770a000000b004e025479219mr34580040pfc.43.1646254108391;
        Wed, 02 Mar 2022 12:48:28 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:28 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 08/16] staging: r8188eu: mark cckrates_included as bool
Date:   Thu,  3 Mar 2022 02:17:29 +0530
Message-Id: <20220302204737.49056-9-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
MIME-Version: 1.0
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

Mark cckrates_included as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 33c022820..4f58c8970 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -45,7 +45,7 @@ static u8 rtw_basic_rate_mix[7] = {
 	IEEE80211_OFDM_RATE_24MB | IEEE80211_BASIC_RATE_MASK
 };
 
-int cckrates_included(unsigned char *rate, int ratelen)
+bool cckrates_included(unsigned char *rate, int ratelen)
 {
 	int	i;
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 26f31f20e..21c7f020a 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -632,7 +632,7 @@ void addba_timer_hdl(struct sta_info *psta);
 		_set_timer(&(mlmeext)->link_timer, (ms)); \
 	} while (0)
 
-int cckrates_included(unsigned char *rate, int ratelen);
+bool cckrates_included(unsigned char *rate, int ratelen);
 int cckratesonly_included(unsigned char *rate, int ratelen);
 
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
-- 
2.30.2


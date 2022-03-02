Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1F4CB03A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbiCBUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244653AbiCBUtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D9C1162
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:32 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n15so2621684plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EfjmzJb7Lf/yi4gvZp25594w20L/weNb6/LvpO1ErKw=;
        b=BwkeGewl6EZdwpTRoprC7vshGyUOaTZ9Ep54pSQhaW+CtWm8bwPFuwZdJn/3pWm7OA
         buyL9eBt1HB4fqXwsQuZo9oOIO+oNc4iFbI2ahiusqON9FSe1mMPQbhBbxu5lcsblgqR
         1j4YCsxTsuKZHcE9WQWEZZ9JokB3LcJmxPstPjZyUVcx+rHdgb8z09UUQklx7kIpgKos
         yxlA/TLi9/C5npuqSCZYFR8VHaTV9TBLCaa7/GCHTl6OZk5nwXMzi+gzpXZdfo5gQOLH
         RKtbZ8CDScyL9UyaUljLPx4HXYi0D/HtLICw0pnkCQjP4Gjtr5SKHdPNyer5rucjJE2v
         eotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EfjmzJb7Lf/yi4gvZp25594w20L/weNb6/LvpO1ErKw=;
        b=DDfwVl/GwVNCwqY3v+jgwWmEemtjOfbKQfr0YXG1O05KGyaTd5jkEhqG5Mmhp1iG1z
         e6AQXFwmkDpUC6xMra1S3pDoaAZCBFJSwRuDZXCaO8akezsAxFlKzV/HS09R7ewS0Bit
         I8pxdHJrclxzsvJLsYWcMIo76DQn1PLEezgs/b19/BZMLhhPOW6WHt8h1wbXjtFMhEqO
         LYJW2n2jeKamI8WRTIalMcnx6ellKdKf/Sny/0BmJDZ3Qy2CFmzsPLOMA/WR5lwJSPoa
         zBn1oHH4S0VVW06pPFqHRcDfl/cONFloP1CpxDCABOHrqlFJBxr5ep7BkKF9dd1Ao1nM
         Mc5A==
X-Gm-Message-State: AOAM531QIh1gn3CN9hTzppYmm2CgWP0hqMZDA6zO8Qf2oXxy+7GI/lDk
        Fu54OysRE+UlyqTslsZ5XfA=
X-Google-Smtp-Source: ABdhPJzYhlHCySyM0DDJxZvonduU8G3iFcUviunLI3CKrlUUK7fMzuF2ZGG7kZg8CYNfDVOlLS0X8Q==
X-Received: by 2002:a17:90a:550b:b0:1bd:1e3a:a407 with SMTP id b11-20020a17090a550b00b001bd1e3aa407mr1671588pji.112.1646254111543;
        Wed, 02 Mar 2022 12:48:31 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:31 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 09/16] staging: r8188eu: mark cckratesonly_included as bool
Date:   Thu,  3 Mar 2022 02:17:30 +0530
Message-Id: <20220302204737.49056-10-makvihas@gmail.com>
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

Mark cckratesonly_included as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 4f58c8970..eef8523c3 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -57,7 +57,7 @@ bool cckrates_included(unsigned char *rate, int ratelen)
 	return false;
 }
 
-int cckratesonly_included(unsigned char *rate, int ratelen)
+bool cckratesonly_included(unsigned char *rate, int ratelen)
 {
 	int	i;
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 21c7f020a..cf397ac68 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -633,7 +633,7 @@ void addba_timer_hdl(struct sta_info *psta);
 	} while (0)
 
 bool cckrates_included(unsigned char *rate, int ratelen);
-int cckratesonly_included(unsigned char *rate, int ratelen);
+bool cckratesonly_included(unsigned char *rate, int ratelen);
 
 void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr);
 
-- 
2.30.2


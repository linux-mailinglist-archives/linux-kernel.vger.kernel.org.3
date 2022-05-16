Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF59E528B90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiEPREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiEPREj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:04:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0727163
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id i1so15028791plg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNdJuu/j5yzS384N3qJa/cn4HaocjvrZKpgiycrMSE8=;
        b=PZlOUNOXNlmBxzG7nR6dSG+2VCKRNkVBKqtPYaplvKqer51/5O8yOBuJDF6tJPh4iX
         xajX0cn/4BdAdNtEIlpFvRFG8OOJatpQsMUyZqPOqwGwrv2LJu1A4vYIQ1ypDYeb7vcT
         rm2RqpbGUExYba7PU+ZtWt4o1UKRGebNz3O0ExulG6Re7IsHiFQQUlBMTfAYbEid2oc6
         VDBCDCSsGCBom/jUp7PAW6kM3wYWuBR9w5mOGRzPPoKyZssyxIlVBZj6s0LQaajU1QSC
         UCnJWDstWbNYvJiSsHPUslpdEcNy1NCOOK0SuZTuTzH+/9WL5Ky+CIW44A2BRioLCy3U
         k0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNdJuu/j5yzS384N3qJa/cn4HaocjvrZKpgiycrMSE8=;
        b=hHoeR8M8gFbBHcF7IPlJ/Z/2N66/WrG32wrXrKfXw+MMpK/3QlR/BH6GgDy+a58eO0
         L/XNDm7UpKrPqu3gyUBeeoYUyOdwKAjtkFBJKhoA1D/5ekFVZPIqjaaKQ6E/wC7bWqPa
         wm/AfTfeNO60p0JDlwOcJF800ZC6ltOc0x3mqhH+V7CfDraq7BB9NrEZaOthqN17CTN3
         MsE6tgZFfw9CAARPjqMGu8UD/Y9uLSjebawxyXODBjeCXvDrvWz7H0kGUqErGBM3s69S
         5YlffuZ8+6/muGqiv8zv2EpATd0rW8+dOcNT0hCaTzJd0GZl2pRP7KW9+Fuzi3lpBYkl
         go0g==
X-Gm-Message-State: AOAM5332PHbMm/hn9Gcf2zUDU6mjLs3+sdSBavSS8WYjafh/+wj1iQWe
        9MFbw/ufGXtUTQ+fn18w/l0=
X-Google-Smtp-Source: ABdhPJz/4b2AS2O4bLSWm2ww2lQNwPjfQEwn1NaT0WLvPrZ/c6u4o9dib0dEG4WtvDLYdNYiEDWD9w==
X-Received: by 2002:a17:903:244d:b0:15e:a3a2:5a6f with SMTP id l13-20020a170903244d00b0015ea3a25a6fmr18106103pls.72.1652720677944;
        Mon, 16 May 2022 10:04:37 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:6465:4732:de67:bb26])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm7141292pfb.118.2022.05.16.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:04:37 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: fix checkpatch.pl warnings in rtw_wlan_util
Date:   Mon, 16 May 2022 22:33:06 +0530
Message-Id: <20220516170306.6008-4-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220516170306.6008-1-makvihas@gmail.com>
References: <20220516170306.6008-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to fix following warnings:
    WARNING: Comparisons should place the constant on the right side of the test
    CHECK: Comparison to NULL could be written "p"

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 27035eac6..3f4456901 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -962,7 +962,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 	else
 		hidden_ssid = false;
 
-	if ((NULL != p) && (false == hidden_ssid && (*(p + 1)))) {
+	if (p && (!hidden_ssid && (*(p + 1)))) {
 		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
 		bssid->Ssid.SsidLength = *(p + 1);
 	} else {
-- 
2.30.2


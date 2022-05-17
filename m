Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BA852A449
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbiEQOHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348452AbiEQOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:07:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6BA4C7A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:47 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h24so11726793pgh.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TNdJuu/j5yzS384N3qJa/cn4HaocjvrZKpgiycrMSE8=;
        b=NMICY8qO480E8MtNAZa+IURSCN4xcvsbZJ4Lew2+Md4VhJq9ThZkFwdm0p2EVy5pKR
         QqwjeR/Bsc5uinknc8OYbIfL4WUhvIWZT+mHqHRthGwidkzWWRJ4h98mcAns6aUtFKRs
         dvNkS9G3AcznYLU8fS1UebfoWq/kI+USfdIY6eG5zqt+MtI7YaZCum8KBDhqJJv+lxqc
         kmjUM6230WefSl5gT3Qcls4NwZ0lYvmWYJQ4XOd5BqO2gSZFWMow6zun97o2nIshaXDP
         fSRHhluP5JNq9lP7yCcPz3WtdPspKkcLFBP67rWar3bAyoKukDR8VxK3/ZAzFu8QbzHw
         KP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TNdJuu/j5yzS384N3qJa/cn4HaocjvrZKpgiycrMSE8=;
        b=IC1PhWmNaD4TAHlEDirVl4Sw37n2+uPGoz9D74BQ0hkH04mjOK43cOOH+R4ijm0VoM
         ziIm+UJG8p5/g8JGPENcGL/UCg5MRTVJNF7Vluv9qxdxr22DsqmdMBcaWam7en1avsVj
         nKaHV4gk7KOHrk6DAmy+iEXMjFT6p8cx1r6I2h6Doc9qeUknXB55tCtnsj9sVGDLe4HA
         OgxdLV6dJgM+pB45YAlFto98JTgybVrzK/qBJh+HxJrLORAd/AyZj3kmG/3WDJOxUJS8
         VHdpvfmYnM+cXoM8IQv9I6iDsuNmvteg/6VxrvvCqnFz6dCRdTzfJ0dIivUXwZgK9fSX
         zRog==
X-Gm-Message-State: AOAM531zUbzYO6e1NoASiYambHeGflrpz4sb/DlZTmxHjzYEmnKqA+0b
        zoC0X4NdTm5/E52+Sic1ICE=
X-Google-Smtp-Source: ABdhPJxX9ileI2WmqX6uf7SYTsGgUhniZrweG7+ql+M+jKSmO4li39cSDPQsAxQEEU8bOCBcvx1ZuA==
X-Received: by 2002:a05:6a00:1494:b0:50e:23d:831c with SMTP id v20-20020a056a00149400b0050e023d831cmr22872210pfu.31.1652796407136;
        Tue, 17 May 2022 07:06:47 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:3174:ae5c:a49e:4e77])
        by smtp.gmail.com with ESMTPSA id z34-20020a631922000000b003f27f91135asm3113289pgl.76.2022.05.17.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:06:46 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 3/3] staging: r8188eu: fix warnings in rtw_wlan_util
Date:   Tue, 17 May 2022 19:36:26 +0530
Message-Id: <20220517140626.3716-4-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517140626.3716-1-makvihas@gmail.com>
References: <20220517140626.3716-1-makvihas@gmail.com>
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


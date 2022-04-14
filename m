Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922E7500B41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiDNKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241898AbiDNKjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:39:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E512374860;
        Thu, 14 Apr 2022 03:36:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so6281489wrr.9;
        Thu, 14 Apr 2022 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+H9uo8jaDQ+kAk6GpwLVDlfJtlk/SgUkV35P9NpXgY=;
        b=l9ztUzpU2wRO+hzdBfUprIPjKonUiQxgtSHxGQCjqNQn/2qVyihMV1BTV6Yp1hLgWV
         JKfjhMoWW+g4zIVo9QKAVW+t02X0RwnJ/OzdUEFcQ83XHDBLeWM68ALhAq8McUfQY4Uj
         5Yr+QVJ1HSWKZ3WEF/J7NuRboDG01MN1gnXUmGXrFrPvP3VqfMo4TfcUhxg7+VX7gZBG
         ll/x5T8M6Jk2iTMNqSUOX/0O7/XKREyrDUXOnVtTOhYi0JrvAIV28kOlprJDJgB5p0cu
         V5V7zxxkHSPMixnUGqN+XuTBGlsEl7n5xvDuf162O8b1rfOlUL3knPt0tQEVA/LTMxlw
         Qo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+H9uo8jaDQ+kAk6GpwLVDlfJtlk/SgUkV35P9NpXgY=;
        b=gyuhfQ2QfMqhERyo2DRoZ/xnod5PpU9p7obJP5MJQxj9wH9LZUCHvQnaamm69pe1K8
         iDiVkBHyLlBGSTz64qmjqvJtXBrmjFH0oISAchBwGbz3e3f2CL3wYohSdQFn2aoxeaa0
         aUlof/8656NMbXAGaK8xC2S3pLAoHTO9yKqQyjUuJE1CWlzPFNSjO2Q09qJS6xSfeCwM
         UcuzwDE2Mjl6JqZLRqibcCqnEjQqS34SHA+Ix1L4/WZnqs9y40IQn5+UX4lxbCp0hnID
         9BwV0rn45TL9B7oPG2r7OIqWgj9inCZn48gyZIwuaqXJC41EyVt/NN76w5TGPAIp7iDC
         v8qw==
X-Gm-Message-State: AOAM530Oo43lClsIQ+swilNCyzdMtWo0j26A8tr8U/dYHyICDobc+Dw6
        t3JrciLOiHidxdbg1SOrtfE=
X-Google-Smtp-Source: ABdhPJwXV3YcP+8w+S0kD0SJTZ0cELq2D30GQr5G2hcFvNyGEpDonekUEQKh7+KK4uvvTBtW/681Vw==
X-Received: by 2002:adf:f348:0:b0:207:a696:db82 with SMTP id e8-20020adff348000000b00207a696db82mr1641280wrp.292.1649932611540;
        Thu, 14 Apr 2022 03:36:51 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p15-20020a5d59af000000b0020858885fd7sm1830260wrr.9.2022.04.14.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:36:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] staging: rtl8192u: make read-only array EWC11NHTCap static const
Date:   Thu, 14 Apr 2022 11:36:50 +0100
Message-Id: <20220414103650.297396-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the read-only array EWC11NHTCap on the stack but instead
make it static const. Also makes the object code a little smaller.
Remove comment.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: remove unnecessary comment as per Greg's request

---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 358c35d9589c..a93f09033d9d 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -480,7 +480,7 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
 	}
 	memset(posHTCap, 0, *len);
 	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
-		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
+		static const u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};
 
 		memcpy(posHTCap, EWC11NHTCap, sizeof(EWC11NHTCap));
 		pCapELE = (struct ht_capability_ele *)&posHTCap[4];
-- 
2.35.1


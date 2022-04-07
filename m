Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86A34F6EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 02:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiDGANs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 20:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiDGAN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 20:13:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834F207CA6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 17:09:53 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so2806358otq.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 17:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XVeFHIc1i7/STUyOqY2BjiqMfxqrpI5r2pW0fHpiZrg=;
        b=ju2OgTKNguSXVies5Fr0Bpbt5cr6vjY31Htu9eJLAfPRmr4Bl4WwFpPeeSdZG11zSz
         0jQYeT3ojk8AoLZKSUv0WYwxxEM+aP4NaETmYs6W0eWoa3u7XCXafWtT9lij51TtMI5C
         d/ZOWrw0ddAvLlYvqq7URXMp5qo6lgjvl5XLLoU0Qi8SjLI/UxCOe4LwbvFIKHKFn5TC
         xBZ7dKTG1+R4LUC9HkppTPO8TSbfuFDgoKFliDI1gxRDrK4/VqCsWg2Hot4vgyFDWC1r
         oZD+reRwRQVpeUQvRr9+xvX2IJqVgwfxDZZn78xWhBTKx5eKIe253yMV24axUcSzrruZ
         HBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVeFHIc1i7/STUyOqY2BjiqMfxqrpI5r2pW0fHpiZrg=;
        b=OSLSogScm4RDrkywgXyFI5qUwk6usJBYJ0FITEgyiNO0fUtKCToeNH2rsQjF6vXsHu
         xMSapdm/9K6qQFPO3h5HCQVsP22bmge0ZiACd/Ho0Hs9NNl5sgkRrwL6UYOSpr6E7PPP
         5lSIbs3Y980nO7HCLdpdc736VDORDLm43a2aS+NylscVNrRIloP+Ep+Zq8Wu6L2zFTTn
         QH5rG8Rs1QSz935UDxw6Q5d2O8LXILMWI2Gnb3Bc5dXpWeyqFiYi09bFlvec3JPxjCUd
         sLVe5JJiM8cOwIdRwqZQRvsrFBwp2flsavmPZoJJ3lSzHOA9ogX5jbJngBknJKWVyOC+
         6M3g==
X-Gm-Message-State: AOAM531we6AaTzyPwkmqJBeyHEIJ3pb9a0+Z0ki70E3Dbg8U6S8GhTo4
        qug3XsKJtP7JnPBQWHzvkns=
X-Google-Smtp-Source: ABdhPJwmTWBL+ymtBkt//FaRniw79brAz5nbLTAH0A+7eOqrMU/Og6M6W2L1T695eo1odVpp4VgYDA==
X-Received: by 2002:a9d:610e:0:b0:5c9:373e:5819 with SMTP id i14-20020a9d610e000000b005c9373e5819mr3831455otj.348.1649290191153;
        Wed, 06 Apr 2022 17:09:51 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id p11-20020acabf0b000000b002ef93581a46sm6923348oif.2.2022.04.06.17.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 17:09:50 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 1/2] staging: rtl8192u: use max macro instead of ternary operator
Date:   Wed,  6 Apr 2022 19:09:43 -0500
Message-Id: <2513b1520d533c9f487903fc2c97f4637fe5f6da.1649288226.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1649288226.git.remckee0@gmail.com>
References: <cover.1649288226.git.remckee0@gmail.com>
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

Replace ternary operator with max macro to increase readability
and conform to Linux kernel coding style.
Found with minmax coccinelle script.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index 78cc8f357bbc..a10c1303695b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -470,7 +470,7 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
 		return 0;
 	}
 	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
-	erq->length = (len >= 0 ? len : 0);
+	erq->length = max(len, 0);
 
 	erq->flags |= IW_ENCODE_ENABLED;
 
-- 
2.32.0


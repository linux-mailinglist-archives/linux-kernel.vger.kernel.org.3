Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA86750880A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378499AbiDTM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378495AbiDTM0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:26:17 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9781403E5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:23:31 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-e5ca5c580fso1752503fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=TIUNz0EBmXcqRPlOdyGN4ICv5GdtKevGFMV0dTVCKRM=;
        b=KN1EH+ZkU67vRFXgDO4xfqUjsgFZyKpCOMKnhjRkjH16Co9PlrgjbBEy9UTyOLeelA
         BGzYm53QGEti6u/01jPf2J8shH0+mxiJ5IrtOsWmul23Wl1NXQKn0U7MLdEs8YqUExF/
         YlmLgtWchtqGNs5FMe7MNnrGWjh4sf8woOiql6m1NlDZG5y+gVAvno9hT/9tJBYCvh1F
         lNegr90SmksTyexOtEt4VVCnDy1af3PNP3MYZc/FdPy/JSj25LqEdbi60G0PSWLqjSsr
         Q2s8R9l2Vpfw/KXhycFZM3XbMkCBSU1hLhdtOlUeTOeL2BQaTWbvVebKwA7rbDLwx8q7
         sw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=TIUNz0EBmXcqRPlOdyGN4ICv5GdtKevGFMV0dTVCKRM=;
        b=Af9hEq+nBYsHMsFhejn1Tyhefcpoau9oJmTIdtK4tWST40HcFinKwgguOExxrV6MQg
         NDX5OSRWhQYZATFg49aWgtZKXQsi97rI2dW//gqOaI+T+nVRY0gkju89F8mOWhFw4U53
         Mqc/82rj88VMHJo/87xVJ54JpUf8cszNDxa2M2bfPaVycUJKtSdVjsU8ETHUdHfLZQm5
         Js8stimJHM7PmcLVKfIkkvsY7idhnT/Rikj7PO8qwu4jZPDK7g3sXHnd9lSNTEIBAlXQ
         TG/vVYSn5foswAwjNB7flXeWvv04aFPoRcrsBFU/ROvnWehKhOuyZyhwU+wY9oypaF/F
         KB4A==
X-Gm-Message-State: AOAM531O9Pfr9jCW+BumN+CE9vP0Nb28Tybtva6BQkY2tNgN1E69GgN7
        aEKcT23hzZ9rDAOHk40oe+3EBr4N86OMxQ==
X-Google-Smtp-Source: ABdhPJwfZfjdD7QWExbNx3daNAWGm7vWiwN/GrOXV6HfntYFHwxdgyn3VeFjMqXaPJJKA284z7plkg==
X-Received: by 2002:a05:6870:c151:b0:e5:bf64:38d with SMTP id g17-20020a056870c15100b000e5bf64038dmr1389721oad.8.1650457410282;
        Wed, 20 Apr 2022 05:23:30 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id q13-20020a4ab3cd000000b0032830efe365sm6541879ooo.43.2022.04.20.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:23:29 -0700 (PDT)
Date:   Wed, 20 Apr 2022 07:23:28 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8192u: change get_key functions to return 0
 instead of -1
Message-ID: <Yl/7QPKXer7YtXOs@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, these three get_key functions return -1 when the provided len
value is less a specific key length value, which can result in buffer
overflow depending on how the returned value is used. These functions are
used in three places in ieee80211/ieee80211_wx.c:

  ieee80211_wx_get_encode() :
    The behavior of this function will be unchanged.

  ieee80211_wx_get_encode_ext() :
    The result of the get_key function is written to ext->key_len,
    resulting in a buffer overflow if the result is negative.

  ieee80211_wx_set_encode() :
    The behavior of this function will change. When len is less than the
    key length value, it will set a default key of all 0.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
index 101c28265e91..f17d07dad56d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
@@ -362,7 +362,7 @@ static int ieee80211_ccmp_get_key(void *key, int len, u8 *seq, void *priv)
 	struct ieee80211_ccmp_data *data = priv;
 
 	if (len < CCMP_TK_LEN)
-		return -1;
+		return 0;
 
 	if (!data->key_set)
 		return 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
index 689d8843f538..7b120b8cb982 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
@@ -637,7 +637,7 @@ static int ieee80211_tkip_get_key(void *key, int len, u8 *seq, void *priv)
 	struct ieee80211_tkip_data *tkey = priv;
 
 	if (len < TKIP_KEY_LEN)
-		return -1;
+		return 0;
 
 	if (!tkey->key_set)
 		return 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
index 8a51ea1dd6e5..a2cdf3bfd1a4 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
@@ -201,7 +201,7 @@ static int prism2_wep_get_key(void *key, int len, u8 *seq, void *priv)
 	struct prism2_wep_data *wep = priv;
 
 	if (len < wep->key_len)
-		return -1;
+		return 0;
 
 	memcpy(key, wep->key, wep->key_len);
 
-- 
2.32.0


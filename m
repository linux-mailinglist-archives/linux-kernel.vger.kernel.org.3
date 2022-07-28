Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F948584893
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiG1XMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbiG1XME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:12:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA8D4C638
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:12:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h8so4055351wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOMs7BLkqwBB1UyXezQZ04RHJK4IHCUkM0ubSij7BbY=;
        b=TvgWxQ1YU4CH0+n1gsKJEid55d9jKIcmFtMQOw0CZFaHfwluaTrU+wGzMpSwJo2fdO
         JpKRA8uvvt5OAJt/ocPjjpo19sfI3aFcSrN0SBWMLeR951R1yh67AzlzTC62HI3WtPlJ
         zWfGmw7s3Q+D4Y+fDQpO4mWBW4TCG80pXnF2Dqs2Xlg+0cGDedBUs5qC6oSwuV0ZGtrT
         dJqHSXbF+wOy3WDYisoHFmTipvNOrOxJACnGPfDSgjAZOQz5swY8NVyf7oXWEZSsth4n
         SqznWV5UJZBkf6EqyaSSLvbKBtSMEYlqbIeWoU93f7WAZe+ATFd2bu7+8IIRV9uefqCS
         wbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOMs7BLkqwBB1UyXezQZ04RHJK4IHCUkM0ubSij7BbY=;
        b=x5NillEFN3v8D0kCBe/FzF+wPcaCfINMhHAReI3lpdrh1qSEDuf5jvB0Eu7+Nw4ilO
         0Oq1dnbxqnRkVVMFMXtkbgYSISSG0RypoyJM1KyKbDJJelddirMwaCGCLJzNXdN/0jBh
         STBHf2WSEKrZ3r6VQ35FG5C/bAQBqbDFk2uy8ju78yl/Rdj+U2LDdmAhnU+LiDF3W/8T
         vSM2iuiQZgxHvJ+8xUU/lWSm3UbMDzUQszKJ63+V1jPzsIbedKTVfEnC0vV53z7ALnoC
         n/rVp8RgORfZsMzfYYaltAEoTh16pLU+ahXVJPbJg1/oUXk5OFP3fOKt8Z4OUkC3oxQr
         3Y9Q==
X-Gm-Message-State: ACgBeo2/bWJSZsrnKahMW2D68Svq0xtJQMVc5pmdRnpKugPR9HpjlQNP
        DzX8X79aTu7SasN4GGrfTTOppA==
X-Google-Smtp-Source: AA6agR6BuhN5Yz1o0mDQQ2XeVvUQLLBpBJKf9VdtE9hzY5hN+7oicLyfoD+qYRPAxwy8Ry9O0rHoDw==
X-Received: by 2002:a05:6000:80b:b0:21e:d62e:b282 with SMTP id bt11-20020a056000080b00b0021ed62eb282mr614545wrb.557.1659049920763;
        Thu, 28 Jul 2022 16:12:00 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id m20-20020a056000181400b0021e571a99d5sm2089419wrh.17.2022.07.28.16.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:12:00 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        paskripkin@gmail.com, martin@kaiser.cx, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, abdun.nihaal@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: r8188eu: convert rtw_set_802_11_add_wep error code semantics
Date:   Fri, 29 Jul 2022 00:11:50 +0100
Message-Id: <20220728231150.972-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220728231150.972-1-phil@philpotter.co.uk>
References: <20220728231150.972-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rtw_set_802_11_add_wep function to use 0 on success and an
appropriate error code on error. Also convert return type to int to allow
negative return values. For the first failure block where keyid >= 4,
use -EOPNOTSUPP as this is most appropriate, and for the second failure
block where rtw_set_key is called, use -ENOMEM, as this is the cause of
failure in that function anyway - in due course, rtw_set_key can be
converted as well.

Finally, convert both call-sites of rtw_set_802_11_add_wep to use the
new semantics, passing through the error code where we can for one of
them.

This gets the driver closer to removal of the non-standard _SUCCESS and
_FAIL definitions, which are inverted compared to the standard in-kernel
error code mechanism.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c    | 8 ++++----
 drivers/staging/r8188eu/include/rtw_ioctl_set.h | 2 +-
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    | 5 ++---
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 17f6bcbeebf4..a5b5d7f6a864 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -390,16 +390,16 @@ u8 rtw_set_802_11_authentication_mode(struct adapter *padapter, enum ndis_802_11
 	return ret;
 }
 
-u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
+int rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 {
 	int		keyid, res;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
-	u8		ret = _SUCCESS;
+	int		ret = 0;
 
 	keyid = wep->KeyIndex & 0x3fffffff;
 
 	if (keyid >= 4) {
-		ret = false;
+		ret = -EOPNOTSUPP;
 		goto exit;
 	}
 
@@ -424,7 +424,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	res = rtw_set_key(padapter, psecuritypriv, keyid, 1);
 
 	if (res == _FAIL)
-		ret = false;
+		ret = -ENOMEM;
 exit:
 
 	return ret;
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 7365079c704f..761b30bdb8ec 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -11,7 +11,7 @@ typedef u8 NDIS_802_11_PMKID_VALUE[16];
 u8 rtw_set_802_11_authentication_mode(struct adapter *adapt,
 				      enum ndis_802_11_auth_mode authmode);
 u8 rtw_set_802_11_bssid(struct adapter*adapter, u8 *bssid);
-u8 rtw_set_802_11_add_wep(struct adapter *adapter, struct ndis_802_11_wep *wep);
+int rtw_set_802_11_add_wep(struct adapter *adapter, struct ndis_802_11_wep *wep);
 u8 rtw_set_802_11_disassociate(struct adapter *adapter);
 u8 rtw_set_802_11_bssid_list_scan(struct adapter*adapter,
 				  struct ndis_802_11_ssid *pssid,
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 7f91dac2e41b..4d8dbc2a9ef2 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -422,8 +422,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 		pwep->KeyIndex |= 0x80000000;
 		memcpy(pwep->KeyMaterial,  param->u.crypt.key, pwep->KeyLength);
 		if (param->u.crypt.set_tx) {
-			if (rtw_set_802_11_add_wep(padapter, pwep) == (u8)_FAIL)
-				ret = -EOPNOTSUPP;
+			ret = rtw_set_802_11_add_wep(padapter, pwep);
 		} else {
 			if (wep_key_idx >= WEP_KEYS) {
 				ret = -EOPNOTSUPP;
@@ -1613,7 +1612,7 @@ static int rtw_wx_set_enc(struct net_device *dev,
 
 	memcpy(wep.KeyMaterial, keybuf, wep.KeyLength);
 
-	if (!rtw_set_802_11_add_wep(padapter, &wep)) {
+	if (rtw_set_802_11_add_wep(padapter, &wep)) {
 		if (rf_on == pwrpriv->rf_pwrstate)
 			ret = -EOPNOTSUPP;
 		goto exit;
-- 
2.36.1


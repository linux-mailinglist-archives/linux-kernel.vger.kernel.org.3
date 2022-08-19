Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB5599C62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349179AbiHSMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbiHSMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:58 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057DB8607E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id o22so5542766edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rXYLqyvUZrDN2atFN2rBSj6q0FVOWGSmJ64xIojR0jo=;
        b=IyMU8Q0g1EDviaijWxU0HOP0rhogM+knpciweLZp3KyJeTUUfsKqpUcL45r4wJVS35
         HgXshxSpXPW761SZneyuC7aaK32j/UT9vNl5e0QuSXbkH3lnOqUx/exE4szyybj3q+Lr
         msmfs0kWzb4wZtTaVhOj3ZUDC6fQsiAxu2L9faFOWGRkU6tcspWigb139sBiioRTcjPD
         KvRbWWB999vwFaRDYZSC5nbQAY6sbP8ipXbeElTmxk9neAUom5GPknco566HgfU2iEb2
         QVVdMszSNR/dERKkypfiPVeC+c4nOQ6UgPpET9FmyXUifo6YiytjNM9bNmP9BSPpWOwe
         na2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rXYLqyvUZrDN2atFN2rBSj6q0FVOWGSmJ64xIojR0jo=;
        b=hT+IkkWds2WDoYAygkoYB0l7aAaVNaAAxsNhZTrX+FyZrCYPHdUPRfOY1Lw5wuRjYX
         05BaDKrfjxCtUEkTnpYUkFAG4yuUx/DQ/NQAWEP+aPT2mz3zjONAYD87vxqkpSesIWeS
         WE8bVVtDxJPsOK5vh/AD7XgbfJ/YDyaiocTk5FzX3nBWC/ExX/xIZpXP1OnTCTClC0Gg
         8clhehwmBAgpR1g2j21azccxgrTDGjcqVy6Nckj8p8I6jQOhSaYfmgCAm6wqZI6Chh/2
         +qME+dRfQkleQhsjx35QUo8GJE44x6oMcAAGerTiYT6z04ZoWp2P1TytuUi2SBerBWSz
         UqlQ==
X-Gm-Message-State: ACgBeo3decYOnqBpSECXRwVA+DsA0delaKFxCpy7q0gRvWmOsEyRlfUw
        OZgNYcehIpbiYNGzaDCvnxQ=
X-Google-Smtp-Source: AA6agR6MxNlU186MP5egDDLOeR/KWwwZthJZ/YMEAcL+bp+EO/EOrwf/iSpBjapFlEJodROX5ynLog==
X-Received: by 2002:a05:6402:448b:b0:43b:5ec6:8863 with SMTP id er11-20020a056402448b00b0043b5ec68863mr5923937edb.377.1660913683809;
        Fri, 19 Aug 2022 05:54:43 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:43 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 08/11] staging: r8188eu: merge rtw_{os,}_indicate_disconnect()
Date:   Fri, 19 Aug 2022 14:54:25 +0200
Message-Id: <20220819125428.8412-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
References: <20220819125428.8412-1-straube.linux@gmail.com>
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

Merge rtw_os_indicate_disconnect() into rtw_indicate_disconnect().
The function rtw_os_indicate_disconnect() was moved from the os_dep
directory. It looks like the driver was originaly written to support
different operating systems. We do not need this wrapping into an
extra _os_ function obviously.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 6e51d735b2bb..3050c85dec2c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -837,15 +837,6 @@ static void rtw_reset_securitypriv(struct adapter *adapter)
 	}
 }
 
-static void rtw_os_indicate_disconnect(struct adapter *adapter)
-{
-	/*  Do it first for tx broadcast pkt after disconnection issue! */
-	netif_carrier_off(adapter->pnetdev);
-
-	rtw_indicate_wx_disassoc_event(adapter);
-	rtw_reset_securitypriv(adapter);
-}
-
 /*
 *rtw_indicate_connect: the caller has to lock pmlmepriv->lock
 */
@@ -882,7 +873,11 @@ void rtw_indicate_disconnect(struct adapter *padapter)
 
 	if (check_fwstate(&padapter->mlmepriv, _FW_LINKED) ||
 	    (pmlmepriv->to_roaming <= 0)) {
-		rtw_os_indicate_disconnect(padapter);
+		/*  Do it first for tx broadcast pkt after disconnection issue! */
+		netif_carrier_off(padapter->pnetdev);
+
+		rtw_indicate_wx_disassoc_event(padapter);
+		rtw_reset_securitypriv(padapter);
 
 		_clr_fwstate_(pmlmepriv, _FW_LINKED);
 		rtw_led_control(padapter, LED_CTL_NO_LINK);
-- 
2.37.1


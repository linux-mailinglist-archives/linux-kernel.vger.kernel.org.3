Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584854EDF64
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbiCaRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiCaRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:09:55 -0400
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9491F0824
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648746486;
        bh=ctWsvOCYw/Nk+/HVUYkGj4y3NFwJ5+znyibIFc9hryU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ix3cbYpJq7wD4bQn1V9sM79AQk5EAlSEvzgiK18muoULTWuF8NhD/4U6S1sCzPHly
         13ivebdXLoebBYvoU3EyVe6jLaVGWyCofRV4GVT8gstyIOFQ7iEdCFDEIx/eaNCJ6x
         Xu1kPDDBFzgqgg3xX9AagbBvt9s+mQMx/b8EomLg=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 2031D0A9; Fri, 01 Apr 2022 01:08:03 +0800
X-QQ-mid: xmsmtpt1648746483t4hkxdb1g
Message-ID: <tencent_3096E1464A73FF232014CC40B9001C551408@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeMjOTVeXWC6Xr2HPJXf7Z1mIOravcX95UqAVizHoxIBVt3O1iMe
         N+brrEucwxY9JjJAODjkJFI2Ml5/p7bi/oxa+K7Njk2I7SjR/CBb97B4tObAqxiMN9W8hyv9mDQL
         SaBR1OILkXRb61xxFb73V7qPPVZITz4WCzXWnczl55vcknJ5DOJJmoy93s0VjORlIEoMA/MKymrL
         gK1TZK4/RxMammsgvUERL8oR0vsJMN2wvfnu5MoLMDd06g0L6fIy/SX4uCSjEtv2pAdyoHEKk5+9
         qbZHCYxaA/4XGHsMV2iyf1HOyt/WfWPaChRpNhO2CtVdB96AwVSJZr/x5fTOrDDKTxWwjL6VyqHE
         qn28YT3AF4LFLWIQn8oINPt2eFTlUuhWInd24baVuxV+EUsBYGHcvQXK6NhX1x9VYpkfLuktt19k
         LYKnrVcren0gtJYn3fe7cV27BZa605XX44MwDPhZibDNu7b99GdaMZRw5jrVvg1HRl2i9rlGqLfP
         sNDFuqLI9Cy5WR4QO9/FjZLoU3DzPjlt3BP0Fu7yxrULuSLkh8CIVq9ikvOQeNbvvT71Xty2lH0b
         lOk0Gp7cvUmQdyT/w9RSxBqtyPVtHL3Za58Wc803JA2t9YiZb0E+ZH0KlT+gc5bnjbVabN2DFKYr
         IRK0Ad3Ll0Li9BDj2rhnCUTki7TcCPiH1npuH0NJKblHC9xl2S78af7VhQ1L7N0vs0JEMDkWTJeE
         yaqo57re1eebFjxnOJAIatYpTstHZeY79ype4MzIsvgGGkki/r7qiqqRdT+eZ9ezExyHldxgfw4y
         m6dCXmB5GKpAD6GfK8qDxqScbruxPDahim24iANlzPinT9R7PmIRxh2BItXhEX6EAGv3z38+1DaB
         uo+WG/l+pmYN12/prFD7sqBXBL+hhY5PUVSdzmk0gZM8ANrhV9lDMWef86Wutsam7731RcWflaFg
         XMLD30Tk4=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 2/3] staging: rtl8712: add two validation check in r8712_init_drv_sw()
Date:   Fri,  1 Apr 2022 01:07:45 +0800
X-OQ-MSGID: <20220331170745.9592-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
References: <tencent_0A1273526E1E87150578F8B752CF7F178806@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

_r8712_init_xmit_priv() or _r8712_init_recv_priv() returns -ENOMEM
when some allocations inside it failed.
So it is better to check the return status of them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 9502f6a..163baaa 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -308,8 +308,12 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
 		return ret;
-	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
-	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
+	if (ret)
+		return ret;
+	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	if (ret)
+		return ret;
 	memset((unsigned char *)&padapter->securitypriv, 0,
 	       sizeof(struct security_priv));
 	timer_setup(&padapter->securitypriv.tkip_timer,
-- 

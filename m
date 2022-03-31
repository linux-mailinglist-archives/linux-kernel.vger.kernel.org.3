Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F09E4EDA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiCaNHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiCaNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:07:19 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA66049916
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g20so28085486edw.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vhzg+EFSHTIr1gVDui1/FuKQCOLjPrm8bCZUxNvvDXU=;
        b=V12rv/gD9izH5kJjX4/6cUNAYZK5mCknm7kdkqtNI5auSjebI1oFnHvaPqKB87D5Ua
         eWcpwaWUlyMEL0qc0skuBP93r1L/dhi1ewpgYVxqQD79Rax9sWcSmPz1eXHPEorGnN3y
         YC1rWn8L6rDurf5KymFbuu6JLBRu0/MKx1X3oUUHhYvMBksunmwVdHpiuUSgY9m2icbb
         qbFjJLvo/dO6lDU1aXzRifD7oBUO7kIV7sUFRn7p95WWJeostmmztpY7AJ7HMI5MCvc8
         N6fRmhPQNNLjkLbrdJM1ma1Dhh44teNIPaKS91y/WXUX7YnImFHg/TZ10P7S6Puzs74h
         KDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vhzg+EFSHTIr1gVDui1/FuKQCOLjPrm8bCZUxNvvDXU=;
        b=Fw0256ogTsQhVD69yruMLzhFDLAC/HS0s+aXTeZW/eSeUCvV/sjiCo+ocP68OxJHP4
         UvfaC+x8XZUEtUZS4Sz4flKKAPREGECZqdr2JOqfSAhCCJQNuvU6uvChmC/0X/Vocirq
         PhBL2mD//5FkZXbtCCnibcjkCoX59SxNG+EqPL/hoBdpjMtusEvGZIAjfGsjXk6Ck/h3
         h9TV6tqbBes3byxNpRsz0cCU2h0Gq8G+8+85et+6zPiOg/dgdgc95XggbiImEXVDzBHf
         Z9K44IqNt/6X7IdvutLPyIsKBg8WlordWsKxZjC8Z0hU2p2xi0kKrpDoLBN/zqpR5Ffr
         gAPw==
X-Gm-Message-State: AOAM533T2670uqjIUYa9rC4476cNqv+wi67HkT4AlK7MEv1RLVtbGEq2
        2q94Z1hhxivnHk4tAP/jdaI=
X-Google-Smtp-Source: ABdhPJxI+/ZNJNapuNc5I5I5OMz/nuAIDlweF9ZbVqo17g9YvwLlrKiTx6+7HAh+k+R2m81ecmrPWw==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr16432053edt.359.1648731930883;
        Thu, 31 Mar 2022 06:05:30 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.85])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm9333358ejc.197.2022.03.31.06.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:05:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: remove HW_VAR_BCN_VALID from GetHwReg8188EU()
Date:   Thu, 31 Mar 2022 15:05:19 +0200
Message-Id: <20220331130522.6648-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331130522.6648-1-straube.linux@gmail.com>
References: <20220331130522.6648-1-straube.linux@gmail.com>
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

The HW_VAR_BCN_VALID from GetHwReg8188EU() just calls rtw_read8().
Remove HW_VAR_BCN_VALID from GetHwReg8188EU() and call rtw_read8()
directly. Move the call to a new function to indicate what it actually
does. This is part of the ongoing effort to get rid of the unwanted
hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 10 ++++++++--
 drivers/staging/r8188eu/hal/rtl8188e_cmd.c     |  2 +-
 drivers/staging/r8188eu/hal/usb_halinit.c      |  4 ----
 drivers/staging/r8188eu/include/hal_intf.h     |  1 -
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  1 +
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 15a91c5fc852..3032a7e7977b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5755,7 +5755,7 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr)
 
 unsigned int send_beacon(struct adapter *padapter)
 {
-	u8 bxmitok = false;
+	bool bxmitok = false;
 	int	issue = 0;
 	int poll = 0;
 
@@ -5768,7 +5768,7 @@ unsigned int send_beacon(struct adapter *padapter)
 		issue++;
 		do {
 			yield();
-			GetHwReg8188EU(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
+			bxmitok = get_beacon_valid_bit(padapter);
 			poll++;
 		} while ((poll % 10) != 0 && !bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
 	} while (!bxmitok && issue < 100 && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
@@ -5784,6 +5784,12 @@ unsigned int send_beacon(struct adapter *padapter)
 	}
 }
 
+bool get_beacon_valid_bit(struct adapter *adapter)
+{
+	/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
+	return BIT(0) & rtw_read8(adapter, REG_TDECTRL + 2);
+}
+
 void clear_beacon_valid_bit(struct adapter *adapter)
 {
 	/* BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2, write 1 to clear, Clear by sw */
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
index 2e252562e48c..45b788212628 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_cmd.c
@@ -568,7 +568,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 				yield();
 				/* mdelay(10); */
 				/*  check rsvd page download OK. */
-				GetHwReg8188EU(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
+				bcn_valid = get_beacon_valid_bit(adapt);
 				poll++;
 			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 8cb1163ced5d..8c4bc78681e1 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1289,10 +1289,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 
 	switch (variable) {
-	case HW_VAR_BCN_VALID:
-		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
-		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
-		break;
 	case HW_VAR_DM_FLAG:
 		val[0] = podmpriv->SupportAbility;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 1e2177b8e11c..065fc7bd78d5 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -17,7 +17,6 @@ enum hw_variables {
 	HW_VAR_MLME_JOIN,
 	HW_VAR_SLOT_TIME,
 	HW_VAR_ACK_PREAMBLE,
-	HW_VAR_BCN_VALID,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
 	HW_VAR_DM_FUNC_RESET,
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index a00da19c4b88..0875472dbb72 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -538,6 +538,7 @@ void issue_action_BA(struct adapter *padapter, unsigned char *raddr,
 		     unsigned char action, unsigned short status);
 unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr);
 unsigned int send_beacon(struct adapter *padapter);
+bool get_beacon_valid_bit(struct adapter *adapter);
 void clear_beacon_valid_bit(struct adapter *adapter);
 
 void start_clnt_assoc(struct adapter *padapter);
-- 
2.35.1


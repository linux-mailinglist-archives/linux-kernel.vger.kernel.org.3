Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630F15A0292
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbiHXUPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240289AbiHXUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:15:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C293242
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gb36so35607907ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc;
        bh=sCUiS3qiw3P6R4sjn2bcDl99oRoA2UGJKOoJt3+JSec=;
        b=Bi819f3gUZDOPgJw2U8A49ZkwWSBtWfd/+naWC8bEfp/HM3LI8goZYgxsUpetzz6SV
         wZvDH+SoKvP2UmDUE0EN+JKjp69xOcNP/PjliDFz0cLEIionrE9vfTj0cKdEJ5oTbzvj
         BZMqLYjs2Q+T8TBFUzDeDADakyT5+Qtk9eJ5Pl+wo7/ixVFDw+JKxDxVtrUnCBbd+IcO
         EPoV6dbfD5CtfgAulsq/oamI5Qb1r3Y1/12yS1erWEv1egaN6BE7pdm4WfMHuv7Uppfy
         wL1jiGcnaTHyLkjl83vB32d6O2acsVSSPCHBtdS7oJQQbSvRF1K/6xV2+jSlVAF5/sz0
         mqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc;
        bh=sCUiS3qiw3P6R4sjn2bcDl99oRoA2UGJKOoJt3+JSec=;
        b=FV2zgztW2WcsjpUDxmJNTUkvEZW5ujY2jrB/1inxs3jqtmwxfVf6jThjdfc7dJydlb
         cfisd6tCaoHjpyPEVddzPWbae5rLZqfBjHP4n163kMLWNcSWRLl/XrFDL22h653hz9mJ
         2t9TcUFRp/W61JRZs2oe9qgzn37TbfsDyCV1W5M++0wOznvjJngUgYXIoQri+L4X25U/
         Cxil/jW/w936QdhgHgwQuMBdP9Mq6wM3llJNS9Wxk/kmqDinx5wjwl1MSmmWffSFhCG+
         TwBU2nW143VxczKw8pX1HA0HTgZDUTwLxkPJ21a1RM5Xs66gYFw/9/X0Y5guWXpeIT9k
         LLYQ==
X-Gm-Message-State: ACgBeo2KKt0JqLzxibMyWV5DGccwUecs77e1hrvWh74k+efNe80sVKMg
        Ug6bGLBFQCgLulIUpY6sCnk=
X-Google-Smtp-Source: AA6agR5xOzz3SUzOnzLS+/oGLHJTfUQlp6XyTO9qciBJaUBYfGPLUJWQvN3ZxWJZnBW6D6zXesAQfw==
X-Received: by 2002:a17:907:2cc1:b0:73d:c2d9:3232 with SMTP id hg1-20020a1709072cc100b0073dc2d93232mr353713ejc.763.1661372091156;
        Wed, 24 Aug 2022 13:14:51 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b0073d70df6e56sm1525023ejn.138.2022.08.24.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 13:14:50 -0700 (PDT)
Date:   Wed, 24 Aug 2022 22:14:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Remove PHY_SetRFPowerState and rename
 StateToSet
Message-ID: <ae69fd4a09900a395de40b7cfc4fd8af81e63e13.1661370978.git.philipp.g.hortmann@gmail.com>
References: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1661370978.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove macro that replaces PHY_SetRFPowerState with
rtl92e_set_rf_power_state and rename StateToSet to avoid CamelCase
which is not accepted by checkpatch.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 8 ++++----
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
index 7c9148e033d8..7f2a24b72e52 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
@@ -83,7 +83,6 @@ void rtl92e_set_rf_off(struct net_device *dev);
 
 bool rtl92e_set_rf_power_state(struct net_device *dev,
 			       enum rt_rf_power_state eRFPowerState);
-#define PHY_SetRFPowerState rtl92e_set_rf_power_state
 
 void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation);
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 8462dd9859e8..5ac4817909df 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -132,7 +132,7 @@ void rtl92e_writew(struct net_device *dev, int x, u16 y)
  *  -----------------------------GENERAL FUNCTION-------------------------
  ****************************************************************************/
 bool rtl92e_set_rf_state(struct net_device *dev,
-			 enum rt_rf_power_state StateToSet,
+			 enum rt_rf_power_state state_to_set,
 			 RT_RF_CHANGE_SOURCE ChangeSource)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
@@ -168,7 +168,7 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 
 	rtState = priv->rtllib->eRFPowerState;
 
-	switch (StateToSet) {
+	switch (state_to_set) {
 	case eRfOn:
 		priv->rtllib->RfOffReason &= (~ChangeSource);
 
@@ -215,8 +215,8 @@ bool rtl92e_set_rf_state(struct net_device *dev,
 	}
 
 	if (bActionAllowed) {
-		PHY_SetRFPowerState(dev, StateToSet);
-		if (StateToSet == eRfOn) {
+		rtl92e_set_rf_power_state(dev, state_to_set);
+		if (state_to_set == eRfOn) {
 			if (bConnectBySSID && priv->blinked_ingpio) {
 				schedule_delayed_work(
 					 &ieee->associate_procedure_wq, 0);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 8f254c34d5d3..1796c881a5fa 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -598,6 +598,6 @@ bool rtl92e_enable_nic(struct net_device *dev);
 bool rtl92e_disable_nic(struct net_device *dev);
 
 bool rtl92e_set_rf_state(struct net_device *dev,
-			 enum rt_rf_power_state StateToSet,
+			 enum rt_rf_power_state state_to_set,
 			 RT_RF_CHANGE_SOURCE ChangeSource);
 #endif
-- 
2.37.2


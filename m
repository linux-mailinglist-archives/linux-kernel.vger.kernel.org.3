Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF384E4773
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbiCVU01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbiCVU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:26:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABCB4754E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 13:24:49 -0700 (PDT)
Received: from dslb-178-004-174-067.178.004.pools.vodafone-ip.de ([178.4.174.67] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWl3c-0006W7-RL; Tue, 22 Mar 2022 21:24:44 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/4] staging: r8188eu: make _rtw_init_mlme_priv static
Date:   Tue, 22 Mar 2022 21:24:36 +0100
Message-Id: <20220322202439.157999-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220322202439.157999-1-martin@kaiser.cx>
References: <20220322202439.157999-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _rtw_init_mlme_priv function is used only in rtw_mlme.c.
It can be declared as static.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 6f0bff186477..a98712e85d6d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -31,7 +31,7 @@ u8 rtw_to_roaming(struct adapter *adapter)
 	return adapter->mlmepriv.to_roaming;
 }
 
-int _rtw_init_mlme_priv(struct adapter *padapter)
+static int _rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
 	u8	*pbuf;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 42d850f9d777..01de253c0376 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -558,8 +558,6 @@ void rtw_scan_timeout_handler(struct adapter *adapter);
 #define rtw_set_scan_deny_timer_hdl(adapter) do {} while (0)
 #define rtw_set_scan_deny(adapter, ms) do {} while (0)
 
-int _rtw_init_mlme_priv(struct adapter *padapter);
-
 void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv);
-- 
2.30.2


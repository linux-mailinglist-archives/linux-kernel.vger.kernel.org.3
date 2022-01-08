Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC1A488250
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbiAHI1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiAHI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:27:46 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E45C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:27:45 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n19-20020a7bc5d3000000b003466ef16375so6686089wmk.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxNoAeeze9rEMrqirvTKwXGPuD7a3cum906IRqtGFSE=;
        b=OudwkM3oWhgdary6En7VLK/7ka17/mFv1TG88WtBAJ8jdBQkDn6Oy7JgyK2xIwut4c
         qYdVfdRaF5xUhOmRsfKEz/wsY5SEghD/wIN9fre4XlWufbeHaCM8Klh2j9Zof8/U5qzu
         s0e2RJ0PUBbLGMhNnPjbt4LMqgWnt/we4Zltwx6w7yXbZFIjcHI9Y5afu1/KUUhINxhS
         dCh36A5Z+Fzwv/An/cgTaxn5Sf01R5S1/T8c4duQbpy4QPGVmHCE7bC179lXi5zZQqFu
         JPmcogb1c/iLI9gJZTQyURV5qwactd6LlejpKsA9I3eVW1i6vJ1cGicJmpDaUL/ZbGIL
         hXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxNoAeeze9rEMrqirvTKwXGPuD7a3cum906IRqtGFSE=;
        b=lY1RWM2X2eL9Y+Mqv0OC5/dxPBwwhLEukiI1HFSABd//gp0mglarbPFMLrPK0b+VEV
         aScXhc6vSMITyp6uTUi43o63nyq3VOQ6DR3eNWSOGdzgO3URLDi+MMu9QKnBYxIidpco
         LeRImM3WYQPzJTcQISAE6nFNWVxLmrFG3Sk1FjvtMLp6FSzhnRIdBy0ZrkmiegeEmWnj
         U6opKv/sQD4/RdJOll1942W3ySQ1H/85wVa2j1GWsZtD6Yjf81zjv5morKkKAb34cu57
         wJJTuQRyTolU+IXhCiJGjIj8v6ewQjfwVknOq9sGOIalA8InPGNSwIFoLYeWYTlKduTl
         VstQ==
X-Gm-Message-State: AOAM5304jCpnIIiDRrmjSrc4qpK6HBCnq6Dj6HzTjQo96Xex1PlVnkKs
        CMwStuFMjOFO5NyQXRzRh3R3LC4BCvg=
X-Google-Smtp-Source: ABdhPJxD8l8RHFO9v/JDurGVDXLLNA4PKivI9I/jMvoDQH1Zop1p7WOPJ42QHXXdXvZC2qT+PUveAA==
X-Received: by 2002:a1c:9856:: with SMTP id a83mr13738246wme.157.1641630464158;
        Sat, 08 Jan 2022 00:27:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id az1sm964536wrb.104.2022.01.08.00.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:27:43 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: convert switch to if statement in mgt_dispatcher()
Date:   Sat,  8 Jan 2022 09:27:33 +0100
Message-Id: <20220108082736.16788-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108082736.16788-1-straube.linux@gmail.com>
References: <20220108082736.16788-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'switch (GetFrameSubType(pframe))' in mgt_dispatcher() has only
one case that does something different than the default case. Convert
the switch to an if statement to improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index cdd928c37a3e..a169a7a39ebc 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -443,24 +443,13 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		psta->RxMgmtFrameSeqNum = precv_frame->attrib.seq_num;
 	}
 
-	switch (GetFrameSubType(pframe)) {
-	case WIFI_AUTH:
+	if (GetFrameSubType(pframe) == WIFI_AUTH) {
 		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
 			ptable->func = &OnAuth;
 		else
 			ptable->func = &OnAuthClient;
-		fallthrough;
-	case WIFI_ASSOCREQ:
-	case WIFI_REASSOCREQ:
-	case WIFI_PROBEREQ:
-	case WIFI_BEACON:
-	case WIFI_ACTION:
-		_mgt_dispatcher(padapter, ptable, precv_frame);
-		break;
-	default:
-		_mgt_dispatcher(padapter, ptable, precv_frame);
-		break;
 	}
+	_mgt_dispatcher(padapter, ptable, precv_frame);
 }
 
 static u32 p2p_listen_state_process(struct adapter *padapter, unsigned char *da)
-- 
2.34.1


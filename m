Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD534AE04E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384517AbiBHSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384451AbiBHSEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:04:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A67C06157B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:04:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e3so18296619wra.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rd4kXiCHX1JiB3XHGRQrPutLCcRUBpsFocZnJyKVeYA=;
        b=Zekmcg/F0gXl2lTHQ+Iuf+YDVpXmk8DGyGcYKxpgugmaot8g+yWX82rTWFuFGN1kS5
         aFJOxReAILg1ETjWOPttcJ6oI8xi2hhL2Zvjqe57i3V6opHKDjPWkkQPA1CPSYMJimmo
         52obj1Tp1FohouuLlGKSbO8rTOcvnuO1Tmo1Zb0K/GULbxUS3kEUhvbQIVNWCTmYZlmQ
         9JAZo8hD+RdE13bIDCngVhut0hagwfUVoxOtq8oKZKZDM0ANYGW6aXXKaqQ+SrKCr+g9
         n2XYSpMiiNnD2er375NvRle9F0HI/p9bFB7iXMSE/sjgq8htImz9UTKk+cFxikC/WtB5
         SRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rd4kXiCHX1JiB3XHGRQrPutLCcRUBpsFocZnJyKVeYA=;
        b=OnAEejvFcsCYx7bdIy69KX5/f3Pytmqe8j2O78a0NtgCo0h7OXuWAt3QxSVyRJPfMs
         sVaRjsMPXsQATaL3xs07cnSI60ALDSJX5QTSqvJ5ru05WYgnFuQbP7dUWBq34Eg3bfaZ
         hJQE8N/PEbKYrWz6Cs5uvJ7GjB8k9VG5TelKxVxl73ln2e9ShkwZFsl4y5KZXH4+dguc
         fXvyCD1QtOpE2AYX8Th62ekXnBwKIithHW1WQP/FxTJEtiKScN49NEvSg+SzCcKyqEqD
         Jg8xf6yZqQCqaXtATsmds3NJ9paCOkBmXTMc9r/m7e7aTXcbefkLrnar2DMGr56ELnGk
         B7FQ==
X-Gm-Message-State: AOAM532yFOt53MBonxIwG1oxxAnth13Zdc+lYxL4T/oRdW6LZ+RAtkQv
        gDnavUb0UKkRp4kScfstPzc=
X-Google-Smtp-Source: ABdhPJz6VHSsE0bxxnuY/CnoGXeD4TPVnfrv8CkWjmRReX2sSZvNww99j70HMbHPdto99+fvEXXB5A==
X-Received: by 2002:adf:e18d:: with SMTP id az13mr4632410wrb.521.1644343481727;
        Tue, 08 Feb 2022 10:04:41 -0800 (PST)
Received: from localhost.localdomain (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id n26sm3176872wms.13.2022.02.08.10.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:04:41 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/2] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in atomic context
Date:   Tue,  8 Feb 2022 19:04:26 +0100
Message-Id: <20220208180426.27455-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208180426.27455-1-fmdefrancesco@gmail.com>
References: <20220208180426.27455-1-fmdefrancesco@gmail.com>
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

Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in rtw_set_key() 
because it is not allowed to sleep while it executes in atomic context.

With the GFP_ATOMIC type flag, the allocation is high priority and thus it 
cannot sleep.

This issue is detected by Smatch which emits the following warning:

"drivers/staging/r8188eu/core/rtw_mlme.c:1603 rtw_set_key() warn: sleeping in atomic context".

Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f5b2df72e0f4..860835e29b79 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1600,12 +1600,12 @@ int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, in
 	struct mlme_priv		*pmlmepriv = &adapter->mlmepriv;
 	int	res = _SUCCESS;
 
-	pcmd = kzalloc(sizeof(*pcmd), GFP_KERNEL);
+	pcmd = kzalloc(sizeof(*pcmd), GFP_ATOMIC);
 	if (!pcmd) {
 		res = _FAIL;  /* try again */
 		goto exit;
 	}
-	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_KERNEL);
+	psetkeyparm = kzalloc(sizeof(*psetkeyparm), GFP_ATOMIC);
 	if (!psetkeyparm) {
 		kfree(pcmd);
 		res = _FAIL;
-- 
2.34.1


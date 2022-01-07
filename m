Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1601F487E85
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiAGVuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiAGVur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2FBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:46 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a5so9546869wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skpfr+woNwBWq/UkaJ/OM4D8M7RBtrPdTCE1iH30Ya4=;
        b=I0tGo7QPDX1aHrxZWygj92ftpF+2hKsffErIQg9BPPly2LNCJo+UYePeRLT/Jltcd2
         8R7l5FEU3l8tYlKj0WuXpBvr67azuHOo5rNtdktyjX/eAlmTZoh4MSx+TGL+PGOgs5mq
         HfVUIVIXT0BdwUpNOl376MLpYsvbwkk+U0PWIhMlGIVNCXLB0PfCQSewxR3mMlNyJDzn
         L2g11mmInqOMkLAvAAyHvWT0wxI1hj3oIZX+Av20IsR6Bj6+HZ8Cm8Nbqrx7aQoX9iUz
         6vKSyAJoaiiJtTophsNBMj6zvElu1148BqSh2H09nUNDXCQADPiSwUss9NpJqoNjUYDz
         k17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skpfr+woNwBWq/UkaJ/OM4D8M7RBtrPdTCE1iH30Ya4=;
        b=pjhMHzxO1LK8QsCladGVuNDgJ6DGYl+3/seXFe6Sx8zCEdhTQcdXLi1YpVjnNcD29Z
         i7io/k2jFWhN3HY+/yPpyVrQ7QvrnayRyPMgZVDjWBDmLX2PCiySZ2wg42o4888rSw7+
         aCwj629uC+vcImzxlAMkpgleXQQH9vokmjy+Rl4twp/3Fnr+cTbZMgdo48qjcSkDU5j0
         CRjn4NdcatsW13/JW5oVE0Ug72XaDeoGjU56w7zhUhgx17Y6qXJNtaxh2avTBo3qN1aC
         Jou5l5qKMNdmmRUJw9PN95iDU3wbUbpVFCwZTNtlyQ/epCUs3kvqj15SrpRoPJoHTogy
         an/A==
X-Gm-Message-State: AOAM532MTGTfBUaePtDGEbPNXdyoO19Hjn6osICX2MCYhiZHZN2Prcdy
        TfsYSUJGbJoMN1/aFPomV5A=
X-Google-Smtp-Source: ABdhPJwny7FT6SeNz720JLxmXrX6dzb12UysNF3RqlDgx8UKnfMXmuTOnsp1/ZAz2xwekdMiYXpUfw==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr56861714wrp.714.1641592245392;
        Fri, 07 Jan 2022 13:50:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:45 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/6] staging: r8188eu: remove HW_VAR_BASIC_RATE from GetHwReg8188EU()
Date:   Fri,  7 Jan 2022 22:50:28 +0100
Message-Id: <20220107215033.12257-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215033.12257-1-straube.linux@gmail.com>
References: <20220107215033.12257-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GetHwReg8188EU() is never called with HW_VAR_BASIC_RATE. Remove that
case from the function.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 96db9a8e7667..b996580b30ba 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1592,9 +1592,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 
 	switch (variable) {
-	case HW_VAR_BASIC_RATE:
-		*((u16 *)(val)) = haldata->BasicRateSet;
-		fallthrough;
 	case HW_VAR_TXPAUSE:
 		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
 		break;
-- 
2.34.1


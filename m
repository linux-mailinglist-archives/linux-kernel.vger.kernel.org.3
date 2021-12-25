Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403C747F2D9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhLYKGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhLYKGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:06:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4CC061757
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:06:53 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r5so9426918pgi.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUimozoxjLlUVh1Qi+7L8g3Ewbj5TnU71txJNWxTO4Y=;
        b=Sq2jlEB8IRczVrBgF6mBAJ5lXVF/Jjd451dpeaq6OSgxyj9dJNWw1qVCoMfVr/Z7Yp
         587Ec78pnZMzsRaSJE7WrlFtk6jCHHwOpnt+NGsQpM5kFWDUnXDH2ZlXJZOLOo7lc196
         RdM5BqILpweahRNL0OFO2e5jmIu1FBScP9oz0nWQMpMDfORARBB711o5RlcREqzFczJD
         lfZAKCK4qOcDv4b9mMcN6ag2HFZAXUXH2HeGbWiJxWL15fWXgti8y6snRViEr8jTTYeK
         IK1DkpdDGKuic1wyKwIrt8k25JjMd5DRMHdy90ysWF5qMBLV52UkBXalf+gF6RF/G9Nk
         O7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HUimozoxjLlUVh1Qi+7L8g3Ewbj5TnU71txJNWxTO4Y=;
        b=Kr/TiE4MX5ypqYqSMblaQBh/2mBSRDf8hF1plIQXJoPeIoXx2tWHkw3WkkfYYxw5CV
         GBGJmyrzCiW/GzU0bkPZHeRzdV5dinjZXf1mb2FZDTr+++IWUas9ys7QT1hZTTBFK6ib
         ICuXi9z5elkoth32nt7HhW2CFeC0twMSptc4SpYr+JMfCbsooVRIkyxuW/3NKITDh8lz
         TjQGFfXEigj6FiBwcu0+1fInFaX/0Gjoz8LD75xoq49o13GGvjKOD234N8kWM8vwabe8
         znjPFaO9aNkknZFannW0HWMqE0dDmaOLo7/6Rewzy7nEvgDzhVDpMHSXQ87BNF9xaYzN
         4ULQ==
X-Gm-Message-State: AOAM530BM2Tl91xatl/ujDwKNwfJjpzYJVqNAXEyAwzRAc93oKZZhgu1
        tHh9/BLmfWc9fOuP5HYyOOA=
X-Google-Smtp-Source: ABdhPJwAvY5JWXTyFKJcxmY2a70V2qqbGlRZIfUO3b6sSt5MMg4Fs14WOgxU/vyvPDQ99LQKRheszQ==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2e01 with SMTP id f17-20020a056a00239100b004a2cb642e01mr9956583pfc.45.1640426813013;
        Sat, 25 Dec 2021 02:06:53 -0800 (PST)
Received: from localhost.localdomain (1-34-229-86.hinet-ip.hinet.net. [1.34.229.86])
        by smtp.gmail.com with ESMTPSA id i68sm1246109pfc.151.2021.12.25.02.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 02:06:52 -0800 (PST)
From:   s921975628@gmail.com
To:     richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        RinHizakura <s921975628@gmail.com>
Subject: [PATCH 2/3] mtd: rawnand: nandsim: Merge repeat codes in ns_switch_state
Date:   Sat, 25 Dec 2021 18:06:48 +0800
Message-Id: <20211225100648.119011-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RinHizakura <s921975628@gmail.com>

The moving block of codes is shared between both 'if' and 'else' condition,
we can move it out to reduce the duplication.

Signed-off-by: RinHizakura <s921975628@gmail.com>
---
 drivers/mtd/nand/raw/nandsim.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 3698fb430..2ef6bddf0 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -1731,14 +1731,6 @@ static void ns_switch_state(struct nandsim *ns)
 			"state: %s, nxstate: %s\n",
 		       ns_get_state_name(ns->state),
 		       ns_get_state_name(ns->nxstate));
-
-		/* See, whether we need to do some action */
-		if ((ns->state & ACTION_MASK) &&
-		    ns_do_state_action(ns, ns->state) < 0) {
-			ns_switch_to_ready_state(ns, NS_STATUS_FAILED(ns));
-			return;
-		}
-
 	} else {
 		/*
 		 * We don't yet know which operation we perform.
@@ -1755,12 +1747,13 @@ static void ns_switch_state(struct nandsim *ns)
 
 		if (ns_find_operation(ns, 0))
 			return;
+	}
 
-		if ((ns->state & ACTION_MASK) &&
-		    ns_do_state_action(ns, ns->state) < 0) {
-			ns_switch_to_ready_state(ns, NS_STATUS_FAILED(ns));
-			return;
-		}
+	/* See, whether we need to do some action */
+	if ((ns->state & ACTION_MASK) &&
+	    ns_do_state_action(ns, ns->state) < 0) {
+		ns_switch_to_ready_state(ns, NS_STATUS_FAILED(ns));
+		return;
 	}
 
 	/* For 16x devices column means the page offset in words */
-- 
2.25.1


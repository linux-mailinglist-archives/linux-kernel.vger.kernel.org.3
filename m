Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9114FC626
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349994AbiDKUwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349983AbiDKUwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:52:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B801A070
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w18so19940929edi.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Vx0z+MVKUBmBfjBdTjqM5v4jlT6V2YkgBEKK8N1PQs=;
        b=Ud3vN7jzkPF7arNd+zJeB7XzWv5Yh+fWuatSJTAPvJrJ1kZcfPH/OJdHjm0vr6Yki7
         RmYeXa0Br3cseLRlP5SRMyVpm4TIA5gJRYAfTc8IYU6g4DeNoLz5negaozcsYTcGlOBd
         2zsNteewWjUSbc9mkd28dzvkJ0KWId+4DVEp8MuxHCbA+beHS+f2h28vBwAMi85YoZTu
         BPLVvUHJtzl9MzHkk/Z5DbbEyWHWnCDBSVY/kEITQL334/0JrVIJWPgWVjegGiYZlmNv
         v47p24W7ihh6IsINhzdatrJcD0uQpgoCDw2csABE2muHxTgUDdzYZhBuc3yqhcaNzP98
         Yycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Vx0z+MVKUBmBfjBdTjqM5v4jlT6V2YkgBEKK8N1PQs=;
        b=y9THlk8CKFDlWnxP98KryaXktouGNP2ysoGDdEWLYQRymVIXG3LJs47rpwdeCErOf/
         wrbqarWOsFTHnaHo/N3S+LOLlUCRnYnA9e1tTlcXZJ50OPjfjlxfazGMyG6Nisei4Pbl
         vTvJWnWSG5KOGfC5qxiQKNJSIFlKjKUpE01SBTT6591U8WQzNrrE7sFYBTAKYlqb1u4b
         1dX8JY9undQYpwHfnIIBGuvL4LGK/KAMIL0RCfU481ja6j6bDMoyi71iUl0uZTvif6gQ
         BtzmCPbb1+J1KwLHhLsGVQN1zEJesPkiUyqiNV/FAhc+uzc5ofakVAPfCp97Lb8h2BPA
         vmWw==
X-Gm-Message-State: AOAM531Z51l1E5KvaXiJMM22JUTgCAzcuBJVHWOOhSnOzgbnxDEIzGcS
        oHTft3ua2pTviVmmWO/pcc7mTAstkLc=
X-Google-Smtp-Source: ABdhPJx96w0uzfV3MkFvivgu9/OcTTrpwo34F7tlVg0VK62oKu8X2q29ZoOLvvTVC0kuBcaIE9ujog==
X-Received: by 2002:a05:6402:40c4:b0:419:135b:83ac with SMTP id z4-20020a05640240c400b00419135b83acmr35494668edb.321.1649710196805;
        Mon, 11 Apr 2022 13:49:56 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id j22-20020a50ed16000000b00419366b2146sm16064061eds.43.2022.04.11.13.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:56 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] staging: vt6655: Remove macro PCAvDelayByIO
Message-ID: <e8267e7566d389f318a72d911083e52b02e37210.1649706687.git.philipp.g.hortmann@gmail.com>
References: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove do-while(0) and CamelCase macro PCAvDelayByIO as
it is not accepted by checkpatch.pl
As the macro is just used once with a constant <= 50 the
functionality of the macro is implemented by using
udelay() directly.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Changed converting macro to function to delete macro
          This patch was 7/7 and is now 6/6
V2 -> V3: No changes
          This patch was 6/6 and is now 7/7
---
 drivers/staging/vt6655/srom.c |  2 +-
 drivers/staging/vt6655/upc.h  | 13 -------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 7feaa5138de0..e3ee76f09e0c 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -80,7 +80,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 			byWait = ioread8(iobase + MAC_REG_I2MCSR);
 			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
 				break;
-			PCAvDelayByIO(CB_DELAY_LOOP_WAIT);
+			udelay(CB_DELAY_LOOP_WAIT);
 		}
 		if ((wDelay < W_MAX_TIMEOUT) &&
 		    (!(byWait & I2MCSR_NACK))) {
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 904a299cccb5..c7966a638fde 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,19 +20,6 @@
 
 /* For memory mapped IO */
 
-#define PCAvDelayByIO(uDelayUnit)				\
-do {								\
-	unsigned char __maybe_unused byData;			\
-	unsigned long ii;					\
-								\
-	if (uDelayUnit <= 50) {					\
-		udelay(uDelayUnit);				\
-	} else {						\
-		for (ii = 0; ii < (uDelayUnit); ii++)		\
-			byData = inb(0x61);			\
-	}							\
-} while (0)
-
 /*---------------------  Export Classes  ----------------------------*/
 
 /*---------------------  Export Variables  --------------------------*/
-- 
2.25.1


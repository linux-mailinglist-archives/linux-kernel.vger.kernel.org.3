Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2AA468174
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383877AbhLDAok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354180AbhLDAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:44:38 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F1C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:41:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x15so18342819edv.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3I4C4YUq1izmLBQSvsN84pqvyOl0SwNapJXdQ6Zcfg=;
        b=fk8fUfFKTqb8eEsJ2g0dy6rGLiOjZ0SzK7lQscTqB6z6PXqbzp4n4iApEzXwm/4Txx
         icQY/8vhH9AT1fXdSlCYacgg33ep+fAW8/HAXXubbST9QOqh7vwQgzN5fvWgvslwgq1l
         N8dCRvbc4+cdEbC2chZhzZWfjfg1JhdeLujaLwD1MAg382cn2/RcL3mahGC15tKnqtZm
         71AP4Tmh3jSDD7ZNbXgdQiKFaKs4IlOpa64lXEgQccgQe/tAtAkAyomyyT5y0nfQOAVX
         +zdF7lkGrtAJezLGlrwUgakAIppdbtSfNNS4BydjGmk81ULuhBWtm3pgjvKoHtXzWKbz
         rDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3I4C4YUq1izmLBQSvsN84pqvyOl0SwNapJXdQ6Zcfg=;
        b=kdtfcjwo44lfb7udhItg/tjGqit5VG/V31n8W7V1/XTcyYphkxy7PqvzfsFTXBRJ1j
         IJ5pIJBe9z6wtfaY8Svb9Jradc9v9rlMiBhpcW0ooRaPrOK/JV2mjiaQ0+T8JHSmxtOf
         6dDaHyxk3IGTIuW2uuaNPMGGnZzRNFS2CoMb0BHDGsIOibPyXp1/nh82JQxllxjvjaeh
         QGz6ZghzesdkoIHVsGHqJwmdhPs4Ho0XdJ29qWP47/sIkNVBiQyVU75RIyYBX48Pt5cL
         Ik0pGP8OfmWXO3BLpfK9HX5VAlK2XwnnyLj4Oedpcj/xkBlcu6t183sO2AbI+PGOdFPr
         ppLg==
X-Gm-Message-State: AOAM530dHeqmfR2MWjRB1Yc9OqyQ0hHmNJy1fwoqxyqC2+8nWwMXSXQ0
        XljZYCTEccavhlwROuiRW6E=
X-Google-Smtp-Source: ABdhPJxrNqqWyIhGv7QNSuF4/CNZkxU7lf1uC8vo9Me6EcByVcUvRbXmXr9f7M5Z5QEkXUXuKgGj4g==
X-Received: by 2002:a05:6402:2686:: with SMTP id w6mr30860901edd.141.1638578472191;
        Fri, 03 Dec 2021 16:41:12 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id oz31sm2731858ejc.35.2021.12.03.16.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:41:11 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: refactor byMinChannel to min_channel
Date:   Sat,  4 Dec 2021 01:40:38 +0100
Message-Id: <20211204004041.3825744-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase hungarian notated variable "byMinChannel"
into linux kernel coding style equivalent variable "min_channel".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 6ea4165e4929..109d20a010ab 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -200,7 +200,7 @@ struct vnt_private {
 	unsigned char byTopOFDMBasicRate;
 	unsigned char byTopCCKBasicRate;
 
-	unsigned char byMinChannel;
+	unsigned char min_channel;
 	unsigned char max_channel;
 
 	unsigned char preamble_type;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 313f0241d989..4d92b5df5312 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -228,7 +228,7 @@ static void device_init_registers(struct vnt_private *priv)
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	/* Get Channel range */
-	priv->byMinChannel = 1;
+	priv->min_channel = 1;
 	priv->max_channel = CB_MAX_CHANNEL;
 
 	/* Get Antena */
-- 
2.25.1


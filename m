Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E877F481BBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238997AbhL3Lci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhL3Lch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:32:37 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E265C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:32:37 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j17so21436512qtx.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbtCBNF6sxyvZFWUemZV++F4nWdCRsnh+BO2TPv43oo=;
        b=hUJxB2QDslx3YNl5pocgvID8fPQB1GANa4RM6OjJHB61N+RLR/lcBOf0rIhO91SGyI
         lYRmPggUcwoQkHJtCL+Uj0XFWe/NdQEZY2lM9Fm8va3qrYKutAxGa+bvrUZbAiggrTm5
         CALNPlBfkis2yF869vjq6Q2bDz9X6+dYqx2ZtTzcy9jwDB2K6S3aZ0tGzpqA2kBtRVLT
         mUZSdtVtv4ilMC9uGg3qE+n3rFlTsaTWkVdWTZswbC5tebqasKFQ0N+x+3lJ6Uyqci52
         qVDR3ldhF4heiHeDKBOpqy6C07aYvIkciVnqSF/506SL6HJVKlfza6KfqdO7v8b0LT5A
         ey4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbtCBNF6sxyvZFWUemZV++F4nWdCRsnh+BO2TPv43oo=;
        b=iydYgTR8iASjqpX7T3RDcLY9gzMPTHXLF43MyJmenaJBpGB0joccy0LGNzAMFDWqgl
         aulfDNcOwcznFx8jibO4BX7MMR9SbLczkr4f4knAgkbj1eciKkQTgYPu1YocJIPrvBGY
         NBHKvosh2GPd3j3hMhjs5s6NgpHbELIFvFB3elOeUyMWCsno/pftOdV9hllrFdOCxI1C
         dMn+osSt32NgML8O2R3e9ESilyZsYUHEgma+njO6veW1GpCDmusE9JuWItabvk7u3Lld
         sW3KbpyRuq/hZX97EEKazZaCAV0iciPxX9AIDdN/nj0QE4yhKIqEnXE8a0Eos/QWuUE5
         X/QQ==
X-Gm-Message-State: AOAM531IhPQ/+o71hluaENxD8gS3Q3gDnSJGUYY6IPFZA+XEsXZCY2lO
        02PNiPaLTcjfdvJ3MwcJ05Q=
X-Google-Smtp-Source: ABdhPJyKW4CawNE3aJaa06FIHWRv2QQ6s4gqoNbfviXivu684EH0slEHhlaQ5RHmGrEkya481hb8mA==
X-Received: by 2002:a05:622a:1c6:: with SMTP id t6mr26056580qtw.211.1640863956489;
        Thu, 30 Dec 2021 03:32:36 -0800 (PST)
Received: from localhost.localdomain ([181.23.70.139])
        by smtp.gmail.com with ESMTPSA id v5sm20348559qkp.126.2021.12.30.03.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 03:32:36 -0800 (PST)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        juerg.haefliger@canonical.com, rdunlap@infradead.org,
        dave.stevenson@raspberrypi.com, stefan.wahren@i2se.com,
        unixbhaskar@gmail.com, mitaliborkar810@gmail.com,
        phil@raspberrypi.com, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        gascoar@gmail.com
Subject: [PATCH v2 1/3] staging: vc04_services: bcm2835-audio: avoid the use of typedef for function pointers
Date:   Thu, 30 Dec 2021 08:31:25 -0300
Message-Id: <b53a77682994bbc3ccb9b89d617dec23d0785059.1640776340.git.gascoar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1640776340.git.gascoar@gmail.com>
References: <cover.1640776340.git.gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace typedefs bcm2835_audio_newpcm_func and bcm2835_audio_newctl_func
with equivalent declarations to better align with the linux kernel
coding style.

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835.c    | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index c250fbef2fa3..628732d7bf6a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -52,20 +52,14 @@ static int bcm2835_devm_add_vchi_ctx(struct device *dev)
 	return 0;
 }
 
-typedef int (*bcm2835_audio_newpcm_func)(struct bcm2835_chip *chip,
-					 const char *name,
-					 enum snd_bcm2835_route route,
-					 u32 numchannels);
-
-typedef int (*bcm2835_audio_newctl_func)(struct bcm2835_chip *chip);
-
 struct bcm2835_audio_driver {
 	struct device_driver driver;
 	const char *shortname;
 	const char *longname;
 	int minchannels;
-	bcm2835_audio_newpcm_func newpcm;
-	bcm2835_audio_newctl_func newctl;
+	int (*newpcm)(struct bcm2835_chip *chip, const char *name,
+		      enum snd_bcm2835_route route, u32 numchannels);
+	int (*newctl)(struct bcm2835_chip *chip);
 	enum snd_bcm2835_route route;
 };
 
-- 
2.34.1


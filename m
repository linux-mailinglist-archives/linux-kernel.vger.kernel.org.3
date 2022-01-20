Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F5495500
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243633AbiATTiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbiATThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:37:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4404C061574;
        Thu, 20 Jan 2022 11:37:45 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bu18so25649314lfb.5;
        Thu, 20 Jan 2022 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTPMtlLZkmlqbrE2C81Yiq0PZs32RCDh/dQp7wKkOOI=;
        b=MISO9+D8caTj+dW+Lj4qmfdrysr/cNlHmQDwz/ExZL1RH56hXwVcV0ERs4IzfVsncQ
         vT3ZtaUOAJnX1CjhmxdRc8xr8VAXskAOdTiT+wHvdmzXL0BBprMoTgaV95Plc6WHbHPA
         RcGYY/0Apwi6eK0nXFNmasqUG2tSht544vXmQTGk/fugZgp1dFHRKFZIKn+BZ5slmjni
         ZPk1VceJs/zu3kC1AqtOkqVaIPa9A6KXXsQbC3UPJaDMdocpp+7Skj/hSexdvKbf9RCG
         6Vl4ruwR5rzgGiriy19a0Zoc5dz7ULQt47L/iqlMreSKrUeUH/vR7E65UURPjZMfw2Q+
         eMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTPMtlLZkmlqbrE2C81Yiq0PZs32RCDh/dQp7wKkOOI=;
        b=Bj/151wCcvdoVuS6xLaypoGyEh9ya1Kr1WvZXDIzOvCl4+lSxZgcA8xZHlgAgunp6a
         7YJlDHjC4Be7AYUV9OIy4tKAL63OFiGBcCziRq/onIzR12AmZcSgXEALkgu02sNLO+5/
         PIwnPhuJmTzkhJhYhcsNGy3I6r3JjAkwn9JfptFZUFDhUOuA2sUGHON1eJZvOFc7dLMM
         Ek9wNYgr6CCVyLH2LJnZndQuskkQRGDLSFxk6cDrpBV7w//hyYlBxZBPvtbaR8OXK0AV
         wl+ZZJ+SQxlfmmqgYh3QV78oIHuITQYWd1Q+8eCzPrrFviwQTZaoJ4T/tdMVMzOxsaQm
         iWRA==
X-Gm-Message-State: AOAM5300Ka7bvDL2rm0CcHFmPMutWjvuARmakPbx6ylOYfa519SMkF/L
        zcjwdUkWmx/xkb5Bp1qxEfY=
X-Google-Smtp-Source: ABdhPJxAwP3J3wM98DGNM2dVm9aNWnXPG0RKRHyhl12rKPefeM3zt05y/JumiRgGxcH1yddX09yvNg==
X-Received: by 2002:a05:6512:3b8d:: with SMTP id g13mr576408lfv.46.1642707464011;
        Thu, 20 Jan 2022 11:37:44 -0800 (PST)
Received: from localhost.localdomain ([94.103.227.208])
        by smtp.gmail.com with ESMTPSA id q12sm14223lfr.55.2022.01.20.11.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 11:37:43 -0800 (PST)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        =?UTF-8?q?Maximilian=20B=C3=B6hm?= <maximilian.boehm@elbmurf.de>
Subject: [PATCH] Revert "media: em28xx: add missing em28xx_close_extension"
Date:   Thu, 20 Jan 2022 22:37:30 +0300
Message-Id: <20220120193730.28155-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a0ba3685-8c59-cb89-7f81-280c38a92c40@elbmurf.de>
References: <a0ba3685-8c59-cb89-7f81-280c38a92c40@elbmurf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2c98b8a3458df03abdc6945bbef67ef91d181938.

Reverted patch causes problems with Hauppauge WinTV dualHD as Maximilian
reported [1]. Since quick solution didn't come up let's just revert it
to make this device work with upstream kernels.

Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Link: https://lore.kernel.org/all/6a72a37b-e972-187d-0322-16336e12bdc5@elbmurf.de/ [1]
Reported-by: Maximilian Böhm <maximilian.boehm@elbmurf.de>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index b451ce3cb169..4a46ef50baf9 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -4150,11 +4150,8 @@ static void em28xx_usb_disconnect(struct usb_interface *intf)
 
 	em28xx_close_extension(dev);
 
-	if (dev->dev_next) {
-		em28xx_close_extension(dev->dev_next);
+	if (dev->dev_next)
 		em28xx_release_resources(dev->dev_next);
-	}
-
 	em28xx_release_resources(dev);
 
 	if (dev->dev_next) {
-- 
2.34.1


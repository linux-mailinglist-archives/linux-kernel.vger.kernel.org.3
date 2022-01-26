Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCAA49D153
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbiAZSAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiAZSA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:00:26 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCD4C06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:00:26 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id w8so285272qkw.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6zyq73HTm/un92FVOEIYcp2e6RteV0rl4PLFbEb9o0=;
        b=tQo2k8USwbTdGCsoVG//gGe1bPsuO/IzWTC9AaTjewsFEQZEu7g2nTvTTOrPluUgbL
         t3/aIV9MRQOKUmr+5b7O0fjSQnxMgD+cAgJcyM2lsPNXvbFFM7zoIhekRLKTLLRa5uID
         2j2jDLbcdZztINc2hBQ++zf86g9BVMeq0MAq7eLWxJpy1CtERZf8wqeyUXRwb6rc9oh2
         qwGNnYlKiWl6b3c212EUbI7SfR/9oLquohl9hxTjhuigiKshy8R+WkQHVgvFq6GNjPzL
         XyghCWYvgkyIIcnMn27pkj4CMuir8TmPmfCvQIfgoWKo2fsxnzgH3nQkl0yGZJVF/xQr
         GINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6zyq73HTm/un92FVOEIYcp2e6RteV0rl4PLFbEb9o0=;
        b=kUdpv7pwMCE62w+1iTyvsx+MJEk6gvjl64wNB2cSO25LSJqMRHPy+2pzSsNowF76lQ
         9rdtndvbfbwTQfIi1FZmleJBbs/bUEPpXKYjXayPusIeVMIY14DGuiu0CkzhJRv5kX1b
         pw2Zc6USNQzqAHGxdq733bhEcqRCps4j/l3cAUxYdUQN17vLdYuBNZmjOua2KqzjP5+C
         XBQaTMiQ0tJAgiom+MDDfYcpVh07SRO5oP/9VBnT/dgJZivtvqR45t1LjglHWDgyVI4L
         pY425xP/q9fMKR5Y+Qq+/6rvKfuh2wC/oJabm3q1UWKnVeUp4lfdZeax7lmXPboc9RNB
         tadg==
X-Gm-Message-State: AOAM530OUOrZhjBsdKHSAEKgCDsGxit1e4QpASDuYhx+tXeu8nXbiWx8
        mJyue7YGJxG/ybwnGBCgLgDyaNFP1Z+7du3F
X-Google-Smtp-Source: ABdhPJxG3HeL+WTrcpWGmmD9RScesoW/uisEMYZMCzimcJQ7L6uu9AhNnuBVKK6hyvSAkhmPUWokCA==
X-Received: by 2002:a05:620a:438f:: with SMTP id a15mr19314502qkp.566.1643220023537;
        Wed, 26 Jan 2022 10:00:23 -0800 (PST)
Received: from rigel.delfino.n.howett.net ([2600:1700:df50:a7cf::725])
        by smtp.googlemail.com with ESMTPSA id 2sm5702342qtf.9.2022.01.26.10.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 10:00:23 -0800 (PST)
From:   "Dustin L. Howett" <dustin@howett.net>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>,
        "Dustin L. Howett" <dustin@howett.net>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_lpcs: detect the Framework Laptop
Date:   Wed, 26 Jan 2022 12:00:19 -0600
Message-Id: <20220126180020.15873-2-dustin@howett.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126180020.15873-1-dustin@howett.net>
References: <20220126180020.15873-1-dustin@howett.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Framework Laptop identifies itself in DMI with manufacturer
"Framework" and product "Laptop".

Signed-off-by: Dustin L. Howett <dustin@howett.net>
---
 drivers/platform/chrome/cros_ec_lpc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f..458eb59db2ff 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -500,6 +500,14 @@ static const struct dmi_system_id cros_ec_lpc_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Glimmer"),
 		},
 	},
+	/* A small number of non-Chromebook/box machines also use the ChromeOS EC */
+	{
+		/* the Framework Laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Framework"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop"),
+		},
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
-- 
2.34.1


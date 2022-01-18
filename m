Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C54492CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244547AbiARRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:55:06 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36360 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiARRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:55:04 -0500
Received: by mail-oi1-f169.google.com with SMTP id r138so71417oie.3;
        Tue, 18 Jan 2022 09:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WrlSvVtBlJ0UjcFimAddRKRckytk7qO5txu8q+tq17c=;
        b=NmpQkgW5HNXUfmq2AmLLMQ7zZwgEl0h4Jg1zEX8DaGQtjM320GZWWtLanrrTQtrl7H
         TsuXc5ajs2RFWQxFFM8NPlwKGEj3MLjPYh0R7xGMSNfHQCIrF1OYeGPoLDpRtAtwhVwi
         sxjaHABY6+inIpCzY27F5B7bf8m6UD4gauTbdNkCkY8GOJuEWEtO0mlZqlfzaZxcYCq4
         Lnu2xHY/hMMdOssGjuvh+u8TpYeM0DUbkHk8s6hQwoOhEPtcb4gfHJQwp5UHbrUkX6o5
         yI7YiPJtmsTmOQpGFFYg+Md3GFckf8kDZrj+Ldq5R2bGDqDCr2qhREtQ/sAblupINyse
         hx7g==
X-Gm-Message-State: AOAM532fsxIn7pL/4JzxlYTPTWVpgEbB2RxYgUTmyfIPvqhPBm4VJXqj
        ZglJm69aGP3qCqAcT5E7XA==
X-Google-Smtp-Source: ABdhPJw2nYy0X1fNyouL2DU2lX9WpvyUl95MKD/LaCjv61D5x0XYcQo1cI0oVz4ZIkGiExpEBNoYYQ==
X-Received: by 2002:aca:f241:: with SMTP id q62mr9238160oih.64.1642528503551;
        Tue, 18 Jan 2022 09:55:03 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id u12sm5162627oiw.54.2022.01.18.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:55:02 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] of: Check 'of_node_reused' flag on of_match_device()
Date:   Tue, 18 Jan 2022 11:34:04 -0600
Message-Id: <20220118173404.1891800-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child
device") caused the child device to match on the parent driver
instead of the child's driver since the child's DT node pointer matched.
The worst case result is a loop of the parent driver probing another
instance and creating yet another child device eventually exhausting the
stack. If the child driver happens to match first, then everything works
fine.

A device sharing the DT node should never do DT based driver matching,
so let's simply check of_node_reused in of_match_device() to prevent
that.

Fixes: 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
Link: https://lore.kernel.org/all/20220114105620.GK18506@ediswmail.ad.cirrus.com/
Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Chen <peter.chen@nxp.com>
Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index b0800c260f64..874f031442dc 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -28,7 +28,7 @@
 const struct of_device_id *of_match_device(const struct of_device_id *matches,
 					   const struct device *dev)
 {
-	if ((!matches) || (!dev->of_node))
+	if (!matches || !dev->of_node || dev->of_node_reused)
 		return NULL;
 	return of_match_node(matches, dev->of_node);
 }
-- 
2.32.0


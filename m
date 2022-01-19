Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF7C494208
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357484AbiASUoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357376AbiASUoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:44:01 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0361C061748
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:43:58 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3790174pjp.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZcWEQ5Fu8Kd27+r2AXq/zEkJpO9p583fKhA3n76vVg=;
        b=YaFtuZ1conMa1mNYI9ZivYW9O1tEGT9e1ngcXnBJp7kHWF4cQwfCCY/7oTy/jVTRvN
         aiTXae8jY+NQLm1z8iDPdiDMUbl08E/vjWPFdyKAuEJ1RhoYsA4JVGqD0fL22uKhpxpP
         DmnrI41IUKA9HbklmMI8WvDdm6GWbTFsLYTT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZcWEQ5Fu8Kd27+r2AXq/zEkJpO9p583fKhA3n76vVg=;
        b=D+OaR4P3ohLqkI1gkDywNjSGLWHvh/Pl2Yk11wjc5Hx7SAl9XliTfFEhK9XRfZfoOW
         G5GsrT8NqlVQyjmGo2Tmtze+ZniYSLaz3Szu42Ex9OnPlx9+bgXzXqhegvVLwQVMTQ3M
         EBXCaeKCexRXxygzlYa0qi/KoVlyirztyQB8eszGGFw7YVeo6LXV1a189gORdeVKdN5M
         HyQEwIxVCSG7yovuyVqJCMd0YK3tZBDCrZPOyia8kGw3uaJPvi5i0Py7IAQi1UL1Tui1
         QSqhTKS3Q8VGqvEssYcZoVGiKZSpynn1MR6nQ6RKqgeDqlAv4ibeCA4n+k5wRkj6eaRB
         bDNQ==
X-Gm-Message-State: AOAM532OGEXbapRAHUZgKAhUpeFCKfTF+9Mys+L83Dt7SiC7sLcUtQvd
        RivQdzCO4RfN9lKJy0OZmeaJsQ==
X-Google-Smtp-Source: ABdhPJxkDgNJUGBnGZ+MUZ9wgs+k0KumhW1WeZfmNWXC1BwxYPIokX2Bcm3q24M85Iq7J2dKVeNJOA==
X-Received: by 2002:a17:902:b218:b0:149:936b:8306 with SMTP id t24-20020a170902b21800b00149936b8306mr35229092plr.134.1642625038318;
        Wed, 19 Jan 2022 12:43:58 -0800 (PST)
Received: from localhost ([2620:15c:202:201:618e:efc:c014:d89c])
        by smtp.gmail.com with UTF8SMTPSA id a16sm520480pfv.97.2022.01.19.12.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 12:43:58 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Chen <peter.chen@kernel.org>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v20 2/5] driver core: Export device_is_bound()
Date:   Wed, 19 Jan 2022 12:43:42 -0800
Message-Id: <20220119124327.v20.2.Ie1de382686d61909e17fa8def2b83899256e8f5d@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220119204345.3769662-1-mka@chromium.org>
References: <20220119204345.3769662-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export device_is_bound() to enable its use by drivers that are
built as modules.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v20:
- added 'Reviewed-by' tags from Doug and Stephen

Changes in v19:
- none

Changes in v18:
- patch added to the series

 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..07eefddd4a77 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -370,6 +370,7 @@ bool device_is_bound(struct device *dev)
 {
 	return dev->p && klist_node_attached(&dev->p->knode_driver);
 }
+EXPORT_SYMBOL_GPL(device_is_bound);
 
 static void driver_bound(struct device *dev)
 {
-- 
2.34.1.703.g22d0c6ccf7-goog


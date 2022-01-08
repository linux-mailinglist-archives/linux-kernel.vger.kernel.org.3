Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D69488612
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbiAHUxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiAHUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:37 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D84C061401;
        Sat,  8 Jan 2022 12:53:37 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b85so10075480qkc.1;
        Sat, 08 Jan 2022 12:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oWhmcFtfhgbZtaLu7vpHXMJXolJo6+/DDSY5r7bw7Nk=;
        b=PYN/kYpVDfPjGHCGQ/wRuOSzTMT064pJ+qQXj6CfvQYK3eq/ptLuNcoKrUqcauF+d6
         UPeafesL4GV+puJVcb3Vp8FBwXrrUeJo/VaVz8jkfs1X6ORDtPndgn1doitbxdXU5URE
         jsahDfGDFGpVBlCvzUnylHoC7Yb7hziWfeRssTgZ3l6lG59c1SZC5uKINuzEOFaSIFOQ
         GVa8gaXCiowMaOBFt8ilb+pl8Xkqn6BBMaRS/EG3f6HQekeXyaMBZ0Ig/ZHKnCC85cNp
         53tv32WTd2O+RS6Zoq25z9K1r1ctEO1ANQlpQyIYmwc3vdVkz+4LclOoTaLHCqnzw/Pf
         aHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oWhmcFtfhgbZtaLu7vpHXMJXolJo6+/DDSY5r7bw7Nk=;
        b=cPbFXsaidSVj1PfL0hwHvEefpoS8pK2eUgyl3tILVxpTuYlHSDMFk7n5GIgrC03gTl
         aq+K/wKBS0bK52XfQKClSitSlK/YsSd7eo2NEuy6+UQlUWnlZa/h12jL2dneIWR8Ayb4
         F/E9+5ru0jpULFn/zh/4hPYAN/e07uQbKnyyLWO6rA0dtcGQF2DdYnHKMPr1rftLr8r1
         /2xcWkecnw443hKNItpg762wy1xf8UWnJ5phIAsSH2vwZuaY/7J4JQVMNJ4rAq2DCYLL
         vYcQKIHrtdiWX7ucQ78vZy6jlGWs4TIJVnBATAvnC+jN+Oj40UvFYs3I0BAdHvL5Guc/
         rX1Q==
X-Gm-Message-State: AOAM532A2U8yPVALUfm/ObRuZi8mcmNEGVNHWFFNuzPRzwp1kPSjpPrP
        oJO797boufyuu5tOPHsWlOPMLodBGQ8=
X-Google-Smtp-Source: ABdhPJzAbYsYPC9bUz04flrV8AD9l40D+kQkDB9GuzJsXR67yjaNttNtD0EB1hrBbHi/LrSESYACyg==
X-Received: by 2002:a37:654:: with SMTP id 81mr10725406qkg.499.1641675216578;
        Sat, 08 Jan 2022 12:53:36 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:36 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 05/16] iio: afe: rescale: reorder includes
Date:   Sat,  8 Jan 2022 15:53:08 -0500
Message-Id: <20220108205319.2046348-6-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Includes should be ordered alphabetically which is already the case,
but follow what is done in other drivers by separation IIO specific
headers with a blank line.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 drivers/iio/afe/iio-rescale.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 271d73e420c4..69710c481376 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -9,14 +9,15 @@
 
 #include <linux/err.h>
 #include <linux/gcd.h>
-#include <linux/iio/consumer.h>
-#include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+
 struct rescale;
 
 struct rescale_cfg {
-- 
2.34.0


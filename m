Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB44628D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhK3AJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhK3AJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:09:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077D6C061574;
        Mon, 29 Nov 2021 16:06:15 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id iq11so13951359pjb.3;
        Mon, 29 Nov 2021 16:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPU8E18/rfNO+NGRed1cne32L6+cx+NUy8rxuVdLCdI=;
        b=APAUZ+P6V7/0qC11v7y+ToCCkwQKZyISJAue7T7o7k7kYnncHcnlkAglBSsyTZ/dlh
         B8IQgmKyyOTn2D0f3kt4sqEfgIx3X/bEMn0ArFYOnoNrW7RW6RhrqaSv5MeI/nzv6TlD
         mafbfO3G2WOfdM0g6vDMFpi12GoL3lH8ICJ1bwPrpZChc9p+IP8WQfDGePbXbFaDkqBD
         bh2LV0zPRK0X4XWryW0Y7+eLxsyaGpRDXvZE0vZBBdBXDcHpGXM2zz9B6t4RwoUMx94t
         iDxjYluOCpabjDBkcS69PX107K+BOrb9NZ5YU0vHZf25vWHFO83B2I85jrSRVglOH5M3
         5Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NPU8E18/rfNO+NGRed1cne32L6+cx+NUy8rxuVdLCdI=;
        b=gKdwLrAPNWObvQXQg33DYts9RdenfNLQkHmNk9EwvFtGr0cMtczn/eRBLflJTTLxi9
         JOKZham3HK1oeOAbhl3/5niOkHIDY8y5V9QSe73jsonsm+kHsFe/h3bTV4qdQ9IvRBFX
         2EuLxQjyQHlDcaYGrB6pTPD/JM18+r9PkIgI0DhsthiTblCogCqgC/RFb4ARzMR2uZku
         Pgnr5O1ccZKC9JH0bi55TtMJy7cWFKAeifRvO0NYqNdBZsOXTFdrd3ySOzompUajmE+H
         xvzRQQdElpGLe6mMUNNA0k8MU65KU4s+byIqHj9ZZVoYczyUqChxGEb6L9Asv9WvpJub
         tALQ==
X-Gm-Message-State: AOAM531mQrvOWYv+0bUoKYcWVGZttNokixg342LEFUMf9qWyzts/u7fE
        G0RqWIuzjDtDy1Q0oydCXTw=
X-Google-Smtp-Source: ABdhPJyyKwr7COUgkXlgf5fJU/eSeNrWuXpxppKX2t3WN929YduwwLP7E2MN9rErqvmzvJoQukrZ0Q==
X-Received: by 2002:a17:902:a60b:b0:142:7621:be0b with SMTP id u11-20020a170902a60b00b001427621be0bmr62807805plq.58.1638230774600;
        Mon, 29 Nov 2021 16:06:14 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id f5sm417713pju.15.2021.11.29.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 16:06:14 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     yang.guang5@zte.com.cn
Cc:     davidcomponentone@gmail.com, linux-omap@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] omapfb: replace snprintf with sysfs_emit
Date:   Tue, 30 Nov 2021 08:06:03 +0800
Message-Id: <02f27656a2da68cac42ebee55a78b0316ff3d83d.1638185487.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

coccinelle report:
./drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c:
479:9-17: WARNING: use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 .../video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index 8d8b5ff7d43c..3696eb09b69b 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -476,7 +476,7 @@ static ssize_t show_cabc_available_modes(struct device *dev,
 	int i;
 
 	if (!ddata->has_cabc)
-		return snprintf(buf, PAGE_SIZE, "%s\n", cabc_modes[0]);
+		return sysfs_emit(buf, "%s\n", cabc_modes[0]);
 
 	for (i = 0, len = 0;
 	     len < PAGE_SIZE && i < ARRAY_SIZE(cabc_modes); i++)
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1B74688EF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 03:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhLECja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 21:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhLECj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 21:39:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30A9C061751;
        Sat,  4 Dec 2021 18:36:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v19so4744877plo.7;
        Sat, 04 Dec 2021 18:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXPP2xHC6+EdRLJclO8i5hHNTg/IHiFgOFmOC116mis=;
        b=W7MHcHOgO8Kyhsyy6y3b0f9g8CPiK4d5igYkI/KH8cZiJjd9nthrJCCI/xRWpbhzYK
         a95XG7LnHxoi2jCkdokVBXDOPcUc6q9jsw5Orhssmeh8cKo1je34+2xvZVc1JXfIRA91
         e2dOBsMSmKY5cKk6LSKFWUJpVBZDP3REkW6nbDXamf2MS//HKnLOcqlE5ugTsUc+kjDW
         7gn2Zltu2feKhipWDy5HnVUdLeRIfQYykKtjQUOrJoGzMXWamTPJdaVTrMp6OHessnxw
         W8S2VfoYnJphYeX2Ey9jBGd8XwqE44Z14OEIe3YBRg5SkTk/4Lu48zWRODl75V4HNjH2
         KGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXPP2xHC6+EdRLJclO8i5hHNTg/IHiFgOFmOC116mis=;
        b=aqtpUqFacxQCzFJ6UFMuZqOfYZhz60gBuF8X/XGxDPvC0b7OiB4afsYbd2y9r5lh1l
         OsMUornFQf7EQnnp93DNHaGVtNPLnI6Aib5dIVDXYaumoy5TGMb9nb/VqHvjrhl/4pRo
         HKnLi1/y6YbwhfdtmUK/VmdjR7eFC61G5MNM/4Tz8D2KJbfQCo6APPlfX8tN8j3Y9wfk
         jDwkwRAriH2jIHiboSFplmvhO/rkQ8qBW9NcsDR+tYfTndiAM5BCB9wbAmLvijalw6fy
         slfW7+WzHIX19w4v0hpcNCav0O7RR44pDKh4cvB20XRuVkVp0YYmjedqIYJ6b9SfBkdH
         cHwg==
X-Gm-Message-State: AOAM532nnsc/A7044PgsvufD5fANoAoMlAryQVK1evwIfgXCORNr11Aq
        0xVNx7AfVXhF4eqsDMBh6EcBuZiVWz/fVstJ
X-Google-Smtp-Source: ABdhPJxUZfvhe1514Q/VjaFPxCyuwC/0dyet5Cez3psRHHoFY8Efx5Y7bRWZKnw8npq4W7vm951JIQ==
X-Received: by 2002:a17:902:b712:b0:143:72b7:4096 with SMTP id d18-20020a170902b71200b0014372b74096mr33894174pls.25.1638671761651;
        Sat, 04 Dec 2021 18:36:01 -0800 (PST)
Received: from localhost.localdomain (host-219-71-72-98.dynamic.kbtelecom.net. [219.71.72.98])
        by smtp.gmail.com with ESMTPSA id c2sm7514493pfl.200.2021.12.04.18.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 18:36:01 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, johan@kernel.org,
        gregkh@linuxfoundation.org,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] usb: core: Fix file path that does not exist
Date:   Sun,  5 Dec 2021 10:35:29 +0800
Message-Id: <20211205023529.91165-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both driver.c and generic.c are not under drivers/usb/, should
be drivers/usb/core/ instead.

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/usb/core/driver.c  | 2 +-
 drivers/usb/core/generic.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 072968c40ade..267a134311be 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/usb/driver.c - most of the driver model stuff for usb
+ * drivers/usb/core/driver.c - most of the driver model stuff for usb
  *
  * (C) Copyright 2005 Greg Kroah-Hartman <gregkh@suse.de>
  *
diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
index 26f9fb9f67ca..740342a2812a 100644
--- a/drivers/usb/core/generic.c
+++ b/drivers/usb/core/generic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * drivers/usb/generic.c - generic driver for USB devices (not interfaces)
+ * drivers/usb/core/generic.c - generic driver for USB devices (not interfaces)
  *
  * (C) Copyright 2005 Greg Kroah-Hartman <gregkh@suse.de>
  *
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE7046D605
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhLHOuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhLHOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:50:18 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6EAC061746;
        Wed,  8 Dec 2021 06:46:47 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id k4so2237790pgb.8;
        Wed, 08 Dec 2021 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abO6t0h0ZyTAKao1FORuZLKClUQrGyg7tXcyMOqZ1OA=;
        b=CGWBvzAFHk4gwwCoMS6EvYfqDjTdGfgoAd9DwJtw15ptspglZcqwY+9LOtpzc8EsOt
         hIh2r+01UgDUHyXpjNO+q93STzUHiCURYXEnCpqE37ex/X+kMLwxASVKlxIiseWvtozH
         sVt6dieU0hh3BuIvRfvhAfgHPGxQNs4bRKF06U09KRLy53eExj4DpOz+LZ2LxJDrjeYX
         xWXbvIEfGOijMn1sm+yfKT4MfdC3MMDBDvYK0JZryMgj7N3LzfCXSQs+5zb5paz6MkPc
         PwOF/2iQ9TFf/Go6oNkmiOX99KYC0u8D+ashqLd7EGE8V+1Cc/kfXrBfIv4Ia3W4DQik
         xQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=abO6t0h0ZyTAKao1FORuZLKClUQrGyg7tXcyMOqZ1OA=;
        b=yYS/KaKftoqRhH2Ts1StCahA+DkeTiGZNqbPY2fHjRdA1qK90tGcXN6qi7v0YO5W/m
         fg7Puh3ujdDVUd4QCW+vRTWfWMjM3PHiIeYax8s2UOxGXflqqzleDQu4AcG1mSHfVnNu
         g4tj4vbT8orYfegLiERe1yESF26klYi49c9gTU6nb5JMfs3rRBzQNGFQqvW3f+vJ+CNa
         h+mBgolyGNwqEqyOc6wpTf4ajC8R48C0OVCDH3ir7XzgMiAfTf0w2mxOAv/EsTo78ORK
         +HrMdhmMnJz9MJWeNt/BQjwm54YXlq0PMQRfRFkcb9rsswRZnbogp2yAlWNPBf22ss/d
         t/xQ==
X-Gm-Message-State: AOAM5335/juRZZDV7jxFo7Qm7GBkNbYJktWfZAktNW39rpAz1LTIFnwI
        mu2Dx1p7W5UOe1lZ1q3DkWUdavrFZPv61w==
X-Google-Smtp-Source: ABdhPJzRxlFT2LitZqt5q22fxIHSpBytcIkyx6Cq4uWtDot4pKiZxMB9+FSTclQJ5vYpkfNGz4mnRA==
X-Received: by 2002:a65:6a43:: with SMTP id o3mr28961742pgu.329.1638974806321;
        Wed, 08 Dec 2021 06:46:46 -0800 (PST)
Received: from localhost.localdomain (27-53-123-192.adsl.fetnet.net. [27.53.123.192])
        by smtp.gmail.com with ESMTPSA id t38sm4135280pfg.199.2021.12.08.06.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 06:46:45 -0800 (PST)
From:   Wei Ming Chen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, tzimmermann@suse.de, robh@kernel.org,
        andriy.shevchenko@linux.intel.com, maxime@cerno.tech,
        Wei Ming Chen <jj251510319013@gmail.com>
Subject: [PATCH] fbdev: Fix file path that does not exist
Date:   Wed,  8 Dec 2021 22:46:31 +0800
Message-Id: <20211208144631.3710-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pvr2fb.c should be under drivers/video/fbdev/
instead of drivers/video/

Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 6ed5e608dd04..93b8d84c34cf 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -829,7 +829,7 @@ config FB_PVR2
 	  You can pass several parameters to the driver at boot time or at
 	  module load time.  The parameters look like "video=pvr2:XXX", where
 	  the meaning of XXX can be found at the end of the main source file
-	  (<file:drivers/video/pvr2fb.c>). Please see the file
+	  (<file:drivers/video/fbdev/pvr2fb.c>). Please see the file
 	  <file:Documentation/fb/pvr2fb.rst>.
 
 config FB_OPENCORES
-- 
2.25.1


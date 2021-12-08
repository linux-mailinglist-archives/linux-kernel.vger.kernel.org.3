Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2046D9C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhLHRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbhLHRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:37:06 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71495C061746;
        Wed,  8 Dec 2021 09:33:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u1so5295858wru.13;
        Wed, 08 Dec 2021 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFjgpzYOUpbB4qYqyIaCf0rkR6PtP6ZykESuPFgH1+w=;
        b=Vggm/iTYGIHhCVnsM1sbA+kFFKwnYzstAZccpW8HQT258n+U5EWKy5r/tCDXRDqa2s
         CEgElAysrU/2n0GZ3AjF03oOMC69r1RONzczunG+UmnK3pEy2FHeche0j86opC5laDUV
         8z+sGO8V9ENzl5OWeGOsYGUrLf6gHn3Y8Vu3bfw5a7C+At2at8wyH1FOGBxADr7wrm4G
         h4zBvPj4VCdWyg0Rn3ZoDQMFqTB6UUC+63ZbjxOCGfi/t6l4/zkyIKRFYX8o6QH/t74d
         IvA+xg3OR1Jjy+F+6KN38saAuHfOnt2zxhgRap9+hmZAz/UgctD+FK5ElcPDJpWPl2UL
         Pssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFjgpzYOUpbB4qYqyIaCf0rkR6PtP6ZykESuPFgH1+w=;
        b=q5aBB9EbQNMM58P2BV2PFvTWA/jCtcO/Xga4g4+Xuq9Jj/HrhnWEfZzhgCC5hIbXts
         HRk79ruYMipV3/GivowOkvwXRZWoqSnsegcmOXkQgs1viQgGanvu7bMgH6gzYYF4cif5
         jOtg4DunMVxdQMyInK5E/lxdlcUcNTmKDeoKTL6P4pvf1k6gPDWM1uWvZI7py/nJkOOz
         6JWxZ/ni2DNBE8pcuSPUc42HORsrG96EdrFt6H24jdfnc8vrsWitr0DMgaUnLO/Z3E6Y
         yR7Ynmc4GnP3oPxBqX6YSNymMWI12r+3pCVpDAnCimD2c+HyoCDAne7xol3XC1BV0clF
         /nuw==
X-Gm-Message-State: AOAM530ZXDn5rDxyOZHuHse8IUka2FQvFFn3SUudQKej2YeyZUPomVYt
        0RNoMIThPyYgWndSfdyo+p4=
X-Google-Smtp-Source: ABdhPJw2FRsOod6oXkh3vQhYFnU8OX3cocILQt5q0h1vnRQeuEADcLOGWtGEcfnLU2PEvKW/EdFYWw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr90845wro.484.1638984813050;
        Wed, 08 Dec 2021 09:33:33 -0800 (PST)
Received: from localhost.localdomain ([217.113.240.86])
        by smtp.gmail.com with ESMTPSA id k37sm3281061wms.21.2021.12.08.09.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 09:33:32 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     hdegoede@redhat.com
Cc:     hadess@hadess.net, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] Input: goodix - Fix memory leak in goodix_firmware_upload
Date:   Wed,  8 Dec 2021 18:33:21 +0100
Message-Id: <20211208173321.26659-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addresses-Coverity-ID: 1493934 ("Resource leak")
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/input/touchscreen/goodix_fwupload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix_fwupload.c b/drivers/input/touchscreen/goodix_fwupload.c
index c1e7a2413078..191d4f38d991 100644
--- a/drivers/input/touchscreen/goodix_fwupload.c
+++ b/drivers/input/touchscreen/goodix_fwupload.c
@@ -207,7 +207,7 @@ static int goodix_firmware_upload(struct goodix_ts_data *ts)
 
 	error = goodix_reset_no_int_sync(ts);
 	if (error)
-		return error;
+		goto release;
 
 	error = goodix_enter_upload_mode(ts->client);
 	if (error)
-- 
2.25.1


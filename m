Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D440479812
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhLRByd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLRByb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:54:31 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:54:30 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id n16so2560050plc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95hYg702ByWDI8LkkZz4UDtSUdCMXCKIYGEc2f0cgdA=;
        b=bluQr4/piV76nQMAZSaoWQ/u9EsSNhtGOAbweNHbfXKqtj4ttANy6hGwAIhwdfXKMw
         RJE9BZ9O+iXZUMoh6FPeftdrTrAgTZaRB9ZG0xV/Itx1++jvqg8mEU60A6BGIBLLV6nR
         aipz55HM6nMfzKHuAng+i6DMKLU4ZUogP97x9nkxaSsatL6EiNfwApDKG0BsBlXJj48n
         F85epyvN731F/N+fAjXQ/e5l2EfdiYImHgcKxsP28bSE7DE+IJvX007NprgGV9+NnJsM
         8KoYBuVAL45vS/E67Xu2d+wygKrmoztkT/kkURnJPVQEJ8EKHbc9qpNbCT2JD2sVYle7
         0e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=95hYg702ByWDI8LkkZz4UDtSUdCMXCKIYGEc2f0cgdA=;
        b=aNBum0GQi8ryrPMZPK30CbAnRiuIuyRLHjg27R8KGX5Wi30seEDB6vZViCOzSaX1AK
         J1a+X1EeVP0EcxFSgxXktUgCR7cyWKH3FZUl1ewZZR4FRztSVAb2PRPKhMSSagATRy4D
         KSyj32Qig+FuHkQLF4xiP4842ChrgIdC6/4UKlr52otpX2CxXgnKl09bBT8GSgPR2STL
         SrhlkA5L1bsOZND8Tz6Lm+QPprd/JQ8PZAWPlbVYX7CmJdPo3XQ8OrvPJuG0pyob9+9f
         AetSq58CDixjnrEWAor7443/YvE8nuiu6Gw1NziI622A7C2ZuDFXGTzzKZxHsTQ1FGgI
         A+eA==
X-Gm-Message-State: AOAM532JQbbxw3GojenhKBt4igmZZj4fvcxxYY5KWH7BlysAf6J3nYR9
        Aw35mzREpvr9bwlf2QAbQUJWEsiHG/Y=
X-Google-Smtp-Source: ABdhPJwJOliNXPO1x9DNdsq48RgUbA+0/qjklDveAVkCF2EV+8muYhOpcrW050cGMBg8ZTXUyuB95A==
X-Received: by 2002:a17:90b:3545:: with SMTP id lt5mr6892591pjb.14.1639792470050;
        Fri, 17 Dec 2021 17:54:30 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id h6sm11277520pfh.82.2021.12.17.17.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 17:54:29 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     perex@perex.cz
Cc:     davidcomponentone@gmail.com, tiwai@suse.com, broonie@kernel.org,
        joe@perches.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ALSA: hda: use swap() to make code cleaner
Date:   Sat, 18 Dec 2021 09:54:16 +0800
Message-Id: <ebc9db44b802dfc88e1538629b517e000acb27b3.1639790796.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 sound/pci/hda/hda_auto_parser.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 4a854475a0e6..82c492b05667 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -92,14 +92,10 @@ static int compare_input_type(const void *ap, const void *bp)
  */
 static void reorder_outputs(unsigned int nums, hda_nid_t *pins)
 {
-	hda_nid_t nid;
-
 	switch (nums) {
 	case 3:
 	case 4:
-		nid = pins[1];
-		pins[1] = pins[2];
-		pins[2] = nid;
+		swap(pins[1], pins[2]);
 		break;
 	}
 }
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A26F4840BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbiADLZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiADLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:24:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66435C061799;
        Tue,  4 Jan 2022 03:24:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so40524406pjj.2;
        Tue, 04 Jan 2022 03:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PO7WThJm8A1VltTWZS6VmCv6l32L8rM76DCuBVs8Jow=;
        b=hueypFByEa9g4Nx1d4zgwZaoJ/WLmuOrRjeJKxmxRt4+PWNBMWTGMY+jpwuh4ZbsY+
         GPmL1kIY8Qb2NEniifGoqg9u0QUvSRECjXTxovpiJk1BHSzanwa/klZ+4DcIQ3r/910b
         zqCr6mqKtrwVDufaeOhN3IXgLnoFIEHeN89Cp2iEqDzMz7UAyZGSRKgaz8GV84r/kCgb
         6yGfjrDNo6vUmi2TeeVlzdjIaoytBXZe/l+7+ANiqyjhkw623S1QEMvU3XYKKC4H9tSY
         p5xIrH/MrlcEa7koyPwS/du/vjs0xnaK+OQE+5efJ6R4RXvVbb8imD6ujLcYxT17fCUJ
         XX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PO7WThJm8A1VltTWZS6VmCv6l32L8rM76DCuBVs8Jow=;
        b=j+RNf394penukAUviyyaveobajFUW602AXwLxBKH7DWPI2m8nrrIGDLBSEirNu/rJP
         +jmxPQGDD1NN4mFO+FPgjHufIWP1nmyD4b3L+mJWpd7SLUg1ZdQMCkuiXhkKHPelXbd8
         NepjYarUhXDmhFyCEyvHlQZRychLdK4mHSTAtlEX/fPDEBm9L6W2yE2tjTLDxUbO+hsK
         DIAsxQ/wrm5LjMpFY9pFEXHH3jn9+CuEAam2QU6EhDyV0DAdfGBvLaY3RhAet9X40KmQ
         k5eFBJMdXctLzxPAoVgnDRudn0NK//b2g2Tsna1vffC/F3pxg1W+IPZo7dY1DdBuGaTS
         4uKQ==
X-Gm-Message-State: AOAM5300L//H5prnf+I3VbCW+1aR/cMzo9cTtPpJ0RIOzYENjRTieWaS
        2sEAnqAMtm/5n+uKIgxzo3A=
X-Google-Smtp-Source: ABdhPJy0EjPeLhCFiZ2MCgqcQNvAWPN8LoKv9G8lUKwwF//2ImHUaJ3M996i+Qt9o/2IzulculP+YA==
X-Received: by 2002:a17:902:7246:b0:149:636f:2fde with SMTP id c6-20020a170902724600b00149636f2fdemr44205356pll.9.1641295496934;
        Tue, 04 Jan 2022 03:24:56 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id kb1sm46694172pjb.56.2022.01.04.03.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 03:24:56 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     hare@suse.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/scsi: remove redundant error variable
Date:   Tue,  4 Jan 2022 11:24:52 +0000
Message-Id: <20220104112452.601899-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from ahd_linux_queue_abort_cmd() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/scsi/aic7xxx/aic79xx_osm.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index 5d566d2b2997..928099163f0f 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -755,11 +755,7 @@ ahd_linux_biosparam(struct scsi_device *sdev, struct block_device *bdev,
 static int
 ahd_linux_abort(struct scsi_cmnd *cmd)
 {
-	int error;
-	
-	error = ahd_linux_queue_abort_cmd(cmd);
-
-	return error;
+	return ahd_linux_queue_abort_cmd(cmd);
 }
 
 /*
-- 
2.25.1


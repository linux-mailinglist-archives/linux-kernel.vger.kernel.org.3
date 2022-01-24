Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE14980AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiAXNOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiAXNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:13:52 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF12C061759;
        Mon, 24 Jan 2022 05:13:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso16847465pjm.4;
        Mon, 24 Jan 2022 05:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SuD6sheATFuuLSHiFeUeKDBZFiRvmZlnh/SZkdpgISc=;
        b=HseGslMxsGF82e3iqYEkb4BTLD/csJH/OgIC5HFuberMikfaDQOBTrzYNNfB9JqlID
         PB1W2Er3/n2BtnIE9hoLUnmJK+ekPrk0GeIKaajV+aQxT0XgQbqBPKQI3um1na8nW7A4
         97LKHB62w1blgmzSOLCCKY0dZ5KbHF3hjmbJYY9rK3GN1Jsf5yYnlNRmhFAdtYFVyA5t
         Zf2dlVnwmV3UqH+Fm6ljGcUt4cWXwHhmbf22cbLq+LSBnr6/ltR3v/Qv76gdi+IGmNwB
         NWiBubid9GCZ7Jj+WuqllkZzPRvWEvoG27ygtu7UscpbcKZrjmAlE4DxD75APjQeQ7so
         Iq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SuD6sheATFuuLSHiFeUeKDBZFiRvmZlnh/SZkdpgISc=;
        b=LXBAbigrIwkXPEkQ6eQaonlVmUxGk1tsWslBNWu7OSARoD96YOy2YF+9B7Gu9QCfKM
         u7Gja+sBAGtYMdZPEgZxqKYJp/LG3BDQNKmS1XfMZ4Ntx6Rm8P02TjJPQog5Q9/yIqeo
         LNK9nOw3vIfg0/ZT0BMwBaD4ow8CoEGecTmJdUzv57Tm2Wi1ldyp7CJkvFMzVirOEeLe
         iuO0S3Qy447a2WeGPZlD3ThaBaJqg1qIv8DhRi6Hw/k9KO5rVC40PlvAOG/bDmQ3SsQX
         UEK99Zcw26KO28akIKKLru1MniCKlkUor6Rfn4Gj8q3/iDNBdUI42NblDI296HavTlOT
         PHrg==
X-Gm-Message-State: AOAM530c6w4sLJEyitHnI1VjWSJtYeaL1WmroAHIUojkcjtjmjyEYSyA
        Q1Exn6VEUhOA+yqVnENebetd997yTeXswWZl
X-Google-Smtp-Source: ABdhPJxEQElMBY55AeZqCVCOFNii4gh3iaEeL/1pcOCdIZGIJkSOZaqbehpCnljKH3rlYpKmeh3YVA==
X-Received: by 2002:a17:903:32c1:b0:14b:2d82:c05a with SMTP id i1-20020a17090332c100b0014b2d82c05amr10179670plr.55.1643030031319;
        Mon, 24 Jan 2022 05:13:51 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id kk17sm4819342pjb.21.2022.01.24.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 05:13:51 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] power: supply: ab8500: Fix memory leak in ab8500_fg_sysfs_init
Date:   Mon, 24 Jan 2022 13:13:46 +0000
Message-Id: <20220124131346.12571-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()：

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix memory leak by calling kobject_put().

Fixes: 8c0984e5a753 ("power: move power supply drivers to power/supply")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/power/supply/ab8500_fg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 05fe9724ba50..57799a8079d4 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2545,8 +2545,10 @@ static int ab8500_fg_sysfs_init(struct ab8500_fg *di)
 	ret = kobject_init_and_add(&di->fg_kobject,
 		&ab8500_fg_ktype,
 		NULL, "battery");
-	if (ret < 0)
+	if (ret < 0) {
+		kobject_put(&di->fg_kobject);
 		dev_err(di->dev, "failed to create sysfs entry\n");
+	}
 
 	return ret;
 }
-- 
2.17.1


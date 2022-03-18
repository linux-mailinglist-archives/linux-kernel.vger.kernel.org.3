Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AF74DD272
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiCRBbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiCRBbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:31:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C231207C8;
        Thu, 17 Mar 2022 18:30:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u10so9787869wra.9;
        Thu, 17 Mar 2022 18:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8hWtjydg1Uns+eOzqAaZoK2Vcd2nxaf7d5KD8AEEt4=;
        b=hBcKG/WWy4HsVunBcI3ydG4SVMw/+29z7t+io0+b0TKqfjgmGEmZ6UIS16BlYMVnwH
         LxM8FKgjziksWCiNEINZw5PnnjGyJ0TFNAGqqmfkffcNSldXqTB0ahWuMKbSLTla0rSm
         aVCNkZcqC4xnqvxoIyrYoZe/yVo+ziL8w0HNivZbX7THsXlDKOltYyjBVlrpG6+OExVP
         vNgFLlz++46k3zKIhiMIw6lbWM5rb35CI0eOcQJuefJdUr/J23F3Qp4XLu7ftVDezuAs
         YgRPfekxmOYFaEu2294R2k5pLnxC8R9N46JAFHGHMsjZa5+h4eOh5bRzCemrU83DQHFp
         kNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8hWtjydg1Uns+eOzqAaZoK2Vcd2nxaf7d5KD8AEEt4=;
        b=p5QYPTrwP/qIjuGjux85VLUQQwYpph1HUehVB+z6XqNXDEAngPakVIjY/Srh4yoV+1
         c/ScHrY/WMrIcGSUeByAwhXIsvjjaKl/xBGO9upyn7258xeoTSS10BOkG6+BRMO3vw/I
         ujaRs/Yqnr1BJHJAa3tTbcsgQCKKhppk4Teqmo+YIMAuiFdHhTWzyKfyx6Gy2F8wdLx/
         DB7MwLW1YJjiLJGllRpdeCPusaBYJjhn4MMcCDLsXwONPj1L/IuSI1NY1fgrmZjnFExO
         dcgqzbwvj6EVU2wOw2P9ap1V0CQ2arRgtjhNEnT34tpblxOTAvwfG8niMUCDcoku2XjH
         QTgQ==
X-Gm-Message-State: AOAM533lCWveMCx/okfwuZWzMv3Agg9FhQvKqExSOuBssLCp51zFRfCJ
        MGYn3opc8wO71n55HT6sFEE=
X-Google-Smtp-Source: ABdhPJy44/ZTFxrG+FCtGZtXs1cj8lLzdIGlbJvYj5LgXRGfXlHaGY9J6mj7f3LTMs9tZivMYD9a9Q==
X-Received: by 2002:a5d:59ab:0:b0:203:cc07:8d82 with SMTP id p11-20020a5d59ab000000b00203cc078d82mr5881291wrr.688.1647567015653;
        Thu, 17 Mar 2022 18:30:15 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm9534520wmn.46.2022.03.17.18.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:30:15 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] nvmet: remove redundant assignment after left shift
Date:   Fri, 18 Mar 2022 01:30:14 +0000
Message-Id: <20220318013014.90698-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The left shift is followed by a re-assignment back to cc_css,
the assignment is redundant. Fix this by replacing the <<=
operator with << instead.

Cleans up clang scan build warning:
drivers/nvme/target/core.c:1124:10: warning: Although the value
stored to 'cc_css' is used in the enclosing expression, the
value is never actually read from 'cc_css' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 724a6d373340..75876f70a7eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1121,7 +1121,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
 
 static inline bool nvmet_css_supported(u8 cc_css)
 {
-	switch (cc_css <<= NVME_CC_CSS_SHIFT) {
+	switch (cc_css << NVME_CC_CSS_SHIFT) {
 	case NVME_CC_CSS_NVM:
 	case NVME_CC_CSS_CSI:
 		return true;
-- 
2.35.1


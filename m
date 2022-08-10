Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1979E58ED80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 15:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiHJNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbiHJNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 09:40:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93673326C6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:40:54 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id pm17so14772418pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 06:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IyZuXwvWxfkgzhF4RsrPMJZKJwH00vPO7yyEdw3/HlU=;
        b=ntBoPYazYax6r+0qruxmbOuxL4Quz3/W4JD/frVfAWX5FLJeldi7Kf67t1zu8kWyhg
         D1CTRuLF1AdfTtu4+q/ViZUx2EYsycML1zowouHBWwdm2kFD1y/ETa5c7BK/n7AeWCGh
         25VjN9PyZmAcPKMNrNToRhoPCM3LpSsMBGYH//dodvco7MUS6ROxfJC/1wJcQo90oXc1
         i8lacWkOrJt5rJQx+/59O5XTOh5sdT0vU/Zjd1+1bkwhIaheXTK37lr37tBOUCe4g2MA
         so9+IdGuE44IwtigMXYJ+K4nfMpFOS/Bj14zNu2k5sqrLeQPGv1y84Xs+7EDCT4Eg4Ya
         9OKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IyZuXwvWxfkgzhF4RsrPMJZKJwH00vPO7yyEdw3/HlU=;
        b=XQszOhyn2u1TmDYUDtodBawpqOg3YIhaOuGAUrr/fE3gRbDY8MY/09iftk0HqtOx1V
         /rPkesbrlrFKsHg+xMLokDdQeO/kkg/bvOtYoOhXSKil7iHCkhus2xgWJSuKfAQihO6M
         NoezuG40w67U/u8baAsVOccmD1v/lXNhWt+11b6wvJ1vaOU/xzkKuPawIFU3kTd2TAkB
         o3cvXLdd53Gjr7Cenp0xftjXUI0oYVruFKR4ZRQqmiGEI7iy4PHDB9qzz4Lmz18YDm8j
         Qz9n5VRCiCVodn2p1kNwz6kr3yE2eBYubI31QIm7uDppQn9sBs79hTA7vH9Zq7eSIGcV
         WdMQ==
X-Gm-Message-State: ACgBeo326uXfV/HOrQa47yk0jVMIpssbr7/KLBbHeZo7pAtAmdwbxNFR
        Bx3/LAdqf1IjpPCBEkV+lKc=
X-Google-Smtp-Source: AA6agR50lS+v70l8L54U1MD/Aa7s1ADUymKDg/apa/H8HaUHjIpyM0gFNZxxl2s+u6o4hQctVzKLUw==
X-Received: by 2002:a17:90b:38c9:b0:1f7:28bb:aa16 with SMTP id nn9-20020a17090b38c900b001f728bbaa16mr3798436pjb.201.1660138854073;
        Wed, 10 Aug 2022 06:40:54 -0700 (PDT)
Received: from pipi-desktop.testerjoe ([101.88.11.237])
        by smtp.gmail.com with ESMTPSA id f23-20020aa79697000000b0052d4487ae7fsm1969999pfk.27.2022.08.10.06.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 06:40:53 -0700 (PDT)
From:   Linjun Bao <meljbao@gmail.com>
Cc:     Linjun Bao <meljbao@gmail.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: align "fake" nqn with spec 1.3
Date:   Wed, 10 Aug 2022 21:39:54 +0800
Message-Id: <20220810133953.5411-1-meljbao@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace '.' with '-' to align "fake" nqn format with nvme spec 1.3 or newer.

Signed-off-by: Linjun Bao <meljbao@gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2ea6ca37c41..d6fb91bbcf9e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2504,7 +2504,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
-			"nqn.2014.08.org.nvmexpress:%04x%04x",
+			"nqn.2014-08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
 	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A0D4611D7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhK2KMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhK2KJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1132C0698CB;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7D97B80E61;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5453AC53FAD;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=k/r/HEftU56EeEP2U5xn5dg4W7rEwcQiF7pmRR/y6tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Njibk+EORllBjF9kVb+169wlt6RjTpgLm6rzZgdaZWthQrMe/1OaoW7ewzdKwgPlu
         wHSkuYANdXAJbqAnlFol+3opi3u4MiUBEqBdlUt6zlehYNNt1pJMVNOGqRs+6FvPx1
         F8ZDTeUstIRjUsQ9xdap3qdZCv7afdffharO+BwN7OBmhinaeWuBi5A9lshOiIOHwf
         K9FSjZIevwXHUHwrcz+8JNJs2bsqp0aW/QRpXPpaWnI5Wc3qnXVcj/fO2cZNQH3zfU
         iiCKmA02+wezuPwUzpcMCrAjfFviUWnYByV4o84F4bsX5qVkPOx2kP1Zn/G3ihTyFm
         wQDo3w7o3dOTw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RAz-5t; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 02/20] media: saa7134-go7007: get rid of to_state() function
Date:   Mon, 29 Nov 2021 10:47:34 +0100
Message-Id: <8efe1d7c0023ce124fa9984095f5bc7198c71c82.1638179135.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638179135.git.mchehab+huawei@kernel.org>
References: <cover.1638179135.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just an alias for container_of() and it is used only
on a commented code. The commented code actually is an issue that
require fixes, so, move the container_of() call to the commented
code, and drop the unused function.

This way, a fix for the function could be added later without
needing to re-add to_state() function.

This fixes a clang W=1 warning.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/pci/saa7134/saa7134-go7007.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-go7007.c b/drivers/media/pci/saa7134/saa7134-go7007.c
index f319edb39c0e..da83893ffee9 100644
--- a/drivers/media/pci/saa7134/saa7134-go7007.c
+++ b/drivers/media/pci/saa7134/saa7134-go7007.c
@@ -56,11 +56,6 @@ struct saa7134_go7007 {
 	dma_addr_t bottom_dma;
 };
 
-static inline struct saa7134_go7007 *to_state(struct v4l2_subdev *sd)
-{
-	return container_of(sd, struct saa7134_go7007, sd);
-}
-
 static const struct go7007_board_info board_voyager = {
 	.flags		 = 0,
 	.sensor_flags	 = GO7007_SENSOR_656 |
@@ -385,7 +380,7 @@ MODULE_FIRMWARE("go7007/go7007tv.bin");
 static int saa7134_go7007_s_std(struct v4l2_subdev *sd, v4l2_std_id norm)
 {
 #if 0
-	struct saa7134_go7007 *saa = to_state(sd);
+	struct saa7134_go7007 *saa = container_of(sd, struct saa7134_go7007, sd);
 	struct saa7134_dev *dev = saa->dev;
 
 	return saa7134_s_std_internal(dev, NULL, norm);
-- 
2.33.1


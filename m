Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557AD4611D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350788AbhK2KLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhK2KJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D34C0698C9;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710F06129E;
        Mon, 29 Nov 2021 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3005C9039C;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=YlKZnWxAnzvzgRkW58KVzO1NH7YwxG8b4dfk4+1g7WA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaYNnMhUgeuxefx7BBPsTqNpGJAbJfwuIxSLPx+KA6ewujY+L5rTPUb0u+usXowaB
         Rfymx9vSlJAtHV5qpUL3gL7AauCLlZvwxO3+j0/cdy2IuvT951pKoG7Qob3CC9di6r
         VhTZMfKlkwiFnhJUmZc+PVG4KPLpogFmG7+wDV3V5ymr2eD6ECPvrt+qtDmew21FKp
         16yZGgNbaXif8rsPNaGamfgr+75GO9H/Bgy3uAOoL6b7B+uZXA8vUOu/juhIhrO5cZ
         5pxQ9t3ndWf1yVe1/SycXA5ykhAKDakXKx0fD1NIBfMewlOgl5L8viFkQLpNZcMWwZ
         lw11h/uj5B+MQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBm-Oa; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 14/20] media: adv7511: drop unused functions
Date:   Mon, 29 Nov 2021 10:47:46 +0100
Message-Id: <b9078d405c0cd22176acad69ffac531f60baf8bb.1638179135.git.mchehab+huawei@kernel.org>
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

Those are aliases for another function and not used at the
current implementation. So, just drop it.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/i2c/adv7511-v4l2.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/media/i2c/adv7511-v4l2.c b/drivers/media/i2c/adv7511-v4l2.c
index 41f4e749a859..8e13cae40ec5 100644
--- a/drivers/media/i2c/adv7511-v4l2.c
+++ b/drivers/media/i2c/adv7511-v4l2.c
@@ -270,28 +270,6 @@ static int adv7511_pktmem_rd(struct v4l2_subdev *sd, u8 reg)
 	return adv_smbus_read_byte_data(state->i2c_pktmem, reg);
 }
 
-static int adv7511_pktmem_wr(struct v4l2_subdev *sd, u8 reg, u8 val)
-{
-	struct adv7511_state *state = get_adv7511_state(sd);
-	int ret;
-	int i;
-
-	for (i = 0; i < 3; i++) {
-		ret = i2c_smbus_write_byte_data(state->i2c_pktmem, reg, val);
-		if (ret == 0)
-			return 0;
-	}
-	v4l2_err(sd, "%s: i2c write error\n", __func__);
-	return ret;
-}
-
-/* To set specific bits in the register, a clear-mask is given (to be AND-ed),
-   and then the value-mask (to be OR-ed). */
-static inline void adv7511_pktmem_wr_and_or(struct v4l2_subdev *sd, u8 reg, u8 clr_mask, u8 val_mask)
-{
-	adv7511_pktmem_wr(sd, reg, (adv7511_pktmem_rd(sd, reg) & clr_mask) | val_mask);
-}
-
 static inline bool adv7511_have_hotplug(struct v4l2_subdev *sd)
 {
 	return adv7511_rd(sd, 0x42) & MASK_ADV7511_HPD_DETECT;
-- 
2.33.1


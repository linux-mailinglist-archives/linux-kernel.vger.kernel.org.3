Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E3461168
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbhK2JyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:54:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34614 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245453AbhK2JvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:51:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20449B80E72;
        Mon, 29 Nov 2021 09:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0FEC5833B;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=qLsXkKUqYgx/y5TYU+1VFJtNdFV5qBVzuVbWurIKgCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbtrAZaJ0HUA0HsvUsfHoTlDWfeg93Ece5o26tcCNNmwlO0oVEbHoTNUH2p+VrhM0
         3HwLL4V/DY0XAIhcImSIjai9kl6XQ5WnCmIvG65I/RlWtkaJmSNE3jxNiF25zg2Hor
         JiCgVMXrqGFaUgRdMlMJbRfvvG48wmRj8B3I+j6vJl7BYwYs0XkL04hG5yPft8OXmW
         tpNTjqfBnISgyl1So++MI6Kmrj/iFu4AcgpJmyCcEUt60GV9OGEBpBp30SQ3fWP+Ee
         irkIqaZgbcLsGgD6VudykQjb4D2dV/Z51/rLYDGacjGXzZLmtWJYN86+pFSUZ/CzRt
         75TD2DbIUMuWg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBi-Md; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 13/20] media: adv7604: mark unused functions as such
Date:   Mon, 29 Nov 2021 10:47:45 +0100
Message-Id: <91b6e8c97de3608785a035eaef6d970aea7926ac.1638179135.git.mchehab+huawei@kernel.org>
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

There are several unused helper macros there, meant to parse some
fields. As those actually help to document the hardware, the
better is to keep them.

However, it generates clang warnings with W=1, causing build to
break with CONFIG_WERROR.

So, add __always_unused to fix such warnings.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/i2c/adv7604.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 44768b59a6ff..a2fa408d2d9f 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -398,14 +398,14 @@ static inline int io_write_clr_set(struct v4l2_subdev *sd, u8 reg, u8 mask,
 	return io_write(sd, reg, (io_read(sd, reg) & ~mask) | val);
 }
 
-static inline int avlink_read(struct v4l2_subdev *sd, u8 reg)
+static inline int __always_unused avlink_read(struct v4l2_subdev *sd, u8 reg)
 {
 	struct adv76xx_state *state = to_state(sd);
 
 	return adv76xx_read_check(state, ADV7604_PAGE_AVLINK, reg);
 }
 
-static inline int avlink_write(struct v4l2_subdev *sd, u8 reg, u8 val)
+static inline int __always_unused avlink_write(struct v4l2_subdev *sd, u8 reg, u8 val)
 {
 	struct adv76xx_state *state = to_state(sd);
 
@@ -439,14 +439,14 @@ static inline int infoframe_read(struct v4l2_subdev *sd, u8 reg)
 	return adv76xx_read_check(state, ADV76XX_PAGE_INFOFRAME, reg);
 }
 
-static inline int infoframe_write(struct v4l2_subdev *sd, u8 reg, u8 val)
+static inline int __always_unused infoframe_write(struct v4l2_subdev *sd, u8 reg, u8 val)
 {
 	struct adv76xx_state *state = to_state(sd);
 
 	return regmap_write(state->regmap[ADV76XX_PAGE_INFOFRAME], reg, val);
 }
 
-static inline int afe_read(struct v4l2_subdev *sd, u8 reg)
+static inline int __always_unused afe_read(struct v4l2_subdev *sd, u8 reg)
 {
 	struct adv76xx_state *state = to_state(sd);
 
@@ -479,14 +479,14 @@ static inline int rep_write_clr_set(struct v4l2_subdev *sd, u8 reg, u8 mask, u8
 	return rep_write(sd, reg, (rep_read(sd, reg) & ~mask) | val);
 }
 
-static inline int edid_read(struct v4l2_subdev *sd, u8 reg)
+static inline int __always_unused edid_read(struct v4l2_subdev *sd, u8 reg)
 {
 	struct adv76xx_state *state = to_state(sd);
 
 	return adv76xx_read_check(state, ADV76XX_PAGE_EDID, reg);
 }
 
-static inline int edid_write(struct v4l2_subdev *sd, u8 reg, u8 val)
+static inline int __always_unused edid_write(struct v4l2_subdev *sd, u8 reg, u8 val)
 {
 	struct adv76xx_state *state = to_state(sd);
 
@@ -570,7 +570,7 @@ static inline int hdmi_write_clr_set(struct v4l2_subdev *sd, u8 reg, u8 mask, u8
 	return hdmi_write(sd, reg, (hdmi_read(sd, reg) & ~mask) | val);
 }
 
-static inline int test_write(struct v4l2_subdev *sd, u8 reg, u8 val)
+static inline int __always_unused test_write(struct v4l2_subdev *sd, u8 reg, u8 val)
 {
 	struct adv76xx_state *state = to_state(sd);
 
@@ -601,14 +601,14 @@ static inline int cp_write_clr_set(struct v4l2_subdev *sd, u8 reg, u8 mask, u8 v
 	return cp_write(sd, reg, (cp_read(sd, reg) & ~mask) | val);
 }
 
-static inline int vdp_read(struct v4l2_subdev *sd, u8 reg)
+static inline int __always_unused vdp_read(struct v4l2_subdev *sd, u8 reg)
 {
 	struct adv76xx_state *state = to_state(sd);
 
 	return adv76xx_read_check(state, ADV7604_PAGE_VDP, reg);
 }
 
-static inline int vdp_write(struct v4l2_subdev *sd, u8 reg, u8 val)
+static inline int __always_unused vdp_write(struct v4l2_subdev *sd, u8 reg, u8 val)
 {
 	struct adv76xx_state *state = to_state(sd);
 
-- 
2.33.1


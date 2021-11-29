Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35AD4611BD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbhK2KKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243537AbhK2KIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:08:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B68C0698C2;
        Mon, 29 Nov 2021 01:47:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8782E61263;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E37C53FD4;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=Fp7arA5lBUk6fO+z1FEqsXv9rP6Nf7CrzZDn+sfxLds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1ruu5h3vaAuIaDwY2Y7R357Md4qbqysmgOA2tTiziJsy+WBnTgSNpSGAKlwqL/a2
         AW12kPHjgcVylpo9lehquP4lBlAPuda4ESqJ3BMG8vTKdSn3QkA6mzARZf70Tujq9n
         j5MkW+Xcy7qmABb6uwy4RaUyzMeVRhDxHPOn3TRDpk1m3gTdkDvSTmptU6uZ49BWUM
         UQNpjQ/MCZzca+HEF0HX/5HXXoM4eyazantRBZU5R5jAbJHOqt7T8ggc0W3JykwyAT
         CzEXWOZYAHYRxyjrExMlPPzN+a0NDKmdXjLuMVBZxe1+uKheTE/IdnNq4UU4vDVExB
         eANb/wNGOSLhQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBC-Aa; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 05/20] media: drxk: drop operation_mode from set_dvbt()
Date:   Mon, 29 Nov 2021 10:47:37 +0100
Message-Id: <28e38377afa7535cb1ede125b8aa987bbf9b4f27.1638179135.git.mchehab+huawei@kernel.org>
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

This var is set, but never used. So, drop it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/dvb-frontends/drxk_hard.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxk_hard.c b/drivers/media/dvb-frontends/drxk_hard.c
index d7fc2595f15b..9430295a8175 100644
--- a/drivers/media/dvb-frontends/drxk_hard.c
+++ b/drivers/media/dvb-frontends/drxk_hard.c
@@ -3720,7 +3720,6 @@ static int set_dvbt(struct drxk_state *state, u16 intermediate_freqk_hz,
 {
 	u16 cmd_result = 0;
 	u16 transmission_params = 0;
-	u16 operation_mode = 0;
 	u32 iqm_rc_rate_ofs = 0;
 	u32 bandwidth = 0;
 	u16 param1;
@@ -3759,10 +3758,8 @@ static int set_dvbt(struct drxk_state *state, u16 intermediate_freqk_hz,
 	/* mode */
 	switch (state->props.transmission_mode) {
 	case TRANSMISSION_MODE_AUTO:
-	default:
-		operation_mode |= OFDM_SC_RA_RAM_OP_AUTO_MODE__M;
-		fallthrough;	/* try first guess DRX_FFTMODE_8K */
 	case TRANSMISSION_MODE_8K:
+	default:
 		transmission_params |= OFDM_SC_RA_RAM_OP_PARAM_MODE_8K;
 		break;
 	case TRANSMISSION_MODE_2K:
@@ -3773,9 +3770,7 @@ static int set_dvbt(struct drxk_state *state, u16 intermediate_freqk_hz,
 	/* guard */
 	switch (state->props.guard_interval) {
 	default:
-	case GUARD_INTERVAL_AUTO:
-		operation_mode |= OFDM_SC_RA_RAM_OP_AUTO_GUARD__M;
-		fallthrough;	/* try first guess DRX_GUARD_1DIV4 */
+	case GUARD_INTERVAL_AUTO: /* try first guess DRX_GUARD_1DIV4 */
 	case GUARD_INTERVAL_1_4:
 		transmission_params |= OFDM_SC_RA_RAM_OP_PARAM_GUARD_4;
 		break;
@@ -3794,11 +3789,7 @@ static int set_dvbt(struct drxk_state *state, u16 intermediate_freqk_hz,
 	switch (state->props.hierarchy) {
 	case HIERARCHY_AUTO:
 	case HIERARCHY_NONE:
-	default:
-		operation_mode |= OFDM_SC_RA_RAM_OP_AUTO_HIER__M;
-		/* try first guess SC_RA_RAM_OP_PARAM_HIER_NO */
-		/* transmission_params |= OFDM_SC_RA_RAM_OP_PARAM_HIER_NO; */
-		fallthrough;
+	default:	/* try first guess SC_RA_RAM_OP_PARAM_HIER_NO */
 	case HIERARCHY_1:
 		transmission_params |= OFDM_SC_RA_RAM_OP_PARAM_HIER_A1;
 		break;
@@ -3814,9 +3805,7 @@ static int set_dvbt(struct drxk_state *state, u16 intermediate_freqk_hz,
 	/* modulation */
 	switch (state->props.modulation) {
 	case QAM_AUTO:
-	default:
-		operation_mode |= OFDM_SC_RA_RAM_OP_AUTO_CONST__M;
-		fallthrough;	/* try first guess DRX_CONSTELLATION_QAM64 */
+	default:	/* try first guess DRX_CONSTELLATION_QAM64 */
 	case QAM_64:
 		transmission_params |= OFDM_SC_RA_RAM_OP_PARAM_CONST_QAM64;
 		break;
@@ -3857,9 +3846,7 @@ static int set_dvbt(struct drxk_state *state, u16 intermediate_freqk_hz,
 	/* coderate */
 	switch (state->props.code_rate_HP) {
 	case FEC_AUTO:
-	default:
-		operation_mode |= OFDM_SC_RA_RAM_OP_AUTO_RATE__M;
-		fallthrough;	/* try first guess DRX_CODERATE_2DIV3 */
+	default:	/* try first guess DRX_CODERATE_2DIV3 */
 	case FEC_2_3:
 		transmission_params |= OFDM_SC_RA_RAM_OP_PARAM_RATE_2_3;
 		break;
-- 
2.33.1


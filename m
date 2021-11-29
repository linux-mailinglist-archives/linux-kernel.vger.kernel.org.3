Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B59461166
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349381AbhK2Jxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:53:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34590 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245375AbhK2JvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:51:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B766B80E66;
        Mon, 29 Nov 2021 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D07C58324;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=55eT3wgWOJhie6F7iqSlU4bA4FiL270RS5JqRpvLTyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZDZBxWs/BcZKGatNB4UlPCgcj4fLrgtWWovVsjozNIUXdDPWJCyVj5ZrZE0pK7K3f
         RHQW7tBJLDfdtef2a300EVWrP5XnD5OkWNrX1IqAQr+C7BTgergTGJXAkRjVEfnhuR
         Tw5YCI5divZ9H1yEJ7E6XUZR92xXyme2NyL/y9KKe07EGb/X5gzJo+aPyyhTKSKYjK
         twTiw73T4LsRnmeEJYWwS/FzuXM57A4N9XWhqgOKhB3Mrn5ktWttWc00F1/iTfFnWK
         eO/IS9QeVXVTxSMj6P5YFws4pZ7iKaCtSG09GRghHBmCRSxOJE+/EF8RF3O5a/7bKO
         tkHWmpHfVJVfA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RBG-Bp; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 06/20] media: m88ds3103: drop reg11 calculus from m88ds3103b_select_mclk()
Date:   Mon, 29 Nov 2021 10:47:38 +0100
Message-Id: <535b7e2c4d48e14aed70b70231306b0f6263f103.1638179135.git.mchehab+huawei@kernel.org>
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

This value is never used at the code. So, drop it.

Solves a W=1 clang warning.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/dvb-frontends/m88ds3103.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/media/dvb-frontends/m88ds3103.c b/drivers/media/dvb-frontends/m88ds3103.c
index 02e8aa11e36e..bce0f42f3d19 100644
--- a/drivers/media/dvb-frontends/m88ds3103.c
+++ b/drivers/media/dvb-frontends/m88ds3103.c
@@ -451,7 +451,7 @@ static int m88ds3103b_select_mclk(struct m88ds3103_dev *dev)
 
 static int m88ds3103b_set_mclk(struct m88ds3103_dev *dev, u32 mclk_khz)
 {
-	u8 reg11 = 0x0A, reg15, reg16, reg1D, reg1E, reg1F, tmp;
+	u8 reg15, reg16, reg1D, reg1E, reg1F, tmp;
 	u8 sm, f0 = 0, f1 = 0, f2 = 0, f3 = 0;
 	u16 pll_div_fb, N;
 	u32 div;
@@ -480,8 +480,6 @@ static int m88ds3103b_set_mclk(struct m88ds3103_dev *dev, u32 mclk_khz)
 	div /= mclk_khz;
 
 	if (dev->cfg->ts_mode == M88DS3103_TS_SERIAL) {
-		reg11 |= 0x02;
-
 		if (div <= 32) {
 			N = 2;
 
@@ -532,8 +530,6 @@ static int m88ds3103b_set_mclk(struct m88ds3103_dev *dev, u32 mclk_khz)
 		else if ((f3 < 8) && (f3 != 0))
 			f3 = 8;
 	} else {
-		reg11 &= ~0x02;
-
 		if (div <= 32) {
 			N = 2;
 
-- 
2.33.1


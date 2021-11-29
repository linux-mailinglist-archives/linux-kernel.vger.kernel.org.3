Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99E64611DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353611AbhK2KMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbhK2KJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A290C0698CE;
        Mon, 29 Nov 2021 01:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3377CB80E6B;
        Mon, 29 Nov 2021 09:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D06C8CFC9;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179277;
        bh=almiBRvaRIswDQ0M54jkBCu++okng5mXod3ZWHjA9zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bYUkGbbarxNSXez5Q7KK4TvqK5ZftC5v/LITcTho7w9ecANgRfh/ILgp/V+XMgAzT
         D+RHjtYH6UqgatA4xQPft02ZryN6Iolqymom+tbCVNvIk5+LpfaueCGaPU7r4oMkSB
         5DG+DmX+vvide0RHSoqVwwhurxEbwAuclEjRZ6FnInFyF/iUmW0kN16OC/MXmrl1pQ
         zEXqrfIwGEd9nHYteyaJtKoGtmfhGVzUWqqbKwr9cZ49dlggryl6iFVsgp2CHuFGNr
         E7vv/yfqih4C/474Q99jWJ9jAIzFFJuXalNDW0OuHO2agUPdDUXht0TRhJ5z7dCzxJ
         2D23CV5HiRxqg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGN-000RCA-4c; Mon, 29 Nov 2021 10:47:55 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 20/20] media: mxl5005s: drop some dead code
Date:   Mon, 29 Nov 2021 10:47:52 +0100
Message-Id: <f7702322ec7fce557850e6a5acabc1c5d574ff33.1638179135.git.mchehab+huawei@kernel.org>
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

As reported by clang (with W=1), the ctrlVal var is never used.

Yet, there are even some loops to estimate it. As this is dead
code, remove it. If ever needed, someone could revert this
patch.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/tuners/mxl5005s.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/media/tuners/mxl5005s.c b/drivers/media/tuners/mxl5005s.c
index f6e82a8e7d37..ab4c43df9d18 100644
--- a/drivers/media/tuners/mxl5005s.c
+++ b/drivers/media/tuners/mxl5005s.c
@@ -3414,9 +3414,8 @@ static u16 MXL_ControlWrite_Group(struct dvb_frontend *fe, u16 controlNum,
 	u32 value, u16 controlGroup)
 {
 	struct mxl5005s_state *state = fe->tuner_priv;
-	u16 i, j, k;
+	u16 i, j;
 	u32 highLimit;
-	u32 ctrlVal;
 
 	if (controlGroup == 1) /* Initial Control */ {
 
@@ -3432,9 +3431,6 @@ static u16 MXL_ControlWrite_Group(struct dvb_frontend *fe, u16 controlNum,
 							(u8)(state->Init_Ctrl[i].bit[j]),
 							(u8)((value>>j) & 0x01));
 					}
-					ctrlVal = 0;
-					for (k = 0; k < state->Init_Ctrl[i].size; k++)
-						ctrlVal += state->Init_Ctrl[i].val[k] * (1 << k);
 				} else
 					return -1;
 			}
@@ -3454,9 +3450,6 @@ static u16 MXL_ControlWrite_Group(struct dvb_frontend *fe, u16 controlNum,
 							(u8)(state->CH_Ctrl[i].bit[j]),
 							(u8)((value>>j) & 0x01));
 					}
-					ctrlVal = 0;
-					for (k = 0; k < state->CH_Ctrl[i].size; k++)
-						ctrlVal += state->CH_Ctrl[i].val[k] * (1 << k);
 				} else
 					return -1;
 			}
@@ -3477,11 +3470,6 @@ static u16 MXL_ControlWrite_Group(struct dvb_frontend *fe, u16 controlNum,
 							(u8)(state->MXL_Ctrl[i].bit[j]),
 							(u8)((value>>j) & 0x01));
 					}
-					ctrlVal = 0;
-					for (k = 0; k < state->MXL_Ctrl[i].size; k++)
-						ctrlVal += state->
-							MXL_Ctrl[i].val[k] *
-							(1 << k);
 				} else
 					return -1;
 			}
-- 
2.33.1


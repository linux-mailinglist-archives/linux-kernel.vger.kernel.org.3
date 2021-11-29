Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319544611D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 11:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbhK2KMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 05:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbhK2KJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 05:09:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F0C0698CC;
        Mon, 29 Nov 2021 01:47:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C80B5B80E62;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD25C53FD0;
        Mon, 29 Nov 2021 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179276;
        bh=Dl4PsWpdjqElHMy7Xe1wnMBXy8V8aqd1CbbHT17BCQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYOcXgDdgiySXP6eKKtxNnCx3F+qo8nNXnc3y8vqzZR4Ev+D+vBFHVqpyYfp3xxt7
         JcwFNrWTH2VWQHd79Adu2pPgVxcU/IbYvaUGIqtXCk5d61eHhC5Bc1ek+of+Yo5LvW
         zZLOxHvAfovhoR5r/TiHB/MnzSaPdwx5tvOEWldJfvty3WRi1AP5rNt3/q8/GNDlCL
         Ct0e/WAKDfBnTakiopIfBToqrsQFsNzPmRu8Mym7ZDpCHvLLV4ZMvoAjpH6YCwCZBA
         rHxdYVSPaI+m7S+C0GqKwoSfcLY8M4RmH71D6PbsAvvW8b4tcWt1UhA5ZR7KWFEBHD
         M+Zuu0fhnXInQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGM-000RB8-90; Mon, 29 Nov 2021 10:47:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH v2 04/20] media: drxd: drop offset var from DownloadMicrocode()
Date:   Mon, 29 Nov 2021 10:47:36 +0100
Message-Id: <54a313c07f938258eba9038031b3bd4fb64712c0.1638179135.git.mchehab+huawei@kernel.org>
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

The offset is not needed, and it is never used, as the pointer
itself is already incremented.

So, drop it, in order to solve a W=1 clang warning.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/dvb-frontends/drxd_hard.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/dvb-frontends/drxd_hard.c b/drivers/media/dvb-frontends/drxd_hard.c
index a7eb81df88c2..9860cae65f1c 100644
--- a/drivers/media/dvb-frontends/drxd_hard.c
+++ b/drivers/media/dvb-frontends/drxd_hard.c
@@ -914,44 +914,36 @@ static int DownloadMicrocode(struct drxd_state *state,
 	u32 Address;
 	u16 nBlocks;
 	u16 BlockSize;
-	u32 offset = 0;
 	int i, status = 0;
 
 	pSrc = (u8 *) pMCImage;
 	/* We're not using Flags */
 	/* Flags = (pSrc[0] << 8) | pSrc[1]; */
 	pSrc += sizeof(u16);
-	offset += sizeof(u16);
 	nBlocks = (pSrc[0] << 8) | pSrc[1];
 	pSrc += sizeof(u16);
-	offset += sizeof(u16);
 
 	for (i = 0; i < nBlocks; i++) {
 		Address = (pSrc[0] << 24) | (pSrc[1] << 16) |
 		    (pSrc[2] << 8) | pSrc[3];
 		pSrc += sizeof(u32);
-		offset += sizeof(u32);
 
 		BlockSize = ((pSrc[0] << 8) | pSrc[1]) * sizeof(u16);
 		pSrc += sizeof(u16);
-		offset += sizeof(u16);
 
 		/* We're not using Flags */
 		/* u16 Flags = (pSrc[0] << 8) | pSrc[1]; */
 		pSrc += sizeof(u16);
-		offset += sizeof(u16);
 
 		/* We're not using BlockCRC */
 		/* u16 BlockCRC = (pSrc[0] << 8) | pSrc[1]; */
 		pSrc += sizeof(u16);
-		offset += sizeof(u16);
 
 		status = WriteBlock(state, Address, BlockSize,
 				    pSrc, DRX_I2C_CLEARCRC);
 		if (status < 0)
 			break;
 		pSrc += BlockSize;
-		offset += BlockSize;
 	}
 
 	return status;
-- 
2.33.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1FC461163
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347961AbhK2Jxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:53:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53506 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245374AbhK2JvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:51:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA8A612AB;
        Mon, 29 Nov 2021 09:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAC5C8CFCA;
        Mon, 29 Nov 2021 09:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638179277;
        bh=PZc8s3X7+3Fvl9dhdA2WhkbH6WBiqlNGKDPhzYrtWIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzv6b49Jr4kuLZ6+ooSy3BfBoTQunFcJjbBAWSec5tyFqV0ZSCu84wS3RKWJpnEP9
         AR3OCgpIggV/0Sr2tkWchkhheEFuQOpOBFrArIDDBlTYqRcGWfM22mP8/bJeObiy/T
         gjGKGseU83VL/D1cKOHd/D+rdFXLU7AlqxfHi3S7GmfuHCLL6wotZLHy2VnTVb7jv7
         /YoAVBvNtmc8GKfXCNOSNFo9si5UVDh2V524NtAU4wc1vMFSi/utB3nq6DY6UxBUS1
         PzuNt2Z0fRF/30rz/HMwuGgtwKNnn/JJvYpvr3WM2NQyFLeh7GHLsIQW3EbHJ7D4UQ
         FEHb9UzajIiUA==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrdGN-000RC6-2W; Mon, 29 Nov 2021 10:47:55 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 19/20] media: cobalt: drop an unused variable
Date:   Mon, 29 Nov 2021 10:47:51 +0100
Message-Id: <22f9904099e3dfd1d245c45a125392b549e142d8.1638179135.git.mchehab+huawei@kernel.org>
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

The clock_control value is read but never actually used. Based on
a comment at the code, it has to be reset at the function.

So, drop the variable that stores its value.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH v2 00/20] at: https://lore.kernel.org/all/cover.1638179135.git.mchehab+huawei@kernel.org/

 drivers/media/pci/cobalt/cobalt-cpld.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/pci/cobalt/cobalt-cpld.c b/drivers/media/pci/cobalt/cobalt-cpld.c
index 3d8026483ac3..fad882459d23 100644
--- a/drivers/media/pci/cobalt/cobalt-cpld.c
+++ b/drivers/media/pci/cobalt/cobalt-cpld.c
@@ -236,7 +236,6 @@ bool cobalt_cpld_set_freq(struct cobalt *cobalt, unsigned f_out)
 	u8 n1, hsdiv;
 	u8 regs[6];
 	int found = 0;
-	u16 clock_ctrl;
 	int retries = 3;
 
 	for (i = 0; i < ARRAY_SIZE(multipliers); i++) {
@@ -260,9 +259,7 @@ bool cobalt_cpld_set_freq(struct cobalt *cobalt, unsigned f_out)
 	hsdiv = multipliers[i_best].hsdiv - 4;
 	rfreq = div_u64(dco << 28, f_xtal);
 
-	clock_ctrl = cpld_read(cobalt, SI570_CLOCK_CTRL);
-	clock_ctrl |= S01755_REG_CLOCK_CTRL_BITMAP_CLKHSMA_FPGA_CTRL;
-	clock_ctrl |= S01755_REG_CLOCK_CTRL_BITMAP_CLKHSMA_EN;
+	cpld_read(cobalt, SI570_CLOCK_CTRL);
 
 	regs[0] = (hsdiv << 5) | (n1 >> 2);
 	regs[1] = ((n1 & 0x3) << 6) | (rfreq >> 32);
-- 
2.33.1


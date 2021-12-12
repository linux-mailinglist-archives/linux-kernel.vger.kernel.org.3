Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7037F4718FB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhLLHEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:04:52 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:23364 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229533AbhLLHEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:04:51 -0500
X-QQ-mid: bizesmtp51t1639292666tdc0063s
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 15:04:24 +0800 (CST)
X-QQ-SSF: 01000000002000D0I000B00A0000000
X-QQ-FEAT: NXXopmE8dHbdspMIfiXAad1qP2yuR39QVi2oeQSv3rBI97xxw1I0MtBjMjlyf
        MRiAnfVLGM6nJSVEwt8cBPMifHtaa0vmNkA1uTH2Mu2Kc1NrqN93Y5LMeqf5+lLSRUrHlsz
        CX/FBs3/s0+oDsZfpq0340fvGQ8HC+0BQXHHoUFEA/Nxb9Zqnj+diTjVYvAs9GHRxnMNh1M
        Lvm7WOPaIipL62z8eC7CM6Vu3M9lDBMxHa5ZcFODcairpJvgss8Hnc2shzhCQA9HiHS87qK
        XiAG65hzRWTiIanrdp/R+O+ANsIOczrzvnmvphx7JQh31AU/Vikm2YJDRPm1DswLcqn6uXs
        9YFY2a7QlT8qCDENnirsjYjpfOfAYGQKWRTY8kvKgaTzZ+kNGU=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, leon@kernel.org, wangborong@cdjrlc.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: sparc: no need to initialise statics to 0
Date:   Sun, 12 Dec 2021 15:04:22 +0800
Message-Id: <20211212070422.281924-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static variables do not need to be initialised to 0, because compiler
will initialise all uninitialised statics to 0. Thus, remove the
unneeded initializations.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 sound/sparc/dbri.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 6b84f66e4af4..3881e1c1b08a 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -688,7 +688,7 @@ static void dbri_cmdsend(struct snd_dbri *dbri, s32 *cmd, int len)
 {
 	u32 dvma_addr = (u32)dbri->dma_dvma;
 	s32 tmp, addr;
-	static int wait_id = 0;
+	static int wait_id;
 
 	wait_id++;
 	wait_id &= 0xffff;	/* restrict it to a 16 bit counter. */
@@ -1926,7 +1926,7 @@ static void dbri_process_interrupt_buffer(struct snd_dbri *dbri)
 static irqreturn_t snd_dbri_interrupt(int irq, void *dev_id)
 {
 	struct snd_dbri *dbri = dev_id;
-	static int errcnt = 0;
+	static int errcnt;
 	int x;
 
 	if (dbri == NULL)
@@ -2591,7 +2591,7 @@ static int dbri_probe(struct platform_device *op)
 	struct snd_dbri *dbri;
 	struct resource *rp;
 	struct snd_card *card;
-	static int dev = 0;
+	static int dev;
 	int irq;
 	int err;
 
-- 
2.34.1


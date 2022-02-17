Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9285A4BA2CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241837AbiBQOVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:21:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbiBQOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:21:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD332B1659;
        Thu, 17 Feb 2022 06:21:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D3472110B;
        Thu, 17 Feb 2022 14:21:20 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6F65CA3B84;
        Thu, 17 Feb 2022 14:21:20 +0000 (UTC)
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: sibyte: Add missing __user annotations in sb_tbprof.c
Date:   Thu, 17 Feb 2022 15:21:17 +0100
Message-Id: <20220217142117.107976-1-tsbogend@alpha.franken.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing __user annotations to fix sparse errors.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---
 arch/mips/sibyte/common/sb_tbprof.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/sibyte/common/sb_tbprof.c b/arch/mips/sibyte/common/sb_tbprof.c
index f80d7a710333..bc47681e825a 100644
--- a/arch/mips/sibyte/common/sb_tbprof.c
+++ b/arch/mips/sibyte/common/sb_tbprof.c
@@ -437,13 +437,13 @@ static int sbprof_tb_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t sbprof_tb_read(struct file *filp, char *buf,
+static ssize_t sbprof_tb_read(struct file *filp, char __user *buf,
 			      size_t size, loff_t *offp)
 {
 	int cur_sample, sample_off, cur_count, sample_left;
 	char *src;
 	int   count   =	 0;
-	char *dest    =	 buf;
+	char __user *dest    =	 buf;
 	long  cur_off = *offp;
 
 	if (!access_ok(buf, size))
@@ -512,7 +512,7 @@ static long sbprof_tb_ioctl(struct file *filp,
 		if (err)
 			break;
 
-		err = put_user(TB_FULL, (int *) arg);
+		err = put_user(TB_FULL, (int __user *) arg);
 		break;
 	}
 
-- 
2.29.2


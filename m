Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5735E48BC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347635AbiALBRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:17:04 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:37767 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347624AbiALBRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:17:02 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V1c8Chh_1641950209;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1c8Chh_1641950209)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 12 Jan 2022 09:16:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] scsi: message: fusion: Fix returned errno code
Date:   Wed, 12 Jan 2022 09:16:48 +0800
Message-Id: <20220112011648.110287-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers of initChainBuffers() and PrimeIocFifos() only
cares about gross success/failure, but we still might as well
resolve the following smatch warnings and fix the other error
paths as well:

drivers/message/fusion/mptbase.c:4330 initChainBuffers() warn: returning
-1 instead of -ENOMEM is sloppy
drivers/message/fusion/mptbase.c:4404 initChainBuffers() warn: returning
-1 instead of -ENOMEM is sloppy

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/message/fusion/mptbase.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index e90adfa57950..2c6ebc324bf8 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -4327,14 +4327,14 @@ initChainBuffers(MPT_ADAPTER *ioc)
 		sz = ioc->req_depth * sizeof(int);
 		mem = kmalloc(sz, GFP_ATOMIC);
 		if (mem == NULL)
-			return -1;
+			return -ENOMEM;
 
 		ioc->ReqToChain = (int *) mem;
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "ReqToChain alloc  @ %p, sz=%d bytes\n",
 			 	ioc->name, mem, sz));
 		mem = kmalloc(sz, GFP_ATOMIC);
 		if (mem == NULL)
-			return -1;
+			return -ENOMEM;
 
 		ioc->RequestNB = (int *) mem;
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "RequestNB alloc  @ %p, sz=%d bytes\n",
@@ -4401,7 +4401,7 @@ initChainBuffers(MPT_ADAPTER *ioc)
 	if (ioc->ChainToChain == NULL) {
 		mem = kmalloc(sz, GFP_ATOMIC);
 		if (mem == NULL)
-			return -1;
+			return -ENOMEM;
 
 		ioc->ChainToChain = (int *) mem;
 		dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "ChainToChain alloc @ %p, sz=%d bytes\n",
@@ -4440,7 +4440,7 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 
 	if (ioc->reply_frames == NULL) {
 		if ( (num_chain = initChainBuffers(ioc)) < 0)
-			return -1;
+			return -ENOMEM;
 		/*
 		 * 1078 errata workaround for the 36GB limitation
 		 */
-- 
2.20.1.7.g153144c


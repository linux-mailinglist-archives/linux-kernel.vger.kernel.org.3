Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528524AB8E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbiBGKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbiBGKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:14 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EE1C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V3oaIP1_1644229903;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V3oaIP1_1644229903)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 18:33:10 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     abbotti@mev.co.uk
Cc:     hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] comedi: remove useless else if
Date:   Mon,  7 Feb 2022 18:31:41 +0800
Message-Id: <20220207103141.100004-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow coccicheck warning:

./drivers/comedi/drivers/das1800.c:1300:8-10: WARNING: possible
condition with no effect (if == else).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/comedi/drivers/das1800.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/comedi/drivers/das1800.c b/drivers/comedi/drivers/das1800.c
index f09608c0f4ff..c4b6c68f3551 100644
--- a/drivers/comedi/drivers/das1800.c
+++ b/drivers/comedi/drivers/das1800.c
@@ -1297,14 +1297,13 @@ static int das1800_attach(struct comedi_device *dev,
 			outb(DAC(i), dev->iobase + DAS1800_SELECT);
 			outw(0, dev->iobase + DAS1800_DAC);
 		}
-	} else if (board->id == DAS1800_ID_AO) {
+	} else {
 		/*
+		 * the branch includes (board->id == DAS1800_ID_AO).
 		 * 'ao' boards have waveform analog outputs that are not
 		 * currently supported.
 		 */
 		s->type		= COMEDI_SUBD_UNUSED;
-	} else {
-		s->type		= COMEDI_SUBD_UNUSED;
 	}
 
 	/* Digital Input subdevice */
-- 
2.20.1.7.g153144c


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367E057BE96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbiGTTcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGTTcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:32:05 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5064C60F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:31:59 -0700 (PDT)
X-QQ-mid: bizesmtp79t1658345371tlldvzkb
Received: from harry-jrlc.. ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 21 Jul 2022 03:29:18 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000000
X-QQ-FEAT: eSZ1CZgv+JBwvEJ1SHKfm2QxE6P9LIKgQPgHFaX8SnIXr7PdBiCjAqywFYKH9
        5WJF1aFA230+piHtPRcekobU+PYuyQ66GnB/iD/wJuY/kbGKAlUoGKCYSYu0QJwD1Q+KEv2
        uhHAc6X8g/fqgAxWBe8FH4chjmdi7MCVwDoUT3CVsbDJLDFS+Ul/7v9bMc32vaPv7IbcveF
        H9uejwoAf/IuA2vlqcv9RIGxS5DpRnmjlsSWSuQ+1uQf+49R26mLvTrXbMKhnbC+Flbwpgn
        51mgo0dTxndmGlYxSfj72UCy28mgljsla1jA2Gtzidl7am+KJNw+KDWh2qVW/np5srFUxSn
        fUdW26oPB5uYIQulB1PJ8Wu+tUHL5ty5v5OPnxtVTIyz+JkRVI=
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     axboe@kernel.dk, martin.petersen@oracle.com,
        hoeppner@linux.ibm.com, kch@nvidia.com,
        frederic.danis@collabora.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] ubd:do not initialise statics to 0.
Date:   Thu, 21 Jul 2022 03:29:16 +0800
Message-Id: <20220720192916.7564-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not initialise statics to 0.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index c4344b67628d..ae2fb671ba72 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1555,7 +1555,7 @@ static void do_io(struct io_thread_req *req, struct io_desc *desc)
 int kernel_fd = -1;
 
 /* Only changed by the io thread. XXX: currently unused. */
-static int io_count = 0;
+static int io_count;
 
 int io_thread(void *arg)
 {
-- 
2.30.2


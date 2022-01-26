Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC449C724
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiAZKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 05:09:57 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:19548 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbiAZKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 05:09:55 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 20QA1cXh035874;
        Wed, 26 Jan 2022 18:01:38 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 18:09:02 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Chen Lin" <chen.lin5@zte.com.cn>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Nikita Yushchenko" <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>
CC:     Neal Liu <neal_liu@aspeedtech.com>, <BMC-SW@aspeedtech.com>
Subject: [PATCH] usb: gadget: mass_storage: add READ_TOC cmd mask check
Date:   Wed, 26 Jan 2022 18:08:56 +0800
Message-ID: <20220126100856.3680716-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 20QA1cXh035874
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

READ_TOC cmnd[2] specifies Format Field which is defined
in SCSI-3 spec. Add command mask to avoid marking this
sense data as invalid.

Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 46dd11dcb3a8..14d51695b8ae 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -1944,7 +1944,7 @@ static int do_scsi_command(struct fsg_common *common)
 		common->data_size_from_cmnd =
 			get_unaligned_be16(&common->cmnd[7]);
 		reply = check_command(common, 10, DATA_DIR_TO_HOST,
-				      (7<<6) | (1<<1), 1,
+				      (7<<6) | (1<<1) | (1<<2), 1,
 				      "READ TOC");
 		if (reply == 0)
 			reply = do_read_toc(common, bh);
-- 
2.25.1


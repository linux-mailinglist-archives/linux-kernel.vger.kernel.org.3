Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5455C417
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243040AbiF1CRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 22:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbiF1CRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:17:14 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC623146;
        Mon, 27 Jun 2022 19:17:06 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 25S1wfO2055689;
        Tue, 28 Jun 2022 09:58:41 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Jun
 2022 10:14:40 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: [PATCH v3] usb: gadget: f_mass_storage: Make CD-ROM emulation works with Windows OS
Date:   Tue, 28 Jun 2022 10:14:36 +0800
Message-ID: <20220628021436.3252262-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 25S1wfO2055689
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add read TOC with format 1 to support CD-ROM emulation with
Windows OS.
This patch is tested on Windows OS Server 2019.

Fixes: 89ada0fe669a ("usb: gadget: f_mass_storage: Make CD-ROM emulation work
with Mac OS-X")
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
v3:
- ignore start_track value with format 1
- add fixes tags
- revise comments properly

v2:
- revise comments

 drivers/usb/gadget/function/f_mass_storage.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 3a77bca0ebe1..e884f295504f 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -1192,13 +1192,14 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
 	u8		format;
 	int		i, len;
 
+	format = common->cmnd[2] & 0xf;
+
 	if ((common->cmnd[1] & ~0x02) != 0 ||	/* Mask away MSF */
-			start_track > 1) {
+			(start_track > 1 && format != 0x1)) {
 		curlun->sense_data = SS_INVALID_FIELD_IN_CDB;
 		return -EINVAL;
 	}
 
-	format = common->cmnd[2] & 0xf;
 	/*
 	 * Check if CDB is old style SFF-8020i
 	 * i.e. format is in 2 MSBs of byte 9
@@ -1208,8 +1209,8 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
 		format = (common->cmnd[9] >> 6) & 0x3;
 
 	switch (format) {
-	case 0:
-		/* Formatted TOC */
+	case 0:	/* Formatted TOC */
+	case 1:	/* Multi-session info */
 		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
 		memset(buf, 0, len);
 		buf[1] = len - 2;	/* TOC Length excludes length field */
@@ -1250,7 +1251,7 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
 		return len;
 
 	default:
-		/* Multi-session, PMA, ATIP, CD-TEXT not supported/required */
+		/* PMA, ATIP, CD-TEXT not supported/required */
 		curlun->sense_data = SS_INVALID_FIELD_IN_CDB;
 		return -EINVAL;
 	}
-- 
2.25.1


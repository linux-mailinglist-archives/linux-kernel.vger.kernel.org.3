Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1F5A5E69
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiH3Inu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiH3Inj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:43:39 -0400
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D9A5735;
        Tue, 30 Aug 2022 01:43:34 -0700 (PDT)
X-UUID: a1eacdbadf364491962084fe0678a21c-20220830
X-CPASD-INFO: 5c614a9c99bb432ebf4fe4b30a3a12d8@frNwUWGTZ5NlWaSug3Z9n4KXZJaVYIK
        CcptTkV9ikFiVhH5xTV5uYFV9fWtVYV9dYVR6eGxQYmBgZFJ4i3-XblBgXoZgUZB3hKVwUWSPaQ==
X-CLOUD-ID: 5c614a9c99bb432ebf4fe4b30a3a12d8
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:173.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:102.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:2,DUF:3567,ACD:65,DCD:65,SL:0,EISP:0,AG:0,CFC:0.338,CFSR:0.081,UAT:0,RA
        F:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,E
        AF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: a1eacdbadf364491962084fe0678a21c-20220830
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: a1eacdbadf364491962084fe0678a21c-20220830
X-User: huxiaoying@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <huxiaoying@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2131062562; Tue, 30 Aug 2022 16:43:47 +0800
From:   Hu Xiaoying <huxiaoying@kylinos.cn>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Hu Xiaoying <huxiaoying@kylinos.cn>,
        Hu Xiaoying <huxiaoying@gmail.com>
Subject: [PATCH] usb: Improves USB2.0 write performance
Date:   Tue, 30 Aug 2022 16:43:25 +0800
Message-Id: <20220830084325.752655-1-huxiaoying@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,KHOP_HELO_FCRDNS,RDNS_DYNAMIC,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB external storage device(0x0b05:1932), use gnome-disk-utility tools
to test usb write  < 30MB/s. if does not to load module of uas for this device
, can increase the write speed from 20MB/s to more than 40MB/s.

Signed-off-by: Hu Xiaoying <huxiaoying@gmail.com>
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 4051c8cd0cd8..3925c7c67915 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -62,6 +62,13 @@ UNUSUAL_DEV(0x0984, 0x0301, 0x0128, 0x0128,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_IGNORE_UAS),
 
+/* Reported-by: Tom Hu <huxiaoying@gmail.com> */
+UNUSUAL_DEV(0x0b05, 0x1932, 0x0000, 0x9999,
+		"ASUS",
+		"External HDD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_UAS),
+
 /* Reported-by: David Webb <djw@noc.ac.uk> */
 UNUSUAL_DEV(0x0bc2, 0x331a, 0x0000, 0x9999,
 		"Seagate",
-- 
2.25.1


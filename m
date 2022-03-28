Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5B84EA1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 22:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346129AbiC1UsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345695AbiC1Un2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 16:43:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46A66AF9;
        Mon, 28 Mar 2022 13:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65F65B81219;
        Mon, 28 Mar 2022 20:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD95DC36AE2;
        Mon, 28 Mar 2022 20:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648500102;
        bh=QzQoNs68jW+xI6V/AO2/hYHoODXE7W40VrXyZsKu0h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBNGwfhiLKxRrZbiDzg4Oqg/CqeVhvgp8WmqmRoljNmqbl7G7r/I6kYfRl88Aq/zU
         TVJ76WDdsIP6ZKXKdC4ajI4JwokvyuaBtG6bXaAxifP1jytue4dXNo+IasGsd4STD6
         7ntLHLuhbWjv8WLYC7jK35oS27kVY0zh9axBAQ04ZMH1Vi2t9q0JayIhty06As5cfd
         LyDXZuZZSHbNq7EQW9gJwr0x/dfproYjmH3xfNAT/qn2VZdQXwzvHN7Q/bpLJCvT4x
         1gYuN+oKYjhFqJSOAm0FVYu0+ctt3tmG6lnA/rQ89jouoAH48xpiXmfFsQytAsjiwg
         /9JNfpP6eIItw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nYwBI-000lca-F4; Mon, 28 Mar 2022 22:41:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 12/26] media: dtv5100: use the newer dvb-usb macros for USB device
Date:   Mon, 28 Mar 2022 22:41:24 +0200
Message-Id: <6e7183735aacf33fff86bc709a38aafb6b858dff.1648499509.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648499509.git.mchehab@kernel.org>
References: <cover.1648499509.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the drivers under dvb-usb more homogeneous,
use the new macro.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 00/26] at: https://lore.kernel.org/all/cover.1648499509.git.mchehab@kernel.org/

 drivers/media/usb/dvb-usb/dtv5100.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dtv5100.c b/drivers/media/usb/dvb-usb/dtv5100.c
index b644c1302c84..56c9d521a34a 100644
--- a/drivers/media/usb/dvb-usb/dtv5100.c
+++ b/drivers/media/usb/dvb-usb/dtv5100.c
@@ -162,10 +162,15 @@ static int dtv5100_probe(struct usb_interface *intf,
 	return 0;
 }
 
+enum {
+	AME_DTV5100,
+};
+
 static struct usb_device_id dtv5100_table[] = {
-	{ USB_DEVICE(USB_VID_AME, USB_PID_AME_DTV5100) },
-	{ }		/* Terminating entry */
+	DVB_USB_DEV(AME, AME_DTV5100),
+	{ }
 };
+
 MODULE_DEVICE_TABLE(usb, dtv5100_table);
 
 static struct dvb_usb_device_properties dtv5100_properties = {
@@ -201,7 +206,7 @@ static struct dvb_usb_device_properties dtv5100_properties = {
 		{
 			.name = "AME DTV-5100 USB2.0 DVB-T",
 			.cold_ids = { NULL },
-			.warm_ids = { &dtv5100_table[0], NULL },
+			.warm_ids = { &dtv5100_table[AME_DTV5100], NULL },
 		},
 	}
 };
-- 
2.35.1


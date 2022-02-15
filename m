Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809154B6387
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiBOGcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:32:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbiBOGcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:32:47 -0500
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139CEAF1E8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 22:32:37 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id JrO7noYGWi9Q8JrO7nCM26; Tue, 15 Feb 2022 07:32:36 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 15 Feb 2022 07:32:36 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: Use GFP_KERNEL instead of GFP_ATOMIC in non-atomic context
Date:   Tue, 15 Feb 2022 07:32:34 +0100
Message-Id: <eccb2179ce800529851ed4fabc9d3f95fbbf7d7f.1644906731.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few lines below this kzalloc() we have a mutex_lock() which can
sleep.

More over, the only way to call this function is when a delayed work is
schedule. And delayed work can sleep.
  INIT_DELAYED_WORK(&fw_event->work, mptsas_firmware_event_work);
    --> mptsas_firmware_event_work()
      --> mptsas_send_link_status_event()
        --> mptsas_expander_add()

So there is really no good reason to use GFP_ATOMIC here. Change it to
GFP_KERNEL to give more opportunities to the kernel.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/message/fusion/mptsas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 4acd8f9a48e1..34901bcd1ce8 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -3680,7 +3680,7 @@ mptsas_expander_add(MPT_ADAPTER *ioc, u16 handle)
 	    MPI_SAS_EXPAND_PGAD_FORM_SHIFT), handle)))
 		return NULL;
 
-	port_info = kzalloc(sizeof(struct mptsas_portinfo), GFP_ATOMIC);
+	port_info = kzalloc(sizeof(struct mptsas_portinfo), GFP_KERNEL);
 	if (!port_info) {
 		dfailprintk(ioc, printk(MYIOC_s_ERR_FMT
 		"%s: exit at line=%d\n", ioc->name,
-- 
2.32.0


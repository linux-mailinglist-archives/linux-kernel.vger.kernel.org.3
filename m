Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9894F5ED7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiDFNDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiDFNCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:02:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DABC141456;
        Wed,  6 Apr 2022 02:27:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so3038278lfa.6;
        Wed, 06 Apr 2022 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3IQ7CoZ6vlav2yUsjjiGW1nzTDdZ4wf2eol2IE81cQ=;
        b=VBZ7KQ/NZDgWKsyvuVHZCw6NEKu2hgdV+Xk4R1wwE2jCwieAxP/SKuN3X0c8YofH8f
         tJmrZO7ssCkesBW6AnVxtRRLKBg8f3aKHvtZNpjSSPLrn27GceasbmCIBYY/dUNZ6ReL
         6dhOM1SWbJ3TxxDwIn15J8WJjI+MtFCdFRyL/czvfgtKV+/kEcG+X/q5m4DNSijPdFlu
         lnUdYWj4gDJy3N1370tOYnR0FlFGDlt4XdC1Kiox1yheVMTnK1VoZgQXYUXaoTRavptG
         WWuVwGiBHB4NvX8IZdzXsVHWQxpbAPPSk93IdG9BjpbmuVm80m6lr3Gwm8uuDVtPVOny
         k8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m3IQ7CoZ6vlav2yUsjjiGW1nzTDdZ4wf2eol2IE81cQ=;
        b=vKMeuJB78EjbtIqbZ2mZNWfX3x5NjhtUUB2xZSTxHthn7PHpw9naFgXxI04+M0aVjn
         twkdNxtF+YTBnzvIpvoKb0NiYGnhp66iAejdoveyx8RfxPassA7Sac0pxu/OrO92N7o2
         QNgrMcYSPc3bJSKMN15M/LMit74z1NXlg3dvJ7142gmxcsSsPVo7N+IKAcZ286VfDxds
         OaVvf2hHUXsWlqqsa7MdpB21EutnK+t0E01AyuQ58M2XlUUeGcCsaXaTxLR5J4LszCn3
         g4+0I9+WsCFlfIfBfV44HSAJ7uwYJ0GM4yQ0M7QLbLZH9x2VKD2W/xQoOH0M5B0SzhrE
         GpGw==
X-Gm-Message-State: AOAM532gGLhNo1o5H2XW6SB1drGb8ceUIDImgrx2PN0blosd4IVh8UZc
        CrJ4li9wx974YSHVko2MRjSggv0k33fb5oqy
X-Google-Smtp-Source: ABdhPJxz0CiarLexgsE9kHwbeL5jl5eAo9sOJTTGGKFBmvBW9mOs2pCfQBQ35/Sz6sZFoPlUKfpRPQ==
X-Received: by 2002:a05:6512:3b06:b0:44a:5bbc:4d2 with SMTP id f6-20020a0565123b0600b0044a5bbc04d2mr5463156lfv.571.1649237266379;
        Wed, 06 Apr 2022 02:27:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-95-84-198-152.ip.moscow.rt.ru. [95.84.198.152])
        by smtp.gmail.com with ESMTPSA id r23-20020a2e94d7000000b0024b1565bba8sm988627ljh.118.2022.04.06.02.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 02:27:45 -0700 (PDT)
From:   Maxim Devaev <mdevaev@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     mdevaev@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: f_mass_storage: break IO operations via configfs
Date:   Wed,  6 Apr 2022 12:24:45 +0300
Message-Id: <20220406092445.215288-1-mdevaev@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the SIGUSR1 signal sent to the "file-storage" thread
from the userspace, it is possible to break IO operations
that block the gadget. Thus, it is possible to implement
"force eject" without stopping the gadget and umounting
it from the host side.

There are two problems here:

  - In order to send a signal, we need to find the thread
    in procfs, but if several mass storage gadgets are created
    in the system, each process has the same name and it is
    impossible to distinguish one gadget from another.

  - Root privileges are required to send the signal.

The proposed "break_io" interface solves both problems.
It allows us to get rid of the procfs search and delegate
sending the signal to a regular user.

Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 6ad669dde41c..e9b7c59e1dc4 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -3239,6 +3239,27 @@ static ssize_t fsg_opts_stall_store(struct config_item *item, const char *page,
 
 CONFIGFS_ATTR(fsg_opts_, stall);
 
+static ssize_t fsg_opts_break_io_store(struct config_item *item,
+				       const char *page, size_t len)
+{
+	struct fsg_opts *opts = to_fsg_opts(item);
+	unsigned long flags;
+
+	mutex_lock(&opts->lock);
+	spin_lock_irqsave(&opts->common->lock, flags);
+
+	if (opts->common->thread_task)
+		send_sig_info(SIGUSR1, SEND_SIG_PRIV,
+			      opts->common->thread_task);
+
+	spin_unlock_irqrestore(&opts->common->lock, flags);
+	mutex_unlock(&opts->lock);
+
+	return len;
+}
+
+CONFIGFS_ATTR_WO(fsg_opts_, break_io);
+
 #ifdef CONFIG_USB_GADGET_DEBUG_FILES
 static ssize_t fsg_opts_num_buffers_show(struct config_item *item, char *page)
 {
@@ -3283,6 +3304,7 @@ CONFIGFS_ATTR(fsg_opts_, num_buffers);
 
 static struct configfs_attribute *fsg_attrs[] = {
 	&fsg_opts_attr_stall,
+	&fsg_opts_attr_break_io,
 #ifdef CONFIG_USB_GADGET_DEBUG_FILES
 	&fsg_opts_attr_num_buffers,
 #endif
-- 
2.35.1


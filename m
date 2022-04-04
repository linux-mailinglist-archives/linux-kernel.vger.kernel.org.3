Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1314F114E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241820AbiDDIuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243582AbiDDIt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:56 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F01C30F64;
        Mon,  4 Apr 2022 01:48:00 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o10so1663403ple.7;
        Mon, 04 Apr 2022 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsQsOGOBswiqIkfE+MmZmSYrrU64sgPI4cLq7rNPZkk=;
        b=b4c7KmBW0dluWZGhagtxX35zeboI86n00qjpygwNWb4mr9DaRZ6+hVK0lwlf8CRknM
         knRly/iSX7myVM4yjqVn9+5Uhrp+Vd9NDBC9jeUSfKfGic+DoUDOwQVqCgZKUxY4t30s
         S6co9ns78h8EOSuPT5AW8xTNGw0kx1dbO/fN703kgdlfd9EpmDl6na6IHiv77Z6ogI8H
         BfBso/WnyYdmflfwlALETgTAH7sMrjnWUAcl9+bTz9wrqXAWCSYTIFxvt91ZxjwL7m0q
         04g+YjOhsvC6gzJ7L91krIz8eBRXNArQZXmByvOfA/8CUOj9Ct224O1V/oXSr5Xj6gJ6
         EcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsQsOGOBswiqIkfE+MmZmSYrrU64sgPI4cLq7rNPZkk=;
        b=PGE67l69uFiC3DwMREm0HDuYgn3dcZkoQ/nbe+SwrJyS4PLSFuXfKeKvCt9Hw8w0yV
         GzaoSbu2abJ2tBxXDVj9qrbeTTQnIAtAd/tNpdjbTE4t6QBviS2+4TY9anreCWtiAm2x
         HgbnK3BEyXYuPV9WjA43Z7HPan28s0XIEwgUCqhBb01NuWWMV1klltEczwaJlarzYXz9
         pKkzsAysNJbvV0QXs2MlvahjTtLJGXDgoOngJLfd2Rw+O3N/IaDi6SnbHnqBq2UU9+Nr
         eBkYCf7OvjGjYPnjLHlMcZ5K9b2tPmfzeB753+E2FQDY28JVzPwn7iK009BNyCZ12rvU
         D9Vg==
X-Gm-Message-State: AOAM5321pPgV+RsaPG3q4bci2+jgDIemhlXtCXgUY9uiQNIptmWzmTsg
        CftVhF7UdJIakooz6TXI2rD9hHl2L4tMMDMysQ==
X-Google-Smtp-Source: ABdhPJyaumC2pAoaVZdgGxH0C6+k3h97CLv5+0nGYCnk+CTU9mYZSDQ8odzFEQgW1zPAVxACmLujOw==
X-Received: by 2002:a17:902:8f94:b0:14f:d9b3:52c2 with SMTP id z20-20020a1709028f9400b0014fd9b352c2mr21780055plo.103.1649062080299;
        Mon, 04 Apr 2022 01:48:00 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:48:00 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 6/7] video: fbdev: arkfb: Error out if 'pixclock' equals zero
Date:   Mon,  4 Apr 2022 16:47:22 +0800
Message-Id: <20220404084723.79089-7-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404084723.79089-1-zheyuma97@gmail.com>
References: <20220404084723.79089-1-zheyuma97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace program could pass any values to the driver through
ioctl() interface. If the driver doesn't check the value of 'pixclock',
it may cause divide error.

Fix this by checking whether 'pixclock' is zero.

The following log reveals it:

[   76.603696] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   76.603712] RIP: 0010:arkfb_set_par+0x10fc/0x24f0
[   76.603762] Call Trace:
[   76.603764]  <TASK>
[   76.603773]  fb_set_var+0x604/0xeb0
[   76.603827]  do_fb_ioctl+0x234/0x670
[   76.603873]  fb_ioctl+0xdd/0x130
[   76.603881]  do_syscall_64+0x3b/0x90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/arkfb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index edf169d0816e..eb3e47c58c5f 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -566,6 +566,9 @@ static int arkfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	int rv, mem, step;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* Find appropriate format */
 	rv = svga_match_format (arkfb_formats, var, NULL);
 	if (rv < 0)
-- 
2.25.1


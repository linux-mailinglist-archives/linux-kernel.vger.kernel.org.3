Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EC04F1150
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245564AbiDDIug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbiDDItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:49:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109873B540;
        Mon,  4 Apr 2022 01:47:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gt4so2239587pjb.4;
        Mon, 04 Apr 2022 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99A9a3hHeLpuMdZogws2agT3Pd/9V9gAGhJHXsYptTw=;
        b=FEWaJFqHiORNV4n3ITN4hvIxL/s/r/ujDrwxJkvlaNB8kwZiS7A/KFs0C6nSH9Fjj6
         hNV2GTIYaKbOjwploqMSVC3IkiQ05w14dN/RGAB8X+ZUWmFvKEk5sV3bc6Bx758tPqHO
         U2reaV4WrwQFVFhhL69S6ey2NDHe74btKudCdicMuTYguS0WMfO/xMb5nQ9CIifNSOkA
         TMPenuoIkkxwusMIeBOg0m7n7IG3XCVpVwQtNJBYiCUz+ujG6hh/6zX8ne+OduhAujW1
         MmPUHKNB2dDspHO3g9QYl+owLNVEgfl8hubi9rQ1xusjDFxsx1kIdlwZfP//ZNtzqbKA
         M9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99A9a3hHeLpuMdZogws2agT3Pd/9V9gAGhJHXsYptTw=;
        b=e61PPw0t9fu3LPv+vKMQzUD/zjz0UXoB4wE4Blzk9nHQ66C5g7SLrv8whpyYuG12QO
         1fv0SJJRjRL8SKmkyrtbZFUXkMM69L28tvTizptGieWOPCP0ZiYtPcnzjutZ2itbdYWt
         xiv670I6BKbRAjHhJrNJ23VAOycJSB3pNoNWXEAoUSJmEAoLptYlqeSFfW9upLj0HxLt
         TWtOEbLfpITkErbYHooLFrSAWyPYMjq6OjmpwasIZeCUHxZul5w7i190ZEUr/hr351j3
         MLsdRpo3BzG47FYZdRcLJlPVQELVQEY7RcM+hIQd+5ABCtzd9L5XYQh5EfEseLTyxt2Q
         M6tA==
X-Gm-Message-State: AOAM532pGMOuqokwsDgdpPgpEOxUqOC+2/A9t6H0Guvp8Jzk7nQ+BI1L
        uV+C2VEmppdQrSe1sMECQQ==
X-Google-Smtp-Source: ABdhPJzHEpK7iQlUi2JXa05S2CyzF7s2BEpWcpFng5mVwfJfydFQGtfX42aZdvVbPwni/HDOC/K2tw==
X-Received: by 2002:a17:90a:7288:b0:1ca:6e77:84a0 with SMTP id e8-20020a17090a728800b001ca6e7784a0mr9647359pjg.60.1649062075558;
        Mon, 04 Apr 2022 01:47:55 -0700 (PDT)
Received: from localhost.localdomain ([144.202.91.207])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm3991960pjm.13.2022.04.04.01.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:47:55 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH 4/7] video: fbdev: vt8623fb: Error out if 'pixclock' equals zero
Date:   Mon,  4 Apr 2022 16:47:20 +0800
Message-Id: <20220404084723.79089-5-zheyuma97@gmail.com>
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

Fix this by checking whether 'pixclock' is zero in the function
vt8623fb_check_var().

The following log reveals it:

[   47.778727] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   47.778803] RIP: 0010:vt8623fb_set_par+0xecd/0x2210
[   47.778870] Call Trace:
[   47.778872]  <TASK>
[   47.778909]  fb_set_var+0x604/0xeb0
[   47.778995]  do_fb_ioctl+0x234/0x670
[   47.779041]  fb_ioctl+0xdd/0x130
[   47.779048]  do_syscall_64+0x3b/0x90

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/vt8623fb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 7a959e5ba90b..a92a8c670cf0 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -321,6 +321,9 @@ static int vt8623fb_check_var(struct fb_var_screeninfo *var, struct fb_info *inf
 {
 	int rv, mem, step;
 
+	if (!var->pixclock)
+		return -EINVAL;
+
 	/* Find appropriate format */
 	rv = svga_match_format (vt8623fb_formats, var, NULL);
 	if (rv < 0)
-- 
2.25.1


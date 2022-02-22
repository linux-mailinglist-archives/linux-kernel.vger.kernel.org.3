Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D564BF339
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiBVILd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBVILd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:11:33 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319C6151D03
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:11:08 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 12so12841061pgd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=1ewwsYJzbOlGrRg/5LtBaFSLY+YVPW6LvHzITLWMd+M=;
        b=a/XzAzT5Iy3cExR3bLhwAr9dB5ILxwEivpVpU0xEJzXgL71wwn1t5U/+Bhsfxz8URV
         XOUu0laoAJpZga5y2JZgFtY+YbZUU/WRsbhL2RIDkjD5zHob1Y/BhPNtA1g/kCbP0i7j
         TK0OBKV7zPTcV5Dj1wUNa72bYXn/m3V9h6sROKkRMLpQFGB46NopD1URys/3aBMtjNov
         Dbltds12jzJ5CAK6S16cv+Twc1Dwg7DjJXXL13Hqxwb2KcpVHeDtMWu2HWr4pSimxUeg
         JhBxFS9CBznZ2hN532lK2xk19GuyXc1dFtf/6o3JMv2RIcFfP/5+1eXp+OpCPhafV2Vj
         K9qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1ewwsYJzbOlGrRg/5LtBaFSLY+YVPW6LvHzITLWMd+M=;
        b=rYq3wnDTSIhQ33A4500og0cpuglrC8vf8KnC7f6y/LImUxE+cWK24wQZVNtTSkZ0me
         ANMqkwdg33btWU+ye3lnkyA/nBx3dVJN4aQL6MZWfzXMILXBYucBbmh77GiT1gitdYmo
         LD4nhVeDCKtvPe0tqAJ721UhlDTkQmqNKdal9ukbnHqzpJzWFfG29DeLVvRDrD9q24jK
         A2lMLaA2BRcxvimuDRibtyIcYvBCwxXjONVnzfkJ2AFfk+dHBiSjRTuMGfBvNZfInLI7
         B7SIBxCBMbHZAi6sw4ktdQ08dOJrc3GfZvOWFs7tZLK/QIi/81fgNHpmNhx15vnVbTQ7
         bSZA==
X-Gm-Message-State: AOAM532tLj3OX6npVKJvn/v87YbVAyJ55KS2yaaufT5AZnXBOOuQVzuM
        mfOqdLOoyqngKWtCjcklXiQ=
X-Google-Smtp-Source: ABdhPJw6OTUtX6GZj2IzCgZBLnhDm741qs5KZgxLmc3O/+HinVZu03+1uiPRVi0gdPIckuJtxHZ4YA==
X-Received: by 2002:a63:de46:0:b0:364:cad7:bf3b with SMTP id y6-20020a63de46000000b00364cad7bf3bmr18961824pgi.491.1645517467680;
        Tue, 22 Feb 2022 00:11:07 -0800 (PST)
Received: from ubuntu.huawei.com ([119.3.119.21])
        by smtp.googlemail.com with ESMTPSA id w198sm16101185pff.96.2022.02.22.00.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 00:11:07 -0800 (PST)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Date:   Tue, 22 Feb 2022 16:11:01 +0800
Message-Id: <20220222081101.21233-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VT_ACTIVATE an almost identical code path has been patched
with array_index_nospec. In the VT_DISALLOCATE path, the arg is
the user input from a system call argument and lately used as a index
for vc_cons[index].d access, which can be reached through path like
vt_disallocate->vc_busy or vt_disallocate->vc_deallocate.
For consistency both code paths should have the same mitigations
applied. Also, the code style is adjusted as suggested by Jiri.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/vt/vt_ioctl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 580136986..8c685b501 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -898,11 +898,13 @@ int vt_ioctl(struct tty_struct *tty,
 		if (arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 
-		if (arg == 0)
+		if (arg == 0) {
 			vt_disallocate_all();
-		else
-			return vt_disallocate(--arg);
-		break;
+			break;
+		}
+
+		arg = array_index_nospec(arg - 1, MAX_NR_CONSOLES);
+		return vt_disallocate(arg);
 
 	case VT_RESIZE:
 	{
-- 
2.17.1


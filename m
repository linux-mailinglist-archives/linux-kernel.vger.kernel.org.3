Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308EC4BF06C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiBVD5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 22:57:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiBVD5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:57:45 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F53DA69
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:57:13 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 12so12396404pgd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=j/H4mFylDMSEQkCMQZwHR9+6dNYYHfAALzwtqS+CylI=;
        b=i2AnfZi9Fih5yI1l68xvv5yfbuQVfg8MXSYQMTb2MAz0OVTOpbe82gLAMgqiSC1xQD
         g7ZuYC/h3dGfXK2Xrwki37ftjzJJsjk3HqHc3W4kxsqdho8iSb+YomwIcD/XlrxrLvni
         959HEOVxGrt2GjH6fK5rtuPeMOv8gVE6yuBj9A+5kw8gXY0mDSeT++cSJV2E+ajgzW3m
         QjwlyL0WztVBVe2wka22WgAEkhmpADaDjl/3VlbOUxzE2LtIWDzLIXue2ZsOXGoZ846j
         4iQvy883Lqo5XEHjYuOlM7E8+Fn216uha2YulethWqDlCN35Fqwx1tN9otkfByZygcXy
         si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=j/H4mFylDMSEQkCMQZwHR9+6dNYYHfAALzwtqS+CylI=;
        b=cN/VT3iEMQNuRz7fLLpEz4YtBxx25QrNaQ/St45gPSohTVJOwuluDSEQL/8ctIhUXq
         B2w/pDvNRhKC9US8CYNxwO0OfBLwTJEWgozmxWIhHDSMo2RQyIIGWvrTTqBZKDdC/DiK
         bAQZwBBuTUkYlXuzk0oyHK6nK+wDeSEIRpaQkek4eWKfDP/f4sLp40hRRYVhS7tnkYWI
         pKa3q4PUaojwf5EM47RZCF4AqFwCTCZDVENXQQztVb83BWMPE5SPQEq8DTpxpLvVZKNR
         87DGPmdZ3Sh7JOMvEJ79Inhn3xkl1KVOs60uo7d/y+kpwGU/fGKmzgT4LE8okEwpMxm2
         qxIQ==
X-Gm-Message-State: AOAM532G0IamWAk7zFIPfgf+q451bBxPvbNB/Fg6Ug5ra5Av2qBA/Ilk
        Gm/nSkZKLP9NV4xwZ60W+ez74BomoStkJ2yAtq6/RarK
X-Google-Smtp-Source: ABdhPJw/ZrwmxT1Wuw4MRyXHNzwhgKK9xO32PWtjBUYSWzH+QD0sAW3JWp7re2Rez6X6P68g4yo37A==
X-Received: by 2002:aa7:8882:0:b0:4e1:4531:e3c8 with SMTP id z2-20020aa78882000000b004e14531e3c8mr22876753pfe.76.1645502233250;
        Mon, 21 Feb 2022 19:57:13 -0800 (PST)
Received: from ubuntu.huawei.com ([119.3.119.21])
        by smtp.googlemail.com with ESMTPSA id 142sm7912097pge.62.2022.02.21.19.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:57:12 -0800 (PST)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Date:   Tue, 22 Feb 2022 11:56:48 +0800
Message-Id: <20220222035648.17984-1-xiam0nd.tong@gmail.com>
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
applied.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/tty/vt/vt_ioctl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 580136986..acd53c1c9 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -898,10 +898,13 @@ int vt_ioctl(struct tty_struct *tty,
 		if (arg > MAX_NR_CONSOLES)
 			return -ENXIO;
 
-		if (arg == 0)
+		if (arg == 0) {
 			vt_disallocate_all();
-		else
-			return vt_disallocate(--arg);
+		} else {
+			--arg;
+			arg = array_index_nospec(arg, MAX_NR_CONSOLES);
+			return vt_disallocate(arg);
+		}
 		break;
 
 	case VT_RESIZE:
-- 
2.17.1


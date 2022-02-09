Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABE4AED18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiBIItt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:49:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbiBIItp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:49:45 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83314C0043F4;
        Wed,  9 Feb 2022 00:49:40 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id r14so1236176qtt.5;
        Wed, 09 Feb 2022 00:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGdhIE5RG442DELBhFAVFpR6XS4hpzdg4tGBVA8vUWc=;
        b=bBl0GrPApUyp9PKJrzZqGzE2GGrRkM9plAwR+Z3Y3Z5PPbvXHnNUw2sEdQOnDJDa+D
         9t9stRmRhcDGlY0eRoXncTHtpPoAln863IeNlUPtg17MZ0YbAffrmhg3aZTSIQ3+Jmos
         dG6lkh1if7EaNBoMufbF7I/un80y68bwIvmDGmv6ROk9kqKUgJNXCPR7MawgLlmjhs92
         3jOnnd0gszVCokFPZ+VApCt89c+cseXtiU29mWJyqc7PLuUjaWIUwHjv9o2vNCm8WoDc
         +TObwhVnJ60Y9FDSIHwpAhak0qGkLSkUY7qQ/lLkliqg0ORRKF0aIo6aZEIAHSrbxJ+I
         DNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGdhIE5RG442DELBhFAVFpR6XS4hpzdg4tGBVA8vUWc=;
        b=P8BFTgoNyVAwzWQxJQ5EmlY7Yc9267KBXsOeOoaU/TZR7WO2feGuJx9dD4XzIKlDhv
         ExrXdNEdEIos0CRvt8o7QcdqZMP7tPLTZ3sYsz72aC8M1lq9ChuSP2q6sUgtQhbp48P9
         pJQ73wyhsa6h5C4bymVMPW/TzvlG3x9thVcM0aGxjwMfMTPl7MUCtLJ5EvJTBSDbW5jx
         FFCXQF4fcNSWr25W6dmLmtbCUeZUFdeW8QR/Xl0EZ0khoy3h+37wHWNgV9I0rDER8WcU
         1tvEN9h6Fqfhbpt/IQN2QjdagEDmz79UYEShurgbIw2Xciizx5TlHHVg+KUomdb46qJG
         D/pQ==
X-Gm-Message-State: AOAM533qHam5ZsRNPU1bmn7sJ6XXMl60cJ7qUB0R9d6lE7RYFRnSHaDK
        Xy/r6CAMoPa1f79eaSq7ZAY=
X-Google-Smtp-Source: ABdhPJyiOBYIcPBMcHHZfwdm7yELi0V71MeIsgZstO1OYCnrhoVrPiuIYR6gLmFJ5OgCeb24mFuAUw==
X-Received: by 2002:ac8:5a52:: with SMTP id o18mr626863qta.33.1644396501284;
        Wed, 09 Feb 2022 00:48:21 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w13sm7857289qkb.106.2022.02.09.00.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 00:48:20 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     deller@gmx.de
Cc:     daniel.vetter@ffwll.ch, geert@linux-m68k.org, svens@stackframe.org,
        cssk@net-c.es, penguin-kernel@I-love.SAKURA.ne.jp,
        deng.changcheng@zte.com.cn, ducheng2@gmail.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fbcon: use min() to make code cleaner
Date:   Wed,  9 Feb 2022 08:48:10 +0000
Message-Id: <20220209084810.1561184-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use min() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index f36829eeb5a9..61171159fee2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -602,7 +602,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		save = kmalloc(array3_size(logo_lines, new_cols, 2),
 			       GFP_KERNEL);
 		if (save) {
-			int i = cols < new_cols ? cols : new_cols;
+			int i = min(cols, new_cols);
 			scr_memsetw(save, erase, array3_size(logo_lines, new_cols, 2));
 			r = q - step;
 			for (cnt = 0; cnt < logo_lines; cnt++, r += i)
-- 
2.25.1


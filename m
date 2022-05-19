Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8153352D0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236861AbiESKkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 06:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiESKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 06:40:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF5AE25A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:40:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so4851538pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVV1dRw9CXbITFRFAr38oo/Tg0GD/yZ0EddEdw7HELs=;
        b=DNzH6HuorMvOBHr9yxuvuIHtguwSss2h0NhcB901IipyCSG56/vKC4VNhExwsp2ON9
         oyQmliTQlX6QGf7x/cxK6xqnlYnw2IYUTCk3SOmfeICpkwMBee4X/nb7wcDqzePpAB3e
         9ksi0hOqmzy94hGGJNkHHA5gXJoyzvkm1+sGY2xvDm/wSRuDYFRaNE5qc5krz+t2baW/
         VgMx1WomNaiQ7ANz4zFpald6ez5cwo0X+hnCWMd0/QplY5l08hNe/q5bWD++WztmhBlU
         ZcXQ2ReiWszZaGO40nJBTOQDhOnH1L1MfHvdcsqqYZ6T777/dREvW84pff5gm6ZIzYH+
         FxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WVV1dRw9CXbITFRFAr38oo/Tg0GD/yZ0EddEdw7HELs=;
        b=mtkuZJmEaaUwi0DNXhfsYGOwk78a72mfItMUeqXM/4eNPc5ZmUZz2oHCz3EgHo9Zqf
         bfU1XDWv1uJTryBids18IO+7DBsEqPEJGJvxh9SeDKRcJv+ytX56Uw05p2naFqLECyAS
         Jn5evlouvGkC1ZlVBU7ql4V6AyUV5/w7WZK7D0nJin2KtwVinBRsubYIiNMxtrOcoWi7
         AEzgDOoP54O6FI95LUr+MgmYHg4uHg3nIfObmzti6rfB+d3ZMnyCEHRkMNC7xYOdDW16
         isr2quwFXdPTyFsE2GxbDkErgjsyMcM0O+BaNUuOSzFIdQm7PD9WRTsF8Y1tNeeiZKX5
         fXYQ==
X-Gm-Message-State: AOAM533STdy8bCWh5vYlE9mnahAcvAAVnQfHhZY4JtHK4IP0wDzRcj2+
        bpbolloZvIe74YYy/bzVkHs=
X-Google-Smtp-Source: ABdhPJysKe/VP1x16Pzr+Zm4BdZErNEnX40uHqCKrSLKl2eQFnwpzGs8MuQ1zEpCuSeb/8MCl4xOdg==
X-Received: by 2002:a17:902:eb90:b0:15e:b55f:d9c5 with SMTP id q16-20020a170902eb9000b0015eb55fd9c5mr1986867plg.33.1652956840621;
        Thu, 19 May 2022 03:40:40 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b00161527e1d9fsm3344206pli.294.2022.05.19.03.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 03:40:40 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH RESEND] f2fs: make f2fs_read_inline_data() more readable
Date:   Thu, 19 May 2022 18:40:10 +0800
Message-Id: <20220519104010.2814819-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
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

From: Chao Liu <liuchao@coolpad.com>

In f2fs_read_inline_data(), it is confused with checking of
inline_data flag, as we checked it before calling. So this
patch add some comments for f2fs_has_inline_data().

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 fs/f2fs/f2fs.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f579e2ed0f14..5071f6636e41 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3167,6 +3167,10 @@ static inline int inline_xattr_size(struct inode *inode)
 	return 0;
 }
 
+/*
+ * Notice: check inline_data flag without inode page lock is unsafe.
+ * It could change at any time by f2fs_convert_inline_page().
+ */
 static inline int f2fs_has_inline_data(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_INLINE_DATA);
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DFF5529AB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 05:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbiFUDL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbiFUDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:11:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47631FCC9;
        Mon, 20 Jun 2022 20:11:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so12011028pjz.1;
        Mon, 20 Jun 2022 20:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tec/+3ICzBjemtamjAZhwJmmbovsB9vXjrr7CbXvID8=;
        b=MSfF43jlB5pC5ITVnWcT+6zEqF5p9hWljG5e/Su18a5n4rusiODM9L0KAEQynU0AZm
         +qCs8DM2sJVG2Z4+W9Dq3lxDPfececHXhTdfLLO3Qu4HGJ/qDdJRG+7ImD7Oy+KhKx9J
         Z8v5DTcFFzVBCKfk4qLvqoHYeZpdP2Wzh2QA+dj3qhTUQGmKKTrI4GijctdmzCCz5M58
         b5Sx7QmItomCE5qIh7b6VogQx/jltsGP66yCjnHQQbqHxF4pMA5tmVYQLY8GV/ROl9D4
         0XL289A9s4Btcng91EhPXimSOOsylc9yBPuVLoovthL572buV3RD9Wna/o4GlvFuxSfT
         9t7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tec/+3ICzBjemtamjAZhwJmmbovsB9vXjrr7CbXvID8=;
        b=nKDGmbeNy8J8BTiPED25aE7Cdp3QDsqW1P9+kqCMrG47JAEsLszCYJBM6LvaCC3nQO
         1n9MWwpukjZ77+UOOjKisGNkCiClXT5JWDWjEGormrlHIugOnCH3tzg7v3niVuE8KxVR
         YPRuNXxGWfnKRnvseW/OptVIARyCGTcMyrJ23FQsX4ZXr4kzu6nBa3/14KxqbOGXJRt8
         o8diQvqFSkx4H5hovZMPXXwJlhhSlb5eOcsA8DYqsNp0EQLdaJSGOAqnqhr/WBEeAbP8
         R9IA/bWWon+82yGU/6JHN9nfbVtLqfGJ631DgxhRlolWjjfB8+aten5DDgTBbuczdo31
         wgyw==
X-Gm-Message-State: AJIora9zXKE+HrnRfRY8ZHcQqkHLbiJXeqCNEnjgeagfxKpT5zUaE9ld
        5zwNSm3EDbRZsz96OK79p8A=
X-Google-Smtp-Source: AGRyM1v5RUBw/72/m5bgdvic9ut/hQUE8DuiyD09+3a6dKfvWxBlcOh5zSBw6qb69X3/cYCjhMeD6w==
X-Received: by 2002:a17:90b:1e42:b0:1e8:7669:8a1c with SMTP id pi2-20020a17090b1e4200b001e876698a1cmr30387495pjb.206.1655781082935;
        Mon, 20 Jun 2022 20:11:22 -0700 (PDT)
Received: from localhost.localdomain ([178.173.230.211])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b00168b113f222sm4027844plb.173.2022.06.20.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 20:11:22 -0700 (PDT)
From:   Shida Zhang <starzhangzsd@gmail.com>
X-Google-Original-From: Shida Zhang <zhangshida@kylinos.cn>
To:     djwong@kernel.org
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH] xfs: return when delta equals 0 in xfs_mod_freecounter
Date:   Tue, 21 Jun 2022 11:11:13 +0800
Message-Id: <20220621031113.1222877-1-zhangshida@kylinos.cn>
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

There are cases that xfs_mod_freecounter() will get called when delta
equals 0 while it's unnecessary.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/xfs/xfs_mount.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index daa8d29c46b4..a3db932fd1fc 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1129,6 +1129,9 @@ xfs_mod_freecounter(
 	if (rsvd)
 		ASSERT(has_resv_pool);
 
+	if (delta == 0)
+		return 0;
+
 	if (delta > 0) {
 		/*
 		 * If the reserve pool is depleted, put blocks back into it
-- 
2.25.1


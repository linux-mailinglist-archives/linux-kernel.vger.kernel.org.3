Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183005061B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiDSBjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 21:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiDSBji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 21:39:38 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00BC114B;
        Mon, 18 Apr 2022 18:36:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id fu34so2568501qtb.8;
        Mon, 18 Apr 2022 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Yke2vGYLiJCkGyPInhuyijxDy/0Qofixn5QpzPB3vE=;
        b=SPotxyjOGfWKjyMPXrZnOr4NDXjDwDApnR8cEMXKr8thRc6yq5NbLU1E6NOQTyqGeh
         yfFKF3UREESAOKrL5+rSIMr7H/cLy7phTZF8Z9cjAd1o3pcIAggfFHRBdw0JYHU2IoVU
         Dx7mXwsQlaW5TLgOCjrH/HiuA0uxMYZ29aokmWZlGkymVjJKvFc3pNjRhZZtcRuveY0g
         caUleBHm+4l49hWYlHXG9VuNJppiAI7vFw1SY9LtrYhr8bA3qz94fNBfcgMn4I7F5h+R
         lj7uUNcgZ2+arw1gxQusZ/qRRPQmVCnq11wLf8dhqw7/UWmhy316/afshQ9Ql5L75Agx
         A8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Yke2vGYLiJCkGyPInhuyijxDy/0Qofixn5QpzPB3vE=;
        b=zA01VfwHrkb3ocqdBok/0RtH+4zmRrtr7i0M4jO/5O3Sq1+q6P1Rau6pxVOjeDo0uZ
         OyKE3BsJnhA0wi6TAjLsP8MbN754//LBOkORZPAYQSH3aDS3nDGqeyfcNr88M4rUuCnC
         2AMq0zCUykf9peL8fXccCzmWcB0ZsI4yFfi3xllGIWvErBTekSOCwtxw9qVaHn5xzaIz
         pzYUrZDpATc2IVg54k84Jk9AYY+sACpPoNYxF++ZRP07LJojtuv3TOyICHJXvSkB/+w4
         6KEqbSpsdCO+RA0xbEtsc0F3jb147VScQlBRt4cZMaOUwXBRlNrBi9G/lLtWtx8JUg/W
         DtKw==
X-Gm-Message-State: AOAM533WKEJMsa7yD5hzn6xDcuwtIBh2bxsZ9vQG1zZjl4ZcGcv4SuBE
        IVhmzdwrwysivv4KSUNqs+H7nTXCvIM=
X-Google-Smtp-Source: ABdhPJwMRCGCo3HARt+3j2n2sZQvmTy2+f5n7dQhR+8gvAubs8e3baodz2uTlQKzSgoxR5u1Atf1+w==
X-Received: by 2002:ac8:5743:0:b0:2e1:cee6:f15 with SMTP id 3-20020ac85743000000b002e1cee60f15mr8911648qtx.634.1650332214801;
        Mon, 18 Apr 2022 18:36:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q139-20020a37a791000000b0069e88513517sm3664391qke.91.2022.04.18.18.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 18:36:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     lv.ruyi@zte.com.cn, arnd@arndb.de, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] firmware: tegra: fix error check return value of debugfs_create_file()
Date:   Tue, 19 Apr 2022 01:36:48 +0000
Message-Id: <20220419013648.2561533-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

If an error occurs, debugfs_create_file() will return ERR_PTR(-ERROR),
so use IS_ERR() to check it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/firmware/tegra/bpmp-debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index fd89899aeeed..0c440afd5224 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -474,7 +474,7 @@ static int bpmp_populate_debugfs_inband(struct tegra_bpmp *bpmp,
 			mode |= attrs & DEBUGFS_S_IWUSR ? 0200 : 0;
 			dentry = debugfs_create_file(name, mode, parent, bpmp,
 						     &bpmp_debug_fops);
-			if (!dentry) {
+			if (IS_ERR(dentry)) {
 				err = -ENOMEM;
 				goto out;
 			}
@@ -725,7 +725,7 @@ static int bpmp_populate_dir(struct tegra_bpmp *bpmp, struct seqbuf *seqbuf,
 
 		if (t & DEBUGFS_S_ISDIR) {
 			dentry = debugfs_create_dir(name, parent);
-			if (!dentry)
+			if (IS_ERR(dentry))
 				return -ENOMEM;
 			err = bpmp_populate_dir(bpmp, seqbuf, dentry, depth+1);
 			if (err < 0)
@@ -738,7 +738,7 @@ static int bpmp_populate_dir(struct tegra_bpmp *bpmp, struct seqbuf *seqbuf,
 			dentry = debugfs_create_file(name, mode,
 						     parent, bpmp,
 						     &debugfs_fops);
-			if (!dentry)
+			if (IS_ERR(dentry))
 				return -ENOMEM;
 		}
 	}
@@ -788,11 +788,11 @@ int tegra_bpmp_init_debugfs(struct tegra_bpmp *bpmp)
 		return 0;
 
 	root = debugfs_create_dir("bpmp", NULL);
-	if (!root)
+	if (IS_ERR(root))
 		return -ENOMEM;
 
 	bpmp->debugfs_mirror = debugfs_create_dir("debug", root);
-	if (!bpmp->debugfs_mirror) {
+	if (IS_ERR(bpmp->debugfs_mirror)) {
 		err = -ENOMEM;
 		goto out;
 	}
-- 
2.25.1



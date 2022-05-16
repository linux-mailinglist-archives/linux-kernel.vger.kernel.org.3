Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1EF527C90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 05:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiEPDww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 23:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiEPDws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 23:52:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2BFD00
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:52:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f10so1352096pjs.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 20:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMPTt/Of+OgWknmwr3MDPDoNNiu/QtIgBOYrO8XaQBE=;
        b=Uwt0u5+LUvgNI6yu6phy6yswi1r5YnZ2KRdIP75+c0oZarBqPui6oKVTls4jsFAGRw
         sjXUbX0nFgNwmwpXLllnxpKK1cv4FXnqPk6KKKZfWlfRmmdVvLtndMPo3g5vxlX8HOZ/
         MEg1D2rDTlvEHs+DLOOh2Xd4z+lXfP2uqCRadu6dDZ23+pjDlVD43lRSeSlMCXYAvowR
         SYWWGrWGsGqIRtk7KXzApD/NFeg76YHzyigyxCHNmevSEnFRTx5p5+st+blaBy1Zt82e
         d+wBl35rSFJv6EObxiIUX9JognI5OGHXvC0ixL6EvsQ8uhJJTXcQ+MG+2kHkrbpEhqQF
         u43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mMPTt/Of+OgWknmwr3MDPDoNNiu/QtIgBOYrO8XaQBE=;
        b=W52DCPiCAFeEOqgyJyH3hUvPClXggXBEqkURfbs3MseVtddFi6VPDqnuaNTWna0adH
         Ni339d70N2AXgf6gM8TvP6PF7APhjAX/5g3tnV2+OJOrFhzk5Ui+rzWIMdV4hDr7Z+lr
         xvBgaGuNT42P5ewQJQaTwSd5MbLsyB7U+ekr51lI8lO5CYhEnonzAj5Fet1wqaablN5G
         GYANDOF3Hr3SBjiivtOOeLLaAPSEq3STVDGONio+Oyc3TZxoCjQwdCBqWBe+h0bW/o5Q
         aYrRT9jhou5Q6IXN0CRPnlt8vyxmxrRI2Fli0+tPE23VUMITJahBMtFg/+wO6J1HZuqS
         1gWQ==
X-Gm-Message-State: AOAM5312XC9s7oL7A+3lIMsloDgmVek6EhqcoNSWAmFRzMzVGb+MDW/H
        NGhFRqpbgcLrit56TcSGxAp99mWKxc3r7ZNQ
X-Google-Smtp-Source: ABdhPJyhicCI2IanoagT3mondvYF4JvReoWk6NJpNAjgUzh7q77RDUI4S1j0elpnuhZj4xtX7/hmIA==
X-Received: by 2002:a17:902:ce82:b0:15e:982e:a815 with SMTP id f2-20020a170902ce8200b0015e982ea815mr15154896plg.167.1652673166361;
        Sun, 15 May 2022 20:52:46 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id im9-20020a170902bb0900b0015e8d4eb1b7sm5815772plb.1.2022.05.15.20.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 20:52:45 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx27: Fix refcount leak in mx27_suspend_enter
Date:   Mon, 16 May 2022 07:52:28 +0400
Message-Id: <20220516035231.5362-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
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

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: d54debc72f5f ("ARM: imx27: Retrieve the CCM base address from devicetree")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-imx/pm-imx27.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index 237e8aa9fe83..179506196f8e 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -24,6 +24,7 @@ static int mx27_suspend_enter(suspend_state_t state)
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx27-ccm");
 	ccm_base = of_iomap(np, 0);
 	BUG_ON(!ccm_base);
+	of_node_put(np);
 
 	switch (state) {
 	case PM_SUSPEND_MEM:
-- 
2.25.1


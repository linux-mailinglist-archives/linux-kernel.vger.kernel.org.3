Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7A53C9A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiFCMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241360AbiFCMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:03:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8759E2D1EA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:03:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j7so7209642pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAU9VOHgii5Wb5QPt822QV/PI4uIiJFGRJit8v42VVY=;
        b=HE1wDncs7+sayb1iTW06qw8e76iV+Xe7y7LA94M8Dywn4ywXB+lBy/II4PB9rZkvGK
         ukEi89hqX/q02lORaYDIEkulxGmc3G4ww9Gyzaj9kgZA0SfJb29lm6wSvWASPzjYB7lM
         KPKJiAKkI7N+iYsBgV5aL7WzwQKSiYX9T+QThNygRMQZY65w9i7VOA4P22k1E4Uroujy
         6S8nXtz+PMxQI9UdpYrTYnkIzXqF4eVWalTTaFLCs/FrYUWyWzByAi6071dzej3LFUlp
         I4A97GWtzZkD725KyAwbxG+6Q151bgMzVH22W5tcYhRjEowp08aeW9ISyUF/63i1hnXW
         uFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qAU9VOHgii5Wb5QPt822QV/PI4uIiJFGRJit8v42VVY=;
        b=CWWiRX+48x0Sg88tPc/UdMXnT7lsrp8xFe7C1d9AbKzOiSBpnLJdCjnirSz31EqDoS
         e89XMzrWQbF781LxM6NJJZFhjcY5Wk/mhWXKFGLharYdlgHT2DzFS5JXfbtsiLD/Khbs
         riD0ZDmjPsa0+5wDct8/7aciDA1L3nLlxVcsUDjhiSscm1qg6RmEWUQrstZvQHvnNkeZ
         k8aBY7Peif0N5f6ZS0Frg36RfYlc2lOwnWZobTKhucENKye+l5DJFc5Zmwvl6P2uVd3c
         iy4crZFYTygqod5hTLWAIO9AW7+E4eHxvumNrtnnlEal9XMzZab+V4i9p4kQiLIZ0fvW
         xRLw==
X-Gm-Message-State: AOAM5312VET4uyQ8dJZ+DOC23HkSBBgWa6r6C5tPBm58HrRFWlKrUcaw
        58G6bW6XQzo6Klh/cYP+Pp8=
X-Google-Smtp-Source: ABdhPJy4N3lyqqdqLOfVkBBotTfzO18+RUMzodGioUIYhBafR7dVEREOJAMPpEhPxRQpHdCr+5dqNg==
X-Received: by 2002:a17:90a:7349:b0:1dc:9314:8699 with SMTP id j9-20020a17090a734900b001dc93148699mr46128313pjs.184.1654257804023;
        Fri, 03 Jun 2022 05:03:24 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id kw3-20020a17090b220300b001e2f6c7b6f6sm5008486pjb.10.2022.06.03.05.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:03:23 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mxs: Fix refcount leak in mxs_machine_init
Date:   Fri,  3 Jun 2022 16:03:13 +0400
Message-Id: <20220603120314.15488-1-linmq006@gmail.com>
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

of_find_node_by_path() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: format:2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-mxs/mach-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 25c9d184fa4c..7d957cadd3e9 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -393,6 +393,7 @@ static void __init mxs_machine_init(void)
 
 	root = of_find_node_by_path("/");
 	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	of_node_put(root);
 	if (ret)
 		return;
 
-- 
2.25.1


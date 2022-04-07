Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1403A4F7AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 11:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243561AbiDGJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiDGJD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 05:03:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA68164F;
        Thu,  7 Apr 2022 02:01:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t19so7580710qtc.4;
        Thu, 07 Apr 2022 02:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7k9wHjGCmirLGQtDNZunWvATfCdcYy0H3Z1yCUnVVgo=;
        b=eoSQ6dFjX7ebCs11Jl1ZGRgtLmSxbNl8ge+CP32X1ALfHiAP2IqJsNz2PI1FytMYUG
         wUlrBhsUyB8iWdbxQvx7SEou0vURFav0N5dpZmkhWn1epeWwsbtahWixJ+DvtrgxM7O1
         cAyCa3JpyK47O59pZ7QhhwWLIWuO1h3ttFuePmUQSOpK4UesJik8t17h7x/b1PySd85y
         W1hb6lPqoW6xpJx88rax1kgFmWI8v/12R9K4AU+Y8W6Vs3STD1QjVe0nB0w5ZedFy8Ql
         94sSm72kvl24tKaaqoNkeiKR56ArK91gf6jWl5bv1YLhOjabEm6zcLamLIAsZFavr8sQ
         VyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7k9wHjGCmirLGQtDNZunWvATfCdcYy0H3Z1yCUnVVgo=;
        b=JaBvADIcdcoid7PhhANHYlwxuU77kIVTbGnYp+Qvky8E43hwY2s25PLc9xXdLFPJDN
         vWL7N/1wO1urQLv7tasFJP6ChgWKfaGpTJDXVQ9TdqgXk2dpOS7nzllmC3aJsuBhStg/
         8nV80SSzGHxnLVhm65IT28qK/hCrNLKDycxnxMFWBNF8vsM9GK41wKMC5wGnDmvpgU2U
         sDjjkKsMdasciL88jOJoLv8zjcRA1bEImbj60QSVOST6K6AYKYA5yvkeasP+/LEhvFFK
         pRn29dnaJjqH+gRJdy8WCnL4gVIUGZ+r8EXjkfMFy860JMu0hp7G9AKqds5y5aoMzXm6
         Yudw==
X-Gm-Message-State: AOAM532Jb60/tJ5HrCdCHJRdR13FdNNYW6ouB13tT0Rt1MY+JrjVQWGM
        QHSxUcgisi3aMiWAXV8DV9U=
X-Google-Smtp-Source: ABdhPJyt6Mnnqh0FTkOo1W8dKin7q9bCtIm4dDnlr76kyfZvugnPP3KPcRcXj0jwBM7EhC3Ss1VxKQ==
X-Received: by 2002:a05:622a:653:b0:2e1:c046:4825 with SMTP id a19-20020a05622a065300b002e1c0464825mr11178669qtb.430.1649322089296;
        Thu, 07 Apr 2022 02:01:29 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm15031194qta.96.2022.04.07.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 02:01:29 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     deller@gmx.de, shawnguo@kernel.org, festevam@gmail.com,
        linux-imx@nxp.com, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] video: fbdev:  Fix missing of_node_put in imxfb_probe
Date:   Thu,  7 Apr 2022 09:01:22 +0000
Message-Id: <20220407090122.2491922-1-lv.ruyi@zte.com.cn>
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

of_parse_phandle returns node pointer with refcount incremented,
use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/video/fbdev/imxfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 68288756ffff..a2f644c97f28 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -925,10 +925,12 @@ static int imxfb_probe(struct platform_device *pdev)
 				sizeof(struct imx_fb_videomode), GFP_KERNEL);
 		if (!fbi->mode) {
 			ret = -ENOMEM;
+			of_node_put(display_np);
 			goto failed_of_parse;
 		}
 
 		ret = imxfb_of_read_mode(&pdev->dev, display_np, fbi->mode);
+		of_node_put(display_np);
 		if (ret)
 			goto failed_of_parse;
 	}
-- 
2.25.1


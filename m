Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D74481AC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbhL3Il1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhL3Il0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:41:26 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5551CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 00:41:26 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z3so17786682plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=gOSR7Y5DhmldlZYZfgKoXEayFeN352tbiKfrmxSItQc=;
        b=WBrUjKZ1MYrPSt00PeR/mTNRrVpCvHel0Lg3ImvjYrpFZDbWLK/UnfPLg6rZWPeI3s
         Si60i3Aaj2AyUUMW0xXXnnZgAaFG22VM/YW3ILLJ/KEamEiBVhhxUWy1zg3NTG0uksIc
         aFG+jX43bMqYzYfMwXnGGLouv/ga81ZvAOSsDGLO5w8VRpCSAlWRHnf+8MrGHlonel/Y
         AjFH1wloszk4fPX32kaJzvRfprgl685dJUQvSbEqD0//nIAxewNsuc1CE9ZDb/Ac/NTl
         iD1qlBDxnJNUNVUZYaCpA515E29AZGbXEAJuCdfxLYP0XFD+idJy6SOMf1jQwQUJTY+i
         5k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gOSR7Y5DhmldlZYZfgKoXEayFeN352tbiKfrmxSItQc=;
        b=IF5dGcwvkaEvpZkJNZISgC0HDm99ljdWSo+pDr7fQb59JGAP0lbZj2BIK/p5CtWiAH
         4V+a2GTwO6JJTyeP4ws/z0neQCNfUHMYOij2Mz0haRcMqCtve6WQb9b5r41G9rZ3uRzE
         jMsIgx9XNuKFS5/kO45T42gHzApCYodnzErc2Js2w+sld0z5n4khLeGGj/euanLhH7Kt
         dmOg02OpmqVt8AtwbRwQqCnkRG0DTUac05Tn67bjLeckHaF+BH0YN/JRVW7tMIK7Z7aW
         3Nc0UMFfqb6DwK+3P3Yzmns50DwNyBtuEHndk6OB3GpNLrUeh48hcBBNccQyYns/IBJ1
         5LrQ==
X-Gm-Message-State: AOAM531T6FhsttXACKXQgygxgJmXK1pLLCKM3Iq+LzeUudycPsE62ZVQ
        vw4NEIGTUnqLel4zC/IG8I8=
X-Google-Smtp-Source: ABdhPJyH2XwTtE9Nzyy6f297GaPnRvARYrZckPTba0wOcm8Ng7MoLinGyFkMGnhgZso5EuXvpfs9Ow==
X-Received: by 2002:a17:902:b10e:b0:149:a59c:1417 with SMTP id q14-20020a170902b10e00b00149a59c1417mr2392252plr.165.1640853685835;
        Thu, 30 Dec 2021 00:41:25 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k23sm4171216pji.3.2021.12.30.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 00:41:25 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common
Date:   Thu, 30 Dec 2021 08:41:15 +0000
Message-Id: <20211230084115.5375-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling paths.

Fixes: 4740475 ("memory: mtk-smi: Add device link for smi-sub-common")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/memory/mtk-smi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index e201e5976f34..2131f2c9e7ed 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -386,8 +386,10 @@ static int mtk_smi_device_link_common(struct device *dev, struct device **com_de
 	of_node_put(smi_com_node);
 	if (smi_com_pdev) {
 		/* smi common is the supplier, Make sure it is ready before */
-		if (!platform_get_drvdata(smi_com_pdev))
+		if (!platform_get_drvdata(smi_com_pdev)) {
+			put_device(&smi_com_pdev->dev);
 			return -EPROBE_DEFER;
+		}
 		smi_com_dev = &smi_com_pdev->dev;
 		link = device_link_add(dev, smi_com_dev,
 				       DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS);
-- 
2.17.1


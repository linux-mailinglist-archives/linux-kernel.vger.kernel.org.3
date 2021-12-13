Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C8B471F41
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhLMCFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbhLMCFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:05:19 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1AEC06173F;
        Sun, 12 Dec 2021 18:05:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y7so10177140plp.0;
        Sun, 12 Dec 2021 18:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZfMoG6X9oBnz9vgJgatuWr3jCxlugYsFtu5GcGk49Mc=;
        b=g5vVjsFJHe9o2GHUu4E4+Su0ye9H6m0xqBM+DGcgJdmD+IQiPo5zQOKiiu3Ft8IEbs
         zHBPcspyJeEVAOVSDs2hxq1G/V1lyQek5p3oHS1dZyT8RP7vge/6jUa6z80deAs1Escm
         KqNH4YQYYqjvsvPSnV6SWPkr001GcVsgSdjEFRjvtNIj2v1zh6T6pGwoXAu/mvU/j8mu
         clkhoeQjghjlwBf+ck+uSZ7G8C9C2J5ffNXHE3/4ge0i35niKH7wy0bTzREkA1FL7pRJ
         fN/vq9LkR1bWZKCXUf7BDqsOkx/FL6fldEAA6rmuOO1A6EuV7igYRYWsRMTT4VOkmRZC
         X2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZfMoG6X9oBnz9vgJgatuWr3jCxlugYsFtu5GcGk49Mc=;
        b=kzIYD3WF5iZqwXbPR3SevokrltLbpq7MlYd743m0UqmoeeaXqwugO80kiSNLdxCfrE
         fUf3Mvi1vpYCcWOiind8RNm+7NYLhmxiiB0wahUqZI/U057C4uGM7s/8mhLGWsHNce3S
         HvZ8iyIHLYlj94stF+Rg/fCq5QEIAI38fNvqWD6zBwww/3N5CKmdFo/gvpzWYVwS4X6z
         Nr9k1jBurKBXd95u1bXw0FDughrGD22JnqeTnr9y0u4FoCkwt6vLtqAmHD0X3vYSME/z
         S1GP5lRe0lU0J+36LkwzakhPp+wnu73L+ntvMA/rtIA4T+a6uhAmvk5EzvkbXTpHrbgn
         S2IQ==
X-Gm-Message-State: AOAM532ij/qi8yyUsYYW2omZmm1ivGfjlozz80XClgUTsIyd5DAHs6rj
        kazZdPbAU/Ew+Z1YsE72bh8=
X-Google-Smtp-Source: ABdhPJxXe2sVfiehDtu1Fli3a+yt3W24vxsc25t6eLYydxx6kbdIMIr5thbA+poPOAHvKPLb0sj9Cw==
X-Received: by 2002:a17:90a:ce02:: with SMTP id f2mr40408011pju.77.1639361118786;
        Sun, 12 Dec 2021 18:05:18 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s28sm11278915pfg.147.2021.12.12.18.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 18:05:18 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     digetx@gmail.com
Cc:     jckuo@nvidia.com, jonathanh@nvidia.com, kishon@ti.com,
        linmq006@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        thierry.reding@gmail.com, vkoul@kernel.org
Subject: [PATCH v2] phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node function
Date:   Mon, 13 Dec 2021 02:05:07 +0000
Message-Id: <20211213020507.1458-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <942f943c-9ec8-9887-aa6d-4d133821beca@gmail.com>
References: <942f943c-9ec8-9887-aa6d-4d133821beca@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

callers of tegra_xusb_find_port_node() function only do NULL checking for
the return value. return NULL instead of ERR_PTR(-ENOMEM) to keep
consistent.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/tegra/xusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 963de5913e50..aa5237eacd29 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -455,7 +455,7 @@ tegra_xusb_find_port_node(struct tegra_xusb_padctl *padctl, const char *type,
 	name = kasprintf(GFP_KERNEL, "%s-%u", type, index);
 	if (!name) {
 		of_node_put(ports);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	np = of_get_child_by_name(ports, name);
 	kfree(name);
-- 
2.17.1


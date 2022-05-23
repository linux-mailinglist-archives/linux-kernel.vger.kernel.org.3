Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634A05313BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbiEWOG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbiEWOGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:06:21 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB12237EE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:06:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so13204293plh.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8y5BRaHXUyaMApI9OkAQijsflwdIHfE4WR6ORnNMHho=;
        b=j/v7TapmIXCeZCguAy5n0XikUxpBpbZZXgASm4lzUDpJg0YoD3MIBgIwVXxhOPAY+/
         yFAiIKNXFA87xFKgRB6RlJpMesb63CuTvoQqXe2uynXQlLkgUan3wKnHI8RfY6sAEgzR
         hLzWAWEqCtGzPqPc9cLQPcidJgFMRmwI8kPVKi5VZetoy6hUeeKBYqF/qj9yGxIlcSEI
         +DMh6CRJK/YzhAogG7XjgWfGzGpfOMvVewUAS967HoeZq6tmBtiXkNuHHi9WTvoJ47Ks
         BE5BZdD9mifa99iCgPwlGljEAnrlw22Mzy8dplvlMycAQ9J9g0DI8RK7yDrw2bakOc3K
         2elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8y5BRaHXUyaMApI9OkAQijsflwdIHfE4WR6ORnNMHho=;
        b=u4cRQ8U19uTLq9pm3NYX8/EAzBvqhs9siYt9G94RaEk+6FrT4+82+q40Y4JW1vHZgZ
         6wWZNmT7IGzdNpjCXDUv/vBHVfZEUxwsl1CIW6aXXQ+WzcnGfqvxZfLm/YODAtA+H5+n
         OF2W8YKVPs88oUlrRpDTxTVxtyjGjWWNMN7YkVAsMoqmEQ3BZmAFUtolyPYAPzCI0dUJ
         39USrt68YZ645BRJgQE/38RQATtbDsprEOtajdD9fvd05YK4LBUPPTjrJiegaY2rFDBn
         NwYXD5wPwbxUrdRqP0AWISGwNghfbRElO7Z8yT4thWcEGUoUHnpi/rcJRbl/0uPIG4fd
         zyKg==
X-Gm-Message-State: AOAM530D7yqODxh93OMYSq01DZ8dlbChbEaHiOhKDfDhZcUP1W/CCWUr
        SUDX5AUalR1JPSGWK6vlhqU=
X-Google-Smtp-Source: ABdhPJyFOXj2ryIjuzJfas0FpOP+2TbpxesLsEPTi6B8TYXOqVZln8qV0MkTsqPVAVL9qJrHEdom/A==
X-Received: by 2002:a17:903:2288:b0:162:23c:c151 with SMTP id b8-20020a170903228800b00162023cc151mr12484842plh.78.1653314780118;
        Mon, 23 May 2022 07:06:20 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id n89-20020a17090a5ae200b001df6173700dsm7170927pji.49.2022.05.23.07.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:06:19 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] phy: rockchip-usb: Fix refcount leak in rockchip_init_usb_uart
Date:   Mon, 23 May 2022 18:06:03 +0400
Message-Id: <20220523140603.50848-1-linmq006@gmail.com>
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

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 605df8af33a7 ("phy: rockchip-usb: add handler for usb-uart functionality")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
index 8454285977eb..9743b4ac5d1c 100644
--- a/drivers/phy/rockchip/phy-rockchip-usb.c
+++ b/drivers/phy/rockchip/phy-rockchip-usb.c
@@ -543,6 +543,7 @@ static int __init rockchip_init_usb_uart(void)
 	if (!data->init_usb_uart) {
 		pr_err("%s: usb-uart not available on %s\n",
 		       __func__, match->compatible);
+		of_node_put(np);
 		return -ENOTSUPP;
 	}
 
@@ -551,6 +552,7 @@ static int __init rockchip_init_usb_uart(void)
 		grf = syscon_node_to_regmap(np->parent);
 	if (IS_ERR(grf))
 		grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
+	of_node_put(np);
 	if (IS_ERR(grf)) {
 		pr_err("%s: Missing rockchip,grf property, %lu\n",
 		       __func__, PTR_ERR(grf));
-- 
2.25.1


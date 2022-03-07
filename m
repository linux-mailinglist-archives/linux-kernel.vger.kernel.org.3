Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFB84CFD9C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 13:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiCGMDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 07:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbiCGMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:03:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1D827172;
        Mon,  7 Mar 2022 04:02:41 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c11so968659pgu.11;
        Mon, 07 Mar 2022 04:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=n+d9Lxh+NheIDAOxQIfuGYj1TJDnhntgDMXeTmrg5/4=;
        b=DN/v/7UttIijMOQM5kxSoTk4ag0wCFMu0YYo1p7SHYc5pnmgTNisTRag9pMLEz/J6r
         H/uilcgT0hQkiOR0tazG+guECgx2t8dHC2g9It+CG3t+mD7SiKoFBFxqemhFsPadMZrW
         U/vOrVznUIyqR9vaLCNX7SN3IbJGWYdludIyNvivcBUno5bpx4/sYk5OhegahlN7neE1
         7z3u/EfSHU+XAPIVZS1knrLyoLIm0at8HuHzzN9RpIkuoo1Ada+iZ7UOpfBUothnqziZ
         hSsi1c5dST7M2hhRi9xz1TmaZkJJFK91jNzNLo2WrDHFf2JSV+OoXgpk4zxNjiU2nDGI
         CGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n+d9Lxh+NheIDAOxQIfuGYj1TJDnhntgDMXeTmrg5/4=;
        b=qI20c56AEAIsiE2hUVCg6dC8visFHWHifVOwU1apj5OYAkqy99WHtlksswqpSTGxIU
         iNgjL0K0sR76m+aIe61bB+rejGSke6ISv04vspLL5yMCNsy736gh/OK+nxtB3BiQ6Dzi
         GJKXO/GtiJMr5BEzgelSMGRc52XhON2/MBQ96XjtLBS4PncPHVIn3ZqZunOAAXGocjtp
         frtw9fQ03GDz/cFuIWUwnbtYLFkf40gOUAjnau2XWzQMGqZpRo+L9GTpPOjCQAscvjgJ
         KuxITLAYkzNUebwDw1wYbhM/jA8qO/3RMv35CjEaEKgQjfUB7dXbYPo1xmPRhvw+So++
         F25g==
X-Gm-Message-State: AOAM533qcTQEw33MGvt//FTWgpLBim3oPneLqQBPmnud6HI+A+BwfVkF
        Q3VYCqvM3c03iya5EfwRavg=
X-Google-Smtp-Source: ABdhPJxNNKbKfGTPrzvPjBpyu7ws4sfOGeZM9oyV399bYvQQJpZhZNHYPE2OhyHQHlPyYUE1/CmU9w==
X-Received: by 2002:a05:6a00:2166:b0:4f6:67fe:a336 with SMTP id r6-20020a056a00216600b004f667fea336mr12370831pff.17.1646654560561;
        Mon, 07 Mar 2022 04:02:40 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm19684932pju.1.2022.03.07.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:02:40 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] pinctrl/rockchip: Add missing of_node_put() in rockchip_pinctrl_probe
Date:   Mon,  7 Mar 2022 12:02:34 +0000
Message-Id: <20220307120234.28657-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: 1e747e59cc4d ("pinctrl: rockchip: base regmap supplied by a syscon")
Fixes: 14dee8677e19 ("pinctrl: rockchip: let pmu registers be supplied by a syscon")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index d8dd8415fa81..a1b598b86aa9 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -2693,6 +2693,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	node = of_parse_phandle(np, "rockchip,grf", 0);
 	if (node) {
 		info->regmap_base = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(info->regmap_base))
 			return PTR_ERR(info->regmap_base);
 	} else {
@@ -2725,6 +2726,7 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
 	if (node) {
 		info->regmap_pmu = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(info->regmap_pmu))
 			return PTR_ERR(info->regmap_pmu);
 	}
-- 
2.17.1


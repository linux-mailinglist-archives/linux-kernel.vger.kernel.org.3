Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B544D2F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiCIMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiCIMuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:50:01 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458953F30F;
        Wed,  9 Mar 2022 04:49:03 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t19so1852015plr.5;
        Wed, 09 Mar 2022 04:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=gmzfDc79SJaw0O2J8OrdJVxDniuiRhZZSCsFjJqsgqU=;
        b=hqHHbC4f33ri/ELlINMm1EGRqrT6SfD0ZFHEaHa0Zgu6ZHRJIpolnRhwLLG6NAPkbZ
         HHqltR8DP748UgQc8n/vfGJVT0W27pKIHw+/Ib9zBSDe55UbQKPjCkNC9zxtlTtKBK7M
         qCevSfewjeIT023qhBz09+5y0mbg5k6WXWTZaMbpWP/+kIB/4VPxAspE/eVXPKrofxbC
         Jd614Xt+Nhv4TTFNK+vNKWb0Z6JG7e9XjHrq2U/1UbIGWr/Om4pvWKvYQ+foRwUSsMjI
         gRRl9qSVS8X6eDQ6bDPRaSQFbJAws8EaQV5aSzPi91rsTEeKhE6FpnRxwqpQ7vP320rM
         wjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=gmzfDc79SJaw0O2J8OrdJVxDniuiRhZZSCsFjJqsgqU=;
        b=kkVjrNgqko+EljZgR4EqV9B4Y2ZM7qcqyHUK2ppLO/UlK4zgHw58kxGJcvUUxPkl+O
         4aiXhY/1Tlh/xl1fwMxhAUSrRDWvZw5jteie5fHoktC11zG77w5XtKkurjRbK9yn+uvb
         +YweddFci+rcsZCqfRQzpM2d5iXw4UBhUpEw2ed38gdKUmGQFgu01eleLQ9N3+wvDZu5
         lE87+HJJJ/selYX3Xd3IILFYn33qnO8LgmUhvs2/sVPwLbi0Zv9mjgI4htcN46zlB682
         MhEPKtYuxpZbsaGMSlA4/tf7VgGmoUbA3xJV2YTixUhZgbvLFon1+PVnM/vn/rIywm0S
         wu9g==
X-Gm-Message-State: AOAM533W4q7dl6MZgxPwb079uS9xqFegVF/voJ//UUWlfz8W8hbc3Vw1
        8ZYkBZu37M/yJHzeFoR4u19E03MfEGi51o3IPyWncA==
X-Google-Smtp-Source: ABdhPJwy69AcSthvPd1Jwa4D/eCjVma76OudGhtMQzni4PgKe7zYNLgFb6mVdJmX/5YGFr/o8D6oKQ==
X-Received: by 2002:a17:902:ec8d:b0:151:cab8:9aa9 with SMTP id x13-20020a170902ec8d00b00151cab89aa9mr22320338plg.173.1646830142783;
        Wed, 09 Mar 2022 04:49:02 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h18-20020a056a00231200b004f72b290994sm3083024pfh.180.2022.03.09.04.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:49:02 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Girish K S <ks.giri@samsung.com>,
        Vasanth Ananthan <vasanth.a@samsung.com>,
        Yuvaraj Kumar C D <yuvaraj.cd@gmail.com>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: samsung: Fix missing of_node_put() in exynos_sata_phy_probe
Date:   Wed,  9 Mar 2022 12:48:52 +0000
Message-Id: <20220309124856.32632-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle() with refcount
incremented. We should use of_node_put() on it when done.

Fixes: bcff4cba41bc ("PHY: Exynos: Add Exynos5250 SATA PHY driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/samsung/phy-exynos5250-sata.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/samsung/phy-exynos5250-sata.c b/drivers/phy/samsung/phy-exynos5250-sata.c
index 9ec234243f7c..6c305a3fe187 100644
--- a/drivers/phy/samsung/phy-exynos5250-sata.c
+++ b/drivers/phy/samsung/phy-exynos5250-sata.c
@@ -187,6 +187,7 @@ static int exynos_sata_phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	sata_phy->client = of_find_i2c_device_by_node(node);
+	of_node_put(node);
 	if (!sata_phy->client)
 		return -EPROBE_DEFER;
 
-- 
2.17.1


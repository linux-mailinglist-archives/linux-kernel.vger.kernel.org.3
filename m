Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA814FE577
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357433AbiDLQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354266AbiDLQAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:00:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E272CE3B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:57:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so28343365wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oXU3hwiMfKY80GD9UAyVjvKh2iumJni0metDCTcR0Zs=;
        b=gyITdjS2U9I7emTve761Mhyp4rm1MvbYmGDM5K/9Gdw3Sh21Hakr6ivPa8gXU0wDAC
         a4ZbjQmq0C7UU8g1ejYaBfbE0RV1tuhBAtEhgm4wY7b8WBO/IosxZImvbSEmXPt65t9/
         G8EcZFQOlfN4oD+mTSgYBJkiJD9Xv10UQPABA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oXU3hwiMfKY80GD9UAyVjvKh2iumJni0metDCTcR0Zs=;
        b=SXwq+CvcU6tlbxN5O8beXi2rQBXao+ZqN/HCUB5KHFRBfwvpRL8w7ew9doce1gRnkY
         mjA7e82NWlyJonOWw1Hg/VQ8lRDXfF9wd30jds3bE3cKN3IVGE9hXxZD1zjSkWrcMpRu
         Y43UaspdRVCYzylZ0ys3TvZxLGUgt+XCSps1myJJueI4duYaPgmHJjEOvofzdqGlY34o
         pbKRK2bCisxFmmkx5UjXU15Hd4wjr2bN5RZzmqW41p0YnWsxUGd7CrVKP4pRGwRWYCnr
         QxmrYq7g1YEc5AgYLE2L2vpylIJ/yla1y1Mc8kzSXelk9kH/vSSmJCuT7kuJKPMZfCNd
         LVpg==
X-Gm-Message-State: AOAM5333LpQE3dX6YJpsR7Qhv6hGjYVg33guUO/mOq46Iu71W2tHhFhk
        dbVNT8tz8wDU/xQl2ztZ1fKhMg==
X-Google-Smtp-Source: ABdhPJzvB91kCZ6vPMivEWQNfWetW2FsTs2voeYmQzoe8Ic2OtqbXJZBPqn5lmO8qcT4wpU+wAv99Q==
X-Received: by 2002:a05:6000:118f:b0:206:81d:c030 with SMTP id g15-20020a056000118f00b00206081dc030mr29130004wrx.169.1649779074464;
        Tue, 12 Apr 2022 08:57:54 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d6b8f000000b00207ab69284csm3497155wrx.23.2022.04.12.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:57:53 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: realtek: don't parse compatible string for RTL8366S
Date:   Tue, 12 Apr 2022 17:57:49 +0200
Message-Id: <20220412155749.1835519-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

This switch is not even supported, but if someone were to actually put
this compatible string "realtek,rtl8366s" in their device tree, they
would be greeted with a kernel panic because the probe function would
dereference NULL. So let's just remove it.

Link: https://lore.kernel.org/all/CACRpkdYdKZs0WExXc3=0yPNOwP+oOV60HRz7SRoGjZvYHaT=1g@mail.gmail.com/
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/realtek-smi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 2243d3da55b2..6cec559c90ce 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -546,11 +546,6 @@ static const struct of_device_id realtek_smi_of_match[] = {
 		.data = &rtl8366rb_variant,
 	},
 #endif
-	{
-		/* FIXME: add support for RTL8366S and more */
-		.compatible = "realtek,rtl8366s",
-		.data = NULL,
-	},
 #if IS_ENABLED(CONFIG_NET_DSA_REALTEK_RTL8365MB)
 	{
 		.compatible = "realtek,rtl8365mb",
-- 
2.35.1


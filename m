Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E6A4B43DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiBNIR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:17:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbiBNIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:31 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06A606EF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:16 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6FB10407DD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826635;
        bh=YIMchXgxrGO/KxGG+/UkFx+hf7tS1WrOyOXtJpDqg8o=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=q68KrJxtY3MZ2TuRbvwonTQSbc5/iN1y/yB/stVqB/pcjhL8ltiUQL9h/SlplY83L
         iUyiFIf/zxxAxSluntXt9uNsCnKbJJ8Zmy3aLmH5jyT7dfp650MirNAkdYEpltiG6g
         e149qRZQOZuGfq/mVE3ZySLhMy5AeyCkVU+0YSKhPhHO0gxLDGRIoz1xkBMaYactzy
         LJNvrmcHH+l0rbcolEWEusGGLV5gC+pfzYbZAOf17MokdHXa+WZgCExSDMmbuCU6f/
         6Bix23H4YHrKaTg/OGVaG8fPkXIAr03v5U247yJmq1BHo4qmY2RS9+g3OYmYqelDx8
         V3l6i9qUX+HbQ==
Received: by mail-lj1-f197.google.com with SMTP id c31-20020a2ebf1f000000b0022d87a28911so5393034ljr.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIMchXgxrGO/KxGG+/UkFx+hf7tS1WrOyOXtJpDqg8o=;
        b=E+964PGu5DyhJ04ni5zgxtbiqInyNRoIGCvdzwrhsSGQpeQbv7nBFzcfTHm9Up/eUg
         /tVMXZ9IrDvEpkZabJXyknRdKkfvLe04J90ZKgoy3c4UYIMlh19K7t7w9OGF7ZrSO54A
         x5vCp2GYr/Z+qgXXzNh7QRumon/qv7l9ZmOItBxnVvlqhKaSKUCUE566TePhYBssoXU5
         zBSk6q4Jqulv2vhAxFWgyQzZ/q6QGlrgMFMZ+FWoxPMuATP0bFxNkK5i8n8KlodttvtN
         yW1l3BYXZFSjjdhBOZq73df6J5YYf37Teell5j5JtFVAhAUVwj4IYhRChJ0VMBuRJfDn
         zu3Q==
X-Gm-Message-State: AOAM532ZurPQ7NJYRbbS7sdzWr3OLGbC4SKh19GSaw+6aZ23iohLu894
        hEItkT0gvd6UvoNHi2fRsNb8ayhfaT8IsKix4Hi8WOab0ma3bYxPGJDiEruMzqgj/cuHpMTGLAS
        VW1/81xTwJpboLGrxiFRqmpw6y5Mbtz2DicMHutdl+Q==
X-Received: by 2002:a17:907:3342:: with SMTP id yr2mr5958124ejb.146.1644826624455;
        Mon, 14 Feb 2022 00:17:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfK0aywy5WjW2583ifLTvYYWtVDcJ7Gtmfi5jkghjnk2WcWRlDFdui/O6H62E9nB+KLqqdpw==
X-Received: by 2002:a17:907:3342:: with SMTP id yr2mr5958081ejb.146.1644826624297;
        Mon, 14 Feb 2022 00:17:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:17:02 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        Rahul Tanwar <rtanwar@maxlinear.com>,
        Jeff LaBundy <jeff@labundy.com>,
        Yash Shah <yash.shah@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Vignesh R <vigneshr@ti.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 14/15] dt-bindings: pwm: tiehrpwm: do not require pwm-cells
Date:   Mon, 14 Feb 2022 09:16:04 +0100
Message-Id: <20220214081605.161394-14-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
References: <20220214081605.161394-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pwm-cells are already required by pwm.yaml schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
index ee312cb210e6..70a8f766212e 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.yaml
@@ -48,7 +48,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
   - clock-names
 
-- 
2.32.0


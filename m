Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC824B43CB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiBNIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 03:17:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241784AbiBNIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:17:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECBA5F8FD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:57 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B297740573
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644826616;
        bh=7rHD29slkZOFSJhahaVYXmLu64XBgMMbFm+fpWjAlF0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=e3s4GUYV+YZW3mOa8Xkb1yTi80q2HYVIB5laHRiWYig8Bxi975rXePggNVLg9KE+3
         zI7U5R7xV7XhVZLAWZuSqUvs5ICh6yI5JX5X7LydTdVnNU20ONUiTpQ81FtSwc0qIG
         uUuJm1ImnfYi525Xev4LRb7T8qsci4I7sk7OBHeZYq5crR71aYO2wnlkFYWQ82lfp2
         wfYNPxeIIDF6qGMo3VZLDmxmzIvIoXrBFX6s55DYN4/05PGCABvQ3IpET1DASvLLgQ
         qpqDGgez5Gb5wpAJXt10gDz8RsrTmDYV51y1UiJ8Bxl+5FNmDn1jA9CxGyM7ZeEGhS
         JxHLydSrXOgYg==
Received: by mail-ej1-f71.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so5483196ejc.15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rHD29slkZOFSJhahaVYXmLu64XBgMMbFm+fpWjAlF0=;
        b=jZhYZRoCMqiQHk4oZmW6g/acV354gypoMb4VKPdn5ZU+nKXqsv1kYEA89ZtecC31ga
         ZOJopXxe4895VQKQrTLWWfxBjkNjok4I/0bq0h/htACnlXHlTpmRtSiw2r72ZA93+TNs
         hgmCmIUwn/u6Zvw/GfKPLgHRhzITYTln52m9kA7wEtmHQ9A/nZ2GOUIwTjWlmNCc2J1z
         IS6G1LiCDzS+TGv9uz/zaYoGdC4KkbBlLcDHgJd/+HYDSzIjG6Yo68Xr2W+qjZjUAWxy
         HovxOwkdfV1FD5iaFRxGjraKJ8K+zTOUa/HbUWks9JGZhCew9/o4mHa+TT68eMnhh427
         QCfg==
X-Gm-Message-State: AOAM533uIf79P60XTo517CGWAUuAMqnNp8IvSsGVQMVvZ0jEo+PwslRh
        L5nAvWTA6E+7zF5tNPqRZ4UcXPed7V53mGdKWeMCjEVQZ1ng9HWOCjX+942To7yMHSY8qemOslD
        Pg9ttqAUk9N8T+czEQnxQvPzbxVFirMu+DItxru4BTg==
X-Received: by 2002:a17:906:6496:: with SMTP id e22mr10192497ejm.263.1644826615558;
        Mon, 14 Feb 2022 00:16:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpvkONiH4FS0uQPH9alYGubO9/o9pYJXoAtA309TiungpCh9WYv1lWlRgqPAUTIAinl39jGQ==
X-Received: by 2002:a17:906:6496:: with SMTP id e22mr10192484ejm.263.1644826615405;
        Mon, 14 Feb 2022 00:16:55 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id t21sm3363642edd.74.2022.02.14.00.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 00:16:54 -0800 (PST)
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
Subject: [PATCH 10/15] dt-bindings: pwm: brcm,bcm7038: do not require pwm-cells
Date:   Mon, 14 Feb 2022 09:16:00 +0100
Message-Id: <20220214081605.161394-10-krzysztof.kozlowski@canonical.com>
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
 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
index 4080e098f746..119de3d7f9dd 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
@@ -28,7 +28,6 @@ properties:
 required:
   - compatible
   - reg
-  - "#pwm-cells"
   - clocks
 
 additionalProperties: false
-- 
2.32.0


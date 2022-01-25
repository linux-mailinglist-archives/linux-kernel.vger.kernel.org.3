Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F8449BA13
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1587542AbiAYRSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351700AbiAYRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:50 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF8C0617A3;
        Tue, 25 Jan 2022 09:12:46 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y17so5866180ilm.1;
        Tue, 25 Jan 2022 09:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RU3KIa4qrZXY9R48xjJEZLxL91fbwb33hYcDZGPVEeA=;
        b=KHvX4bjGcFWJPXQ91el6u/lSljusxx8pbcvu7lMe5WJ9FwnlTXtJ69WFqEVLsE4976
         RuF7fIouyHo1iSezLZbFkPem8wnA2SDnrF6rDwwnYZfdIbwv1dXNCkLCBTy+WpJydfm5
         EqcVwTs5S1iFUN1XY7i4NIgw7SCwiNg0+j7y7/lWwOjBk3HPSxr9t9cYTZpcSGbPaIIq
         or0eYS9JxmErq4ojq2ZQyvjFRmkcNA8Ava9Sm0s2Jg//dgpzGKZYQtbJibU+RLiyb1jV
         SHJnDa+wuTcz0PNhOea/uzau8fwSq0CQtWw5Q1KBWhJunAzkSrfVScL4LrwCdHeluWx8
         /w7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RU3KIa4qrZXY9R48xjJEZLxL91fbwb33hYcDZGPVEeA=;
        b=xyR5r63bt2pPc/8yClL1+QKFsEPo2dcV3FyR24eQHpIiblNiU+tK7Ckh1qcGqFza2n
         DwUlIv1jO/ym/Phc3bjTMbS1yHvQHG+EApyEsjZh7wrM9c1rGSEr460JI7Ylxw2+gh29
         Ia9c+fY3PIfgzVol37oD13NpTDWMIOgCzAuVf2ncyXYvWkZcjJL/cy8dvZT+VSk6Io3Z
         DqTp1iM6xgCIWWdxEt8PAjkxzih81bE1JeeU49bn+ZftGXyxO+B3p/aCNgmMQQP+QRqD
         2KYVl5BLR12CHQBb7GnGZ9m1TK2bbgFbLMoFd3x0agb1gJ7BGCoXkags8ENUGyd/nBHg
         QffQ==
X-Gm-Message-State: AOAM532jnmVVANLINwaTxH8h3xGWBB3hej8a2zIqejcg+PMPOGxohls0
        Ee0phqnxv6bZMK3IL0qShOraQJcD1e8=
X-Google-Smtp-Source: ABdhPJysd/AktlKpxM3/2Jwk3iYtFwARQhWgrwR964Q7bKGasZLBkRVo7UQcFFUdCsdTaVEYa5IG8A==
X-Received: by 2002:a92:cd85:: with SMTP id r5mr12345147ilb.182.1643130765506;
        Tue, 25 Jan 2022 09:12:45 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:44 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V4 09/11] dt-bindings: media: nxp, imx8mq-vpu: Add support for G1 on imx8mm
Date:   Tue, 25 Jan 2022 11:11:26 -0600
Message-Id: <20220125171129.472775-10-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M mini appears to have a similar G1 decoder but the
post-processing isn't present, so different compatible flag is required.
Since all the other parameters are the same with imx8mq, just add
the new compatible flag to nxp,imx8mq-vpu.yaml.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
index 9c28d562112b..7dc13a4b1805 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
@@ -5,7 +5,7 @@
 $id: "http://devicetree.org/schemas/media/nxp,imx8mq-vpu.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Hantro G1/G2 VPU codecs implemented on i.MX8MQ SoCs
+title: Hantro G1/G2 VPU codecs implemented on i.MX8M SoCs
 
 maintainers:
   - Philipp Zabel <p.zabel@pengutronix.de>
@@ -20,6 +20,7 @@ properties:
         deprecated: true
       - const: nxp,imx8mq-vpu-g1
       - const: nxp,imx8mq-vpu-g2
+      - const: nxp,imx8mm-vpu-g1
 
   reg:
     maxItems: 1
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377555E36F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbiF1IDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244834AbiF1IDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:03:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7782CB7EC;
        Tue, 28 Jun 2022 01:03:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k14so10383610plh.4;
        Tue, 28 Jun 2022 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvMf3PepUugPqVKhQRoUgt1ly6hwpig91v9ZXdNJXbs=;
        b=Fjmt0M1UVl7saO28IVQSKUeNq7CVK61mTdx2OLRFjYrnF46LcWL4yT9FNXKBWozPZd
         ipW3hlY0RkuzbxFOkVlj84dyWzAquEl3wE2OsbYQxAB6CBOLjB1aMKKZ+IhoPBbuVDi+
         ZpquvlsEvBTnZtGsVMWTHPsPNp6Hz/U/N7GG6QbeokVzGQZfht5T0yScWeykWC7UJXnX
         NJ7gJuxTy/rY7WfrN97E9TPRXkpZHEUOa38ptMjvQMQTxO0qLwBIF/6UaYSXQPmYtqwH
         GEZsLxh2SYX4QSZBd1/S7N9PCGmvJyYhPHn+qgA13r7ZEvJ+0fRhj5MF50pcLtK/NR/s
         fHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hvMf3PepUugPqVKhQRoUgt1ly6hwpig91v9ZXdNJXbs=;
        b=R44MdMBlaesjV7LQhWSYP9k1aWobtjL05Q0Vkjhm32Q/243rmfw2fzk7Ru3Y4IxLrr
         28J2wxiyBQVOeMU3Xghw46/tbvE6WmTaA+FNw0F6nhiaExLN0ELDBc0cjbFWsNvCLW8S
         XYdNjn/OacARZ2QzRoQ9AIoaszezZlpSp9oKIqDUwE1ClUTJ4keBTGl63D7JG0SHqqo1
         49djGQkuOsSvvtr+AZg4I6SScrPKb7VQfYsu2+DNDYlnm7bql3dFEF/ASFYy86A7q9Z9
         gwTVUhNzt2DHp36CgSeNgiiRInRrhi3pwC13f0hGKFHak6krPDcGRgLDCkFvjag6PO5s
         7b1g==
X-Gm-Message-State: AJIora+xzoGXVPg0WTMASWmw2WOWtiWGe9tX49tPHyXUswC7VBMKTGXR
        XXw0i3lxSNmGiZxMtHUaw3g=
X-Google-Smtp-Source: AGRyM1vRXYXW+HKwEgrbxihFSnoNxPLYaNicpTq544RfbChi0sKL9blFN20gnk7oKaJwSUGtvmRUNw==
X-Received: by 2002:a17:902:aa8a:b0:16a:1ea5:d417 with SMTP id d10-20020a170902aa8a00b0016a1ea5d417mr3880598plr.4.1656403391046;
        Tue, 28 Jun 2022 01:03:11 -0700 (PDT)
Received: from chrome.huaqin.com ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f7c500b00163bfaf0b17sm5249034plw.233.2022.06.28.01.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:03:10 -0700 (PDT)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, spanda@codeaurora.org, dianders@chromium.org,
        devicetree@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rex Nie <rexnie3@gmail.com>
Subject: [PATCH 2/2] dt-bindings: display: simple: Add InnoLux n140hca-eac panel
Date:   Tue, 28 Jun 2022 16:03:03 +0800
Message-Id: <20220628080303.2143291-1-rexnie3@gmail.com>
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

Add support for InnoLux n140hca-eac display panel. It is a 14" eDP panel
with 1920x1080 display resolution.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index a5568d1dc272..51e573615aab 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -186,6 +186,8 @@ properties:
       - innolux,n116bge
         # InnoLux 13.3" FHD (1920x1080) eDP TFT LCD panel
       - innolux,n125hce-gn1
+        # InnoLux 14" FHD (1920x1080) eDP TFT LCD panel
+      - innolux,n140hca-eac
         # InnoLux 15.6" WXGA TFT LCD panel
       - innolux,n156bge-l21
         # Innolux Corporation 7.0" WSVGA (1024x600) TFT LCD panel
-- 
2.25.1


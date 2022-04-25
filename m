Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8BA50E335
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiDYOfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238920AbiDYOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:34:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B012B25A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id s21so6450672wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ec2V5shBteoRtCqtxfW2R62kxRNZBNcV3MF01Vbbug=;
        b=QiN4139opvnc7CzgbwFybNYp1p3HrZRT5GCNAgla0IVM2Zrl5QTbNwNt7O6QWpiq5c
         q6aozGBMEuD/hUZ+T5epxetNThR1L4cIfvuoI13PXL/jFD9gZ+VWcNjBmz70A5PG2rci
         e2/svw3agvKn4K+x9FgPUk07rU0TEUq2zSZ13z1b6qtrofG2F8ncB1eGFCBfcKE/zv/q
         Qrur4q76PDloWwTneErY1Pd0sUCFQ0EwN+sg89GAJm8TpnbEI+PdLLmXj5xqKnHRAXK2
         2jfMMqmjoahdP2tEKgAy63jvuySR0jTe3oGPhe78+TIoNhxvnbDVkGUd+d9Ju9h3tkES
         8P+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ec2V5shBteoRtCqtxfW2R62kxRNZBNcV3MF01Vbbug=;
        b=KN6TD8RFxXjfg4G8Oo4kIs8vEViccSqPMO1j68tCLEFb2YzjEMxYMtgVoC+OF/t5fn
         UypYkJwGXaEmWs8XN4TqYfGqs+G6QkuCUYnh3j7nFylUpGhX0X7jGBCu9ptitvcu9Xmq
         D8l3bTA8CFCFHpW8xlfk/b0v+EMpv23fn0ozmSeCl8ghAPUG+uKzO3FzZERE32IDHRXW
         vNiaeg0/zZYCh6RMAjBDik5kkaPRPwxI2mVqAYQ0QEC93560FOTJsx6w1mGAg9uQL+pF
         q9j158c4cPg4oRD6VspnK6MWTFuLUXUC2el94NpiGfh1u2Nejv4G08qXnSP7uaEDr2qB
         If7g==
X-Gm-Message-State: AOAM530lgneCFidNlvQl7csqSM5NZjl5LY5OuDaM/L51h/uvlkq3/RuL
        W1nPDdXiz2wNE1eqR+4QzTGusA==
X-Google-Smtp-Source: ABdhPJwVJGTJ+1Rl6zqnCeUHjHWgEqFfE9hWxTo8PFA94FMtT7qnou41+6gxfsBIHbspyhCxwJpuxg==
X-Received: by 2002:a5d:4645:0:b0:20a:db5d:258f with SMTP id j5-20020a5d4645000000b0020adb5d258fmr4355178wrs.135.1650897092310;
        Mon, 25 Apr 2022 07:31:32 -0700 (PDT)
Received: from groot.home ([2a01:cb19:85e6:1900:ce86:3a65:67d7:726d])
        by smtp.gmail.com with ESMTPSA id s13-20020a5d4ecd000000b00207b4c92594sm8679525wrv.59.2022.04.25.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:31:32 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH] MAINTAINERS: input: add mattijs for mt6779-keypad
Date:   Mon, 25 Apr 2022 16:31:25 +0200
Message-Id: <20220425143125.163799-1-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in [1]:
Fengping has no longer interest and time to maintain this driver so he
agreed to transfer maintainership over to me.

Add a dedicated maintainer entry as well for the driver to make sure
that I can help with patch reviews.

[1] https://lore.kernel.org/r/20220421140255.2781505-1-mkorpershoek@baylibre.com
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5936f2d9d8ed..d092414ae7be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12139,6 +12139,12 @@ S:	Supported
 F:	Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
 F:	drivers/media/platform/mtk-jpeg/
 
+MEDIATEK KEYPAD DRIVER
+M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
+F:	drivers/input/keyboard/mt6779-keypad.c
+
 MEDIATEK MDP DRIVER
 M:	Minghsiu Tsai <minghsiu.tsai@mediatek.com>
 M:	Houlong Wei <houlong.wei@mediatek.com>
-- 
2.32.0


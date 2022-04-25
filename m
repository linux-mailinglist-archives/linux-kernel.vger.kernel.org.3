Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819C750EA71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245360AbiDYUZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245319AbiDYUZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:25:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89B12C8C6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s21so7784248wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNKqn6GgSk4bpiHhHcjzWzAApOdvZObjZd/qjun9sbE=;
        b=W0+hzDsyXNRUErPDaVkKaOZ8ON7Row/GsuoUT13wsSaj2QnuxFUn/r5WvW7TNK9xF9
         YSQSKQH80ebP+iHZohlvr4f4lhpiFxEFnBB2um3EWBUifD2390UyrawEW3j0azci7XCR
         VZLV+62XxeC39WNCrZ0VuvBVXNfjAUJr4y7e8uplt++3ldMtWQTUSFAM+JcX/3qluFDG
         0sNkaQ3fPwZeNORGpS4HwZGfQcBgpXKRqd0Vajq024YRA2E53xRlOez6zJ6KGQ31r931
         27fK/PXwWOh1ngC/E4idPt2qNj/p3bb/pcHBQ1EwKoFUfU5+AagnLhO3zjb4UEKMluYM
         LpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNKqn6GgSk4bpiHhHcjzWzAApOdvZObjZd/qjun9sbE=;
        b=Poif8LrwocMz7mqEGBpslG5RyjkxM9GFqSAKKEg+0x/vh05QWepeXfT0nfw9UFz2Qk
         L5KCjbniSKV8EM1KFSFKUjko3a7fRSan3sDK7baog1cQY/Ld2jntEyah7pwv2UKrB07b
         0qTCYWoJMNzqGcN0guFvqE/zcj25uMtV3mTfGojhxtmKMDsNdGKaODXgFk31CJ9AF6GF
         bDD5sNIgaPPva2okRMzsXVc6IADL9fJR0CD9XfXlBOiguX/+C7eFby1e3abjU5863Kk0
         tAnO2GHQXvP+BMtFtJE9aAlvFJAXfyv/m//e1YjvSP8uG1mSV88zCq7DXclHRy38Tfda
         SRwQ==
X-Gm-Message-State: AOAM5328UeYDKyC4JOBBTY6uvG2P4b0c1pno4pGV5J38ICGOB4af2zHw
        kS6rBDfzNbaWtmxq60+7s/680o7G9Kb7hg==
X-Google-Smtp-Source: ABdhPJxo1Ew0MzI0MJNR79IL+3D+t6orpWGHjYg0Sc5MxK8XNn3M5uHQCyKIgUGey+QsAY05sGQ88w==
X-Received: by 2002:adf:ce89:0:b0:20a:d917:5234 with SMTP id r9-20020adfce89000000b0020ad9175234mr6749610wrn.265.1650918102961;
        Mon, 25 Apr 2022 13:21:42 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p3-20020a5d59a3000000b0020a9132d1fbsm11101003wrr.37.2022.04.25.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 13:21:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v6 16/33] crypto: rockchip: add myself as maintainer
Date:   Mon, 25 Apr 2022 20:21:02 +0000
Message-Id: <20220425202119.3566743-17-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220425202119.3566743-1-clabbe@baylibre.com>
References: <20220425202119.3566743-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is set as maintainer of rockchip crypto, I propose to do it as I
have already reworked lot of this code.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6157e706ed02..1f3bd9b5827e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17005,6 +17005,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CRYPTO DRIVERS
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+F:	drivers/crypto/rockchip/
+
 ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
-- 
2.35.1


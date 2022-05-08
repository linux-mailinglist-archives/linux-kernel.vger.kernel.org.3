Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08CD51EF7B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378435AbiEHTLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbiEHTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:04:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5CC2C6
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 12:00:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q23so16716479wra.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZivRzjlDS3OoPoRTHkJnPDZ3sM1VA8uv4BaZC71qcQ0=;
        b=q/ppPaIIl+eqJvd8tj15Mlu/trxXjFCeCmxtUyJ5cmEHGhk0rr3TVqFtvFdE2vJYcn
         ElQ3xcAP5TfTxgz7TBisUq0CV2bqoIQ1IlukREGRA5lUKE4LBFGxovImG/SXa5XWw46m
         dLvmZ8is7gwVB9yVwJ4Kekq5/k3HhWUy7lRHeZgzoXuW3jTC/guENjHIyHB9Jom33MB5
         MGfsQK8Tf6Bet2xwwhKIfZYbBLPI3UO/hpwMUznRvhpBmdX/ImnGrp0YyiubDJ6xuaiw
         cJuc/v54Lxvr07H1zWNlyo6vONTs+gsd34B/MPNeAIRL5xpPRoIw/6ezdiQUJqlODTV6
         7b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZivRzjlDS3OoPoRTHkJnPDZ3sM1VA8uv4BaZC71qcQ0=;
        b=P79GTvDvU1c1ZfeL0nJIR0WJo7mV1rXTPFMN1Gm6wfwsnyaZadGW/tQk9IB+2j/hAn
         wAyJiAwZhocIK5bF2bi+GF3f6h9UDIYYPZhUvRpfrlhw6K9WAUXzX6wRpLcFwtKNozCy
         8czC+3DjO6YQDBElSlSi/hqO5iMFIInRy6L9ZymYlPx3ak8wCb5P/Ne62K0WStho7u39
         wW8I7rfWdkUz1ry78Rl2Q4jH32SXrunu58kb0aQ+SRvxkZ9rKv+SjPA1GaPaTMd3wJ8H
         ds4afrMkCKPXBqxkAsDqYTlcjMMjwo/a52cDG9fnMPuJzpbbyQBeRLwPTIo/GG/MbLRi
         NfpQ==
X-Gm-Message-State: AOAM531Z3TysEx0Do4V06fQEHpDOCFu1ijlbTKyqGYC3chWtg9+v9Wun
        2Le8nhhJ8dkUNpvawBLRjvkxaQ==
X-Google-Smtp-Source: ABdhPJzWk7REzNl7td89g1KNSNNFMCGphZgLl+KXy+0Kn28KbOpy+jUc008FX/AJp8UzERzAeDGPKw==
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr11031410wrc.150.1652036432499;
        Sun, 08 May 2022 12:00:32 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:32 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 26/33] clk: rk3399: use proper crypto0 name
Date:   Sun,  8 May 2022 18:59:50 +0000
Message-Id: <20220508185957.3629088-27-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RK3399 has 2 crypto instance, named crypto0 and crypto1 in the TRM.
Only reset for crypto1 is correctly named, but crypto0 is not.
Since nobody use them , add a 0 to be consistent with the TRM and crypto1 entries.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/dt-bindings/clock/rk3399-cru.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 44e0a319f077..39169d94a44e 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -547,8 +547,8 @@
 #define SRST_H_PERILP0			171
 #define SRST_H_PERILP0_NOC		172
 #define SRST_ROM			173
-#define SRST_CRYPTO_S			174
-#define SRST_CRYPTO_M			175
+#define SRST_CRYPTO0_S			174
+#define SRST_CRYPTO0_M			175
 
 /* cru_softrst_con11 */
 #define SRST_P_DCF			176
@@ -556,7 +556,7 @@
 #define SRST_CM0S			178
 #define SRST_CM0S_DBG			179
 #define SRST_CM0S_PO			180
-#define SRST_CRYPTO			181
+#define SRST_CRYPTO0			181
 #define SRST_P_PERILP1_SGRF		182
 #define SRST_P_PERILP1_GRF		183
 #define SRST_CRYPTO1_S			184
-- 
2.35.1


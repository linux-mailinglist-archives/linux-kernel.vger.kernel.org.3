Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0F24CB0D5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiCBVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbiCBVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:12:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F40DD952
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:11:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk29so4749701wrb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 13:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mEFtl1Tv/8nxJX+EKBZcS0Lbq1ln6/kUirDV/Y73Tsk=;
        b=BGC8nrmMzBNASLXkYa2JNo0/+8z6t4pK8iDFZsnFwNbRNywY9MSW+in1XAfzhpduHG
         M90eCf634zQDtoqa+KxYP+4Q/F9NrnUwkV0Hq71kfygDD9iDFhDTHeVYM8n8ancu8Wro
         q9/ekreyuQmJOIiEAHj2lugGcj8qN6donBz7TnBgMRMjnxKurRav02a5XZt0s7bdm37f
         jOPee5RfiLPG/58Cp4IT85T9UADV/4UDPF/HI21FDDDpr6paXJoX+WUysCA/MpY9mPG4
         ow3IXPTXuH8j0L7sjRZWe+DrZywMI/VqaQ9slo4SDoglDlfHEfFdESIhiJ1pYZCEv+VJ
         JhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEFtl1Tv/8nxJX+EKBZcS0Lbq1ln6/kUirDV/Y73Tsk=;
        b=pJXW2uzxN8bWu9261nKO4aLvX9JroFkZT6wuyF8nM/X9oXxPMj3rzl9pLPBqKED53g
         fNaHluIA7M3CxlOBg5g1Uqt8pTVzC2pBBz051hiXAUkzaNk77oVFe5rjQFKBgSeV2uuQ
         ayC+8aRFbQkgL+xu28uAG/EVIji/QqulG4ZR86HOso00B5ySTgAKj+cFPhU3sosFwXn5
         1udXkEVj3rXjs2nRa0YA+qluYxg5HdbX1bMTsRp06ZBmZ9k9Co9QTFGkljt/DGfK7bQ5
         KatelKHOd1YsWvaJSFz2Eyo5ZoVLZTVpnYd1gCSBrjPnm9DHcmwLXVx89ozLMhjeH/K3
         XErA==
X-Gm-Message-State: AOAM531wGenUjg0Qd1lRA/IxYUPPmNi9mJgGAvHs7aE9esciCaJqmyfI
        8UiBBOBLkLaRZLAz0pH2l0rSwQ==
X-Google-Smtp-Source: ABdhPJy3A1W9tLBSCIWiQnLMKAnn7XqQUscUgC/xxLeQMr8lptDLl6mme9vRIINzoq6iIM5uwmaMFg==
X-Received: by 2002:a5d:64c4:0:b0:1f0:36ee:15c with SMTP id f4-20020a5d64c4000000b001f036ee015cmr3143058wri.126.1646255486175;
        Wed, 02 Mar 2022 13:11:26 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm145776wmp.44.2022.03.02.13.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 13:11:25 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, john@metanate.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 04/18] crypto: rockchip: fix privete/private typo
Date:   Wed,  2 Mar 2022 21:10:59 +0000
Message-Id: <20220302211113.4003816-5-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302211113.4003816-1-clabbe@baylibre.com>
References: <20220302211113.4003816-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix a simple typo on private word.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 2fa7131e4060..656d6795d400 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -235,7 +235,7 @@ struct rk_ahash_ctx {
 	struct crypto_ahash		*fallback_tfm;
 };
 
-/* the privete variable of hash for fallback */
+/* the private variable of hash for fallback */
 struct rk_ahash_rctx {
 	struct ahash_request		fallback_req;
 	u32				mode;
-- 
2.34.1


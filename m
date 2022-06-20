Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAD552533
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344123AbiFTUHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 16:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244507AbiFTUGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 16:06:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB501DA7A;
        Mon, 20 Jun 2022 13:06:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so6194766wml.2;
        Mon, 20 Jun 2022 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6euAwHf+u1ItA2eK0so1Yr2FypSsHdAXRoV366E1T7A=;
        b=ltBWD1dr5RteubU05COvdKRAItNBE3XGRxsyg7vyiQ01v6gFjKkGQCa7AxlmlAlEzY
         AezfAXia6RuJ38Bg9CC3TjmJVkv+VhSCZoabV6MHfCWW/xklUdcZ/WY/1zIABVKL88nB
         WIUir0+yDu0HI5+CAA3jsSyTlvoO/BMKRYNcAGaUDoqrRUi7MUBaYNF+YGqEKRDqHCrk
         6NWMWphH7cTh+N4d7Wj2CRuYxpEAqY1ZRwT8qgOSayGNQKBdURajaEjI6DjrBNeapqlB
         yYOfUhgVlTPPPj0QyHa5BKMwDnq4P6Qhr+RaXEI/210OX3LUMTHtrnc7u7e9RyvHCH4H
         a21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6euAwHf+u1ItA2eK0so1Yr2FypSsHdAXRoV366E1T7A=;
        b=6uET5Ro9/8Ww4eN3QpdAKyQ6qK4YPGCtn7JOlzQd+/sil80jkyJrl/NT6mTJdd61id
         7PxE4SXjRlqirUbcNFQ6NhC7ewNB38ERr8npVmIWsCe5cIoD8SoSSoVPonENATbJXXJN
         tcwuNG7r+yJipK6B6yJ3TrHnBAA4k8eFRKDC7RvWu7BOkvJFha72+cxmeY6OFzJ2ESI6
         SJPOJmc/r4f//3BPrGYH+PbXVotr03Ess4wdSJmkX0gEq7gJwQdxFoEdbJrV9Cn4qK2o
         oZ1vwTfyfhHAm8eXTwGWX/xlgXS2fm3mmrURGFtZdLavFw7ccRyaI38MTfQy9pcIQU1t
         8DZQ==
X-Gm-Message-State: AJIora839Ae2QQaM+faGB893O8x4bqpHO/dLB/ISdJqDU61F2F1S11bT
        LEw5kgTfXN79fgovLHGCd/k=
X-Google-Smtp-Source: AGRyM1vvGym6dIu1dzL5D9w5ByCyaMzKJVi5dIkF/tCPnAULV9l/JONes8lGy1VG4OGs+OyJ5i+Pgg==
X-Received: by 2002:a7b:c012:0:b0:39c:529a:7590 with SMTP id c18-20020a7bc012000000b0039c529a7590mr26485917wmb.6.1655755601453;
        Mon, 20 Jun 2022 13:06:41 -0700 (PDT)
Received: from localhost (92.40.169.68.threembb.co.uk. [92.40.169.68])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b003973c54bd69sm19423794wme.1.2022.06.20.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 13:06:41 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        michael@walle.cc, linus.walleij@linaro.org, brgl@bgdev.pl,
        tglx@linutronix.de, maz@kernel.org, lee.jones@linaro.org,
        mani@kernel.org, cristian.ciocaltea@gmail.com, wens@csie.org,
        tharvey@gateworks.com, rjones@gateworks.com,
        mazziesaccount@gmail.com, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        jernej.skrabec@gmail.com, samuel@sholland.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        alsa-devel@alsa-project.org
Subject: [PATCH 17/49] regmap-irq: Add broken_mask_unmask flag
Date:   Mon, 20 Jun 2022 21:06:12 +0100
Message-Id: <20220620200644.1961936-18-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
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

This flag is necessary to prepare for fixing the behavior of unmask
registers. Existing chips that set mask_base and unmask_base must
set broken_mask_unmask=1 to declare that they expect the mask bits
will be inverted in both registers, contrary to the usual behavior
of mask registers.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index ee2567a0465c..21a70fd99493 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1523,6 +1523,7 @@ struct regmap_irq_chip {
 	bool clear_on_unmask:1;
 	bool not_fixed_stride:1;
 	bool status_invert:1;
+	bool broken_mask_unmask:1;
 
 	int num_regs;
 
-- 
2.35.1


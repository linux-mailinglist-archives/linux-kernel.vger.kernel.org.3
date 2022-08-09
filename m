Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3ADF58D4A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiHIHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiHIHcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216A1EED3;
        Tue,  9 Aug 2022 00:32:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l10so7553929lje.7;
        Tue, 09 Aug 2022 00:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FbGrIGAHhJp/faYmz82qs7Q5FS2VF0GR2GJ1cl1M5UM=;
        b=A4/NB6hQs7YAzVnSIW1tzll4PpJ/8TqKsheiN14pBB7krXkCKiYlMn9lQwHcoN7d4b
         2CFaPZ3rR45zCrrl1/bWeOaIEIXvWSziVPt6Kag7ON6FNIrcBSyfhfRnPiobZACgrXwe
         +XPzHPmzoUNAHiTQhVkoBj4UsMsVEiAKdRuUfVH+TX7J7l1z0BXc7cc5p3unVO1khBex
         uywKZfu5Dbptdaq0cikCK8y4yW9IRwr/TJpaK/VK/5iK3I5NC0eHh992b3puR9vCYSbH
         GBaWQY2NDxZN9hPs7AtI+U6yCGh8ByVLE8Zf5ND2043XnTGFaOqbbk8A+WgWLEGwTHHQ
         BtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FbGrIGAHhJp/faYmz82qs7Q5FS2VF0GR2GJ1cl1M5UM=;
        b=mP9LltqcotfxsCShgPxjTFybebjTmpuyyTcPfqYYVABQAICB08kaNY8MAlfk8sDj8+
         1BNgTi5WaFZD1+Wda/iMQglMi5TgdV9l692vv31Gp3Pa9lFERZ5jMqJTTQkspe5uzk1I
         MZWFi6Ms/j4SmJWLl6wEZ/qnjcws6ktl+wHv3VIwxCKqFV6RiLo2ggMsp1Pu1rRgmCrQ
         XZBwn08KEyQiNHLRokVYLmB27kx1ogiwLBmK10iUOHuKjRuDN37W9qc9Vis/d2lCjf27
         aYzl1JWZtE5LizU4wUtQkANAzIlNv4y+EFzUcTGdpyOzgyiCprO4Cg+Vt7lFMx/GkOKL
         fK2A==
X-Gm-Message-State: ACgBeo1Jy19U+ehHintOoPov4vRWY1FdHJSPvHLFnPV4BXoMhspC9UEr
        9D/2uPOHlxKMnCrHLepMwMbsQDKXcTjjtQ==
X-Google-Smtp-Source: AA6agR5Rcj6qS7KuUrq6Dlec0sG22Pv/33VKcqgKumBGGXotc5CXBxqQy1XwO7THvfX9fsRo3dS6ig==
X-Received: by 2002:a2e:92c8:0:b0:25d:6ddf:e71d with SMTP id k8-20020a2e92c8000000b0025d6ddfe71dmr6734711ljh.170.1660030347821;
        Tue, 09 Aug 2022 00:32:27 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:27 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/9] iio: adc: mcp3911: make use of the sign bit
Date:   Tue,  9 Aug 2022 09:36:40 +0200
Message-Id: <20220809073648.167821-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809073648.167821-1-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device supports negative values as well.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 1cb4590fe412..f581cefb6719 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -113,6 +113,8 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			goto out;
 
+		*val = sign_extend32(*val, 23);
+
 		ret = IIO_VAL_INT;
 		break;
 
-- 
2.37.1


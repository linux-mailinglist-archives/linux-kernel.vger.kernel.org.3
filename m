Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530B0554667
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353090AbiFVKQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiFVKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:16:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A8C3AA5D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:16:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id i10-20020a1c3b0a000000b003a0297a61ddso173726wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PV5l/qPIaVc2UdGzPYXAFK1SR2E90ae569+VbL0JX38=;
        b=q3/SypPg2Bx+EDeFhgEN8xqA9rbU32McCqgA8rtBXGJMnukSrlhXbn9YM6cNMAtcms
         Uif2w4FtkaBR/nJd2jdro7nEuuykFe6OJB5cvt1460qfjyXQ6KNIY8A4FQpdvowVj/kd
         HoFwIAEg/fZG9wxCc2zP7l77q1eqcMS10p6IgK5LYtYOAR1XcLtyXVaEwYjBABOOlxdo
         vU8MyrsOjEL41Nzh9peEr/b/impPpV5+SOMsYcPC7EM8jboen0Gy8w823SMnfMptHiNJ
         5VBLx2kCvVbr0A4ROZTQvPFU5SktGVy0mjYYNPBLpdaoQAwPpV5iOj7GGilV5Q8uJ+bn
         g4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PV5l/qPIaVc2UdGzPYXAFK1SR2E90ae569+VbL0JX38=;
        b=tZ+AgKufAxRMDVlwEMxv/mov6FbWSZdcMKTi2uIb3lEnVQd7S/LTrEZlxWmIjPDTkQ
         FElU8zf9300gpkM7GNVUq6obqdSC8H8wrDVIGRP4QqCE8GVdO6c6IDXOMndlVJdWpG0C
         tjhwlkLx6Ctdgs02nSYHfHo4IbLIMZg25neO2H24aSE7UjU44Z2s4itjXHEDYO+4U9q6
         kPTgfUu3AzKx0c5w23In0TKxh5SOB1uOaa9hkUlrQi8USM1ojQds0ctf05N26u6Ml/gQ
         bskgRKNl9NYJsrXHkBfx+JK3dytOGw/XXKIaf8UVrI61iRncTrP+SrhjXITkdWIHR0Z1
         8+tw==
X-Gm-Message-State: AJIora/ULPqkGoD4+LUSVBLlJz9i5U/+uo8nBUh5vxGUQJsgjH3ZAaNg
        OzfB6RJtqUqGGy/DSyER8a6sDg==
X-Google-Smtp-Source: AGRyM1sgXQCS7RfXwY5oOIAiqhuex4MXD0de1ceeGIuv/RbLW4evLvRCPWDYHJz4sMFioAelRYKuqg==
X-Received: by 2002:a05:600c:ad1:b0:3a0:2b9c:e46e with SMTP id c17-20020a05600c0ad100b003a02b9ce46emr1704522wmr.29.1655892965648;
        Wed, 22 Jun 2022 03:16:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u3-20020adfeb43000000b0021a34023ca3sm18460269wrn.62.2022.06.22.03.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:16:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     chen.kenyy@inventec.com, Arnd Bergmann <arnd@arndb.de>,
        joel@jms.id.au, andrew@aj.id.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, steven_lee@aspeedtech.com,
        krzysztof.kozlowski@linaro.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     David_Wang6097@jabil.com
Subject: Re: (subset) [PATCH 3/7] dt-bindings: arm: aspeed: add Aspeed Evaluation boards
Date:   Wed, 22 Jun 2022 12:16:03 +0200
Message-Id: <165589296123.29026.15593062333148193999.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-3-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org> <20220529104928.79636-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 12:49:24 +0200, Krzysztof Kozlowski wrote:
> Document the new compatibles used on Aspeed Evaluation boards.
> 
> 

Applied, thanks!

[3/7] dt-bindings: arm: aspeed: add Aspeed Evaluation boards
      https://git.kernel.org/krzk/linux-dt/c/7752cf2fe2d533c7558423c9fdda002bf0fa6476

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

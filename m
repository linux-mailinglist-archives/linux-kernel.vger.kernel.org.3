Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F66755473C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiFVKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238239AbiFVKSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:18:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC093AA73
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:43 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g26so11767327ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDIAIfYa1wZqErTQAQkY6lDsvB17Bzjh5kLg7XbRCyI=;
        b=W/Xu2zxueiM/FDUQIKaAR+o3BObdZNQyJiX6J9XHRUZtZDEVlN17qP2SXvXqaBhYIs
         7sncquN2cz3Y/TVhVA44GazQhED3ZhZozXP3NsC/qPOlI+d0ncOa8727LRmI/b2Xd+BI
         3C0IcvvXicr/5BGlNfV1szDlT00GC4Yh0IloR+UYNQUX+R3KjZnT+J8jOkGdEYErXh3s
         G6xHQMNzQbbEYuGBSxdTF58KcUrVxVMlewjw8EsmLrXJMIWplC8ocC2bHMivswYDtvuH
         Bytul0gwd06pV6PToxY4yqo/CAKt6eT4v8ReJ/c+HkyfLYReUc1IovfuoOpYTsVc6992
         WAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDIAIfYa1wZqErTQAQkY6lDsvB17Bzjh5kLg7XbRCyI=;
        b=Y0J3fQaouh6Qx1Q87UJ6ts403eBlE64tE7mqbmXeZaxuiJrLcKsinxa8NM0DoezTL4
         dSCLoIqXhzVcAooRZSEaE0X2j4ZKg83MJS5welf+vKTdB95a+h93u3G90Hxg8tD8CVKp
         L/aiI0DgL9yM/mNd+N655fxwuNL7uD2L4ijX6RNsYSDXd3FvSvAFfV7UeH1N6j02JI4a
         D+8AJg5A1ZKHsQMBqtZsFDiYRL00ALMiUq96kdjdnYjMO/gWvo//fyOcWBk02FMzDW6D
         W+2zLIR4/OmvfXbweO4S9GY/sXKIXfzrjDvUBq7SGy+v5z8Qjf95MwOtH8zmymODSgsh
         00rQ==
X-Gm-Message-State: AJIora9kZlZot8Rng5rOp7OqFE6mmF2PrboDvaR3EPp05Hx9FMb8CCvc
        DJqsaOHfAhgcS8Cvju1TjbZTYg==
X-Google-Smtp-Source: AGRyM1sW1vCW/gmsXrvOjh2leCLICnUswRvl8RG/IIW3duvVzkOlgQgDHclcqDqLgTYcrv+n6uVDGg==
X-Received: by 2002:a17:907:968b:b0:70f:30b7:9324 with SMTP id hd11-20020a170907968b00b0070f30b79324mr2467406ejc.19.1655893062296;
        Wed, 22 Jun 2022 03:17:42 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b006fe921fcb2dsm9028707ejc.49.2022.06.22.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:17:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     steven_lee@aspeedtech.com, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        chen.kenyy@inventec.com, linux-aspeed@lists.ozlabs.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     David_Wang6097@jabil.com
Subject: Re: (subset) [PATCH 4/7] ARM: dts: ast2500-evb: fix board compatible
Date:   Wed, 22 Jun 2022 12:17:36 +0200
Message-Id: <165589305701.29629.1874683425220257656.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-4-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org> <20220529104928.79636-4-krzysztof.kozlowski@linaro.org>
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

On Sun, 29 May 2022 12:49:25 +0200, Krzysztof Kozlowski wrote:
> The AST2500 EVB board should have dedicated compatible.
> 
> 

Applied, thanks!

[4/7] ARM: dts: ast2500-evb: fix board compatible
      https://git.kernel.org/krzk/linux/c/30b276fca5c0644f3cb17bceb1bd6a626c670184

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C09D554817
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiFVKSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbiFVKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:18:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CC83B560
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so10650090eda.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sw2lC+m2hGDUwBL9IFA6pBssodKXCe1mWf619i6f5BQ=;
        b=hgLMdhIMgiUy+MoiXvHJ2RJ9Wa0i1ZtMh73G1txuIKpg2AaqgMOwrM9CZPZ/sxDHYZ
         IMgph9yXYODnsgCQbf4TNClb8Ig7RHB8cabwDRw4cDlk7Q3tjgmmj0W0xB/iLnHX9n9+
         Z8bXF7T8T9B2ZVaGBQh8R7pePDlE1Jsyt6uy3Cg43YaZMkrg22A4aqupR6A21O0xhUxe
         NfLmARQNCl5rZsME4DXIfs4bmbmy00RiWWWZa0lQ95N05AvVsE3cb9WiA8niad8+VBzU
         ZZYwXKW3uEtEr4BOYecqDjltS0jA1vLMCuh4PfAP28A+VWI6iJ3iH/8hwi7X/rmrneR6
         dZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sw2lC+m2hGDUwBL9IFA6pBssodKXCe1mWf619i6f5BQ=;
        b=XqsP22moD4yKveiGLItZJlxEKTbHDVZkYNphIZQVNtKQbFQMzISq9LjB2zH+T1MDxJ
         OYeYYL+h9lQGkxdOxOpLffOM5eRe+w0YfuKkocYxqwuhdKuPgb/P18b45/jSo9DAhNnY
         g3qpkB8CYnXZPJ1FuIqPL3SCCG2eARNWmKB6HVUsVhL67Ki7Fvo7WmsdwHbe7AN+QENR
         Ww+LlLUPsvARpTaMf7++6jmXCsl/YCh0NG0j+DakOTKxBaZcpv7crN/yZgTzOPMcVLIX
         uopsRkjpxdVaDzWHjLUf/LyvR29cjZAGeysPK6GLl9upJYJJ7xFIMex4F1PrCEylHPbU
         N4ew==
X-Gm-Message-State: AJIora+LK9GxYmsmR1mWGhuNBL5+2G6xkO1ZRa02XaJABQZbtsQfI1VW
        SekwQUobU/bZLB7WL4Ymjmfq2g==
X-Google-Smtp-Source: AGRyM1vibWYX9QDeWYNt9B5sInQlF+vF5g0R5kz55sooOwbcMXMh2vUXX0FF1o1QUF932CUm0pAP5g==
X-Received: by 2002:a05:6402:28a2:b0:435:798e:2988 with SMTP id eg34-20020a05640228a200b00435798e2988mr3220145edb.217.1655893065351;
        Wed, 22 Jun 2022 03:17:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b006fe921fcb2dsm9028707ejc.49.2022.06.22.03.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:17:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     steven_lee@aspeedtech.com, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chen.kenyy@inventec.com, linux-aspeed@lists.ozlabs.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     David_Wang6097@jabil.com
Subject: Re: (subset) [PATCH 7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
Date:   Wed, 22 Jun 2022 12:17:39 +0200
Message-Id: <165589305701.29629.10216921074802952879.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org> <20220529104928.79636-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 12:49:28 +0200, Krzysztof Kozlowski wrote:
> "qualcomm" is not a documented compatible and instead "qcom" should be
> used.
> 
> 

Applied, thanks!

[7/7] ARM: dts: aspeed: centriq2400: use qcom compatible
      https://git.kernel.org/krzk/linux/c/6202c6063145cf9ec22b40aac219122dd702a10f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

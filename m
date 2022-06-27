Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87B955CE32
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiF0JRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiF0JQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6A6250
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z7so11994456edm.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4yCp6aTXqUcXVsV0Np3Dwjlcr0jYRXR8pM5bj50a/ow=;
        b=A/AH+rqyBgloYrW3r5UfZDex8wxiYwvMlaBdRYE7DqkFvHJv1lz7pOR/uEcpmNDf9l
         zoKpIHNYtN3yFJ228uMZNAnlykPHvFa+gNngWSmW2m3U5tHGDjyFU4fCRgLVZzCX+7v7
         iR6YiT2ta/zahwUpgsriaTIUU8CowWzLoEqU2tRQxCpf26W4PdbMuwSkSY+07eDKgS1Y
         CFBaeepxTVduRlMysqV8xzkmf0E/oeTQ5QJ5f3Q3Kdyq/jkfsZTJsuuge1K+u3xnN+wo
         us/25Le2kjU2H/YI3g0DTEVpCEu+hydMJ5uDE9vI5MBrlPKjTo7RU45fA4UjsxPspsU3
         xwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yCp6aTXqUcXVsV0Np3Dwjlcr0jYRXR8pM5bj50a/ow=;
        b=Yl+9IL280zVYo43rPvmZqKbF93jbOOJefVfrxyePiSjybkh3P8aBT6zS02Pe/BIstR
         LBvbirLVGmj165/61KKLeiml+xioj+fZbJ2G0zeVnuR8fl/fkET2r6uQvsyVW0cYh+Cg
         Fb5bpQNo3irqDRRZrOY4Qve1KC3O3Ua2IuF0SONwYE9mvWtZT4Qs+bPmFBMR3fLQSdTE
         0lX9u8HPTnDNQata2xsMbVnIOQ5vH+dJI8VWg/o2Z78GP7794VEb/1qpr2TyXcO5vll7
         umgyNu2r91UhQTFl8bsUEAJOohHdBvfI0O2i3FcC5Ml4ZLknMBZcaPS26E94pT6XKc5m
         E1yw==
X-Gm-Message-State: AJIora+t0YL7HvjfPd1iOwhEdKSikxj6XmBWHaQvjyhftewwii5Tu/ci
        TOMtCf/URdXqNYAldyBLqqOhSw==
X-Google-Smtp-Source: AGRyM1tGxNBHWOJWILt1IIISQWZABMsK2JgKp45IPF/kZntw7pMPmbIgZBPos3nCiw1YiVXFdIO6Nw==
X-Received: by 2002:a05:6402:2549:b0:437:788d:b363 with SMTP id l9-20020a056402254900b00437788db363mr10845669edb.406.1656321387840;
        Mon, 27 Jun 2022 02:16:27 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006f3ef214e2csm4805395ejb.146.2022.06.27.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:16:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        arm@kernel.org, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        olof@lixom.net
Subject: Re: (subset) [PATCH v3 40/40] ARM: dts: at91: drop unneeded status from gpio-keys
Date:   Mon, 27 Jun 2022 11:16:00 +0200
Message-Id: <165632135506.81841.16359602083216967103.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-40-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-40-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:33 -0700, Krzysztof Kozlowski wrote:
> Nodes do not need explicit status=okay.
> 
> 

Applied, thanks!

[40/40] ARM: dts: at91: drop unneeded status from gpio-keys
        https://git.kernel.org/krzk/linux/c/592feeea113553be142680a25a9c0850daae3567

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6793E55171C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiFTLPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241866AbiFTLO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:14:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837716580
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id g25so20367277ejh.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ClzjJShbVFx8TaQxCfkeV22/Wl7HoeIA99LoGmKA+g8=;
        b=JbBGfXGBvpV/uk/dk4gI9PUkSHtjiE0n6+v4S+HKY8ZkglzgWdAERXCGgfP+Il/ckR
         tENuRnPpbnOIl7roKYNXVPtDdEkHS1LGl0H0oy+Jahjjhc5d3+sEyzb8wA6kk39sMpRj
         1Hij+r/IT9yIrpYmjZaIFauMUOR3ZHdg8NI/txVus2RPesI8MnkiHEGcJcEmRzhA6uo/
         JpSxS+ToNCDSQgmkYQlL5Fahxk1rbnnotErqGYbC3jvBTit02+oNx+xGCiW1FYaRQY2A
         hQRBSRjb7y8IKFI1ddSrzCy82n0d+Y4j13z72UIo3IIgR9fYMk6qB74PuqgTVMWR85Gm
         QEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClzjJShbVFx8TaQxCfkeV22/Wl7HoeIA99LoGmKA+g8=;
        b=ukpPa+XeKgkBj8pH0mJ3Zx9ogZFSNW1IieNflWmSCbA0Q5xLWk1WN4H3Ckf0isSDN8
         D55y59cpMEJAkAiDrMZGyXprFG+QDbDleYZArU1VcF4EjRrYNIYpO6UK2ZjaR+UO6TtN
         JcWwKsoHrbXlOXZyUDSI/Gfd83xgasEQ0U4YU2sVh6zRx6dvhnIxo0WEZPtTACz3Tu6y
         vJ1sP9gB0jolK9fIh9jJrN1F3oa3H0GH7cPfC5VylovBxZJYiVWDk7r1l46+6igPfYga
         +dR/l/PCrgr5H+fZOnTK44wd3pgpA2XvckWIv3RrOC8slSwSogQPji6DnVTjjrjnulq+
         aKSg==
X-Gm-Message-State: AJIora8uMu7qFqXJZgcNqDzKTr/JrOXCleHSXTrk+BuavyvYyBM9yiC2
        C6MUR/AVvlmrZs59D2y1HczpLw==
X-Google-Smtp-Source: AGRyM1s3OCH1IXHmN9/QkFae5Zxbc8cFd2aL5mfxKeMADz7GSrTDrB9hE+rWIu/Wws4tYGNcmbhvmg==
X-Received: by 2002:a17:906:730f:b0:711:db1a:fdb0 with SMTP id di15-20020a170906730f00b00711db1afdb0mr20529013ejc.54.1655723683183;
        Mon, 20 Jun 2022 04:14:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b006fed9a0eb17sm5699969eje.187.2022.06.20.04.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:14:42 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: Re: (subset) [PATCH v3 10/40] arm64: dts: hisilicon: correct gpio-keys properties
Date:   Mon, 20 Jun 2022 13:14:33 +0200
Message-Id: <165572367262.35195.3017202631161821565.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-10-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-10-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:03 -0700, Krzysztof Kozlowski wrote:
> gpio-keys children do not use unit addresses.
> 
> 

Applied, thanks!

[10/40] arm64: dts: hisilicon: correct gpio-keys properties
        https://git.kernel.org/krzk/linux/c/717b3096da2ea205c6f31b4c2cd4485671d6ac79

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

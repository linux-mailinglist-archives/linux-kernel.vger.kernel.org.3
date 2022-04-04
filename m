Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BFF4F1BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381464AbiDDVXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379422AbiDDRKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:10:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41640A22
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:08:24 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id p15so21314110ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipAqGG7z/bjCUbbldP3QnV+u1TlXP5SNSAgJPZ9hWlM=;
        b=tSbHRuk0MS99cFdUeFR5R+Bi+PRSY64qtW6Lf4huO9G8fxmYBDwX7spLTp9zDdol52
         8kS0e+VjSYjukxT7BgcWDxoh+kcqD96cHT9H44ZX2LV5HSU9aC+vmrQfvRhzMt0nHX/t
         /jNPLQZ/RtEGvq9InDA7ZO25gSYZIiIML/uoQQshCdQuccUyvHhdxH/gTnSiNDac6EKo
         tOkPjqQYcBSS/0duMoB7XeLKTHEDR65OJZu25pkPCkVDdrRr76g1UiLTCqvYKtYYcTRd
         iBUkUiBYfBjVpTP0Mljns25yJLhePuQ+u5G4xLgS3x7/M4MxfWEAkFTrejZWi4i8Xwaw
         5P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ipAqGG7z/bjCUbbldP3QnV+u1TlXP5SNSAgJPZ9hWlM=;
        b=ZNXACb0OJ4VSUrWapDzAVJDOuME5WCWrHHlP0ZUOgabfMunlxlxYzC65qCK9cpvxMT
         TBSuoiA20nY3hsrdrbpIR7zjlfNErKtKA07HN1la3gBmUptqFEme5BHp2X5BbRjMJUc5
         PaPgnDM1dYdwoREkpTQ3x6GkkTQnOJV1cvrNicSEC48uJulGi2je+rvXxZC0+EhQs4Bo
         bh8oBf7s6GajQ8NAfdzp+iC3enbvY13CpBwEjlju8agMDK/33f3ntJ9LqpjxEFdsDBKr
         ejSoNZ2hSDD0O0NcNnWHXMT2i7RmJve7XKzGdIdlb8KVbcxpQeoQ4aNNSvkBKLNaV+2U
         ZgDg==
X-Gm-Message-State: AOAM532HQssyeOOl7LVr51ga4LYpPp3lIVVrzYov5vHwCpFr4ZXJkv1Y
        MzCkMsfCU3dh7Jrw0fm1VP4Vfw==
X-Google-Smtp-Source: ABdhPJzJ8ipzi3tPzGp8I9/ArDVIgRmNh/9yQj48sHdg30kofjOAJMlZ5iYjtDAf0ZxTd3p/RSCB6g==
X-Received: by 2002:a17:907:9606:b0:6e7:f7b3:5ef6 with SMTP id gb6-20020a170907960600b006e7f7b35ef6mr1130451ejc.332.1649092103093;
        Mon, 04 Apr 2022 10:08:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm4565827ejy.132.2022.04.04.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:08:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] memory: atmel-ebi: Fix missing of_node_put in atmel_ebi_probe
Date:   Mon,  4 Apr 2022 19:08:16 +0200
Message-Id: <164909209237.1690243.5430999106496739107.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220309110144.22412-1-linmq006@gmail.com>
References: <20220309110144.22412-1-linmq006@gmail.com>
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

On Wed, 9 Mar 2022 11:01:43 +0000, Miaoqian Lin wrote:
> The device_node pointer is returned by of_parse_phandle() with refcount
> incremented. We should use of_node_put() on it when done.
> 
> 

Applied, thanks!

[1/1] memory: atmel-ebi: Fix missing of_node_put in atmel_ebi_probe
      commit: 6f296a9665ba5ac68937bf11f96214eb9de81baa

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486284F1E25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381404AbiDDWIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379423AbiDDRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:10:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0E40A23
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:08:25 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot30so11392685ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gE+w/j83z+j5pFEpkVfRt65zDyjwfQWBfmU3yi7pNz4=;
        b=Z5ajhx0rAWO0B+WgSD8sPn72nbeudyCmwS5vob1s31OX28awvdfYeRSUPWxQ83CYqN
         hypRsAR6KiJfB/q/j8/zF3XgpOot7kIuVUpOVaos4vDb3/Hj0NKYvIxsexoTTbAnn0NP
         n5dFL7RqPfSwOOzeLar2e31X+N6WjT2x+Jb+pEYdCSwLxFNQAS/qhYlgfy8wFsRMnVR7
         YOEcS69a37c86FD4YIPkA8JVYdhNMcrU8OhTtspKIRAJy05kRQeWe8wPYMXb9+GxLOuY
         J4DRavI2x8ieDtRP6MOIdyyB3+GBSVET6KMXhaJZw9fAxWPz82aJlC8OGaD6VK8+DYpX
         onhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gE+w/j83z+j5pFEpkVfRt65zDyjwfQWBfmU3yi7pNz4=;
        b=dyIVsrvNGYA4KYQVXeXlSioHef5TtcUYRIoi0WIwZW6cZTpR8T7kX1e1bGFOyEdwam
         V14oGRnKguQX1ewLpUL7WVZOfLwuYc8v+3rO870xUHXFMPIHNLOJAly/TRwuVOO9TIa0
         YPQ2tkaKV2xCY/CxxOfwgwZXeQrIVLq8aG1fh4DFUUA28PvNizWpcrd+1iWcAqH9ExZs
         TjsOQw1jejbja8F+7YRx0CA/jAbdMZPm2Nw8Ou+R1ZfCGLb8FNf+u4xO3s00FsXO1Q2k
         Nunopk0fKkArRv9fYcJDB6kowKok6T0fqLmgYutyHSzRgyBiYjjTN4Q1jMfXfNgm+gTi
         BzaA==
X-Gm-Message-State: AOAM530J7h1XuSmLo3/bPS85BLi/0UZZDxFgf/DaB6yvjTjKV1Tvl5hd
        kCAmkHR/8nTx47uQtTSQv+FymQ==
X-Google-Smtp-Source: ABdhPJyIutBGaqFTl0dav6T/02/aRGrIX5ffFX87pkIS7/d7sWASJJUMEmE2oijmlP3Ba3tWeflKPA==
X-Received: by 2002:a17:906:c111:b0:6db:cf0e:3146 with SMTP id do17-20020a170906c11100b006dbcf0e3146mr1108050ejc.280.1649092104286;
        Mon, 04 Apr 2022 10:08:24 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm4565827ejy.132.2022.04.04.10.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:08:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     dinguyen@kernel.org, s.hauer@pengutronix.de,
        Sherry Sun <sherry.sun@nxp.com>, michal.simek@xilinx.com,
        shawnguo@kernel.org, bp@suse.de, robh+dt@kernel.org,
        manish.narani@xilinx.com, krzk+dt@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH V2 1/2] dt-bindings: memory: snps,ddrc-3.80a compatible also need interrupts
Date:   Mon,  4 Apr 2022 19:08:17 +0200
Message-Id: <164909209237.1690243.4980500786689807223.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220321075131.17811-2-sherry.sun@nxp.com>
References: <20220321075131.17811-1-sherry.sun@nxp.com> <20220321075131.17811-2-sherry.sun@nxp.com>
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

On Mon, 21 Mar 2022 15:51:30 +0800, Sherry Sun wrote:
> For the snps,ddrc-3.80a compatible, the interrupts property is also
> required, also order the compatibles by name (s goes before x).
> 
> 

Applied, thanks!

[1/2] dt-bindings: memory: snps,ddrc-3.80a compatible also need interrupts
      commit: 4f9f45d0eb0e7d449bc9294459df79b9c66edfac

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

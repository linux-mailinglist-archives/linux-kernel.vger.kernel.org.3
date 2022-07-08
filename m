Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1C56C256
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbiGHU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 16:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbiGHU6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 16:58:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C25EAA;
        Fri,  8 Jul 2022 13:58:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w185so84005pfb.4;
        Fri, 08 Jul 2022 13:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxD5sTcZMquHrrPEk7eG6nkr8w50h82786De/Ri3JgU=;
        b=LbT7P9baXBN4Lf1Qqmm+RSL7dqklKJS0NktNG9i6pKOZfKpfDbCZ7u8SrlfuLN0Jo6
         SFpKbfHtpjChCbCp+0lLzpjkgRlj7W9qeddfuEJDsIrFJOZhHT1XLz421J7Ku29P7Cu5
         xj3t5CpRqxl4NENDou+hIGh08iggQ0ad9qjo1hXKQ5TNeeKq5zviUzOm7dxqV0Na+m7d
         x6EVJB58A7JCbB6dOqnqa8dEUZ7U9UEVaBq7d2vvKyphKA4/0YRtzkpyx7T5H2xQm/1M
         mb2DJU8W93OmPpBAXt2YvcVOnmEbxAfRY3XRpsH5SidP0gxdwd8vf4nCQJt+UaMrau7z
         gZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxD5sTcZMquHrrPEk7eG6nkr8w50h82786De/Ri3JgU=;
        b=Q8YRYkNy/8yhL2rKoTWCd6LGr/OY+I6nP6qtnEnotzpkTBsRdV+AhE5p1fOVKIixrL
         EB5I3MGWDnqM3aQUh3900Ro6aVbQQty5ROfVOaEbQNJOpJc7R8KF6jfDxDFkE+pZkTyq
         2HctaiJVI+Uzn0yDCS9s0VPQZZfrS/UjDXltarpWfK0dRukTdOmQI7AiffQNal46r83E
         M1IOO0Xf8JaDzTaKa668srOdFM0iuzWAso4jGLjbIpJuuYI8h8bwfOxaWKVUL2j3XCTi
         PQGLmreLvj8fvLBjBVHwoIICZq6jVjmE+EEdaUNP3caLTSxrjkz3M+yLxPIGD7udhHey
         0CSQ==
X-Gm-Message-State: AJIora8j+WUnlqqPSQzx5dBmewu/Eg5j+l9QcdRfPLIhYegzLd24DPrK
        nJpPwzo41YbIxO+jNHeGzyd9+8duDlc=
X-Google-Smtp-Source: AGRyM1uvMO3xWX7ff+A/on6UqZxaLnxvC3e0/WDi1NmhBiRSww7nvvImxh9K1/nyM/p3cjX1FPkiEA==
X-Received: by 2002:a05:6a00:1693:b0:528:3c0:5825 with SMTP id k19-20020a056a00169300b0052803c05825mr5732062pfc.21.1657313932566;
        Fri, 08 Jul 2022 13:58:52 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902b58f00b001677d4a9654sm30310529pls.265.2022.07.08.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 13:58:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: arm: add BCM63138 SoC
Date:   Fri,  8 Jul 2022 13:58:50 -0700
Message-Id: <20220708205850.2408654-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707070037.261532-2-william.zhang@broadcom.com>
References: <20220707070037.261532-1-william.zhang@broadcom.com> <20220707070037.261532-2-william.zhang@broadcom.com>
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

On Thu,  7 Jul 2022 00:00:31 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add BCM63138 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

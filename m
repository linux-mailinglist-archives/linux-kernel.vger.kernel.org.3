Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94C354A143
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbiFMVTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351619AbiFMVTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:19:40 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128A28E03;
        Mon, 13 Jun 2022 14:02:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id n28so8868301edb.9;
        Mon, 13 Jun 2022 14:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q+yaULdwu+rPL5G3MbWME0SaA5eeeXALvtNnWDC8wYA=;
        b=Z3Zp+je1tvgRYJne1HFf3ZU8TV5rQ6wVEdKi2Ozg9+v/gZF1Q7EdGSU49t7iJbACzr
         T60Bn+ddWAdg5eWnfRIB9uAQwPTuvHmXB917v7IPvts0r3jpZWWefU7QacBSK9uwNFZN
         c8GDDbZqjrTisqwCR/vGfpKSHzXLv/V+6/OyOkGb3CTI6/dQ/4ke0F++EiV+3On1WacQ
         mGnKAGI887a7ydBLuwYrYT6GHYTtqoYE77UDQ/X/KatV2tWb1fkYwcG9r1PuYSR9PBZZ
         /+aq1qaKfHXxUomXC+UZrSaEeyNsTVPKnZeOxKLokpF8ku2eturrAlCy4DJg5gNozN0P
         fAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+yaULdwu+rPL5G3MbWME0SaA5eeeXALvtNnWDC8wYA=;
        b=x12TKCMwoUf84195LPg4t8aXMvOx9tXNNd+YxdEtJPibWUooPxdJEJS4cFGtjqZaXd
         I8fpGlYF9FuXeDMKonISCDTUafYQlVAQ6CaeH0AXv2tFG8SkTzI2LnlrJqSySr1MSNnj
         4FIgtxclYXl5Aa5B277G8Xqzyvv+87Z1+ubQw0Z3UvLhl7QBD2ddMSKlPdkflYS2u9Cj
         EWa9wSMQBoHS6U/54+P0BvY9uSlIOmUm85UHjxSdiKIdRYpZnN3B0vs1Rqq2Cn/hRoCK
         jhQkbsiV0l57MEUvuwxDmzuFN76c74YzvA4LWikVRgQ0GC5sEQl1y4nIWNhgXVAUWIRP
         dEQw==
X-Gm-Message-State: AOAM531zOLablglAG6yFJXUjDPWvbR760MRCa6dQW6ZZ0SQoZdIB8PYk
        QocmBAWO1vM4KKNh1v6+VB0=
X-Google-Smtp-Source: ABdhPJxQQjQlNd90jfnjQ5cdDCsNYWfxsyeGYqf4sXuU6zLN/1BV9Z4Vj7CJU7eESLv+NSnM2GcZAQ==
X-Received: by 2002:a05:6402:3293:b0:42e:18a:d6eb with SMTP id f19-20020a056402329300b0042e018ad6ebmr1871193eda.293.1655154148518;
        Mon, 13 Jun 2022 14:02:28 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id q23-20020a1709064cd700b006feed212f50sm874123ejt.184.2022.06.13.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:02:28 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 06/48] ARM: dts: allwinner: align gpio-key node names with dtschema
Date:   Mon, 13 Jun 2022 23:02:22 +0200
Message-ID: <4743697.31r3eYUQgx@kista>
In-Reply-To: <20220609113911.380368-5-krzysztof.kozlowski@linaro.org>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org> <20220609113911.380368-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 09. junij 2022 ob 13:39:08 CEST je Krzysztof Kozlowski=20
napisal(a):
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



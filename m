Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF37551715
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241380AbiFTLPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbiFTLO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:14:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB5B15FED
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so20359664ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=r1VUPW8HeQuAus0WR/qhUKBR3nAc6jn8bNOOeAD1qP8=;
        b=L1yo1JH/rvcvHc/Jbcu20cw3a/qNdXrtoauJZcUZ3IGQ94HyicsrikmMoh5BfIsq6c
         fwYLf2+/k3VJErueXETFvnMvxL4p7EFOEfAdYBPP4AWLyNXcWdstxzRlstQEqc3WgfVd
         TuLEhqh42z9V14I+bq7f9TYvvLmTidmPAGIyOB/8YjH7IZb+8kinjQ57yfjI6xXtVWln
         /HkXyN/HCcVOz8HPImnAmRGsxnizPXBtY4t6rpl2K9AC7uMTb4giLJrAZrUPnnwxOSeS
         AhYpn4K+FY3J75Q6wpKdunHYFkteZ0gLMaX1zgLAS+nc/05jmYMi85TyaU6UEKGBDjdB
         uMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1VUPW8HeQuAus0WR/qhUKBR3nAc6jn8bNOOeAD1qP8=;
        b=OCgziewUgvPUmXfS6nyHUcZE/g1PdQOENnnC++SVwOOh5YK6rO9T2yADXQRD73Ctfb
         q5KwCMx0UN2KxA8eaAhYgMg6Oc9OQNYGtd0FULrORZajUcSPDofcIaWgLFvb+m3Lxg/C
         2FJvliNWKrAwFLiImVnEihU3aeFbUr/g9qZO1hL0UkysGGclsIzzGp/KhNADxVfLz/qZ
         4XBG7d62FfgkvpmXRjDoF1mwlYzUA/kMR4r252j1HwyV2vNDT5TG0zjSNBHdsyHfITnP
         mg0e9SvUusZeDNUVkltibM3DbxhwzwOE7IwadM2g73OVi3tNG/ZsAr/mA+XuQzNx1qlm
         KPRA==
X-Gm-Message-State: AJIora+AyYYetGAv7cmDBb27nfzcq+Cn9ZTjSKMUMqOXGUDrZRwpN+Lj
        qODc162B/zfIPetrJqOT1VuuZQ==
X-Google-Smtp-Source: AGRyM1vlUrmNMDAT29z9DBns/Ohr0A7Gxvoprpz+ikUzMDSCm3GF3UoXp8wjIkfC6RfnJLvlZNe3eQ==
X-Received: by 2002:a17:906:824a:b0:70f:4c58:6ec6 with SMTP id f10-20020a170906824a00b0070f4c586ec6mr20480020ejx.648.1655723681574;
        Mon, 20 Jun 2022 04:14:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b006fed9a0eb17sm5699969eje.187.2022.06.20.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:14:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, soc@kernel.org
Subject: Re: (subset) [PATCH v3 09/40] arm64: dts: hisilicon: align gpio-key node names with dtschema
Date:   Mon, 20 Jun 2022 13:14:32 +0200
Message-Id: <165572367262.35195.16654742647500367074.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616005333.18491-9-krzysztof.kozlowski@linaro.org>
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-9-krzysztof.kozlowski@linaro.org>
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

On Wed, 15 Jun 2022 17:53:02 -0700, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern
> (e.g. with key/button/switch).
> 
> 

Applied, thanks!

[09/40] arm64: dts: hisilicon: align gpio-key node names with dtschema
        https://git.kernel.org/krzk/linux/c/111b4da2c2fc2551ecfe466616089e1223dc7ac1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

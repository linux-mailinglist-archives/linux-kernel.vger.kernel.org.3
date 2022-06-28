Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA3855E3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345990AbiF1Mzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiF1Mzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:55:33 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47F02F3B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:55:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id l11so21994034ybu.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zmWEZn/MDT8BVlOf2j/0dbSY8mXMBqqiVxeYK+9B6lQ=;
        b=JhUf9b2e4wqWDqQ8nebU+X8F21tnUWwiBkQ3caAT8ggv5nqGzZBBSIs1fyVqGmgTSz
         P0bx2uU/Um+sT7/JMfPoyd+TMY/C0h/HDqX3iWSan4x+3gVgOFqQqxl7uMlO4YALgj1P
         axnMd8R2aq8xen9gsHvKZXoB+QewakVfuJ8MoMEhQLsS7rq+b6tDv+KHy0ssO7jdghqo
         YO21b4nExNXO9RgjmR71guAnd6SFsChnxgBNFeKm96PNLhb4OobEGJJroUD1rrau/T8h
         1IW/3R1VEMOEupRLy+W8KoRPDUYOoNLb+cC2bED7huckB8a5gxeW6VgpiKBa8TJCGma3
         hCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zmWEZn/MDT8BVlOf2j/0dbSY8mXMBqqiVxeYK+9B6lQ=;
        b=aeGGPyOUDsOGxuwBsr1n0FXjh0GyWGm8W6C60iLZ/MIW1ikPsyMabx279dvqBb2ZLg
         iECDoMmSVvoxugzU4EPClOD/KEY5N+lFs1iZQOJ/y8c3fH0X/WRapCP4gk6/OZiHF6YM
         i0mYdaD2q+03TkHkU2VNQfcVyLE3+n2xX9tTD48g7cX3FdPUqHg3T3a2zBQsbd1gWH2Y
         T4sNoMQ+w5xYNwdhZ6/TrMJxG4eCDYMBOi40DFx7oQ6mku8N+UyGZX3MTe5/fv8yQn5d
         KUrsGP9H9Cbg+PAMgB17hQ98t3G0uEZfYydJHQlCEuCRa90ojRNkbAOVOBLebAtHTAhN
         ZsIw==
X-Gm-Message-State: AJIora+9fEgdh/JA50iq7NVmuH2nxlrAgtdEU4cxrLu7Qa1mwknOTkH3
        QQoJGeH/RQg1SS8YMCVzvg6JB4RZRqSDbz1l3GOECg==
X-Google-Smtp-Source: AGRyM1tsaB9tgNaMSUle5S5+neod2eZjuTku0yKoAV6tHrXr5lM2cYOKc71QeSQjdMvN2lSTcPjYvD5JGxKdrp2cnJY=
X-Received: by 2002:a25:cac5:0:b0:66d:2c32:8593 with SMTP id
 a188-20020a25cac5000000b0066d2c328593mr2819682ybg.626.1656420931032; Tue, 28
 Jun 2022 05:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220621161126.15883-1-quic_srichara@quicinc.com>
In-Reply-To: <20220621161126.15883-1-quic_srichara@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:55:19 +0200
Message-ID: <CACRpkdZs=kwFciZaNGWR3t=Q4Vy08qg6UNH6obcyubC=6jkYuw@mail.gmail.com>
Subject: Re: [PATCH V2 0/8] Add minimal boot support for IPQ5018
To:     Sricharan R <quic_srichara@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 6:11 PM Sricharan R <quic_srichara@quicinc.com> wrote:

> The IPQ5018 is Qualcomm's 802.11ax SoC for Routers,
> Gateways and Access Points.
>
> This series adds minimal board boot support for ipq5018-mp03.1-c2 board.

Pretty cool!

>   dt-bindings: pinctrl: qcom: Add ipq5018 pinctrl bindings
>   pinctrl: qcom: Add IPQ5018 pinctrl driver

I'm happy to merge the two pinctrl patches separately to the pinctrl
tree if I can get a review from Bjorn or Krzysztof.

Yours,
Linus Walleij

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9897554EBBD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378854AbiFPU7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378820AbiFPU7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:59:03 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2E0606CA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:59:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f65so2287768pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UV2MRSmy2QOm5kI9kHhiAhoT1gKtarkHT12ger0lyGc=;
        b=ErScX8hlXaOC2ZblzrgY850COqwO0u/FiicfTLTXHUN4wnSzDVfjk2oLGj9JOQl6SL
         eNpwAaDywrckz7zLTXY90pEKcX3aulQcNXbFGLl7cH2mVKNBoS6S1GYvQRdFqhkEacEQ
         he792O8+b7ykNie1I8dtHYCbobu18IGkIk1Nt/5+kb9dQ5l/czM3V7aoCKNWRi3bJaYH
         6FlbrgCT5/94a5bxai2AD64+Q8Q94BVsd6W+bxyTma7LH13bHfjj/pjfgiVqaYcch9an
         isDbr9+/3wuTdN/p3bp9Z4QxGQm9UyDXtQjwYC34Vs2/izXNI3ph1oCTpolKsqN4lH8G
         fTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UV2MRSmy2QOm5kI9kHhiAhoT1gKtarkHT12ger0lyGc=;
        b=grirKZLAgfqwkDnehJswyQ4A6xW2F//iVjTes56pSD3cvg5BqhB9x/8q0xRihISEfO
         0WjpY6jXzc5Ar9loJHr9PJC88NLP9RXRaSgRGkHesUygkWx0pbzUACAxnXOM2cYpfvzl
         jMk/kn60mIACSgqOBWg+qlPfEjghhkUcPxcJI3/PZPSmt6BNX2iJnzOuZSFAD4Mdg+CU
         tpJMZ61sxjeZj3Vt05yVa3tqxibAbvgRPoTZo/T8z0p+S5eNEPP1B7D8a75q0Gl6RXtg
         9gyekK1xBhzoEqQDn8ZhbT6gmDbjP31CK14RwW+2CtrL3cKKvspF2uQt2lDmxSitZow2
         QBtw==
X-Gm-Message-State: AJIora9dCu/MEPFlJoEwF+xIMIe5vZzZSFIcCRE0mzowE0UFBnTCyinY
        svnSmZYYCLoOPAc2PimiJ/IpDw==
X-Google-Smtp-Source: AGRyM1uY8J0CgvZYvgPo0Q2kqT0f9lLu2sW4mXU5VXzAXsYweopSCs4BAVnPS4PQw8MjWsAPzynFRQ==
X-Received: by 2002:a63:80c8:0:b0:405:186f:fa39 with SMTP id j191-20020a6380c8000000b00405186ffa39mr6214275pgd.84.1655413139873;
        Thu, 16 Jun 2022 13:58:59 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id q19-20020a056a0002b300b005183cf12184sm2159436pfs.133.2022.06.16.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:58:59 -0700 (PDT)
Date:   Thu, 16 Jun 2022 21:58:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 4/9] mfd: pm8008: Add reset-gpios
Message-ID: <YquZjdr3H+xtYcjB@google.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-5-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655200111-18357-5-git-send-email-quic_c_skakit@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, Satya Priya wrote:

> Add the reset-gpio toggling in the pm8008_probe() to bring
> pm8008 chip out of reset instead of doing it in DT node using
> "output-high" property.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in V15:
>  - None.
> 
> Changes in V14:
>  - None.
> 
> Changes in V13:
>  - None.
> 
>  drivers/mfd/qcom-pm8008.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

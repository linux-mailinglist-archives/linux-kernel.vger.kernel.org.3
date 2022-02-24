Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF994C28C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiBXKDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiBXKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:03:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3044D285AA0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:02:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id p9so2080015wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=40TX6IOrMXHDsEdOBMZQbSaofRg2Iai14g2HKUHylIw=;
        b=nIFsjDJSyJvelTiW19Y2pdK/O4i+9yNv5cuL+tRpK/le1Nl6LXGbhGsl7YWZsZxHt/
         Sbye4mwANzSPldhUUvl/v6UIK+pKfB2gBq3RTFFyXP+cugEnDFb/IqE1kumtGqXuPMGc
         zXOfnip7wWySwA7Vlm1AEVyeylQFIq1j3nczruP8t/zJxGz9cdfGCRYORw/KIvYQcJd5
         nXfSgnkBHZxifyKDchIWU6ulF0plIhwCqpFU6BdDUTlqjRxbb0+4HenZTwjfPDWtQo9/
         xjHoGUL3yPFRRUfiYHAWh5n+a+GdX6CLtJmYF1U3KbiU1tqiWq3f1fSLdn5gd9Bw9PXX
         9ezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=40TX6IOrMXHDsEdOBMZQbSaofRg2Iai14g2HKUHylIw=;
        b=s/ZYiCG1g2E84WtlYxSJ2lo03nQ9Lq+U1OY+ZGfGIIdUNVUX8TX98pIrN8qgk+P3yt
         1qpn9H9AR+N2j/r865DOLpSm4ajRBgfBJH2Zl6ShkzJa+DuizkgM13COL953NALPsdyr
         k9w0InpKMFo4rnnh2ElyUeROqOMXYC0yK+gmjlbVsTtD9ynEZ7xXgpCRWROsfOUAjiR3
         gZYayUxGLGwWt4gfIDqeIAjeHzM6Uiq+TPr67eCB4cuy+vbOdiHmltQndgNsul0h/m0U
         w85A4aCHbh/hVqcs/zh4CYj5tKb1poTxMZrMoqL74Gm4R11w69rfyUWH3Y8/L++jgkpe
         6HYQ==
X-Gm-Message-State: AOAM532mtx85w7rLgqzugjIALuOXqeD4In7blCk9hkhbPuRkMNwiN20Y
        mwXa9ZCi4zlHf4nFhIyyZ+v/+A==
X-Google-Smtp-Source: ABdhPJznPtWWQWN9tp5giTO0YPGHa54YOMlq33inQa44gWu66H4/BUMLLet4Alf7TttQUZm0TrpHWw==
X-Received: by 2002:a05:6000:178d:b0:1e8:310a:5a51 with SMTP id e13-20020a056000178d00b001e8310a5a51mr1599998wrg.642.1645696971765;
        Thu, 24 Feb 2022 02:02:51 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id c5sm2650428wrr.54.2022.02.24.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 02:02:51 -0800 (PST)
Date:   Thu, 24 Feb 2022 10:02:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: pwm: google,cros-ec: include generic
 pwm schema
Message-ID: <YhdXyBvAbdHzc4gH@google.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <20220214081916.162014-2-krzysztof.kozlowski@canonical.com>
 <YhX7UZSDaqNyD1rV@google.com>
 <3248917.W5uN0jUHDo@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3248917.W5uN0jUHDo@phil>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022, Heiko Stuebner wrote:

> Hi Lee,
> 
> Am Mittwoch, 23. Februar 2022, 10:16:01 CET schrieb Lee Jones:
> > On Mon, 14 Feb 2022, Krzysztof Kozlowski wrote:
> > 
> > > Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> > > the old name in bindings as deprecated.
> > > 
> > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> what is your expectation regarding this patch?
> 
> Are you planning to merge it or are you expecting this to go through
> some other tree?
> 
> The binding-change here is backward-comaptible in that the old
> node-name is still in it, only marked as deprecated, so in theory
> this patch should be able to be applied on its own without
> causing defects.

In an ideal world, it would be broken up and I would take the MFD
part.   Is that possible or are there dependencies?

Or, worse still, does the whole set need to be applied at once?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

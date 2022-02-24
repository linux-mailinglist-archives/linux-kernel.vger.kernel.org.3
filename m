Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1845C4C2B25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbiBXLpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXLpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:45:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D027C3EB82
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:44:32 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d28so2573789wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 03:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=By0koPKvfxcMR4uami4q6nEo7H/plZ6B7hXdRpr9zos=;
        b=i8qMcPf1Q3mE5GCDoGg5rN2z7KNR4v1QkWzdeaMyW3k3kXIOY/PIZZoO6jIzrS9GXf
         N9J6MgxVHAl8cKqQeyfCQQDG4qPlkD5aYJCyfFSPkTwQNcaQ9gYSWj1kbxmzh8jUh+4o
         WC4u08jO9c1zBuBLLsiQa8Spwvz7ssr2B3BAWulYxl4FnxeAYyvP13FtiYVEawCyqc0q
         +yzoQlx6Y4aTL5/fh1nHkgZbx5plCCjmpVTf1t+MWsHwZBuivtQnySk8fM3G6A5NiXCZ
         sXHHBvZ4aTdUjMWeM2AYEuCPcWqA5p7ojUQdIZHcKCaRG/P808wP/zP8G+Ji2NOxc4zc
         g81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=By0koPKvfxcMR4uami4q6nEo7H/plZ6B7hXdRpr9zos=;
        b=5ZHR9MNo33O5QkZHdMZSeou6YQQxCnVtWLzh7AySDeucMQ3ICDDM/ugSWUpINCISD1
         hijXPmdlIBlzEAHMd7OyQk/xQrNGTLbmPvctGbk3Ns/xvqCVoPa7bPZTjhECMus4atzz
         oEUEcD+0wL0UvgjcyqSxYCmIncaSfq8hsCvthyrCOmfXQJnDDqwtFC3DSlB3o4K52Lup
         lIyuZVK9voPd1dQzp4nU82qDYE7IZw+uErO/AFdk3gkwQpieS4O32YF6cndvebVYt/EL
         /oBtBbms35Sm1z+COV0A6W/8ZBTmm9M4+XMKHWJZT9yLZW6pVxnlYR4QakYc2UUGpcdV
         Z52w==
X-Gm-Message-State: AOAM532YNk3I6haVcBlMnOpv8GymWIdK7af62JIPLZVUJwdkeMYgOw/P
        jndSzVbotKYuYdzmsS+6n+1ltA==
X-Google-Smtp-Source: ABdhPJxFyXliu42yySrAeEXNzyWqVzug0J0Iti33/VcWEhV2LbIEmmE4MOW6ths5lINZk21h7SfROw==
X-Received: by 2002:a05:6000:186d:b0:1ea:8e14:21c5 with SMTP id d13-20020a056000186d00b001ea8e1421c5mr1880571wri.635.1645703071405;
        Thu, 24 Feb 2022 03:44:31 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id u14sm3164913wmq.41.2022.02.24.03.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 03:44:31 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:44:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <YhdvnCnXbzFz63ys@google.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com>
 <3248917.W5uN0jUHDo@phil>
 <YhdXyBvAbdHzc4gH@google.com>
 <1817486.VeUe9BSz9F@phil>
 <ad6e347b-a25b-5309-2a6a-8fd3faba256c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad6e347b-a25b-5309-2a6a-8fd3faba256c@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022, Krzysztof Kozlowski wrote:

> On 24/02/2022 11:06, Heiko Stuebner wrote:
> > Am Donnerstag, 24. Februar 2022, 11:02:48 CET schrieb Lee Jones:
> >> On Wed, 23 Feb 2022, Heiko Stuebner wrote:
> >>
> >>> Hi Lee,
> >>>
> >>> Am Mittwoch, 23. Februar 2022, 10:16:01 CET schrieb Lee Jones:
> >>>> On Mon, 14 Feb 2022, Krzysztof Kozlowski wrote:
> >>>>
> >>>>> Include generic pwm.yaml schema, which enforces PWM node naming.  Keep
> >>>>> the old name in bindings as deprecated.
> >>>>>
> >>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml    | 4 ++++
> >>>>
> >>>> Acked-by: Lee Jones <lee.jones@linaro.org>
> >>>
> >>> what is your expectation regarding this patch?
> >>>
> >>> Are you planning to merge it or are you expecting this to go through
> >>> some other tree?
> >>>
> >>> The binding-change here is backward-comaptible in that the old
> >>> node-name is still in it, only marked as deprecated, so in theory
> >>> this patch should be able to be applied on its own without
> >>> causing defects.
> >>
> >> In an ideal world, it would be broken up and I would take the MFD
> >> part.   Is that possible or are there dependencies?
> > 
> > That is also what Krzysztof had in mind - see his reply to patch4.
> > Binding going through the MFD tree and soc maintainers applying
> > the individual dts patches.
> > 
> > As written the binding change is backward compatible, so no harm.
> > 
> > I was just confused by the "Acked-by" and wanted to clarify how you
> > see it ;-)
> >
> 
> The bindings patch should not be split more, but itself can be taken
> alone. DTS patches can go via SoC maintainer trees.

So in answer to Heiko's question, either Thierry, Rob or I can take
the patch.  I'm not overly fussed which.  If I am to take it, I need
Thierry's go-ahead and info on whether he requires a PR or not.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

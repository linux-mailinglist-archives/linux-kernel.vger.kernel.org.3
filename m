Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5DD577C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 09:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiGRHGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 03:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbiGRHGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 03:06:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A517068
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:06:33 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so6546213wmn.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 00:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZI+psl62KRHu+/xwUEa944NIpr8bwJMp0OVmnA0Tjtw=;
        b=iVQrWs3MRYym3WpQlxcZbyUTbB9NgDt540mGZaeASrif4xJJL0ZP16Gs+toxe7etRI
         elH6zhBeYGG0nIgbpXOGPXQpHNTxrE5ylPKniMAJduz9p3niY2iqxrc+r2rHmA1QUoJx
         AsQ5F8jh9xxgn+fJFqhKThhEh/XpE78Z4mWKFskKXGhogvOxOM67Sf8qFCgjgJgLPey9
         Adlz81DQt6k/g1/kfkp5VkC5KczOL8/CTFOlFVihAO8ijGM88Wo9zDoqu2t8IAVUAP9u
         YJiGmHmOqAnlo+R+8m4PL/UvAxoOykmx29qCuJsjKlK9bIZ9Z5AQKuvnJPAjFbAR5NKa
         cxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZI+psl62KRHu+/xwUEa944NIpr8bwJMp0OVmnA0Tjtw=;
        b=TU51uQGEcsFr8aRdhtdENKSOy2Ke1tF8k7g/WlxwYjj7mWMLdDNkC2fCQg0aJeQYZb
         DetAwjn3S9DJ+WYF2puCLcZdNNU3iOEQ2Cx4dJ/n1eg7vdzLst6+NTil5a4h+DgR6Y09
         IRAus7uVZF0tD9FFqU37N2SDIbJl7KD6usi9qYv8sRyF2JUfhXyHIJVw5TjBA1uxJSEX
         H8E+drWUlp+lX5NGeYkSQqaOEHzinCaDwve82G5vLOb3iu8d2RWXPMy/eqXFGDZWCDSA
         5Ngi8sGO6HGoaLe1wuoDXwFK59TDHc86yN7YksrxrR1v+gZRdvgJDPMD65n6cAp3cfio
         tt7g==
X-Gm-Message-State: AJIora9+un/hfJQ+eR++beFezJKLQrbJwi25btzhEImoW9CmxOHKu6Gp
        vIhh1b/IdNKDAN5g7vpCke3eow==
X-Google-Smtp-Source: AGRyM1saJthbQ+1R+t0bpM3h/3M+zTnIoBp23gV23NDFQGiwJecHu1D+2hA54oDOtG4e1bYSU71yoQ==
X-Received: by 2002:a05:600c:1c88:b0:3a3:10b6:e844 with SMTP id k8-20020a05600c1c8800b003a310b6e844mr10970188wms.155.1658127992443;
        Mon, 18 Jul 2022 00:06:32 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6405000000b0021b966abc19sm9914954wru.19.2022.07.18.00.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 00:06:31 -0700 (PDT)
Date:   Mon, 18 Jul 2022 10:06:30 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: qcom: q6v5: Use _clk_get_optional for
 aggre2_clk
Message-ID: <YtUGdmyUoMc3Hro1@linaro.org>
References: <20220714104309.4111334-1-abel.vesa@linaro.org>
 <YtOHOptMSAzHfm7a@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtOHOptMSAzHfm7a@builder.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-16 22:51:22, Bjorn Andersson wrote:
> On Thu 14 Jul 05:43 CDT 2022, Abel Vesa wrote:
>
> > There is devm_clk_get_optional now, so lets drop the has_aggre2_clk
> > from adsp_data.
>
> I like this patch, but for the history, could you please provide a
> reason why you would like to do this?

Sure, I'll reword it and resend.

Thanks,
Abel

>
> Regards,
> Bjorn
>
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/remoteproc/qcom_q6v5_pas.c | 41 +++++-------------------------
> >  1 file changed, 7 insertions(+), 34 deletions(-)
> >

...

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3532511A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbiD0OJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiD0OJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:09:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDB54E38D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:05:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x52so113605pfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OT8jLHi5I0OiZTy0LV6eIgEYpe0uYFZJA9KqVmBMVzw=;
        b=SrCfyOO36j1AT9uvoaS4hD0HxsHPiTi/Zy5MVVnulvhwb5YNHoxltXjGvslBhCNqbS
         iTySn/IB5d+64LM1C9WgYvoHu1w1KB+pV5D212QvcON3HhOiSUTmBWNTl/Iz98Yt02t8
         QpUsTbFJL0/uHrbDkPpawLRsJ5y7gKkxalTVnzG0seOeIIi662zyZNogfo2xOvcOEho8
         mrLpq8HQ5j5V4lkt17/dOwTt21cI8UJCNI+xWHO6lb5mHlZmdG2WhxheejJxdhi9CX60
         rOtpqy+b5DV79oHhBI11C0oj7NBXBVHtPD60/GoipuT6VI/3anhFYhCF4opst0xtVWlP
         ex2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OT8jLHi5I0OiZTy0LV6eIgEYpe0uYFZJA9KqVmBMVzw=;
        b=blJtfWTwmbRd8kqhwXN/rKu4cDjWofGnhd540wc0uJBvRTFzt2lwq9TNmo1jC1luVi
         yls4ti29EUuOSUQLyOLUVAf5EyISdkWi3v7S60l751Ikjcbdo6C67MKEHvWrGVjX3upg
         uSNrJ/AlTr+6BnxdkSqxy+wcG4WZpJURBltJ5VBcblHlHc41pEr9r6tQ2qlhLpNLgwKm
         9kY9o3vfEmuzzox7wekG32MRWIn1MFnc285XosvWPykMfMtJGAQ1blV5egn4as4ufvgK
         wIG+DsO9oPp92WRK1sCVt72o6cT9aQhWFeTCq3iUs/AY1By0/ob68VqGp7QwVW6Rx/RS
         /eOQ==
X-Gm-Message-State: AOAM532skWc+QOTywUKd7/LlkGwDCYQMeyb7Z7PGOtCYn9za4kbvkdMo
        1VdPXmfwOLdKPvc60PQB6SXDQA==
X-Google-Smtp-Source: ABdhPJyogLOjd4c37B198F/9gX6yPAM/D9FmoWqn+QNk98u1oleDEd359HLuknmbJwCvePhkv8ZUIA==
X-Received: by 2002:a63:6e0b:0:b0:397:f965:64a7 with SMTP id j11-20020a636e0b000000b00397f96564a7mr23830267pgc.581.1651068358118;
        Wed, 27 Apr 2022 07:05:58 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id p64-20020a622943000000b004fdd5c07d0bsm18622190pfp.63.2022.04.27.07.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:05:57 -0700 (PDT)
Date:   Wed, 27 Apr 2022 22:05:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] dt-bindings: interconnect: Update property for
 icc-rpm path tag
Message-ID: <20220427140550.GA560849@leoy-ThinkPad-X240s>
References: <20220416154013.1357444-1-leo.yan@linaro.org>
 <20220416154013.1357444-2-leo.yan@linaro.org>
 <YmhBE/JDV66qQIBv@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmhBE/JDV66qQIBv@robh.at.kernel.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:59:31PM -0500, Rob Herring wrote:
> On Sat, Apr 16, 2022 at 11:40:09PM +0800, Leo Yan wrote:
> > To support path tag in icc-rpm driver, the "#interconnect-cells"
> > property is updated as enumerate values: 1 or 2.  Setting to 1 means
> > it is compatible with old DT binding that interconnect path doesn't
> > contain tag, if set to 2 for "#interconnect-cells" property, then the
> > second specifier in the interconnect path indicates the voting is for
> > which buckets.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > index 89853b482513..7464a50804db 100644
> > --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> > @@ -118,7 +118,7 @@ allOf:
> >                    - qcom,msm8939-snoc-mm
> >  
> >                '#interconnect-cells':
> > -                const: 1
> > +                enum: [ 1, 2 ]
> 
> Describe what each cell value is here.

Will do.

Thanks,
Leo

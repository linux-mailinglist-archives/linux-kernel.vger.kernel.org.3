Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4111655E316
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiF1Api (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbiF1Apc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:45:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBE1C10F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:45:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id a15so10498268pfv.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 17:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+07R8ZyMp+5hGqx337Jl/FxePBkgkf4MJf4MdZjVvcc=;
        b=BmzEJhHRJMJi6PYyaBJJSBT3lBP29VNlUbYB7YVfvy0drJKiq/XH3IuJTxarSjH3l8
         8IU6M7Qd87PQW6u2KGW8rHJxXo/X/+4VRuQc2uvCX/byZrn8W9AtLnNwH4WH/6N9bKRL
         StXyEu/5UCLwa9B6luALA3rjMKBkbvOwLtEIO9/S0RGuL1X4gmgDhftLqyD8ByTmrssy
         IH++5JZS06ngLaH6V45EkiRs7GreJG1NT1jwjhdFWQMf0JfLU1vXHxihq5jaTHMcnmZo
         OqayBDP2VInUV0+WIjRipDA+hUQVkBE256yJby+82uAprgh+Xc6o3vYQKOkB5R9cbGuv
         lCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+07R8ZyMp+5hGqx337Jl/FxePBkgkf4MJf4MdZjVvcc=;
        b=VgXW/updMgTqZ2zOeKMqDfzzcQD1eoE4HLPvMvs0HtvPzClmp7N/jR2TGTPBxpu+0f
         1vEm/TgRbu0bPC7YxltKtBjXqyKEqH3OTc2wtZaQTkKKE81Lp7G+8/aDYt9+9f8qAHYP
         lDLzzzUEFGr9LViR7axOuM9aSwKylqqzdklGWVoGDb7p3vvvqNi23x2cGsjRlLRlzWFV
         25iln0IYOiMGr8QN9eNDfzCfi+wh1AjtCwHkc5wHYnf0nZu2Lk3C9rlX2XyyOtX3xZCg
         xTjH/LW739TOiR2FanrT8VInexBKCRwLptascNeGAmEOQ4+N0PEqTnlz/CQa64BRir/l
         PAMg==
X-Gm-Message-State: AJIora9EoE+qsfrnUE5YZtwTrxTiUl2RBqo01KYLokcFNnSbJBXcFJK+
        2atUASOLztof8284rTBmdhW2zg==
X-Google-Smtp-Source: AGRyM1vCH3BDKnJBbhchtIKQE4gHvwE+EJtNJ0TOcyD7LgIP0eTEV8PXiq2/zzhhDt0rBSro7m27YQ==
X-Received: by 2002:a63:90c7:0:b0:40d:3c0d:33f4 with SMTP id a190-20020a6390c7000000b0040d3c0d33f4mr14973935pge.334.1656377110718;
        Mon, 27 Jun 2022 17:45:10 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b0015e8d4eb25fsm7762019plb.169.2022.06.27.17.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 17:45:10 -0700 (PDT)
Date:   Tue, 28 Jun 2022 06:15:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-cpufreq-nvmem: fix board
 compatible in example
Message-ID: <20220628004507.kghkkf6vx3l2hpqe@vireshk-i7>
References: <20220627143340.477120-1-krzysztof.kozlowski@linaro.org>
 <20220627195040.GA2840123-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627195040.GA2840123-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-06-22, 13:50, Rob Herring wrote:
> On Mon, Jun 27, 2022 at 04:33:40PM +0200, Krzysztof Kozlowski wrote:
> > In the example, alone compatible "qcom,qcs404" is not correct.  Add
> > proper board compatibles for QCS404 Evaluation Board.
> > 
> > Reported-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > ---
> > 
> > Can be picked up independently, although the issue reported by Rob was
> > caused by:
> > https://lore.kernel.org/all/CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com/
> 
> Best to go in that tree unless it's going to take weeks...

Lemme know Krzysztof about the timing, I am going to send a pull
request for cpufreq fixes very soon, so I can take it as well if you
want.

> > ---
> >  .../devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Rob Herring <robh@kernel.org>

-- 
viresh

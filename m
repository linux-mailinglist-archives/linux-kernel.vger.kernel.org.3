Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C96756A078
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiGGKxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiGGKxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:53:00 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444235721F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:53:00 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id e16so5812878pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vme1WD+iWy/YBwYhXVZ5Fyl3XOzLIAAM2gpN+oRGDyA=;
        b=CHhXBdKrPgAdIE/UFI3/0M6OBcDh66dbcuv7oZMlg7z3qZk11c8xDpPMusruE50NJM
         5BVcPEsL6yaU++TO9AB9UVgP7+RFsF6OhjLMz53uSvPq0yX7LB7MD1cqlfMuqsu56/Jq
         0Au9AL5gZ82Y912D4Sl0K2cnGZapN5QZNAB957w/zQyf+CGqMg/IiuGhkR6lS1Pr/slC
         +oBvcfrOwnFYLpsqXlrRIUo9vaSgyiAIiB+mGqXrqFlUtS3I0kVrAyFzw3z5VnD4jrby
         cFXuhWc3UPQX0xNg1igLGA5aHi0YDmzIHag2jsjqx4U/aGDrD0yLIR8hKPtgfEX3q2ik
         yyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vme1WD+iWy/YBwYhXVZ5Fyl3XOzLIAAM2gpN+oRGDyA=;
        b=Ka7ZtDMysvqvXKYu54t+HAVA8lQL/v4uWXUz6BZRUWuBJSquaB+Dq+0sIcNKzzF1E7
         gp54T7s7wBkkv4cw/BH4l6ka5xpljJlCuodNB58iguXJxwzwa89c9RVjR3sKn+CfjinO
         TnhX8jBqyuKTiZS9jWlKCx2oVOw/89pTrCmzC4F2To4/dyT7eNq6A45c5vChHEd51Mbj
         weR5Zv5PrFB9w3rUjm32/XcALHexS0OHqiELCOy1kQekard7nCepcjIQ2PXYUajIads8
         dtTIklMMLK1UhD6V3ET3up+PF+SRVyHpSIqwmStsWzYhE2z/BTEElz9tS3o2OJYHTsJx
         /ozA==
X-Gm-Message-State: AJIora8rnxFETEhppFqtTr13AR9iGBK/AcqtDFjJjcTx1qFtQo0t+NbQ
        6tJ6OpyXfXApC+0P2pJjU7cMOw==
X-Google-Smtp-Source: AGRyM1uiL/1NSSmW4kr5Bqvpj4UnhCSl4Nsiie+u+ka5NvNDUAzLdq3b18xSNR8cpsvmwnksbU4guA==
X-Received: by 2002:a65:4b82:0:b0:412:4346:f594 with SMTP id t2-20020a654b82000000b004124346f594mr19277469pgq.593.1657191179791;
        Thu, 07 Jul 2022 03:52:59 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id h14-20020aa796ce000000b005281d926733sm13925071pfq.199.2022.07.07.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:52:59 -0700 (PDT)
Date:   Thu, 7 Jul 2022 16:22:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        rafael@kernel.org, dietmar.eggemann@arm.com, nm@ti.com,
        sboyd@kernel.org, sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] cpufreq: scmi: Support the power scale in
 micro-Watts in SCMI v3.1
Message-ID: <20220707105257.wgqbgoumwvbonvml@vireshk-i7>
References: <20220707071555.10085-1-lukasz.luba@arm.com>
 <20220707071555.10085-5-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707071555.10085-5-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-07-22, 08:15, Lukasz Luba wrote:
> The SCMI v3.1 adds support for power values in micro-Watts. They are not
> always in milli-Watts anymore (ignoring the bogo-Watts). Thus, the power
> must be converted conditionally before sending to Energy Model. Add the
> logic which handles the needed checks and conversions.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

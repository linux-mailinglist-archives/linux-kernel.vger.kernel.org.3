Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD05B03A5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIGMKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiIGMKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:10:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F327279EFA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:10:39 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f24so14344918plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=l+DHrdPvxTsZwy0vBKGsgNTwTQQreF7JrcfVtO8Ltl4=;
        b=jsLNj/V068Z9IODGUBfiOvlacMevs0MPJPkHDxhq2TR+fMyPIwjBOGYssPhblblVCH
         0ugRrGBz9AvcO9ghHLgUq5s6WptoByKGGAvdn3pdaiYkQZrq8XRVZ/eubNTj1mE9qqzH
         xCaE78/jSWBSsud4szpIM9VyWlfWxs4GHRKQRkKsLPHhNZOe4a+P1Kw9Fqn/ZC15al9x
         861EdnDwQbblmyeIGo4KM/R/wguXXI2pgUXufx0fb/EMmgUZfFUMa4HMkzBA3nVryM0J
         knBsumaURTpAHdF6DBeYAn2BNF6qFa6jYigYhQz1oU4VZFgTDzrGdHzL+quoxEU386yf
         igmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=l+DHrdPvxTsZwy0vBKGsgNTwTQQreF7JrcfVtO8Ltl4=;
        b=0zDgdhOiPUhx1q32QHWiBMhvbPpZexvkibjZd+uvBe3/KP0im8ia0fTOPK5fzY0GGI
         lbXIDx5fx/+4JSu0JutASXUiMf78O0NLddzV/XOXwbGPs+110DSy4HiqaD5QoGcwpl2+
         OAwv/xNpAE35zs3ii6Yv8oAdLKx8gx+3jIv+tQIZS29ZiTdD2HXMIxI8Y6wRpn7TkiYu
         aFcYikFvDH6B5R3f91k9YevGmzi5K3giWse9v/y/cQQBEQv5r1lH40LJmhhR4SB+Ak1P
         0IoKIj/kcj9HT6Dqsm9EjBL1uWLx25Pzcy0eLU8ziRHcnNfxKXNrr9w29ylKJYT5CV61
         tsQw==
X-Gm-Message-State: ACgBeo3oA6XqTFNJz8k0m6HX+cowRFeHu9Dj5biunNubuqtUGj2LAyQh
        sdXt7t9u6kx5lKa4P2Rfm9jUJzWyFKuYVGd77DTEqg==
X-Google-Smtp-Source: AA6agR42FdVl6iDpbcGKEYG4eJFaR2Na+cW46NNYQ+kS1Y3Nw6pBbcHMF4BZDi+IXlDbMQ7ntOCUbcsOW12bDyrptHs=
X-Received: by 2002:a17:90a:988:b0:1f2:3dff:f1dd with SMTP id
 8-20020a17090a098800b001f23dfff1ddmr3832027pjo.150.1662552639386; Wed, 07 Sep
 2022 05:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220902124032.788488-1-sudeep.holla@arm.com> <20220902124032.788488-5-sudeep.holla@arm.com>
In-Reply-To: <20220902124032.788488-5-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 7 Sep 2022 14:10:28 +0200
Message-ID: <CAHUa44GPKpezKvybSbNHNm+NcLk9JzC4mtheFL0n0niAhZmP2w@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] firmware: arm_ffa: Add support for querying FF-A features
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 2:40 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Add support for FFA_FEATURES to discover properties supported at the
> FF-A interface. This interface can be used to query:
>  - If an FF-A interface is implemented by the component at the higher EL,
>  - If an implemented FF-A interface also implements any optional features
>    described in its interface definition, and
>  - Any implementation details exported by an implemented FF-A interface
>    as described in its interface definition.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 04e7cbb1b9aa..81b8d578b6ea 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -571,6 +571,32 @@ static int ffa_memory_reclaim(u64 g_handle, u32 flags)
>         return 0;
>  }
>
> +static int ffa_features(u32 func_feat_id, u32 input_props,
> +                       u32 *if_props_1, u32 *if_props_2)
> +{
> +       ffa_value_t id;
> +
> +       if (!ARM_SMCCC_IS_FAST_CALL(func_feat_id) && input_props) {
> +               pr_err("%s: Invalid Parameters: %x, %x", __func__,
> +                      func_feat_id, input_props);
> +               return ffa_to_linux_errno(FFA_RET_INVALID_PARAMETERS);
> +       }
> +
> +       invoke_ffa_fn((ffa_value_t){
> +               .a0 = FFA_FEATURES, .a1 = func_feat_id, .a2 = input_props,
> +               }, &id);
> +
> +       if (id.a0 == FFA_ERROR)
> +               return ffa_to_linux_errno((int)id.a2);
> +
> +       if (if_props_1)
> +               *if_props_1 = id.a2;
> +       if (if_props_2)
> +               *if_props_2 = id.a3;
> +
> +       return 0;
> +}
> +
>  static u32 ffa_api_version_get(void)
>  {
>         return drv_info->version;
> --
> 2.37.3
>

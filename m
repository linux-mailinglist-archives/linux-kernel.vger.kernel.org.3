Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58E64D91B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbiCOAsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiCOAst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:48:49 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F638764A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:47:38 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id l2so34252285ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwy48TpIfjdziu1YiQtRNmjLhaQUITlCfE3MeXwkyUY=;
        b=bcjkkQsIzcr+3GNXFO4i8x4HMVy1xtOZip/jEw21oqYyUelyYiXvMeI44O/+526RIY
         mLH2MPC2lloW4DYOXnCqCVO6I03lF8v4ej7BkKtSjcd/u4Fo+mPKPjA1tn4fJq/7Z3GE
         gUvaOLhnfcAfNle4B5v15BgtHW5wMQmAlOkLR6FSUIcury2QKJ7MVu5iKu2ajsxE2ExA
         4dXdeOIHS6zKTpBU879tULypFTjqSINeeDzbGuAsUlO/ASqjDnC0+ZE7URnbYTevce0C
         7qXeZWy3f+1xKxfSkW+rZazMwM1KJmcrd5vX2f8AL8Lf+SblHa7TxnJ6A4HPGdG2Rs2c
         qPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwy48TpIfjdziu1YiQtRNmjLhaQUITlCfE3MeXwkyUY=;
        b=g7ocSOor40SKdTjv4ZnWaBbO0VphIdUQlHm+VZ3ZMoDtAUuxWE6QbegDpEy8q9poEG
         dAyfjnXV5raDwzliW+OvKFXWEcgvV6axWp94cPT1lnrXfvC06HVYxcCmKxx8HOjBppN3
         UpH5nr0hfdECs+n47VHdcpBoQ/t4Hg1UtlNSDradUo7aQYtjHfxoEr3wWuDYD3qIX+A2
         Arpmg24l6oLmCPynCyHcIYZ2AP4NXqD9zWtzYtj+umILYux6wJ6ZyxAnXpcJTKij2cWN
         ZmQq41Tlqb6ZpwDSWQYRcLqSZVnFY6AJYvxoh3hd4U0CMimtOSvpg3uhNSfN1YBRXx2B
         agZw==
X-Gm-Message-State: AOAM532KtAI09+7JeDb9vsYYeLu0/RVxf2OJw5qZ+t1RWKSd+wbxvF5f
        OahH99gBMm2KogSihFhiNLtw8L+Aw1te+4kyOQvxCw==
X-Google-Smtp-Source: ABdhPJwcJ388MBn9UvTXwF7HirqUDAlOeJSkndByKVb/f0zfV6FH8k9SHEmD9Tryz6E1UL8GrKtRZu5M2oPcQbGiVes=
X-Received: by 2002:a25:2308:0:b0:628:9a66:7327 with SMTP id
 j8-20020a252308000000b006289a667327mr20324118ybj.626.1647305257844; Mon, 14
 Mar 2022 17:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220224043605.26157-1-srinivas.neeli@xilinx.com>
In-Reply-To: <20220224043605.26157-1-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:47:26 +0100
Message-ID: <CACRpkdbtMstgexY2C+Egoqt+jFV7JaV4Qe6ZiogpBNswtSEX4w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: zynq: use module_platform_driver to simplify the code
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shubhrajyoti.datta@xilinx.com, git@xilinx.com, sgoud@xilinx.com
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

On Thu, Feb 24, 2022 at 5:36 AM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:

> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>

Nice, patch applied!

> -static int __init zynq_pinctrl_init(void)
> -{
> -       return platform_driver_register(&zynq_pinctrl_driver);
> -}
> -arch_initcall(zynq_pinctrl_init);
> +module_platform_driver(zynq_pinctrl_driver);

This will incidentally also move the initcall from arch_initcall
to driver_initcall but I assume that works so, OK.

Yours,
Linus Walleij

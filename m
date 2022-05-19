Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67C452D124
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 13:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiESLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 07:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiESLHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 07:07:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DCE91562
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:07:21 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k30so6649176wrd.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vkZczjSkjLFS3y68RSw0rojPGOjOlZoId0KPRN5jWDI=;
        b=y5qsHBjiiFVGuMxIal9/PiCthjrZN5MHmLE/8x1WTtk1KnLIsgczuSPKxK0sTyWH/i
         7esTfvdflsyBFCo9DJru4tUaWt5nBbmMnNI3SQwpc5+m2pgz0967Qz2+erfdO5x0wNTy
         doB9IMu2yLC4+xIrPtmf47bejbnRoHt24S7tu2jRp7UsUJ2HLD1PGQT48LC0GZdXjYz2
         lrTExcZTu1hDRZSGy1AYXIN4PIkSjBNksBpjHTkROJOh+DgeLY6wTcKv7Q2XGhNclMY7
         K8PSAruJSJ3xUFA565CFmNW7dJqe5HZp2z1tRwIfPe34RRnehChSkux1SGY5MxtBwV3E
         /t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vkZczjSkjLFS3y68RSw0rojPGOjOlZoId0KPRN5jWDI=;
        b=Anjs+njX85sYYm0e59ioLXDBbmVpen8Yxt1GZNQ/e42onf3qP8Vq3yw9GlN8tf0b1C
         ejPzsOOV0lLFazfuT0IxpEkKxzevfXAO8hjphoJYq1LGX9nVQOn6cBPZmAQMG25YzUzQ
         UJY97fF7Boud+ihmIUtA0lWbBim23ahh/b1obFWRwdTuA760P9dd8PHbcw0jUYog50C8
         U8OrvYBlhjGG6G3z2SRMi4eWNNJ8g90xHFmhHlYzflF9TgKF/FyM2XUYdnebp/5zU8K0
         cP7BsOkZ0aur8O97sapJQ1gw5KK4eOh9fxo98nLVgbkZMiOtTO80DRjRaoRh86w/9LSN
         Gxrg==
X-Gm-Message-State: AOAM533KWO1aMpTgdvhQ+DPYAYNn4XIsFxBTB9jx8FYxtdrz+gcuOS08
        EagoO4pB4g7AysTYbfyXie5taA==
X-Google-Smtp-Source: ABdhPJwrpXp/aw4eSq7LUBPJeOAkL6hrCc7fv69mLlgZuWdX0aU2PfyaUV3FAQexKVDjbvpduRMbQQ==
X-Received: by 2002:a05:6000:786:b0:20d:6048:71bd with SMTP id bu6-20020a056000078600b0020d604871bdmr3470951wrb.358.1652958439606;
        Thu, 19 May 2022 04:07:19 -0700 (PDT)
Received: from localhost ([193.117.214.243])
        by smtp.gmail.com with ESMTPSA id k13-20020a05600c1c8d00b003971fc23185sm3975395wms.20.2022.05.19.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 04:07:18 -0700 (PDT)
Date:   Thu, 19 May 2022 12:07:18 +0100
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] mailbox: correct kerneldoc
Message-ID: <20220519110718.ywtykvf4aqewl4dk@viresh-thinkpad>
References: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501103428.111286-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-05-22, 12:34, Krzysztof Kozlowski wrote:
> Correct kerneldoc warnings like:
> 
>   drivers/mailbox/arm_mhu_db.c:47:
>     warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>   drivers/mailbox/qcom-ipcc.c:58:
>     warning: Function parameter or member 'num_chans' not described in 'qcom_ipcc'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mailbox/arm_mhu_db.c | 2 +-
>  drivers/mailbox/arm_mhuv2.c  | 3 ++-

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

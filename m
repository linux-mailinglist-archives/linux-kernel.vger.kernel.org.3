Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B14E59F7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240685AbiCWUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiCWUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:38:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755EF2A2;
        Wed, 23 Mar 2022 13:37:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w25so3258010edi.11;
        Wed, 23 Mar 2022 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=m+xd1tDwGKjGGm1zRlDPZw7g8jsg6c2oSOsHqvT059o=;
        b=ogb23Z8o0r/ojubfh+pyigrMuy6eys5nZmQvx5floY4wNh05nWnIkD8uqS5hfZnhzh
         SL43Mrma5nRnEzoQDsKutyWjTdmtYq3brVNebVBpbdYMtrJDwIaOVYNnkJFiYHtB/Bwt
         5KIclFGoYdtuicHtIqzBm+x+zkM8ENocbNhwnBaLQ6cOEYe9YBedEXmlJSfpVEmwEhGx
         Z9I9qzUa79xjd86uX3V3/vRhHkGO0SjKW0KokMDt3Xp+lh5bU2HkCmdfh34qGkMtvSB3
         UjZ0zww6IAFfcQugTEabS886lfbKvvhpa3nx6O3eTZJRoWNMvZLJmeP1+GdQvO7ip92s
         LiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=m+xd1tDwGKjGGm1zRlDPZw7g8jsg6c2oSOsHqvT059o=;
        b=X/Roy/xXY4/7BLEDQgyhzCETJ12DOLN9iEvS+A73qGHImFS9ep08OYI4slaM8Aqes2
         Ary1amzOemr31ZOZxL5bYNLuKKUPEiY8xHTqc/ZhObzLdGonEPmsvOahVAOvGxMzn/cy
         pJ8L4y1W8nGMM3IQXu0pqZzi1YabLzC97eFstBffG7zC9OkIev3YTQF/r+6A4dTjFD9H
         hK1NKmffeZqVZcEGgaEY2wlX8YBQ4KvsSm5y2z04eLCcImFqp7Bq+R9C5gK+SW5GwmCV
         wRLPNLk3gI7M3IBpNNQKeaOkLoKTzpzwjE0lAg7439j41xljVuNP6KhkS3YLHjZvDymD
         u8qA==
X-Gm-Message-State: AOAM532DaNk9raKyqHaQFuzKQZ4Snrq2j+iYETJ/UDqnPJrxoS4R2MPT
        S5SxpBGn3hvU8KKVPF+2wD6wvpD/dmTbhQ==
X-Google-Smtp-Source: ABdhPJw4LDxBQy/6K4rrDRgH6/barx60YfE+K+Lrj0R3Vp9IsIRY+wfsg0LYJ6oLeBYbFCvC5pIyQg==
X-Received: by 2002:aa7:cf0d:0:b0:419:362:7ebf with SMTP id a13-20020aa7cf0d000000b0041903627ebfmr2507685edy.225.1648067837909;
        Wed, 23 Mar 2022 13:37:17 -0700 (PDT)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id b3-20020aa7d483000000b00419209d4c85sm422261edr.66.2022.03.23.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:37:17 -0700 (PDT)
Date:   Wed, 23 Mar 2022 21:37:13 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bastian =?iso-8859-2?Q?K=F6cher?= <mail@kchr.de>,
        Jeremy McNicoll <jeremymc@redhat.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-msm8994: Fix gpll4 width
Message-ID: <YjuE+cgGXCLihPIa@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20220319174940.341137-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319174940.341137-1-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>


> The gpll4 postdiv is actually a div4, so make sure that Linux is aware of
> this.

> This fixes the following error messages:

> [    0.804491] mmc1: Card appears overclocked; req 200000000 Hz, actual 343999999 Hz
> [    0.805057] mmc1: Card appears overclocked; req 400000000 Hz, actual 687999999 Hz
yes, this works on my patchset [1] even without these workarounds (I'll submit
v5 without it)

+	assigned-clocks = <&gcc GPLL4_EARLY>;
+	assigned-clock-rates = <384000000>;

Tested-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr

[1] https://lore.kernel.org/linux-arm-msm/20220218203710.895-1-petr.vorel@gmail.com/

> Fixes: aec89f78cf01 ("clk: qcom: Add support for msm8994 global clock controller")

> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Cc: Petr Vorel <petr.vorel@gmail.com>

>  drivers/clk/qcom/gcc-msm8994.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/drivers/clk/qcom/gcc-msm8994.c b/drivers/clk/qcom/gcc-msm8994.c
> index f09499999eb3..6b702cdacbf2 100644
> --- a/drivers/clk/qcom/gcc-msm8994.c
> +++ b/drivers/clk/qcom/gcc-msm8994.c
> @@ -77,6 +77,7 @@ static struct clk_alpha_pll gpll4_early = {

>  static struct clk_alpha_pll_postdiv gpll4 = {
>  	.offset = 0x1dc0,
> +	.width = 4,
>  	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
>  	.clkr.hw.init = &(struct clk_init_data){
>  		.name = "gpll4",

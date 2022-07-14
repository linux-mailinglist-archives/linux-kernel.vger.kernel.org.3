Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A65746CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiGNIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiGNIcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:32:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC16286FC;
        Thu, 14 Jul 2022 01:32:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y22-20020a7bcd96000000b003a2e2725e89so784983wmj.0;
        Thu, 14 Jul 2022 01:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=6xc+YDuIfvXxIC+O6+IU1kPpAw3fGddKU5daN249fsU=;
        b=cZHYBUMkLjdNB0YKczZHY6aivyAMJ/ONJAWluY9qjPBVx5u4hBDOHZOMmbfhFGsB8g
         qtRa4zJ3lrmOnt5z0hMpYJkVXDNJGi2bXc9IhmINx8WBRitdTpw7QCxqCB6aRVaiPbDY
         4hpAy8TWsht1pMdzeL3OQgWbBur6XaSPGlcv5LjR0noVfYOfszM7M5FAfh3jaaw+ifMT
         a+6cfV+HposCMlDoNTRyWlD83B9zkgttCwSkYizb2FgzrCYs0v8Bc4SZM8Cmv7CVIauH
         YrxjGjX/w2zBSllpltL+Qh+R2uSE2+G6gh00BpQqandCHSqzpgdKz0jSffeZ6rLiyjPQ
         BlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=6xc+YDuIfvXxIC+O6+IU1kPpAw3fGddKU5daN249fsU=;
        b=KwMVLf+FQ7Zl0JnsX1f8wbcBch2TxqBktNWUY5Bp6ybjxA+q5jRzadJcXtAVmVF9iF
         LlKhYx+08RGIeuCBMi6vA6OpzdOvsdrotIC/gFQbFZjOja7k24w2CCvNv4W/xOSqlXg7
         LPryfujqOggIeWCbqG5WPY4uzSTnfUpguYM+viSDywWecSDWIbnPo78MgcqWSFK9RJTP
         HyBazgq7vOW1cTpaUdJM9UUyCFiGeoJ0P6VKxFobQFiAant8aKdxQaYIHgLCfihr+g8r
         YfEAnfM4GEozHahpEtcZjJBnDRzy87MInYqb5Y6+0r8N8HNdI3u+7jOn7HlY7U3WT3vH
         SGvA==
X-Gm-Message-State: AJIora+SVE7kFJnH1gXHyFeQach5HKn0WfVkxHVLPHhM9nz/iDZH0sk0
        oQKeTAptBa+yJf4H2jgpqSBrHXZVDO/gkqAm
X-Google-Smtp-Source: AGRyM1vdlBeARWA3UmGrtweL6mLA0mTff+K0S9p3U2jsCdAcpdyZhaSYEp4Awg1PDAEmk6gjejkubg==
X-Received: by 2002:a05:600c:4ece:b0:3a1:7816:31a7 with SMTP id g14-20020a05600c4ece00b003a1781631a7mr7898848wmq.76.1657787568186;
        Thu, 14 Jul 2022 01:32:48 -0700 (PDT)
Received: from [192.168.214.247] (185-165-241-34.hosted-by-worldstream.net. [185.165.241.34])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d4c83000000b0021baf5e590dsm849370wrs.71.2022.07.14.01.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 01:32:47 -0700 (PDT)
Date:   Thu, 14 Jul 2022 12:32:34 +0400
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 2/6] clk: qcom: msm8996-cpu: Statically define PLL
 dividers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <A250FR.22DB6BQXIGPX1@gmail.com>
In-Reply-To: <CAA8EJpq4YYdeXVtYORaDROiFLRL6p-_jmjx3mj4JtrYDhik3hQ@mail.gmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
        <20220621160621.24415-3-y.oudjana@protonmail.com>
        <CAA8EJpq4YYdeXVtYORaDROiFLRL6p-_jmjx3mj4JtrYDhik3hQ@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jun 21 2022 at 20:02:28 +0300, Dmitry Baryshkov 
<dmitry.baryshkov@linaro.org> wrote:
> On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana 
> <yassine.oudjana@gmail.com> wrote:
>> 
>>  From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>>  This will allow for adding them to clk_parent_data arrays
>>  in an upcoming patch.
>> 
>>  Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>  ---
>>   drivers/clk/qcom/clk-cpu-8996.c | 66 
>> +++++++++++++++++++++------------
>>   1 file changed, 42 insertions(+), 24 deletions(-)
>> 
>>  diff --git a/drivers/clk/qcom/clk-cpu-8996.c 
>> b/drivers/clk/qcom/clk-cpu-8996.c
>>  index 5dc68dc3621f..217f9392c23d 100644
>>  --- a/drivers/clk/qcom/clk-cpu-8996.c
>>  +++ b/drivers/clk/qcom/clk-cpu-8996.c
>>  @@ -135,6 +135,34 @@ static struct clk_alpha_pll pwrcl_pll = {
>>          },
>>   };
>> 
>>  +static struct clk_fixed_factor pwrcl_pll_postdiv = {
>>  +       .mult = 1,
>>  +       .div = 2,
>>  +       .hw.init = &(struct clk_init_data){
>>  +               .name = "pwrcl_pll_postdiv",
>>  +               .parent_data = &(const struct clk_parent_data){
>>  +                       .hw = &pwrcl_pll.clkr.hw
>>  +               },
>>  +               .num_parents = 1,
>>  +               .ops = &clk_fixed_factor_ops,
>>  +               .flags = CLK_SET_RATE_PARENT,
>>  +       },
>>  +};
>>  +
>>  +static struct clk_fixed_factor perfcl_pll_postdiv = {
>>  +       .mult = 1,
>>  +       .div = 2,
>>  +       .hw.init = &(struct clk_init_data){
>>  +               .name = "perfcl_pll_postdiv",
>>  +               .parent_data = &(const struct clk_parent_data){
>>  +                       .hw = &perfcl_pll.clkr.hw
>>  +               },
>>  +               .num_parents = 1,
>>  +               .ops = &clk_fixed_factor_ops,
>>  +               .flags = CLK_SET_RATE_PARENT,
>>  +       },
>>  +};
>>  +
>>   static const struct pll_vco alt_pll_vco_modes[] = {
>>          VCO(3,  250000000,  500000000),
>>          VCO(2,  500000000,  750000000),
>>  @@ -261,7 +289,7 @@ static struct clk_cpu_8996_mux pwrcl_smux = {
>>                  .name = "pwrcl_smux",
>>                  .parent_names = (const char *[]){
>>                          "xo",
>>  -                       "pwrcl_pll_main",
>>  +                       "pwrcl_pll_postdiv",
>>                  },
>>                  .num_parents = 2,
>>                  .ops = &clk_cpu_8996_mux_ops,
>>  @@ -277,7 +305,7 @@ static struct clk_cpu_8996_mux perfcl_smux = {
>>                  .name = "perfcl_smux",
>>                  .parent_names = (const char *[]){
>>                          "xo",
>>  -                       "perfcl_pll_main",
>>  +                       "perfcl_pll_postdiv",
>>                  },
>>                  .num_parents = 2,
>>                  .ops = &clk_cpu_8996_mux_ops,
>>  @@ -354,32 +382,25 @@ static int 
>> qcom_cpu_clk_msm8996_register_clks(struct device *dev,
>>   {
>>          int i, ret;
>> 
>>  -       perfcl_smux.pll = clk_hw_register_fixed_factor(dev, 
>> "perfcl_pll_main",
>>  -                                                      "perfcl_pll",
>>  -                                                      
>> CLK_SET_RATE_PARENT,
>>  -                                                      1, 2);
>>  -       if (IS_ERR(perfcl_smux.pll)) {
>>  -               dev_err(dev, "Failed to initialize 
>> perfcl_pll_main\n");
>>  -               return PTR_ERR(perfcl_smux.pll);
>>  +       ret = devm_clk_hw_register(dev, &pwrcl_pll_postdiv.hw);
> 
> No need to. I'd suggest picking up the
> devm_clk_hw_register_fixed_factor patch from my patchset and using
> this API.

I did it this way to be able to define it statically in the
`parent_data` arrays of the secondary muxes in patch 6/6. How
would I do it this way? Do I define global `static struct clk_hw *`s
for the postdivs and use them in the `parent_data` arrays, or
perhaps un-constify the arrays and insert the returned
`struct clk_hw *`s into them here? Also can you send a link to
your patch? or is it already applied?

> 
>>  +       if (ret) {
>>  +               dev_err(dev, "Failed to register pwrcl_pll_postdiv: 
>> %d", ret);
>>  +               return ret;
>>          }
>> 
>>  -       pwrcl_smux.pll = clk_hw_register_fixed_factor(dev, 
>> "pwrcl_pll_main",
>>  -                                                     "pwrcl_pll",
>>  -                                                     
>> CLK_SET_RATE_PARENT,
>>  -                                                     1, 2);
>>  -       if (IS_ERR(pwrcl_smux.pll)) {
>>  -               dev_err(dev, "Failed to initialize 
>> pwrcl_pll_main\n");
>>  -               clk_hw_unregister(perfcl_smux.pll);
>>  -               return PTR_ERR(pwrcl_smux.pll);
>>  +       ret = devm_clk_hw_register(dev, &perfcl_pll_postdiv.hw);
>>  +       if (ret) {
>>  +               dev_err(dev, "Failed to register 
>> perfcl_pll_postdiv: %d", ret);
>>  +               return ret;
>>          }
>> 
>>  +       pwrcl_smux.pll = &pwrcl_pll_postdiv.hw;
>>  +       perfcl_smux.pll = &perfcl_pll_postdiv.hw;
>>  +
>>          for (i = 0; i < ARRAY_SIZE(cpu_msm8996_clks); i++) {
>>                  ret = devm_clk_register_regmap(dev, 
>> cpu_msm8996_clks[i]);
>>  -               if (ret) {
>>  -                       clk_hw_unregister(perfcl_smux.pll);
>>  -                       clk_hw_unregister(pwrcl_smux.pll);
>>  +               if (ret)
>>                          return ret;
>>  -               }
>>          }
>> 
>>          clk_alpha_pll_configure(&perfcl_pll, regmap, &hfpll_config);
>>  @@ -409,9 +430,6 @@ static int 
>> qcom_cpu_clk_msm8996_unregister_clks(void)
>>          if (ret)
>>                  return ret;
>> 
>>  -       clk_hw_unregister(perfcl_smux.pll);
>>  -       clk_hw_unregister(pwrcl_smux.pll);
>>  -
>>          return 0;
>>   }
>> 
>>  --
>>  2.36.1
>> 
> 
> 
> --
> With best wishes
> Dmitry



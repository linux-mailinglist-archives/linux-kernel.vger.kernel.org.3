Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B376570C91
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiGKVOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiGKVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:14:51 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C168804AE;
        Mon, 11 Jul 2022 14:14:50 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id o26so4864986qkl.6;
        Mon, 11 Jul 2022 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+tiAbR5ipokPOI4Uv53O9dfcW8Zht66rbKGm1GTYpo=;
        b=d83Mzj9ZZK65lmwWYYeI6vy06BxRU06v3My3PdoLtgOcYputPgxrscy/rjd5CZqllT
         63zziwo3mkE7LawXf/TDzDPl87omfufHFMXKQ2W0jXGvgbq59LKT/Jydr28jZEw6bpGN
         P0CyUBQlEjfqo5eQ7ZHRi+6rXLUAlrJxK4LF+AjT2KxUbwvi8kWgWlwwuk3T3Wuz/TV2
         MgZoTCcsgDQNp1iUsBz3Q64twGH04LT4FOliwpWQWR+WHy0KuOLBA6UXd0jgE+B2/zeZ
         ipzXBII1wbEub1slH+D7ezKAKCmvGprPTj5G+h0Q4aOB+gIHKizTCb+weJCXVCzT337G
         7rnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+tiAbR5ipokPOI4Uv53O9dfcW8Zht66rbKGm1GTYpo=;
        b=Zq0weeWawfMP2dlexEze8cceNH4Y/lMYroJ88Xe6QrVrIdDH1jega1ZVx1sOmaVeVS
         pTE9yCddAMGbUrdo7j2Ov1GsRuGMfVWM47CFtPtn5HuyyX9FkupW8gZlmc0orSSP7iq/
         kdAdczse6on1B/K6ruS/mju4gnlYff9S2aSoh9wlrgR7SPHvqfdeBENkIO9TwK6imcK9
         roKUM9tPUoypKyFtHcodCUBPzqHRUkawAI4GJnKwG2ZTdczmu9BNkK4gMywvnzF44qCX
         C1euIfCSEFGu45wbtWwbI+hdCFR7SyBkpdIKibwlPIwKZLp4Wc70OGtrDV9Aa+8Y+e7z
         OMYw==
X-Gm-Message-State: AJIora9YIlF93aiY7cEsJQAHZp5dR7WgNYsUFJ5Uqe4gT1dQCd/rxptl
        sydOsx7n5HjGCaezp5GJBRbkMAPeeIPXNt5Eo4w=
X-Google-Smtp-Source: AGRyM1tsfk66MvgLGjjCS8tQrgRs7OzckX8WV9p0YXE4enpC7rdc8e4wOi1C3YnZhIIOYJQZ8EscKFmLYbw1Llnf9HI=
X-Received: by 2002:a05:620a:c8e:b0:6b5:91da:9b04 with SMTP id
 q14-20020a05620a0c8e00b006b591da9b04mr2886309qki.25.1657574089779; Mon, 11
 Jul 2022 14:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220515210048.483898-1-robimarko@gmail.com> <20220515210048.483898-10-robimarko@gmail.com>
 <20220711211047.952F4C34115@smtp.kernel.org>
In-Reply-To: <20220711211047.952F4C34115@smtp.kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 23:14:38 +0200
Message-ID: <CAOX2RU7NaJL5dTrjz26oiz0psvXKV8C-7HGMmJ-rfNJ3r=y2qg@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] clk: qcom: ipq8074: dont disable gcc_sleep_clk_src
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, tdas@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2022 at 23:10, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Robert Marko (2022-05-15 14:00:47)
> > diff --git a/drivers/clk/qcom/gcc-ipq8074.c b/drivers/clk/qcom/gcc-ipq8074.c
> > index 3204d550ff76..42d185fe19c8 100644
> > --- a/drivers/clk/qcom/gcc-ipq8074.c
> > +++ b/drivers/clk/qcom/gcc-ipq8074.c
> > @@ -663,6 +663,7 @@ static struct clk_branch gcc_sleep_clk_src = {
> >                         },
> >                         .num_parents = 1,
> >                         .ops = &clk_branch2_ops,
> > +                       .flags = CLK_IS_CRITICAL,
> >                 },
>
> Why not just remove the clk from the driver? Is anything using it?

Hi Stephen, USB sleep clocks are derived from it so it cant be dropped.

Regards,
Robert

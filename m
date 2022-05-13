Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDC8526D65
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 01:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbiEMXOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 19:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiEMXOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 19:14:36 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016D3211D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:14:22 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id e12so17669482ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 16:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJjCKmIV0+PUlw1yN8LzGGtdpY7JQRJT83F9A+chaFQ=;
        b=THiP8XlKeuATd+sFBtOcYrkM4vfQtgO4vnzZ0czrpsdPkpjchMTT4P/obyYS2u/Ph0
         +d4NGAg/jxClzjL8HVJs1YAUDTNGgJWRecVdDws5TTDi+gv0iwTmpz+MkqCaUpeAV5AA
         yF3lhT3KSxCLDQJ9FmJNtviqrwf/aWE8xllwdNkP73HSFcu2JxZfzQwraA3ZMJaktL2/
         OkzTNpuZEQcIWaejl7sk/YJRrshWH/IN8sd7qW08KjeWOtRqJdYH5DbIBGNlQDidczW+
         6kEBBpSeOhUtIg4JxlmhyKAglB0MmRs+oQnBntEgiBPniHirdlTfg443BTKKz6xnZr/V
         JO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJjCKmIV0+PUlw1yN8LzGGtdpY7JQRJT83F9A+chaFQ=;
        b=13ZeXUy47Vx5YHYM5y7zFje5K2yafsmjcOrYYvosCjXUTdYiRtdluo4C9d2yihgk6M
         DjVS1NkJnhOwP7Y3K+arFywG5Ayk4Xxvd+e+UVWTVapA79R+YIBuW4bobIuQ3u41KDq7
         7wFFpgE135CGBcocKnWNXzXwC5vcviY4d8w6Eog+2jPQaOroaLt45zAQDowTYNPBTotv
         gxOC6QM0I6A8+Pl+09slutlNRYTCzK5q7z+4zD6Xgj/arKcF6dMfhDdlS6wMAQB/a38X
         qYy2d+WESjzxCUabUaW4DIYlo4fnY5Jr+mE1aygtBTG1HzLR/1OX/RiCoeorSu67f22f
         PluQ==
X-Gm-Message-State: AOAM5321QWKaaCi7Am8ulAmtXjT9S5M1F8dKU5xR6ZfMFOUP4Uqt1Boc
        mmhz1juf0yHwbPJ37tGFUHI//lPLFeM8Necj4tI0+w==
X-Google-Smtp-Source: ABdhPJyqJOHYby5B4zPz7I69RNcSghbBdax44/7CJOKXFMx9IaAQOi+fUTHLPntFEHAMZ9z/gSOi5OooYyzthLTILkw=
X-Received: by 2002:a25:aa94:0:b0:648:62f2:ef4e with SMTP id
 t20-20020a25aa94000000b0064862f2ef4emr6931589ybi.626.1652483661584; Fri, 13
 May 2022 16:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220507102257.26414-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220507102257.26414-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 14 May 2022 01:14:10 +0200
Message-ID: <CACRpkdYjmAKPb9sHvC+Y0goDBmGXDthJDmgbG2CZ6VO_Y1zEmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: stm32: Unshadow np variable in stm32_pctl_probe()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Fabien Dessenne <fabien.dessenne@foss.st.com>,
        linux-gpio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        kernel test robot <lkp@intel.com>
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

On Sat, May 7, 2022 at 12:23 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The np variable is used globally for stm32_pctl_probe() and in one of
> its code branches. cppcheck is not happy with that:
>
>   pinctrl-stm32.c:1530:23: warning: Local variable 'np' shadows outer variable [shadowVariable]
>
> Instead of simply renaming one of the variables convert some code to
> use a device pointer directly.
>
> Fixes: bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_node() helper")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij

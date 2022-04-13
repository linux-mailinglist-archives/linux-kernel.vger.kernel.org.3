Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96104FF369
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiDMJ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbiDMJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:27:01 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E0DEE0;
        Wed, 13 Apr 2022 02:24:36 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 13 Apr
 2022 17:24:36 +0800
Received: from [172.16.137.70] (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 13 Apr
 2022 17:24:34 +0800
Message-ID: <05f14aa0-4001-d08d-610e-12749437ec9a@meizu.com>
Date:   Wed, 13 Apr 2022 17:24:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2] clk: renesas: Fix memory leak of 'cpg'
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1649837953-10984-1-git-send-email-baihaowen@meizu.com>
 <CAMuHMdXcNBq5e6K6YUorLCF0hiFsp6VVKrUcy5E4mdAQAbH7Sg@mail.gmail.com>
From:   baihaowen <baihaowen@meizu.com>
In-Reply-To: <CAMuHMdXcNBq5e6K6YUorLCF0hiFsp6VVKrUcy5E4mdAQAbH7Sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 4/13/22 4:41 PM, Geert Uytterhoeven 写道:
> Hi Haowen,
>
> On Wed, Apr 13, 2022 at 10:30 AM Haowen Bai <baihaowen@meizu.com> wrote:
>> Fix this issue by freeing the cpg when exiting the function in the
>> error/normal path.
>>
>> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> Thanks for your patch!
>
>> --- a/drivers/clk/renesas/clk-r8a73a4.c
>> +++ b/drivers/clk/renesas/clk-r8a73a4.c
>> @@ -215,7 +215,7 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
>>
>>         cpg->reg = of_iomap(np, 0);
>>         if (WARN_ON(cpg->reg == NULL))
>> -               return;
>> +               goto out_free_cpg;
> Note that this is a fatal error, i.e. no chance the system will survive this,
> so cleaning up is moot.
>
>>         for (i = 0; i < num_clks; ++i) {
>>                 const char *name;
>> @@ -233,6 +233,9 @@ static void __init r8a73a4_cpg_clocks_init(struct device_node *np)
>>         }
>>
>>         of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
>> +out_free_cpg:
>> +       kfree(cpg);
>> +       kfree(clks);
> Both cpg and clks are still used after returning from this function,
> through the registered clocks and clock provider.
>
>>  }
>>  CLK_OF_DECLARE(r8a73a4_cpg_clks, "renesas,r8a73a4-cpg-clocks",
>>                r8a73a4_cpg_clocks_init);
> NAKed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
Dear Geert Uytterhoeven
Could you show me how and when cpg & clks free ?

-- 
Haowen Bai


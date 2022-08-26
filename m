Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC415A27AE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbiHZMTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343998AbiHZMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:18:18 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B505DDB58
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:18:16 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id RYHromGHwsfCIRYHroCmxB; Fri, 26 Aug 2022 14:18:14 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 Aug 2022 14:18:14 +0200
X-ME-IP: 90.11.190.129
Message-ID: <e9991ab5-cb55-789a-dfa1-de10acb37842@wanadoo.fr>
Date:   Fri, 26 Aug 2022 14:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] gpio: pxa: use devres for the clock struct
Content-Language: fr
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>, Yuan Can <yuancan@huawei.com>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <20220815091929.130547-1-brgl@bgdev.pl>
 <CAHp75Vc3dazcM1MLzjzPUmgMGNACUsOZ8aK4uauAJk0hzj9q-w@mail.gmail.com>
 <CACRpkdZEcTD1A3tR=d4fDF89ECMDfchVPW921v6X6ARiPXHEMQ@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CACRpkdZEcTD1A3tR=d4fDF89ECMDfchVPW921v6X6ARiPXHEMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/08/2022 à 10:20, Linus Walleij a écrit :
> On Sat, Aug 20, 2022 at 12:15 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Mon, Aug 15, 2022 at 12:26 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> The clock is never released after probe(). Use devres to not leak
>>> resources.
>>
>> ...
>>
>>> -       clk = clk_get(&pdev->dev, NULL);
>>> +       clk = devm_clk_get_enabled(&pdev->dev, NULL);
>>>          if (IS_ERR(clk)) {
>>>                  dev_err(&pdev->dev, "Error %ld to get gpio clock\n",
>>>                          PTR_ERR(clk));
>>>                  return PTR_ERR(clk);
>>
>> Shouldn't we fix a potential log saturation issue first (by switching
>> to use dev_err_probe() helper)?
> 
> Can be a separate patch, the clock mem leak is a bigger problem
> IMO so this should be applied first.
> 
> Hm isn't it possible to toss the task of fixing a gazillion
> dev_err_probe() messages on Cocinelle scripts/coccinelle/? I bet it's something
> the kernel janitors could fix all over the place.
> 
> Yours,
> Linus Walleij
> 

Not perfect and certainly incomplete, but gives an idea:


@@
expression x, dev, e, str;
@@
(
	x = devm_clk_get(dev, e);
|
	x = clk_get(dev, e);
)
-	if (IS_ERR(x)) {
-		dev_err(dev, str);
-		return PTR_ERR(x);
-	}
+	if (IS_ERR(x))
+		return dev_err_probe(dev, PTR_ERR(x), str);

// This rule only: 291 files changed, 1233 insertions(+), 1634 deletions(-)


// The output of this rule needs to be adjusted to fix the 'str'. The
// error code and related text have to be manually removed
@@
expression x, dev, e, str;
@@
(
	x = devm_clk_get(dev, e);
|
	x = clk_get(dev, e);
)
-	if (IS_ERR(x)) {
-		dev_err(dev, str, PTR_ERR(x));
-		return PTR_ERR(x);
-	}
+	if (IS_ERR(x))
+		return dev_err_probe(dev, PTR_ERR(x), str);

// Both rules: 316 files changed, 1321 insertions(+), 1774 deletions(-)

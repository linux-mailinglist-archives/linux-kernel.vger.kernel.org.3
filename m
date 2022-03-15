Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE64D91C6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 01:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343976AbiCOAw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiCOAw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 20:52:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3525A42A01
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:51:17 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w16so34225401ybi.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0UlhLg5UKZcX2aQVdSXvgppoO3cZOrtQ6eoO0oL/Q0=;
        b=QUiGPPJzn7kEVNBbdRGZN7y1wEnZ8PE99wDVRUYPdG7npO00a1a5tmuWBvfD4CYcIY
         0zY/Cj1/jMwmWfhNIUuJcoqQiaR/bJOC74zjK4OGSbmz3/DpS+qTv7gCvTK7yNSoT1Tt
         vQRQ5BHHLORdPrO+a7cLptIZvGk96R6ebiS8UpPXhSWY1n9I4xesAORcmo9READeJDHW
         IW0RZy8yeI2Mh6XeU8GHrWncZvU/65MBWKd3C+167ykIh1Qf9Bzy70QI4L1TnZCFV5ac
         ZQK9DpAIRcp9bNsZ+PpY/oiRanLk9WLkFQea9uhasoQr4uMlDVl+ytiMloy6E9L+dA9J
         GH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0UlhLg5UKZcX2aQVdSXvgppoO3cZOrtQ6eoO0oL/Q0=;
        b=XSSXKxn5bxvSkfInfbYKWdMuyEeLILG3qb5KCxMDXTMZWRI0NaIoCTbMPA7hEyZuCo
         KKWgRzpfol09DR/KBmJ47VCSzJ8yo6gKO/+8KFc7v7ZZ+jSNUIJCqSI1OzFo7MX7Q0mo
         kr9IM3j4VdrB7n2Q2oVybJQDm6hB9lKHMypupp0aGov4SkbZEyTfEK6iFGC2M3zhK3kX
         Y8byPJqxj60/tSKBVTZFOyVb/PSyi1+QRXtAlKbv1paWwOCOTreFrHcyK8S4Bkc/z/QA
         g2vKDXLsvUaQ4jZw1UWrrI1K8RsMpDSmcishvjITm1lgM/72FNz3RUqELoHnc9adyqTL
         53EA==
X-Gm-Message-State: AOAM533BYBvkKr8GMoFaKf4WK21U+vQyQoU1g24XhwzHRAtrg6wNgQKx
        gDijqqbaY3a2NBMQcUoQNPyscanz0Z/wI98CO3HKZA==
X-Google-Smtp-Source: ABdhPJzWvSlEl+Nt8Y9+wYpryt91TF+QUhuMcfghjrafkVrwylfkmDpe2Ot72osvoz1Yng0YyEpiqOLFpGHghLqrox8=
X-Received: by 2002:a25:2308:0:b0:628:9a66:7327 with SMTP id
 j8-20020a252308000000b006289a667327mr20333278ybj.626.1647305476388; Mon, 14
 Mar 2022 17:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220304144432.3397621-2-horatiu.vultur@microchip.com>
 <20220307124501.3487932-1-michael@walle.cc> <20220308083023.frr7qz2xga2tas5r@soft-dev3-1.localhost>
 <691cc39a667d6284fa25bc47f6855152@walle.cc>
In-Reply-To: <691cc39a667d6284fa25bc47f6855152@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 01:51:05 +0100
Message-ID: <CACRpkdYMV+-_MXyHi2LXgGMCo8a+fpFWcEPQRgE2k1oRi_aRMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pinctrl: ocelot: Fix the pincfg resource.
To:     Michael Walle <michael@walle.cc>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        andriy.shevchenko@linux.intel.com, colin.foster@in-advantage.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 9:32 AM Michael Walle <michael@walle.cc> wrote:
> Am 2022-03-08 09:30, schrieb Horatiu Vultur:
> > The 03/07/2022 13:45, Michael Walle wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> >> the content is safe
> >>
> >> > The pincfg resources are in the second memory resource. But the driver
> >> > still tries to access the first memory resource to get the pincfg. This
> >> > is wrong therefore fix to access the second memory resource.
> >> >
> >> > Reviewed-by: Colin Foster <colin.foster@in-advantage.com>
> >> > Fixes: ad96111e658a95 ("pinctrl: ocelot: combine get resource and ioremap into single call")
> >> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> >>
> >> There is already this patch pending, which does exactly
> >> the same:
> >> https://lore.kernel.org/linux-gpio/20220216082020.981797-1-michael@walle.cc/
> >
> > Sorry, I have missed your patch.
> > Should I resend this series where I will drop this patch? What is the
> > correct approach?
>
> Actually, I don't know. Maybe you don't need to do anything, Linus?

I'll just apply 2/2 if applicable.

Yours,
Linus Walleij

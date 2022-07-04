Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC5565C40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiGDQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiGDQgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:36:54 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3530B1D7;
        Mon,  4 Jul 2022 09:36:53 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d16so7890091wrv.10;
        Mon, 04 Jul 2022 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=fgGIkrds/LxOxZz24kZBpk6WZZ1UMSDRaDt1bZLPE0s=;
        b=d89EYI1iAYaRo4lBjclN7TTgOAEcBAz0/NAyQlkyeyu6k4hzHD1X+CMnfkQQCl+s6N
         exr8k3L+itILkzj4yPq8gIODXyn4z6S0bnQ1HTdnq4/GXE6hxSSfMVBvOfS15NsunRXt
         B0jF3KsOPbR8NqR0C7meErK23dZtlUtuvwx7/CdL3vzlrYg561ZHFpETUTIVntVGFp/E
         CAIEhqFd5ZRUrRHZJam0J9hu9wOfPm91IDpba72UQEWCbVhgR4VPC0gHydao4qwNtj+o
         489zLGIGHFzk0VVAmaENQraLZ3TIld4tqMrfuOIw7GbUTf9APfP21c47NyxfSVymsj1p
         edBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fgGIkrds/LxOxZz24kZBpk6WZZ1UMSDRaDt1bZLPE0s=;
        b=bTm/gP0/NNrXalwPsoqyAqNbyLAbElIIUcuRJJZ2W0VGdzcsvvpaPiCmtjbZGMLuO3
         K1nGGL49nSzx0WW+frfNDLtXlNEXEwabmlIvlagUICPy6QK5jbHqAEcKgBmIYM0Ceh/i
         HuAsgMcc+xSiWFoad9rG2Mz4pPqCwWWdTzQpvBHW69bMZ+L7yoUNlnfKcXS/fhqTrSyX
         y4/ppiTLpoaQk2Yuibhpv8CljLRKNhOkzd+b+uXOfD3iUBJOFYWZhjXRG1sXrdV1CaSD
         VM49iEBziGUjEZqz7GHJEDv6TGJB/d5AccyjmVgk3qNhsN7Hq+l3gjnZWjq3gApApv//
         eaAw==
X-Gm-Message-State: AJIora8PB3a80DrY9F5VRPxTvhJQwwZlcnR6hf2xazQDan7u6YlI1Wku
        yVrPjtwz4t0HJfAfNJsNK4I=
X-Google-Smtp-Source: AGRyM1uXbXGZEHV0QcEoDOjA2l7XZbhSe99v16OLg7QRBhdeUzKuv4UcHDE6pX4/d0lCWt9vv8XDOQ==
X-Received: by 2002:adf:e3cb:0:b0:21b:8de5:ec7d with SMTP id k11-20020adfe3cb000000b0021b8de5ec7dmr28277287wrm.714.1656952612611;
        Mon, 04 Jul 2022 09:36:52 -0700 (PDT)
Received: from localhost (92.40.202.7.threembb.co.uk. [92.40.202.7])
        by smtp.gmail.com with ESMTPSA id c1-20020adfef41000000b00219b391c2d2sm3813241wrp.36.2022.07.04.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:36:52 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vc30zZL7LLg6zn7VnMARMOKsYo421KVMDu7RGp4QCtcXg@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
In-reply-to: <CAHp75Vc30zZL7LLg6zn7VnMARMOKsYo421KVMDu7RGp4QCtcXg@mail.gmail.com>
Date:   Mon, 04 Jul 2022 17:38:00 +0100
Message-ID: <EP4LzL5PhvL2RLOodKu5K24zNSfLTjAi@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Sun, Jul 3, 2022 at 1:11 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>>
>> Some GPIO chips require a custom to_irq() callback for mapping
>> their IRQs, eg. because their interrupts come from a parent IRQ
>> chip where the GPIO offset doesn't map 1-to-1 with hwirq number.
>
> Don't they follow a hierarchical IRQ domain in that case?
>
> And to be honest after the commit ef38237444ce ("gpiolib: add a
> warning on gpiochip->to_irq defined") I have no idea how it works in
> your case and also I feel this patch is a wrong direction of
> development.

My own use case is an MFD device with a shared IRQ chip that is
used by other sub-drivers. This is a very common case that seems
to map onto ->to_irq() cleanly. Do we really need an IRQ domain?
What you're suggesting would be a 1-to-1 mapping from GPIO offset
to hwirq number in a virtual domain, then remapping to the real
hwirq number, which seems unnecessarily complicated when we can
just change the GPIO offset -> hwirq mapping.

The commit you mentioned is warning users of GPIOLIB_IRQCHIP when a
custom ->to_irq() method is overridden. That's not relevant here.
Using an IRQ domain also overrides ->to_irq() so I included a check
in this patch to ensure gpio-regmap chips are well-behaved.

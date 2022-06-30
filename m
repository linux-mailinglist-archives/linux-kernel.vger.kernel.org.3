Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE5562280
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbiF3TDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbiF3TDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:03:31 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2303631F;
        Thu, 30 Jun 2022 12:03:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q132so24935ybg.10;
        Thu, 30 Jun 2022 12:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1YP4rROQ1KlH9M242+3quyf1kYcOl9MA5IfXsRWFwso=;
        b=h2im3IXFyogBb14K6BHYaDSE5rpz351bdfXp9jmHfEOAr+b+AQKkLt4CYSVDElw2fh
         kwU+gYpGccPZWggO+Jfu3ZqvTRiEs/F5EE3gVad9VC1VDqxCEFCDqh23+VQ/QPnoc33g
         Eo/wG6mqvs0a+KwTUpzsA9cKeecgoamMY1J2u+qL/zwb0vJD7lb3X3/AE3E/Jo0lrzgx
         K04c0QaBU1t25yhIKcR0GlivbHPaI1ck6crO+s3CvGKoE0blb771/Nyx0lvkAYiqcSsJ
         ZMB2xZFE2AxvwVz4tmohJrNeEIWJqM9UFLCABStEup/glneFbNgXU4sAHEbOf628dFwG
         grjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1YP4rROQ1KlH9M242+3quyf1kYcOl9MA5IfXsRWFwso=;
        b=A9sWlDh/JQeVPaDbGQDTnIBoEbZuWt8+K1uzYgvnf+YzagG2dQoT2NUbIM25EYjv7M
         Uc2+yU//dkXBUokH7ZRHgUDJhVYLnVvlDMPQx9WuCOFiDn99E6+fohqVfpLEAzqhYrFo
         wIYCW0BfwYa8N5RiEV5ITg7mPkL1Z1eSDT7anTt2iboreL5xFD45ljEpXt/uKLbbptbz
         w1Lsi09hTGzfquZYEb0ZX9hzIGFF1o/OykXPW9WB1bR7O4SEGPYvBn1UVMFH0RAQkOtp
         l0bwJN36I9NTvZoineX7lxaHhIsIzCaZgoZs4u71zElnie+sL+xhahDeRX6923/MUX9k
         uM5g==
X-Gm-Message-State: AJIora/j/2mIi55Q9inYZZKaOUNh/A5UgvQHaveGH1lFWxoUZNsBRLTf
        ZmCUACD4pP6Yy9Z18RnQqUY/Q7FZ0pZrRL70e9Y=
X-Google-Smtp-Source: AGRyM1vGdc4tj1sIjgz8UYjpRrxDv/s84ytlBbORBjuGdinTMQCg18ZnMkqwM6+ZhPswFP/8ZGSKkh7uLCbGZmDByLs=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr11119502ybu.128.1656615810234; Thu, 30
 Jun 2022 12:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com> <20220630162716.GA2842206-robh@kernel.org>
In-Reply-To: <20220630162716.GA2842206-robh@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 21:02:53 +0200
Message-ID: <CAHp75VdARCTnpEMyVRAWv7jVSj_+m8_xYiNTwmX6LCzpZT8Tuw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] of: unittest: Switch to use fwnode instead of of_node
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Thu, Jun 30, 2022 at 6:29 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Jun 29, 2022 at 02:50:09PM +0300, Andy Shevchenko wrote:
> > GPIO library now accepts fwnode as a firmware node, so
> > switch the module to use it.

...

> > -     devptr->chip.of_node = pdev->dev.of_node;
> > +     devptr->chip.fwnode = dev_fwnode(&pdev->dev);
>
> Perhaps I want the DT test code to test using the of_node pointer. We do
> want that to work, right?

Nope. We want to get rid of of_node in GPIO.

> I'm really not a fan of fwnode'ifying things that are DT only. It's
> really pointless churn.

Other way around, keeping an of_node for just 3 drivers (and counting
down) + one test case is pointless churn.

But I got that commit message that is unclear about the intentions
behind. I will update that if you agree on the rest.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57AE46FCF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 09:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbhLJIvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 03:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbhLJIvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 03:51:53 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF70C061746;
        Fri, 10 Dec 2021 00:48:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so27036749eda.12;
        Fri, 10 Dec 2021 00:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qkHF+XwQ2moOpOWfA34HBp/T8uX0AbR7EB91Anq22ok=;
        b=UqaPAQKK3Vd1ZYMl9v5BrdodRB5t3MyLXBPEEQXfHcbDEEY0oJlT3hjry/mBUxZ6R5
         ooIGQIAjIGdV++gjqfaPcdAjKoaNEh0cM0XwlSig4rbsoeTkWHrUGdjZ6UTfRIiQyYPU
         MyCs+e5YHQjH6r192BMix0QWKsxePV7EN48RCDbCkoHg3eQKiG+qNSinr9Bx4IebpQwy
         4c8DkLTT7JkhDgaLUrmd5PL6SdGkArbtHunVZaBkJUB6nGl7kf1Sx5K9AryB1pmekV8n
         yoih8Ieilrnu63WIcQM8RBQlC07UuKax1ggIjQYcGkB7Zt8D3X3yGyY5OfrFTfOPQF0m
         RupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qkHF+XwQ2moOpOWfA34HBp/T8uX0AbR7EB91Anq22ok=;
        b=nmhCWicr3sD48xkFrh1+UqI12jKvgxcojz+Q3t27kr3pT3Pw83hMKuO672u8ZK0di6
         6GLyXJOap4RjQgZpX68tKSI4+2qvh7ASrkRElwBPM2o+jaoRwCvDVMsCv7I+Y+exNGm0
         bmgytAc5YYWderGqVhMHjBk9Mf5/o94tjVzP4bzBSM9yWvf7Ev0lTqg1BwY+WcONhZ7r
         EHEIZYbUT0cT00ylJARFwzo00QK0U96KfDZ26FZEBZB9xqcTLAZ7T1DFVxzmPo2572Dp
         /BMHOoj8rSYkifMCgeaU+cohfVo8y6sVI6syp09e0MXSk7qSzo+1vGZ9w/Jh6ORqhK8o
         mfXA==
X-Gm-Message-State: AOAM532yp02r1AS89wMckF7ZLOJXetPcYl/u3R4r/8VYLVOZxzHIML5M
        ARylh8IWWITwba4XdEE47Lsk6pFxxCkI3rNQaRE=
X-Google-Smtp-Source: ABdhPJycGjyJTGxjy8H1QTUexOFtRrVKNPl8q4lWAL1NURgWgvWGUNN4iPah2dcp1gzAiBWd7370i4tG0E5UYmdkJf0=
X-Received: by 2002:a17:906:9b92:: with SMTP id dd18mr21901868ejc.425.1639126097529;
 Fri, 10 Dec 2021 00:48:17 -0800 (PST)
MIME-Version: 1.0
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com> <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
In-Reply-To: <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Dec 2021 10:47:41 +0200
Message-ID: <CAHp75VcdwozpUJVB17VmCDska7euYnx1VjZLnCaZ8DHG+_3vYg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message when
 IRQ can't be retrieved
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 4:47 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> On 2021/12/09 23:59, Andy Shevchenko wrote:
> > platform_get_irq() will print a message when it fails.
> > No need to repeat this.
> >
> > While at it, drop redundant check for 0 as platform_get_irq() spills
> > out a big WARN() in such case.
>
> The reason you should be able to remove the "if (!irq)" test is that
> platform_get_irq() never returns 0. At least, that is what the function kdoc
> says. But looking at platform_get_irq_optional(), which is called by
> platform_get_irq(), the out label is:
>
>         WARN(ret == 0, "0 is an invalid IRQ number\n");
>         return ret;
>
> So 0 will be returned as-is. That is rather weird. That should be fixed to
> return -ENXIO:
>
>         if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
>                 return -ENXIO;

No, this is wrong for the same reasons I explained to Sergey.
The problem is that this is _optional API and it has been misdesigned.
Replacing things like above will increase the mess.

>         return ret;
>
> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?

No. This is not a business of the caller to workaround implementation
details (bugs) of the core APIs.
If something goes wrong, then it's platform_get_irq() to blame, and
not the libahci_platform.

-- 
With Best Regards,
Andy Shevchenko

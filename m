Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834D957901B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 03:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbiGSBwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 21:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGSBwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 21:52:07 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AFC5FE0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:52:06 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31e560aa854so14098007b3.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 18:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIjQaBjQUgp/ajMu8gok6FP0gJMLHKSVzCOxv6asp00=;
        b=GS48YmNO01C/8sX42sKAaQch+uk2MTMaw2zA8jQnRko0YFkFctVBVmxlz5SEKaiEXu
         bknBsMnGjr7Wf78pVvO8u6NZl48L6bB564pHuBs8pMPTtCVTppu+RAvEdyLRwt5HYzIV
         Pc+LgadW3ZEgVvebnT+nDQdj0uhMzxGUqIZSlVdJtV8hqUUr9OTqs1EY6lGeTXgmBNwZ
         YKHI6aIXohCZrbWQ4GITsZTsibwx20PENs4nFJhwgIqsHA9pQWcxSFTBu9ywJJKFETHm
         Ucce6DvsPju7qSp0JSU3rQHeZjicZ0vJmYr6mMW3TgGJR+sHzTv/8ywh849Io81mMSDI
         beTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIjQaBjQUgp/ajMu8gok6FP0gJMLHKSVzCOxv6asp00=;
        b=TGATefCZ1b95V89vhISWQyPC+qtM7Wb1tQGJfOkhHD/UHjQdGcji9rcwQW+q72Fztv
         oCvRu3lm9MpH2osWPJ4p8qILI5tX9QqPRw04nxxTh0ZUBYc5Y1dB00BXQxVgi+Y91JJZ
         yXy6XzR535V+CyctfucEEcZTUabdCsAKmd8jeEXvwGbCPcBRGFVpkWHIa8c1RFQxO5x7
         jW1P9TJ33GDtxHi/mCPPI98P7acuvsaxpvwHsqd/Xo9AquvqEvM7oalexWv3l6sQYIyG
         JRK6J0IbPKUa9pr6ys/3hfbMtdY3mrWbwilnz5BMjNsfVEv+4RvxeYcx7SGkRMZFJSC+
         zVqw==
X-Gm-Message-State: AJIora+JW17qcORO+LC6mhQ5vwoEGuGTfKzaGBaMN/b16NfixEdd2nRL
        raiuA14CAd5GseACUyY/7FwSJBMg7tt28Eui6T+9jA==
X-Google-Smtp-Source: AGRyM1v8daXjvemajsl7uuOlzYdvFLILh7ilDR+pULLtkSQKR7yYjswnNjG4Gx8np3BdeY7CJ01HpTUzvkKJlMJ6JRc=
X-Received: by 2002:a0d:eb83:0:b0:31c:8741:a033 with SMTP id
 u125-20020a0deb83000000b0031c8741a033mr34012541ywe.455.1658195525735; Mon, 18
 Jul 2022 18:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20220705083944eucas1p23419f52b9529c79c03c8cc23e2aaf4c5@eucas1p2.samsung.com>
 <20220705083934.3974140-1-saravanak@google.com> <7482d3af-4b02-4c1d-0386-b0a4ddf529da@samsung.com>
 <8a04332e-e7b1-8bc3-d569-5052427bcb13@samsung.com> <CAGETcx93rWqt-Cyz_8JZ4mxcLpJruzSM1QOAgpkPSM-G1sBXWg@mail.gmail.com>
 <f68f8bcc-7543-5957-0e17-2cc797898ec0@samsung.com>
In-Reply-To: <f68f8bcc-7543-5957-0e17-2cc797898ec0@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 18 Jul 2022 18:51:29 -0700
Message-ID: <CAGETcx-=0Lis2Btt7Ski+eO4Dp+Aa+a+eF+Sp=igSOsWvEntww@mail.gmail.com>
Subject: Re: [PATCH v4] amba: Remove deferred device addition
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 11:53 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 12.07.2022 21:38, Saravana Kannan wrote:
> > On Tue, Jul 12, 2022 at 5:34 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 12.07.2022 14:25, Marek Szyprowski wrote:
> >>> On 05.07.2022 10:39, Saravana Kannan wrote:
> >>>> The uevents generated for an amba device need PID and CID information
> >>>> that's available only when the amba device is powered on, clocked and
> >>>> out of reset. So, if those resources aren't available, the information
> >>>> can't be read to generate the uevents. To workaround this requirement,
> >>>> if the resources weren't available, the device addition was deferred and
> >>>> retried periodically.
> >>>>
> >>>> However, this deferred addition retry isn't based on resources becoming
> >>>> available. Instead, it's retried every 5 seconds and causes arbitrary
> >>>> probe delays for amba devices and their consumers.
> >>>>
> >>>> Also, maintaining a separate deferred-probe like mechanism is
> >>>> maintenance headache.
> >>>>
> >>>> With this commit, instead of deferring the device addition, we simply
> >>>> defer the generation of uevents for the device and probing of the device
> >>>> (because drivers needs PID and CID to match) until the PID and CID
> >>>> information can be read. This allows us to delete all the amba specific
> >>>> deferring code and also avoid the arbitrary probing delays.
> >>>>
> >>>> Cc: Rob Herring <robh@kernel.org>
> >>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >>>> Cc: John Stultz <john.stultz@linaro.org>
> >>>> Cc: Saravana Kannan <saravanak@google.com>
> >>>> Cc: Linus Walleij <linus.walleij@linaro.org>
> >>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >>>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> >>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>>> Cc: Russell King <linux@armlinux.org.uk>
> >>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>>> ---
> >>>>
> >>>> v1 -> v2:
> >>>> - Dropped RFC tag
> >>>> - Complete rewrite to not use stub devices.
> >>>>
> >>>> v2 -> v3:
> >>>> - Flipped the if() condition for hard-coded periphids.
> >>>> - Added a stub driver to handle the case where all amba drivers are
> >>>>     modules loaded by uevents.
> >>>> - Cc Marek after I realized I forgot to add him.
> >>>>
> >>>> v3 -> v4:
> >>>> - Finally figured out and fixed the issue reported by Kefeng (bus match
> >>>>     can't return an error other than -EPROBE_DEFER).
> >>>> - I tested the patch on "V2P-CA15" on qemu
> >>>> - Marek tested v3, but that was so long ago and the rebase wasn't clean,
> >>>>     so I didn't include the tested-by.
> >>>>
> >>>> Marek/Kefeng,
> >>>>
> >>>> Mind giving a Tested-by?
> >>>
> >>> Yes, it looks that it still works fine.
> >>>
> >>> I've tested it by changing the Exynos power domain driver to
> >>> initialize from late_initcall. This in turn lead me to a bug in
> >>> generic pm_domains code in __genpd_dev_pm_attach(), which returns -2
> >>> if the pm domain driver is not yet registered. After fixing that, I've
> >>> successfully observed the deferred probe of PL330 driver on Exynos
> >>> 4210 based boards both with this patch and without (with the old timer
> >>> based code).
> > Thanks for testing it again Marek! I was hoping you'll hit the crash
> > that Sudeep was hitting and it would give me some more clues.
> >
> > Sudeep,
> >
> > This makes me think the issue you are seeing is related to your
> > hardware drivers. Can you look into those please? I'm leaning towards
> > merging this amba clean up and adding delays (say 1ms) to your
> > clock/power domain drivers to avoid the crash you are seeing. And then
> > you can figure out the actual delays needed and update it.
> >
> >> While preparing a fix for the above issue in genpd I found that it has
> >> been introduced by your commit 5a46079a9645 ("PM: domains: Delete usage
> >> of driver_deferred_probe_check_state()"). I didn't analyze it enough,
> >> but it looks that something is missing there if we are trying to probe
> >> amba device. I assume that returning -EPROBE_DEFER unconditionally there
> >> is also not a valid solution?
> > Yeah, the unconditionally returning -EPROBE_DEFER wouldn't work
> > because if the supplier is optional but not present, the consumer
> > driver would never stop waiting for it. I'm looking into issues
> > similar to the one you saw in other threads [1]. The problem always
> > boils down to the supplier device's DT node not having "compatible"
> > property and therefore fw_devlink creating the device link between the
> > consumer and the supplier's parent.
> >
> > Basically if the drivers/DT are implemented "properly", you would
> > never get to the failure case (-2) if the driver is actually present.
> Well, I don't get what do you mean by not having the proper 'comaptible'
> property. Both affected devices (amba's pl330 and its power domain) have
> compatible strings: 'arm,pl330' and 'samsung,exynos4210-pd', but the
> devlinks doesn't help. Is it related to the custom device addition code
> in the amba bus?

Thanks for pointing this out Marek. This is an interaction between the
two separate series I sent out.

TL;DR is that device links don't block bus->match() attempts. That's
the reason. That's a separate optimization that's in my todo list for
a while.

Longer explanation follows:

5a46079a9645 ("PM: domains: Delete usage of
driver_deferred_probe_check_state()") correctly assumed fw_devlink
will block calls to __genpd_dev_pm_attach() before the power domain
has probed or we have given up waiting on suppliers at the driver core
level. So, __genpd_dev_pm_attach() returning -2 was not a problem
(well, there are other issues, but we'll pretend they don't exist for
now).

Until this amba patch, that was true because really_probe() calls
device_links_check_suppliers() before you'll get anywhere near
__genpd_dev_pm_attach().

But with this amba patch, we try to get power domains before we get to
really_probe() and that doesn't get the device links check. So,
amba_match() has to always return -EPROBE_DEFER on any error until we
optimize out match() calls for devices whose suppliers aren't ready
yet. I'm considering reverting 5a46079a9645 due to other issues, so I
think v4 might be okay as is.

-Saravana

> > I have some other ideas on how to get these to work better (not sure
> > if it'll be for 100% of the cases), but until I get those ideas sorted
> > out, I might do a partial revert of the change you mentioned.
> >
> > [1] - https://lore.kernel.org/lkml/4799738.LvFx2qVVIh@steina-w/
>
>  > ...
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

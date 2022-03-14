Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD204D901C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiCNXMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240197AbiCNXMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:12:33 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3113BF8E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:11:22 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso22391034ooi.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dQXfimkP4BsCwXbHKGXhzQW8vpmDXLnmerCage311w=;
        b=WMgI06Ow6zyd9V79cRy/SZ9A291N7G1QMxJNGzSuShxN9qSRCFrIMEJOeEo6LyBiIl
         h8ibm0Z1NHOEIthsOAO/HwthohHGtpmIDTskcP0wNYugB4iDajnz9kJqHZKT0CBzjHfM
         qUpH1BShso249Wup6oL+Ahtvmzz3L/27QE0eI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dQXfimkP4BsCwXbHKGXhzQW8vpmDXLnmerCage311w=;
        b=a4P4FebcouVkOjvcgvjZcqvuHRATpKH7IQPoUO+Y9d+mBlzg5/p/WsMgvk0BSPZ79k
         l+3hP1XcLHhbRkGyNo7F4KTER3ftmVDNnVUbcnLE1ueAxV08tNLOBhyfBPPzl40jjCL6
         DnSbOZ1srXlbFBuB7+Fa/ySIDStUkfEgHNdsMufReIz7pXZ939i0ig2Q0v7naIIjfDsG
         5yvlyGzQv4Qc+0AEQlfvggRzfwbcpyh5457Tqoh3cwtjueae6pdvNnnfIEyfZfuW18uM
         YK+nuU+M4sYjueDBt3P8RrAISj6/wWqHiix9K9qtheUZ/6VZW2QU0OBpKBiL8ITwfRbM
         L1Aw==
X-Gm-Message-State: AOAM532k/DqW3vHWbI5gUCdkHR+nBv+r4YFW5rKmU0JFl4D4gxaDeWcI
        e56uA53RLlcJ7I37Q+YlRYANGZYwDqi51Q==
X-Google-Smtp-Source: ABdhPJwe41xIqfORcdNzRdwzCgN27VhM65wH3P+NYD9c7fJ9IRZCMW/RgGuMfnENXZZydavMiGErEw==
X-Received: by 2002:a05:6870:589b:b0:da:b3f:2b68 with SMTP id be27-20020a056870589b00b000da0b3f2b68mr508254oab.263.1647299481419;
        Mon, 14 Mar 2022 16:11:21 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id c14-20020a056870b28e00b000d7d5962242sm7158446oao.35.2022.03.14.16.11.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 16:11:20 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id o64so19112830oib.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:11:20 -0700 (PDT)
X-Received: by 2002:aca:5e84:0:b0:2ec:9c1d:fc77 with SMTP id
 s126-20020aca5e84000000b002ec9c1dfc77mr606868oib.291.1647299479875; Mon, 14
 Mar 2022 16:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <50d4b87c-003f-818a-c8ba-a3bac9c0f171@intel.com>
In-Reply-To: <50d4b87c-003f-818a-c8ba-a3bac9c0f171@intel.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 14 Mar 2022 16:11:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO8-wmEDPxUrO6j9wBvCMzTZMpTyH7adSga8dYLNq5ehg@mail.gmail.com>
Message-ID: <CA+ASDXO8-wmEDPxUrO6j9wBvCMzTZMpTyH7adSga8dYLNq5ehg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Set HS clock speed before sending HS CMD13
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 6:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 10.3.2022 22.56, Brian Norris wrote:
> > Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> > hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> > some eMMC don't respond to SEND_STATUS commands very reliably if they're
> > still running at a low initial frequency. As mentioned in that commit,
> > JESD84-B51 P49 suggests a sequence in which the host:
> > 1. sets HS_TIMING
> > 2. bumps the clock ("<= 52 MHz")
> > 3. sends further commands
> >
> > It doesn't exactly require that we don't use a lower-than-52MHz
> > frequency, but in practice, these eMMC don't like it.
> >
> > Anyway, the aforementioned commit got that right for HS400ES, but the
> > refactoring in 53e60650f74e ("mmc: core: Allow CMD13 polling when
> > switching to HS mode for mmc") messed that back up again, by reordering
> > step 2 after step 3.
>
> That description might not be accurate.

I've been struggling to track where things were working, where things
were broken, and what/why Shawn's original fix was, precisely. So you
may be correct in many ways :) Thanks for looking.

> It looks like 4f25580fb84d did not have the intended effect because
> CMD13 was already being sent by mmc_select_hs(), still before increasing
> the frequency.  53e60650f74e just kept that behaviour.

You may be partially right, or fully right. But anyway, I think I have
some additional explanation, now that you've pointed that out: that
behavior changed a bit in this commit:

08573eaf1a70 mmc: mmc: do not use CMD13 to get status after speed mode switch

While that patch was merged in July 2016 and Shawn submitted his v1
fix in September, there's a very good chance that a lot of his work
was actually done via backports, and even if not, he may not have been
testing precisely the latest -next kernel when submitting. So his fix
may have worked out for _some_ near-upstream kernel he was testing in
2016, you may be correct that it didn't really work in the state it
was committed to git history.

This may also further explain why my attempts at bisection were rather
fruitless (notwithstanding the difficulties in getting RK3399 running
on that old of a kernel).

Anyway, I'll see if I can improve the messaging if/when a v2 comes around.

> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
...
> > @@ -1487,6 +1492,12 @@ static int mmc_select_hs200(struct mmc_card *card)
> >               old_timing = host->ios.timing;
> >               mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> >
> > +             /*
> > +              * Bump to HS frequency. Some cards don't handle SEND_STATUS
> > +              * reliably at the initial frequency.
> > +              */
> > +             mmc_set_clock(host, card->ext_csd.hs_max_dtr);
>
> Is card->ext_csd.hs_max_dtr better than card->ext_csd.hs200_max_dtr here?

I believe either worked in practice. I ended up choosing hs_max_dtr
because it's lower and presumably safer. But frankly, I don't know
what the Right thing to do is here, since the spec just talks about
"<=", and yet f_init (which is also "<=") does not work. I think it
might be like Ulf was guessing way back in the first place [1], and
the key is that there is *some* increase (i.e., not using f_init).

So assuming either works, would you prefer hs200_max_dtr here, since
that does seem like the appropriate final rate?

Brian

[1] https://lore.kernel.org/all/CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com/
Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
selecting hs400es

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258E44ECE22
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348792AbiC3Ua6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350969AbiC3Uaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:30:55 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825F130F4D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:29:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j83so23249875oih.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBcFsPpBOyUxMEU9H+5eyn/s7lGgdO0ytASVcAnuyUk=;
        b=oOXcqfjkyuYdgdmxLI/iIxMEP8saEapZ2EYdYfJYsjZCN64M7/VMNSmTtFhfde3FOy
         KaaTOpOJ1d0bjO4QHmroHNjF/YgNAEIrpOQUAyqS0CHH/XdOxh3pHc4g+t/VQPkk2aIl
         QPlyy7qQngXPjAZ4eEOHksfLmIg++gKf1+M8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBcFsPpBOyUxMEU9H+5eyn/s7lGgdO0ytASVcAnuyUk=;
        b=S/DXIXyafEJu1/2n7g9UeTuPdS89u0Tx1y8SOhr9kHqTUmJ/6i9wq+kOsNrXXW14vk
         hCWX/x55ooPwEwwy19yZLYmbLoltNZhuRbQlH/ZM+VNL4XEgybb/00kGcdlA2i6UpE0q
         xl7wDV018M7FIcI9beExQgKHVoLOfXNj2p/kgXj9TFBReD7qpmdxjPGdKfICANpKD9KE
         RkvkBGndBJ0/h/2RFzKTpT+mWE13sueNMWedRhkMssc0Q+YryJNJa6wyHx3aEnbuLpgo
         r0StC0SqOAf+CDeM6ynODDjAkQMawSWzq5jcnMWETe/6eWfyO4FiaBhJSKJbKxDSRLD5
         BhwQ==
X-Gm-Message-State: AOAM531I10Y243RK1lz/OZcJTsq9eOVHAMcFZG8PiYBbHaRbk5968b4X
        myx3eRSjRVdm/CHGStRo+6bKCoQyseaMmA==
X-Google-Smtp-Source: ABdhPJw2HF/N0IRTsmPwecxO9Jyw/UPIoCopRxXA1W6ukKISuPfPbLiQJ8R5j3BgrCO9jCep15lu4Q==
X-Received: by 2002:a05:6808:1491:b0:2da:7f75:8dec with SMTP id e17-20020a056808149100b002da7f758decmr885125oiw.275.1648672149631;
        Wed, 30 Mar 2022 13:29:09 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id y7-20020a4a6247000000b00324e9bf46adsm6367958oog.41.2022.03.30.13.29.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 13:29:07 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id e4so23243645oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:29:07 -0700 (PDT)
X-Received: by 2002:aca:5e84:0:b0:2ec:9c1d:fc77 with SMTP id
 s126-20020aca5e84000000b002ec9c1dfc77mr886786oib.291.1648672146590; Wed, 30
 Mar 2022 13:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220318185139.v2.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <CAPDyKFqCcSkHx92XcDkGH19JZyGgkALuf9wGNiBjKkFt4SaDTQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqCcSkHx92XcDkGH19JZyGgkALuf9wGNiBjKkFt4SaDTQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 30 Mar 2022 13:28:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM_RdU3qucLSZ421rw3uzDdf0-_459os-Ox_JFM8kn1bQ@mail.gmail.com>
Message-ID: <CA+ASDXM_RdU3qucLSZ421rw3uzDdf0-_459os-Ox_JFM8kn1bQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Set HS clock speed before sending HS CMD13
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 5:13 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Sat, 19 Mar 2022 at 02:52, Brian Norris <briannorris@chromium.org> wrote:
> > @@ -1482,6 +1487,12 @@ static int mmc_select_hs200(struct mmc_card *card)
> >                 old_timing = host->ios.timing;
> >                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> >
> > +               /*
> > +                * Bump to HS200 frequency. Some cards don't handle SEND_STATUS
> > +                * reliably at the initial frequency.
> > +                */
> > +               mmc_set_clock(host, card->ext_csd.hs200_max_dtr);
> > +
>
> If the mmc_switch_status() fails with -EBADMSG, we should probably
> restore the clock to its previous value. Otherwise I think we could
> potentially break the fallback implemented in 3b6c472822f8 ("mmc:
> core: Improve fallback to speed modes if eMMC HS200 fails")

OK, done for v3.

> Moreover, this change means that we will be calling
> mmc_set_bus_speed() from mmc_select_timing(), to actually set the same
> HS200 clock rate again. That is unnecessary, can we please avoid that
> in some way.

There's not a super clean way to track which paths pre-bumped the
frequency, especially once you account for host->f_max (as
mmc_set_clock() does). I've chosen to teach mmc_set_clock() how to
return early if the clock change is redundant.

Brian

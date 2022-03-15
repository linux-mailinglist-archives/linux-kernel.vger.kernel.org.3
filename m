Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2A4D9B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348211AbiCOM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348271AbiCOM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:29:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEABFEA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:27:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s29so11291341lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AsA+Yh6Q1RmMXptMpCMPYPdPP7vKeigdTvuyokvMeVc=;
        b=Em9Qk7CXYoY7kJ/x5MIbAzFv/MQ57GerniOmbIZANfrMlNCKWIregHTG8SP4ZgX7IG
         uJZ99qnwkg0DMqtfbn0Sj/l54mHyq7so0cllYsVxIXuo/SrV4EMEsPqMM+kI1TnbGrv8
         Si8P04B8WhgV8lHflb39DGw9dML5avysP83Ooata737y5di7fB5rz7l6mL3RKTDMxp3I
         kpqtPotVV3spCSm2WtP9oOsp3adhFKSfWApKc9oYLuo09cKLXkUt1tAZ1SpSxN6Csjo/
         CC4vpWL6pUQ/Pt0rAsZgEnBXb4oiwRNcJRj9tHjZ9XNmOxx5slEokIG32v45dIRcNJnu
         PIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AsA+Yh6Q1RmMXptMpCMPYPdPP7vKeigdTvuyokvMeVc=;
        b=W1HM58naz5RpeoaxV6VEbLuVMPTrT8L65SR+3n4Wr3rmqDFd5hQ1zDJLSO/PeE7oo/
         HHJticOMgDj32Vn0lqNnwyyAvFRYszbO4i0rSS69wX7jQNOPLyIDotzXcBywZmHc1TNC
         Olt/ltr6juLVRYM2iHr9j+aqNcNBdWmX7ARd6BO5gq4pik9Fsltmm96WmZ7O/NMsrJqc
         hwdBOWwvJtprqd7v120uhx6PHUSmIDy3fe1HHBtgdyJ0cznQ3gocGPPVVvOiY6924k9V
         p7TWRUZrx82jrFzpjwKcmGhU7t2XgCKQ3OqLfTWOHz7gtJDUG0aTA4lNCL6QwrE5YbLT
         HlJA==
X-Gm-Message-State: AOAM532DPIH6Ysuvccq5C4Mn1CzHp8VI9aRFhdb1F7AjsOYmyvqE1hsF
        1lc5LSPbR3/wBsblLFoof/nEmzlhGs2wJmj5/mUdJQ==
X-Google-Smtp-Source: ABdhPJwxVWuJkU2Vdp6g6fEM88LdXyiqS980jZq2aSertEju4rKA5wTfDZX/Ssb/jhYjtQ2num4y7Pzb1S633PkhjTk=
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id
 z14-20020a056512308e00b0044838266d68mr15642859lfd.184.1647347266932; Tue, 15
 Mar 2022 05:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220310125636.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <50d4b87c-003f-818a-c8ba-a3bac9c0f171@intel.com> <CA+ASDXO8-wmEDPxUrO6j9wBvCMzTZMpTyH7adSga8dYLNq5ehg@mail.gmail.com>
In-Reply-To: <CA+ASDXO8-wmEDPxUrO6j9wBvCMzTZMpTyH7adSga8dYLNq5ehg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:27:10 +0100
Message-ID: <CAPDyKFoQfr3W45vWY4SnTeBG7=z3J749=WBGNtEgujvXAqAn0Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Set HS clock speed before sending HS CMD13
To:     Brian Norris <briannorris@chromium.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
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

+ Heiner

On Tue, 15 Mar 2022 at 00:11, Brian Norris <briannorris@chromium.org> wrote:
>
> On Mon, Mar 14, 2022 at 6:13 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 10.3.2022 22.56, Brian Norris wrote:
> > > Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> > > hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> > > some eMMC don't respond to SEND_STATUS commands very reliably if they're
> > > still running at a low initial frequency. As mentioned in that commit,
> > > JESD84-B51 P49 suggests a sequence in which the host:
> > > 1. sets HS_TIMING
> > > 2. bumps the clock ("<= 52 MHz")
> > > 3. sends further commands
> > >
> > > It doesn't exactly require that we don't use a lower-than-52MHz
> > > frequency, but in practice, these eMMC don't like it.
> > >
> > > Anyway, the aforementioned commit got that right for HS400ES, but the
> > > refactoring in 53e60650f74e ("mmc: core: Allow CMD13 polling when
> > > switching to HS mode for mmc") messed that back up again, by reordering
> > > step 2 after step 3.
> >
> > That description might not be accurate.
>
> I've been struggling to track where things were working, where things
> were broken, and what/why Shawn's original fix was, precisely. So you
> may be correct in many ways :) Thanks for looking.
>
> > It looks like 4f25580fb84d did not have the intended effect because
> > CMD13 was already being sent by mmc_select_hs(), still before increasing
> > the frequency.  53e60650f74e just kept that behaviour.
>
> You may be partially right, or fully right. But anyway, I think I have
> some additional explanation, now that you've pointed that out: that
> behavior changed a bit in this commit:
>
> 08573eaf1a70 mmc: mmc: do not use CMD13 to get status after speed mode switch
>
> While that patch was merged in July 2016 and Shawn submitted his v1
> fix in September, there's a very good chance that a lot of his work
> was actually done via backports, and even if not, he may not have been
> testing precisely the latest -next kernel when submitting. So his fix
> may have worked out for _some_ near-upstream kernel he was testing in
> 2016, you may be correct that it didn't really work in the state it
> was committed to git history.
>
> This may also further explain why my attempts at bisection were rather
> fruitless (notwithstanding the difficulties in getting RK3399 running
> on that old of a kernel).
>
> Anyway, I'll see if I can improve the messaging if/when a v2 comes around.
>
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> ...
> > > @@ -1487,6 +1492,12 @@ static int mmc_select_hs200(struct mmc_card *card)
> > >               old_timing = host->ios.timing;
> > >               mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> > >
> > > +             /*
> > > +              * Bump to HS frequency. Some cards don't handle SEND_STATUS
> > > +              * reliably at the initial frequency.
> > > +              */
> > > +             mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> >
> > Is card->ext_csd.hs_max_dtr better than card->ext_csd.hs200_max_dtr here?
>
> I believe either worked in practice. I ended up choosing hs_max_dtr
> because it's lower and presumably safer. But frankly, I don't know
> what the Right thing to do is here, since the spec just talks about
> "<=", and yet f_init (which is also "<=") does not work. I think it
> might be like Ulf was guessing way back in the first place [1], and
> the key is that there is *some* increase (i.e., not using f_init).
>
> So assuming either works, would you prefer hs200_max_dtr here, since
> that does seem like the appropriate final rate?

I think that makes most sense, as we are switching to that rate anyway
just a few cycles later in mmc_select_timing(), when it calls
mmc_set_bus_speed().

That said, I have recently queued a patch that improves the
speed-mode-selection-fallback, when switching to HS200 mode fails [2].
We need to make sure this part still works as expected. I have looped
in Heiner who has been in the loop around this change, hopefully he
can help with further testing or so. Maybe $subject patch (or a new
version of it) can even make HS200 to work on Heiner's platform!?

>
> Brian
>
> [1] https://lore.kernel.org/all/CAPDyKFrNp=Y3BhVE_kxtggv7Qc6m=2kef2U8Dn2Bb3ANHPYV-Q@mail.gmail.com/
> Re: [PATCH 3/5] mmc: core: changes frequency to hs_max_dtr when
> selecting hs400es

Kind regards
Uffe

[2]
https://patchwork.kernel.org/project/linux-mmc/patch/20220303164522.129583-1-ulf.hansson@linaro.org/

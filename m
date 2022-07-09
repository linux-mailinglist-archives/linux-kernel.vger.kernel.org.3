Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E628A56C5DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 03:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGIBz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 21:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGIBzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 21:55:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8D65F4;
        Fri,  8 Jul 2022 18:55:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so372676pgb.4;
        Fri, 08 Jul 2022 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ljb+p5S2T+3uZn69+85MUtWtB8Rjy0F+vPmvHJQxGgU=;
        b=dn16MJ44eifmsFxbi5wZMZ/TpYfEyt6Jjm1OSOZNQu3iGBwFZSA2r1SjuMPEvOAkIu
         tJijO8m/P5qXyNPPY+fDYq8Z/lIJOBU2A36hzmxo+lzgR4KEGcOpvRFSee+Mgwi073CN
         Ff4JlPoYvgXFTBTSOJikdS+ti/ZR6PwXgns3F91IU0/5ep4BkXqxUefMcrE7MUUhLLuy
         36abM8WSHiTW8G5iyzoPY4I1JNgJf4GfPPv12CK2TLcjOWtf9FTeY7ElFroBK4MkbPu2
         lCh2PvhgEZrpnNaYkxnqtdaQiN/4fTAnMQrChGDREnm+30METqAw8FOBhAfmndmouzsc
         J4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ljb+p5S2T+3uZn69+85MUtWtB8Rjy0F+vPmvHJQxGgU=;
        b=AVmROw+DWpfqpHZYj+5mxKrRNwEv8qFAJY4ZPMsB1VLsGvAANAv+bypORITXhj8Ro7
         cpvlcG1907a56C8m3nG/o2CN97Ps1ZOax4gy/84Kjgo3b8GOig3K0vIgmljqhlLhd1i0
         wmbJqdnU9lJ7jum150rEnZZfNLb3Tiqmr/bWmv25JFkt7D514iRNfto6FQQU7xPOq+vU
         z+Yejy/Soe8g2c4+Jz19eWtfiaIs7sEuJz1PM1JIKp93mYsgUOTd+v/2/IOVkTbIIhBZ
         pBxPN/pu/XBQsvZYteTx7TyenzTVgxy2iv35YASITdxLe3i1hokNE3V2wMa5y8hzR/Ek
         UV3Q==
X-Gm-Message-State: AJIora8J13ywvB54EDtU+QdrCpiySXDty96453+oZofTnGkezU0eqYtD
        Uxx6K4C7Hp5t0fDlDsaYen404SsxTVA=
X-Google-Smtp-Source: AGRyM1tPrLA6pi2G0vra5t28Ap2wxm2DIenhdzuAiXdpQT16pc9cMR9SjWWOM4IGnn09Rq6LuXwFoA==
X-Received: by 2002:a63:2cc6:0:b0:411:4fd6:49cb with SMTP id s189-20020a632cc6000000b004114fd649cbmr5667155pgs.365.1657331746403;
        Fri, 08 Jul 2022 18:55:46 -0700 (PDT)
Received: from sol (110-174-58-111.static.tpgi.com.au. [110.174.58.111])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b00163f8eb7eb3sm176618plb.196.2022.07.08.18.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 18:55:45 -0700 (PDT)
Date:   Sat, 9 Jul 2022 09:55:41 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix null pointer dereference in
 linereq_free()
Message-ID: <20220709015541.GA5332@sol>
References: <20220706084507.2259415-1-warthog618@gmail.com>
 <20220706085025.GA2259579@sol>
 <20220707090006.GB57165@sol>
 <CAMRc=Mcqvp4oN_tHXS1cb0AnEOU=Znd4bmSwO4ZZ1GszRfXhSA@mail.gmail.com>
 <20220707102918.GA60169@sol>
 <424af43a-bcaf-4f59-086d-b1afea425054@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424af43a-bcaf-4f59-086d-b1afea425054@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 11:24:43AM -0700, Dipen Patel wrote:
> On 7/7/22 3:29 AM, Kent Gibson wrote:
> > On Thu, Jul 07, 2022 at 12:19:15PM +0200, Bartosz Golaszewski wrote:
> >> On Thu, Jul 7, 2022 at 11:00 AM Kent Gibson <warthog618@gmail.com> wrote:
> >>> On Wed, Jul 06, 2022 at 04:50:25PM +0800, Kent Gibson wrote:
> >>>> On Wed, Jul 06, 2022 at 04:45:07PM +0800, Kent Gibson wrote:
> >>>>> This patch fixes a kernel NULL pointer dereference that is reported by
> >>>>> gpio kselftests.
> >>>>>
> >>>> Should be:
> >>>>
> >>>> Fix a kernel NULL pointer dereference reported by gpio kselftests.
> >>>>
> >>>> Sorry - I rushed this one a bit.
> >>>>
> >>> And I might not've been totally clear, but this bug is present in
> >>> v5.19-rc1 onwards (when HTE was added), up to and including rc5.
> >>>
> >>> Would be good to get it fixed before v5.19 goes out the door.
> >>>
> >>> Cheers,
> >>> Kent.
> >> Yep, figured that out. Applied and fixed the commit message, thanks!
> >>
> > Good to hear.  I never got around to reviewing that final HTE patch
> > and, while it did end up pretty close to what I expected, there are a
> > few things that I would've done slightly differently that I'd like to
> > tidy up.
> I can create another thread to address this. Let me know.

I've already got the changes locally, so don't worry. There is nothing
critical or earth shattering in there, mainly how the hte_en flag is
passed around.  You followed the pattern provided by polarity_change,
which is only used on one occasion, when I would've followed the pattern
from line->eflags, which is used more widely.

Though I might take the changes a little further than I have to also
change the polarity_change flag to follow the eflags pattern to prevent
anyone following from falling into the same trap - still stewing on that.

The basic idea is that, particularly during reconfig, the struct line
contains the current applied state, while the desc->flags contain the
requested state.  The polarity_change flag was a bit of a lazy shortcut
to save from adding an active_low (or equivalent) flag to struct line.

> > And also have the HTE specific code compiled out unless CONFIG_HTE is
> > selected, as that is very likely to be the case for most builds.
> > But that can wait for v5.20.
> 
> I am assuming #ifdef CONFIG_HTE blocks around HTE blocks. I think Linus W. also
> 
> indicated that.
> 

Correct.

Cheers,
Kent.

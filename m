Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D91C4B2568
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349905AbiBKMOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:14:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349888AbiBKMN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:13:58 -0500
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F19DA8;
        Fri, 11 Feb 2022 04:13:57 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id w6so9576960vsf.3;
        Fri, 11 Feb 2022 04:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulYLaVXldSoI4tDDRxPqxlHj4drX158bChWih8XppYk=;
        b=H7jTd4dGwOHJeB8IFqS+Z19tuXaok6mNx3fXVmuXQxTyxr/mGePHyncLyvmTcPcz86
         6dYInzawnH0ZosYxamOME6xLQM7kBLfF87xueADBh+t/hvZHLnbEoQYjUJk21Ui+nS+A
         qyN5iwhc8K3orQlbHKxopHWCxs1xTm3WG2BRHU52K0JIHqR5HtMq0nt4SbXawDw/VrPQ
         aeSu1qAyH4WwBM+yYKzqjop8V0ChWV9KhvqtsAnjXceHkCzg7S3bBddtbQcgu03cjbh1
         v6o7eVHh2LNdTRvHBct0E4ZHwRUhNb8aObEqBs+qhGzgDpuRB9YR+MEtpjFCtkaljaqB
         28pQ==
X-Gm-Message-State: AOAM533JYshnlnUk0qiXikAnF4xrn9ZAlaJz31GP0PdAAQYAPA7R2AdZ
        OPycLulzO/Z1z+2q5h609IKEm2n6EnD1SQ==
X-Google-Smtp-Source: ABdhPJxsf3l7v/aOhtds1muYkZEaJkvsq2pGOeHnHeyHuFoS0A/hW+zuhlsxC5W+w81SYw+CmFHJXg==
X-Received: by 2002:a05:6102:a39:: with SMTP id 25mr372146vsb.84.1644581636726;
        Fri, 11 Feb 2022 04:13:56 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id k204sm4798871vkk.0.2022.02.11.04.13.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 04:13:55 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id j26so8546789vso.12;
        Fri, 11 Feb 2022 04:13:54 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr377312vst.68.1644581634672;
 Fri, 11 Feb 2022 04:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20220129184225.407100-1-laurent@vivier.eu> <20220129184225.407100-2-laurent@vivier.eu>
 <CAMuHMdVmCV4v=LhGRB3d3hbyL4Etv_Wbb2VPhK5G9a2xB1Pm2A@mail.gmail.com> <0b488b58-3d13-e987-37c7-16bac7a313e0@physik.fu-berlin.de>
In-Reply-To: <0b488b58-3d13-e987-37c7-16bac7a313e0@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 11 Feb 2022 13:13:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX53by9-5L5UWnjtpsUOX7LJMG+ySbFqO+QtsSST_iXKA@mail.gmail.com>
Message-ID: <CAMuHMdX53by9-5L5UWnjtpsUOX7LJMG+ySbFqO+QtsSST_iXKA@mail.gmail.com>
Subject: Re: [PATCH v13 1/5] m68k: add asm/config.h
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-rtc@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Fri, Feb 11, 2022 at 9:36 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 1/29/22 20:05, Geert Uytterhoeven wrote:
> > On Sat, Jan 29, 2022 at 7:42 PM Laurent Vivier <laurent@vivier.eu> wrote:
> >> To avoid 'warning: no previous prototype for' error, declare all
> >> the parse_bootinfo and config functions prototypes into asm/config.h
> >> and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c
> >>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > I have already queued v12.
>
> I assume you're talking about this particular patch only and not the whole
> series, correct?

Exactly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

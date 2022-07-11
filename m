Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA6057049F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGKNri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiGKNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:47:36 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2452E57
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:47:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l23so8908806ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjwJ2lXT0i+HUz5O+JVv9nTb4O1sy57SFFPwASu6wgc=;
        b=Eedf74tXPQaZVVxLSk0EQ3VllXkjFE9SWr72ktJrdcVUbqy6T0l3fE6qbwf9wvqSHQ
         gUTCkL5Bmh6wzRR/+3N8twr8x6+OOgPG3qENPbelO8gKJDGlT792ykdOAdsLUNobbaiv
         ggC+DAwcCSibGE5VWiUeiiHXNvZ1V1fL8nhQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjwJ2lXT0i+HUz5O+JVv9nTb4O1sy57SFFPwASu6wgc=;
        b=pIGALkG5ZZJ02MKKu8JJ10wb8YFcIxcxWdGQ4dMO/kKXgcldLzzapnA9R7ZVSiO0po
         uZjfuKT3gD7uVHb6bZ634WcsJStSuyPKNPXfZr2+FFkjh3CLD6i2MboiQ+7gYZbbXJ6C
         yc5UIwi28ASWHyU2w/cfts6D3aWTnoDfx4o8+/sgFYtpT/poZXf4fkdUXz95aZbC+m+x
         VZfDDyF0p3b3rP7ZM1FBYKO+7CPY4MO/G565+aoZeCgwBpdjlGFUOfKsb4MbBPoI55KN
         FhIXcdMGvExnhx77kcg5QVrgeCt+jLSpcok+A5RluYQCE10o4b4wj+Zb/+6GF5fmydPs
         y/cg==
X-Gm-Message-State: AJIora/ri7xjQYKbW3I1JyMNckbV5ZB8BBFPqBM1fl4UrswzVsS11ZCU
        gj4lpzcM7J2yvRQ6GH7fp42r/Eg975R1VQ==
X-Google-Smtp-Source: AGRyM1uF9nnTLdiI88Jm6suK/3/gBlwc++HFuSCvdVr7qInEeI+SQyAvx/DY0KnY3Z2SF8OxEnPwCQ==
X-Received: by 2002:a17:907:6818:b0:72b:5bac:c3a3 with SMTP id qz24-20020a170907681800b0072b5bacc3a3mr3537900ejc.139.1657547253429;
        Mon, 11 Jul 2022 06:47:33 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id p13-20020aa7d30d000000b0043575ae2051sm4298898edq.62.2022.07.11.06.47.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 06:47:32 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so5063740wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:47:32 -0700 (PDT)
X-Received: by 2002:a05:600c:511c:b0:3a2:d480:9390 with SMTP id
 o28-20020a05600c511c00b003a2d4809390mr15693873wms.93.1657547252097; Mon, 11
 Jul 2022 06:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220511060521.465744-1-sumit.garg@linaro.org>
 <CAD=FV=WXoDvWuH=yjzCcqOZ5CeUtYun7C8zrtrBP4FC409GkqA@mail.gmail.com> <CAFA6WYPmFqCXk24J71tNO=5bJHgJRAOPFr7cGq8YYLR+MWBoPw@mail.gmail.com>
In-Reply-To: <CAFA6WYPmFqCXk24J71tNO=5bJHgJRAOPFr7cGq8YYLR+MWBoPw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 06:47:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdMsqrsWzX=0RU5HJ1a0cy-pm4BwP47siLj=+eeEXUQA@mail.gmail.com>
Message-ID: <CAD=FV=WdMsqrsWzX=0RU5HJ1a0cy-pm4BwP47siLj=+eeEXUQA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>, Wei Li <liwei391@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 5:44 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> > I'll also note that I _think_ I remember that with Wei's series that
> > the gdb function "call" started working. I tried that here and it
> > didn't seem so happy. To keep things simple, I created a dummy
> > function in my kernel that looked like:
> >
> > void doug_test(void)
> > {
> >   pr_info("testing, 1 2 3\n");
> > }
> >
> > I broke into the debugger by echoing "g" to /proc/sysrq-trigger and
> > then tried "call doug_test()". I guess my printout actually printed
> > but it wasn't so happy after that. Seems like it somehow ended up
> > returning to a bogus address after the call which then caused a crash.
> >
>
> I am able to reproduce this issue on my setup as well. But it doesn't
> seem to be a regression caused by this patch-set over Wei's series. As
> I could reproduce this issue with v1 [1] patch-set as well which was
> just a forward port of pending patches from Wei's series to the latest
> upstream.
>
> Maybe it's a different regression caused by other changes? BTW, do you
> remember the kernel version you tested with Wei's series applied?

Sorry, I don't remember! :( I can't even be 100% sure that I'm
remembering correctly that I tested it back in the day, so it's
possible that it simply never worked...

-Doug

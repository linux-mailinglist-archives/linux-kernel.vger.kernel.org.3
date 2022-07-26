Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD970580EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbiGZIMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZIMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:12:41 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632762DA8D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:12:40 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31f445bd486so15595657b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 01:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCX2ALCWALFGybcMGwSCyXmdfN3GI/+m4dDqSmPpw10=;
        b=s0G272QfIh9/l63hjHAAeg/H9EPmVwACwS37tb+LwxjryHa4mlQWqrwvINvSIIEoW/
         Z5YvAD93ZwX3PpzFcVYHu2JNnjVTJEbu9Utqrz3Y4iFYljnNLzmhkxMNWfU/cW+IHO08
         BtMqsqCC7Au9eyjhgIOU+Pk7NDXHMOQRmVzOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCX2ALCWALFGybcMGwSCyXmdfN3GI/+m4dDqSmPpw10=;
        b=6PLwfeyrXvC91OV8BSu5TUyt2bxvxSORqeIPK2ZJsFbQpLoUVqghXPLk40WhNrHAOC
         kLuTl0BMgxzzb1ggQaGioyhuqVjizu2N4JhwGgJq3p0WklW+/iXs/z5lbeV+/KGBRvP5
         4LMQV1uJf4VZRpz/oSUeZijU8tTjKheWDIIAVVTw303Gp43gdzruhJZMu2O80G4KF+rU
         hGKnoCH3fUgHaCd2hUhDMkV0qmQymD4694CgLQLB9xbglm+HpHzkeP4CsH5wC4onPaSH
         py4P1yuF9kN1zYwyH3cj3gEVFGvDjU/As/bolYwHwk60BbzeeqtQ1M5/QKMzYrqMNo3R
         AzmQ==
X-Gm-Message-State: AJIora9390FdiGdqMEKtuMS9m/deQCs7ix+IZpoiV7V5tTEAGuncF7Oo
        WrSN6aUmftnNa0ah8Kx7BSBBSLdwY7dkqiuBXTbh
X-Google-Smtp-Source: AGRyM1s8Apd3hvFA44J5aJBKOXCo+fbuaspIcsLZraEzhnuLtGz3y8ZMjuWlDz61tH0RApEnIjJf8dPeiNTkr3bt800=
X-Received: by 2002:a0d:ebc8:0:b0:31f:4f08:63aa with SMTP id
 u191-20020a0debc8000000b0031f4f0863aamr352109ywe.145.1658823159618; Tue, 26
 Jul 2022 01:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220715175155.3567243-1-mail@conchuod.ie> <96972ad8-d146-3bc2-0e49-ffe88580bbee@microchip.com>
 <20220725091346.GA20370@willie-the-truck> <28e38506-8fce-9000-c211-199a7aa69910@microchip.com>
In-Reply-To: <28e38506-8fce-9000-c211-199a7aa69910@microchip.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 26 Jul 2022 01:12:28 -0700
Message-ID: <CAOnJCUJh0vU8-tK31-A44h+VNHZA2_R6GayNjFg-7Daa6efbag@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Fix RISC-V's arch-topology reporting
To:     Conor Dooley <Conor.Dooley@microchip.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daire McNamara <Daire.McNamara@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Zong Li <zong.li@sifive.com>,
        Emil Renner Berhing <kernel@esmil.dk>,
        Jonas Hahnfeld <hahnjo@hahnjo.de>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Brice Goglin <Brice.Goglin@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 2:20 AM <Conor.Dooley@microchip.com> wrote:
>
> On 25/07/2022 10:13, Will Deacon wrote:
> > On Sat, Jul 23, 2022 at 11:22:01AM +0000, Conor.Dooley@microchip.com wrote:
> >> On 15/07/2022 18:51, Conor Dooley wrote:
> >>
> >> Hey,
> >>
> >> Not got any feedback on the smpboot changes from the RISC-V side.
> >> I tested it on polarfire, the d1 (with both SMP & !SMP set iirc)
> >> & on the u540. It all looked good to me.
> >>
> >> I'd like to have this fixed for v5.20, but there isn't too much
> >> time left before the mw. Not too sure about the cross-tree changes,
> >> does it need an immutable branch or could it go through driver-core?
> >> Catalin suggested removing the CC stable from patch 1/2 & adding it
> >> as a dependency for the 2/2 patch - but obviously that's up to the
> >> committer to sort out.
> >
> > I'm finalising the arm64 queue today, so I don't really want to pull in
> > additional changes beyond critical fixes at this point, I'm afraid. I was
> > half-expecting a pull request from the riscv side last week but I didn't
> > see anything.
>
> Yeah, that's fair. It's late in the game for cross-tree messing.
> I know Palmer has been p busy recently.
>
> > FWIW, if there's still no movement by -rc1, then I'm happy to queue all
> > of this on its own branch in the arm64 tree for 5.21.
>
> Hopefully someone on the riscv side will have confirmed what I am doing
> is sane by then.
>
> >
> > Let me know.
>
> I will, thanks!

Sorry for the delayed response here. I was planning to test the series
last week itself
but got dragged into something else and a qemu bug for NUMA.

Thanks for the fixes. I have tested this on Qemu(removing the topology
node) for the following configurations.
SMP, !SMP, NUMA (2 sockets)

FWIW,
Tested-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish

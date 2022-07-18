Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A4577DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiGRIjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGRIjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:39:36 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537E6BC3E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0440CE0ADA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DCCC341CA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658133572;
        bh=6868ghL+z9k6lE8Zhf9thtidSkGyAy7loJEZcnhZTxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p97gLbODcmBvh5cx7H8owMnLX98xsIx2FgXC4yXlnl19Hz7HI4E8JOY/1jydlLR6D
         MEMjmxDE3NdqXJdm0rb2PRkr+WRMgBcE2/rJlBhmd+4hxJHQHjo44Eu+AUF4FRV41P
         Dalu8ydIZruE/3I5aflT94cLsmYQZ/NjpQF3+tDQaNmrAs5IWWYnSd3Gmpog8otznn
         SJ0wlpK35/j2GNjApbNpx1E+F17fJJZu9UkIdzl0YR/xuf5KDe3EAoJDw58Lfdiy+m
         q7bUtbsLvcgOqyJjMWx7SPURcbFSoAS0Xqe1Ue9xaAUlzmzXt8Rr0IVNQ+/YBGXCXu
         N+ITPhKgp6gIA==
Received: by mail-vs1-f50.google.com with SMTP id t127so9752233vsb.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:39:32 -0700 (PDT)
X-Gm-Message-State: AJIora/VqBXK/r+iBjsGl7teDGSCA8jVlrumRXo4aPa6lozvKlQhSC2Z
        JkDJGlCz5VoXk+/A5B/B/hPYcK6ipGZ0u/LcgsA=
X-Google-Smtp-Source: AGRyM1vYLPKEzTkdiSMW1GoG0z6Et3OxAmvTioua6BelylBjw6xGvfHRIegg4/8Hd4BjWHhuVTSj/PKWlz4YBTaVEiY=
X-Received: by 2002:a05:6102:3f06:b0:356:f57f:4f59 with SMTP id
 k6-20020a0561023f0600b00356f57f4f59mr8650321vsv.70.1658133571179; Mon, 18 Jul
 2022 01:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <1657868751-30444-1-git-send-email-lvjianmin@loongson.cn>
 <87less52bx.wl-maz@kernel.org> <6e9def1e-31fe-787d-1b2b-a328424352f0@loongson.cn>
 <87ilnw3vlg.wl-maz@kernel.org> <20994a99-b5b1-442d-d23d-2a11ecef24a0@loongson.cn>
 <87wncbzteg.wl-maz@kernel.org> <058aed14-3644-5fc4-8eda-ec645df91836@loongson.cn>
 <87fsiy53h3.wl-maz@kernel.org> <6d534d7d-766c-d5d1-59ed-1ecdd96837be@loongson.cn>
In-Reply-To: <6d534d7d-766c-d5d1-59ed-1ecdd96837be@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 18 Jul 2022 16:39:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4yZYkZBvn0dwCWbdhVjP9wBZ+2yPUcRo8p3m6J_89otQ@mail.gmail.com>
Message-ID: <CAAhV-H4yZYkZBvn0dwCWbdhVjP9wBZ+2yPUcRo8p3m6J_89otQ@mail.gmail.com>
Subject: Re: [PATCH V15 00/15] irqchip: Add LoongArch-related irqchip drivers
To:     Jianmin Lv <lvjianmin@loongson.cn>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jianmin and Marc,

On Mon, Jul 18, 2022 at 4:29 PM Jianmin Lv <lvjianmin@loongson.cn> wrote:
>
>
>
> On 2022/7/18 =E4=B8=8B=E5=8D=882:39, Marc Zyngier wrote:
> > On Mon, 18 Jul 2022 02:07:21 +0100,
> > Jianmin Lv <lvjianmin@loongson.cn> wrote:
> >>
> >>
> >>
> >> On 2022/7/17 =E4=B8=8B=E5=8D=8810:49, Marc Zyngier wrote:
> >>> On Sun, 17 Jul 2022 12:29:05 +0100,
> >>> Jianmin Lv <lvjianmin@loongson.cn> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2022/7/17 =E4=B8=8B=E5=8D=886:02, Marc Zyngier wrote:
> >>>>> But the other issue is that you seem to call this function from two
> >>>>> different locations. This cannot be right, as there should be only =
one
> >>>>> probe order, and not multiple.
> >>>>>
> >>>>
> >>>> As we described two IRQ models(Legacy and Extended) in this cover
> >>>> letter, the parent domain of MSI domain can be htvec domain(Legacy) =
or
> >>>> eiointc domain(Extended). In MADT, only one APIC(HTPIC for htvec or
> >>>> EIOPIC for eiointc) is allowed to pass into kernel, and then in the
> >>>> irqchip driver, only one kind APIC of them can be parsed from MADT, =
so
> >>>> we have to support two probe order for them.
> >>>
> >>> Do you really have the two variants in the wild? Or is this just
> >>> because this is a possibility?
> >>>
> >>
> >> Currently, there are not CPUs(used for PC and server) based on
> >> LoongArch shipped with only HTPIC, but with both HTPIC and EIOPIC, we
> >> just want to provide two choices for designers(but obviously, EIOPIC
> >> may be enough currently). Do you think we don't have to do like this,
> >> yes? If so, maybe we don't have to support ACPI-way entry for htvec
> >> currently, and do the work in future if required.
> >
> > If the existing HW is only following the 'Extended' model, then I'd
> > suggest you only support this for now. It has two effects:
> >
> > - it simplifies the current code, making it more maintainable and
> >    easier to reason about
> >
> > - it sends the message to integrators that 'Extended' is the correct
> >    model, and that it is what they should support
> >
> > Now, we don't have much time left to get this series into -next (I
> > will be closing the tree to new features this week, and only queue
> > fixes).
> >
> > So whatever you need to do, please do it quickly so that we can have
> > at least some of this in 5.20.
> >
> > Thanks,
> >
> >       M.
> >
>
> Ok, Marc, thanks for your suggestion, got it, I'll remove 'Legacy' mode
> support and send next version as soon as possible.
I think keeping the "Legacy" mode is faster than removing it for now
to keep up with the merge window, since it is already here and doesn't
need to modify.

Huacai
>
>

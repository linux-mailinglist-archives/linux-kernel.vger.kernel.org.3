Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32257464475
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346076AbhLABZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhLABZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:25:18 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BEEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:21:58 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v64so58323708ybi.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S286PR0DOlhKjJpIypbhz5PFRsYUTAsr8Ii0YLKt+/8=;
        b=UuJWQaahTTK6KJGehNSnehKrgl4QgxwPTGSm2AeOkOWBq2igthUifPJNo7KL7t9VGp
         Qsz5W6jvXfhhOn1aVSn5wqWM/xEzfWuOkrVJID2Hik+MHSP9NgtgNveL6GDsRUUcUNRj
         9vQ/GN/8IPYpj10AzBIpZ/JjOFkbzU4CrSCu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S286PR0DOlhKjJpIypbhz5PFRsYUTAsr8Ii0YLKt+/8=;
        b=N94LyaNPpu5Cl83HKfBCoS7F2dSWhcCdoo4MN91EjlxFp4C/WV9X2uc6MxBi5Wucnk
         szH2sgq2hYX5jUsBhc2Hc8iRw1TqnlWQM/IJwhLXXWBAU6SRYyGsI+7Z6zC9zl2TaIyo
         r/Hhq65lx489m5btVotJ2VIuPD15iClEEFIct278A2Nm8EcBh+6qMgkuKCfK8Ic1SxLi
         ihRwXKVdMf5tjfpMT1smWYTHsyVGlJkVAlOYK4MRtahTBJEl6L1rhLXG0eSPRMHbuAeK
         UMCocbtlWCR4rBqe+YDacDVxCFnoZfPTKXhF/mO1C85oJcrFkqq+F7v6TXZ8uWu0LTxW
         7yuQ==
X-Gm-Message-State: AOAM532v7FtC4w6MCHAHltEAsF5T52vVABX9W5Wb68ej1L/pyQ5PruS0
        ALilk+PMd+8xl6swmKZAxB3u/DE5ToVyJ6YB421N
X-Google-Smtp-Source: ABdhPJw+00AP89gQplxYPhQDfHcmpRwigzGF+ndaHqbza4cDl274n4eYzpSs5hGU2eSVkLKT8NhCL5rUVD9L5lykoNI=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr3229673ybk.309.1638321717694;
 Tue, 30 Nov 2021 17:21:57 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <1909580.k68io2XIxi@diego>
 <D7F256F9-F31F-4663-AADD-A535E159F87C@jrtc27.com> <2728314.U2HhIfhhqV@diego>
 <C19C85E6-821B-4A87-B764-56CF4D53E7FA@jrtc27.com> <CAAeLtUC0Qc6ysf31sh0dkvfJD-JsREZbyFFk=Ko0vQeBRzyjaw@mail.gmail.com>
 <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com>
In-Reply-To: <03B8F784-4AF3-425D-99B6-F753F7970273@jrtc27.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 30 Nov 2021 17:21:46 -0800
Message-ID: <CAOnJCUKmP6dsrV9xWC52uEaM0=fZh-FNDYyFg1VxQybpQZABMA@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Philipp Tomsich <philipp.tomsich@vrull.eu>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Wei Fu <wefu@redhat.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Dan Lustig <dlustig@nvidia.com>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Rob Herring <robh+dt@kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        liush <liush@allwinnertech.com>, Wei Wu <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 8:13 AM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> On 30 Nov 2021, at 15:01, Philipp Tomsich <philipp.tomsich@vrull.eu> wrot=
e:
> >
> > We did touch on this in our coordination call a few weeks ago: the
> > grouping under mmu and the bool-entries were chosen because of their
> > similarity to other extensions (i.e. for Zb[abcs] there could/should
> > be a bool-entry under each cpu-node =E2=80=94 for some Zv* entries a su=
bnode
> > might be needed with further parameters).
> >
> > The string-based approach (as in the originally proposed "mmu-type=3D")
> > would like not scale with the proliferation of small & modular
> > extensions.
>
> I don=E2=80=99t see why the Sv* extensions need to be under an mmu node t=
hen,
> unless the intent is that every extension be grouped under a sub-node
> (which doesn=E2=80=99t seem viable due to extensions like Zbk*, unless yo=
u
> group by Ss, Sv and Z)?
>

It shouldn't be. All the ISA extensions (i.e. standard, supervisor & hyperv=
isor)
with prefix S,Z,H should be kept separate in a separate node for easy
parsing.

"riscv,isa" dt property will not scale at all. Just look at the few
extensions that were ratified this year
and Linux kernel needs to support them.

"Sscofpmf", "Svpbmt", "Zicbom"

> Also, what is going to happen to the current riscv,isa? Will that
> continue to exist and duplicate the info, or will kernels be required
> to reconstruct the string themselves if they want to display it to
> users?
>

This is my personal preference:
riscv,isa will continue to base Standard ISA extensions that have
single letter extensions.

This new DT node will encode all the non-single letter extensions.
I am not sure if it should include some provisions for custom
extensions starting with X because
that will be platform specific.

Again, this is just my personal preference. I will try to send a patch
soon so that we can initiate a broader
discussion of the scheme and agree/disagree on something.



> As a FreeBSD developer I=E2=80=99m obviously not a part of many of these
> discussions, but what the Linux community imposes as the device tree
> bindings has a real impact on us.
>
> Jess
>
> > On Tue, 30 Nov 2021 at 14:59, Jessica Clarke <jrtc27@jrtc27.com> wrote:
> >>
> >> On 30 Nov 2021, at 13:27, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> >>>
> >>> Hi,
> >>>
> >>> Am Dienstag, 30. November 2021, 14:17:41 CET schrieb Jessica Clarke:
> >>>> On 30 Nov 2021, at 12:07, Heiko St=C3=BCbner <heiko@sntech.de> wrote=
:
> >>>>>
> >>>>> Am Montag, 29. November 2021, 13:06:23 CET schrieb Heiko St=C3=BCbn=
er:
> >>>>>> Am Montag, 29. November 2021, 09:54:39 CET schrieb Heinrich Schuch=
ardt:
> >>>>>>> On 11/29/21 02:40, wefu@redhat.com wrote:
> >>>>>>>> From: Wei Fu <wefu@redhat.com>
> >>>>>>>>
> >>>>>>>> Previous patch has added svpbmt in arch/riscv and add "riscv,svp=
mbt"
> >>>>>>>> in the DT mmu node. Update dt-bindings related property here.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Wei Fu <wefu@redhat.com>
> >>>>>>>> Co-developed-by: Guo Ren <guoren@kernel.org>
> >>>>>>>> Signed-off-by: Guo Ren <guoren@kernel.org>
> >>>>>>>> Cc: Anup Patel <anup@brainfault.org>
> >>>>>>>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >>>>>>>> Cc: Rob Herring <robh+dt@kernel.org>
> >>>>>>>> ---
> >>>>>>>> Documentation/devicetree/bindings/riscv/cpus.yaml | 10 +++++++++=
+
> >>>>>>>> 1 file changed, 10 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b=
/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>> index aa5fb64d57eb..9ff9cbdd8a85 100644
> >>>>>>>> --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>> +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> >>>>>>>> @@ -63,6 +63,16 @@ properties:
> >>>>>>>>      - riscv,sv48
> >>>>>>>>      - riscv,none
> >>>>>>>>
> >>>>>>>> +  mmu:
> >>>>>>>
> >>>>>>> Shouldn't we keep the items be in alphabetic order, i.e. mmu befo=
re
> >>>>>>> mmu-type?
> >>>>>>>
> >>>>>>>> +    description:
> >>>>>>>> +      Describes the CPU's MMU Standard Extensions support.
> >>>>>>>> +      These values originate from the RISC-V Privileged
> >>>>>>>> +      Specification document, available from
> >>>>>>>> +      https://riscv.org/specifications/
> >>>>>>>> +    $ref: '/schemas/types.yaml#/definitions/string'
> >>>>>>>> +    enum:
> >>>>>>>> +      - riscv,svpmbt
> >>>>>>>
> >>>>>>> The privileged specification has multiple MMU related extensions:
> >>>>>>> Svnapot, Svpbmt, Svinval. Shall they all be modeled in this enum?
> >>>>>>
> >>>>>> I remember in some earlier version some way back there was the
> >>>>>> suggestion of using a sub-node instead and then adding boolean
> >>>>>> properties for the supported extensions.
> >>>>>>
> >>>>>> Aka something like
> >>>>>>   mmu {
> >>>>>>           riscv,svpbmt;
> >>>>>>   };
> >>>>>
> >>>>> For the record, I'm talking about the mail from september
> >>>>> https://lore.kernel.org/linux-riscv/CAAeLtUChjjzG+P8yg45GLZMJy5UR2K=
5RRBoLFVZhtOaZ5pPtEA@mail.gmail.com/
> >>>>>
> >>>>> So having a sub-node would make adding future extensions
> >>>>> way nicer.
> >>>>
> >>>> Svpbmt is just an ISA extension, and should be treated like any othe=
r.
> >>>> Let=E2=80=99s not invent two different ways of representing that in =
the device
> >>>> tree.
> >>>
> >>> Heinrich asked how the other extensions should be handled
> >>> (Svnapot, Svpbmt, Svinval), so what do you suggest to do with these?
> >>
> >> Whatever is done for Zb[abcs], Zk*, Zv*, Zicbo*, etc. There may not be
> >> a concrete plan for that yet, but that means you should speak with the
> >> people involved with such extensions and come up with something
> >> appropriate together.
> >>
> >> Jess
> >>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--
Regards,
Atish

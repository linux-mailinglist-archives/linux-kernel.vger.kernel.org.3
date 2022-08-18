Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4755988F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344800AbiHRQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiHRQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:34:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7494D166
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38BFEB821DE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E56DC433C1;
        Thu, 18 Aug 2022 16:33:57 +0000 (UTC)
Date:   Thu, 18 Aug 2022 17:33:53 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mte: Follow arm64.nomte override in MMU setup.
Message-ID: <Yv5p8bF272DxdNO3@arm.com>
References: <20220805214734.1937451-1-eugenis@google.com>
 <875yj1x0k0.wl-maz@kernel.org>
 <CAFKCwrjVaOdrGktxVHLCDPyJSRjZ0B3FHTGsb3PXMULL=dw9rA@mail.gmail.com>
 <87v8r1uztz.wl-maz@kernel.org>
 <CAFKCwriq-Vh+fhxso=xqtKzkL95QkYOOkMR8XwTOJfeg1M-2qQ@mail.gmail.com>
 <CAMn1gO5Va0eVFqzoOLLLJ+C+x-5=cc4qXDTw0e9J7v0RpYWusA@mail.gmail.com>
 <YvtMk2cNDrrzVX3g@arm.com>
 <CAMn1gO4t1hGSTKE0fLCcJXmHGvH_zuzjqiBKp4G=SmKyx=R_-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO4t1hGSTKE0fLCcJXmHGvH_zuzjqiBKp4G=SmKyx=R_-A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:38:34PM -0700, Peter Collingbourne wrote:
> On Tue, Aug 16, 2022 at 12:51 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > On Tue, Aug 09, 2022 at 06:24:23PM -0700, Peter Collingbourne wrote:
> > > On Tue, Aug 9, 2022 at 10:29 AM Evgenii Stepanov <eugenis@google.com> wrote:
> > > > On Tue, Aug 9, 2022 at 9:49 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > In which case what is the tag memory doing in the linear map?
> > > > > Shouldn't it be marked as reserved, not mapped, and in general
> > > > > completely ignored by the NS OS?
> > > >
> > > > That would be wasteful. The idea is to only reserve the parts of the
> > > > tag memory that correspond to the TZ carveout and release the rest to
> > > > the NS OS.
> > >
> > > More generally, one can imagine a system where *any* tagged memory
> > > transaction can result in an SError because the MTE implementation was
> > > not configured by an earlier bootloader phase, e.g. because the
> > > bootloader was configured to disable MTE at runtime. On such systems,
> > > the kernel must refrain from causing tagged memory transactions to be
> > > issued via the linear map, and that's exactly what this patch does.
> >
> > The problem is that it doesn't. The 8.5 architecture allows any Normal
> > Cacheable (even non-tagged) mapping to fetch tags. It may happen that on
> > certain implementations setting MAIR to non-tagged works but that's not
> > guaranteed and with the Linux kernel we tend to stick to the architected
> > behaviour (with a few exceptions like PMU counters and errata).
> >
> > There is an ongoing discussion with the architects and partners on
> > whether we can tighten the architecture as not to cause visible
> > side-effects like SError but not sure whether that has been closed yet
> > (just back from holiday).
> >
> > Until that's sorted, tag storage cannot be reused in an arm64-generic
> > way in the kernel.
> 
> We can see how that discussion turns out, but let me take a shot at
> persuading you that this is the right thing to do in any case.

The argument for MAIR change in the patch description was to prevent the
kernel from accessing the tag storage. In some interpretation of the
architecture (and the proposed change), setting ATA to 0 should be
sufficient as not to generate SErrors, so no need to tweak MAIR. But if
tweaking MAIR is sufficient (and maybe necessary) on all current CPUs,
we might as well tighten the architecture. I'll be away from tomorrow
for another week but please raise it with the Arm architects when you
get a chance (otherwise I can raise it when I'm back).

> Again, this isn't necessarily about reusing tag storage. It's about
> whether the accesses via the linear map are expected to work at all.

Maybe but if it happens to work on some SoC, I don't want to give the
impression that reusing tag storage is purely a kernel problem. That's
pretty much the implication at the beginning of this thread.

In a SoC with MTE enabled by firmware, you are not expected to map the
tag allocation storage in the linear map. If such tag storage can be
reused as normal DRAM, the firmware should somehow disable MTE, probably
in an implementation-specific way at the memory controller level. If it
can't, then such memory cannot be used for anything else other than tag
storage.

> As defined, the architecture gives EL2 the role of controlling whether
> the system is deemed to implement, among other features, FEAT_MTE2, as
> there is no capability for EL3 to trap accesses to the relevant ID
> register. On the other hand, EL3 does to a large extent control
> whether FEAT_MTE2 is implemented on a particular system, regardless of
> whether the CPUs are capable of supporting it. Therefore, the kernel
> has pragmatically defined arm64.nomte, together with other command
> line arguments like arm64.nopauth, arm64.nobti and arm64.nosve, as
> non-architectured means of overriding ID register bits. If the
> relevant ID register bits for MTE as filtered through the command line
> arguments are 0, this implies that FEAT_MTE2 is not implemented.

It's more like telling the kernel that it should not attempt to use it
rather than completely hiding the feature. The hypervisor can do this
via ID reg trapping.

> At this point we rejoin what is architected. Among the features
> implied by FEAT_MTE2 is the ability to assign the Tagged Normal
> attribute to pages via the MAIR. If the kernel were to use the Tagged
> Normal attribute anyway, the behavior is defined to be UNPREDICTABLE.
> Therefore, the kernel must not use this attribute in order to avoid
> UNPREDICTABLE behavior. It is simply a bug that we are failing to
> respect arm64.nomte when computing the MAIR.

As I said above, it depends on how you interpret the command line
option. It's not unpredictable behaviour if the hardware does support
MTE, as per the raw ID register.

Now, the reason I did the MAIR setting early in proc.S is that the
values may be cached in the TLB. When a secondary CPU is brought up, it
starts with the corresponding MAIR entry untagged but once it turns on
CnP (if also present), it would pollute the TLB of the peer CPUs with
the wrong attribute. So there is a small window before the local TLBI
where the peer CPUs may fail to write tags.

Evgenii's patch also looks too complicated with some assembly function.
We can do everything in C as I did in some early versions of the MTE
patchset. See the cpu_enable_mte() hunk here:

https://lore.kernel.org/all/20200715170844.30064-4-catalin.marinas@arm.com/

and you also need this hack (which I didn't particularly like, hence
moving it to proc.S):

https://lore.kernel.org/all/20200715170844.30064-13-catalin.marinas@arm.com/

I'm about to go on holiday and don't have time to prepare a patch but
feel free to pick the corresponding hunks from the above patches and
post a new one. We just need some clarification in the architecture as I
don't want people to start believing that arm64.nomte solves the
carveout reuse problem.

-- 
Catalin

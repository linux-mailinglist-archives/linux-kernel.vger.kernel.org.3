Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4B848B5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbiAKSkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243801AbiAKSkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:40:42 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5040BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:40:42 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so391529pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 10:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bv4Gth0tIcp91Z0tp//9a6XU+yQJP+smy563YC87HSo=;
        b=Lx9j4K3Y4ScsPijxHOjivmLbttR+XEyfJ0jIVNwScHQCFpHz2eWdK02wgP1UvFYdIB
         FjeBxE9gHGNWq16AdoPb7dA6ocQY/Da8n9uDq6mtTTMBhbl1Gs1IFNYShhim76FCi1lm
         ppG1ywh8D6pEBQa7XoIaY22PiIA7zY9mRxXIcOOB//nICq49DDC6fgvxvsgHVzLmvruv
         E56sRCdLsvVQ75MVcXTwmcFlfA/0mtYLSrXLFpXxLo+qYhY/FeBMSznW8vp5RavAEt7f
         a2PuYGDZUXGfDQtFAeT9tgOSoAmw2oJIJKcY5Rmr8vcX+psolSH+ehOo9xtMpRmw5fFS
         GobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bv4Gth0tIcp91Z0tp//9a6XU+yQJP+smy563YC87HSo=;
        b=WC8Grik77kGJj9cdzX04gPlD3WhcmIfe3aUxN5ETrhX/1IJS9NlVVYOqDQeV1YoWlu
         gcd/69Tqx8epT/N6xl+36S3I+UrGlx7g2dUC2BtVcXUJ5Y8MCzS+uD03dyYOl8qrOSPD
         qwWsV7JWKzOaNRUSqSFdv/+rgsJEYfVar1I7RcPpL4iK+eL58SA+RqA1bwsWOf1UGk2M
         EltuWhZdXfQVit7F1/fN8w8c1V4GpdIYREgD0cO5svzEUdff87BJQWcQa+oD2Khip0ra
         oBo/ZyjxYZkUcLdYZ4qqI+cxBhRzjH+9B3XY0nV7YoDQC3Zlc7sMeD2F8H8Zv4ZV2BBJ
         8r8Q==
X-Gm-Message-State: AOAM533WN4e7OoC5XRSc1qnYDn8Bn2wlIPWOyr6HNZpUUSRTcd725Zsu
        12HTEuRjafF7fPxGkUmhmumg2w==
X-Google-Smtp-Source: ABdhPJxLQxdPzVyhiycnn+9tUkGTIl3jwpXTxPgJqzTL4tchJeO+HBiNyvNPkM50gseLeTTQdM+ykA==
X-Received: by 2002:a63:9d4a:: with SMTP id i71mr5080579pgd.570.1641926441493;
        Tue, 11 Jan 2022 10:40:41 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g10sm2988344pjs.1.2022.01.11.10.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 10:40:40 -0800 (PST)
Date:   Tue, 11 Jan 2022 10:40:40 -0800 (PST)
X-Google-Original-Date: Tue, 11 Jan 2022 10:40:06 PST (-0800)
Subject:     Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
In-Reply-To: <Yd1OqLCSI6h+A0Ry@aurel32.net>
CC:     atishp@atishpatra.org, heinrich.schuchardt@canonical.com,
        anup@brainfault.org, anup@brainfault.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <atishp@rivosinc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        ptomsich@ventanamicro.com, gfavor@ventanamicro.com,
        ksankaran@ventanamicro.com, markhimelstein@riscv.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     aurelien@aurel32.net
Message-ID: <mhng-5333a5ff-5a08-40ab-8136-316913fa5fbe@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 01:32:24 PST (-0800), aurelien@aurel32.net wrote:
> On 2021-11-12 17:49, Atish Patra wrote:
>> On Tue, Nov 9, 2021 at 10:19 AM Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > On 7/29/21 08:10, Atish Patra wrote:
>> > > On Wed, Jul 28, 2021 at 9:30 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> > >>
>> > >> On Sun, 11 Jul 2021 11:59:33 PDT (-0700), Palmer Dabbelt wrote:
>> > >>> On Fri, 09 Jul 2021 22:01:02 PDT (-0700), Anup Patel wrote:
>> > >>>>
>> > >>>>
>> > >>>> ﻿On 08/07/21, 9:22 AM, "Anup Patel" <anup@brainfault.org> wrote:
>> > >>>>
>> > >>>>      On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>> > >>>>      >
>> > >>>>      > On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org wrote:
>> > >>>>      > > Hi Palmer,
>> > >>>>      > >
>> > >>>>      > > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com> wrote:
>> > >>>>      > >>
>> > >>>>      > >> The SBI SRST extension provides a standard way to poweroff and
>> > >>>>      > >> reboot the system irrespective to whether Linux RISC-V S-mode
>> > >>>>      > >> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>> > >>>>      > >>
>> > >>>>      > >> The SBI SRST extension is available in the SBI v0.3 specification.
>> > >>>>      > >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0-rc1)
>> > >>>>      > >
>> > >>>>      > > Can you please consider this patch for Linux-5.14-rc1 ?
>> > >>>>      > >
>> > >>>>      > > The SBI v0.3 spec is already frozen and this patch has been
>> > >>>>      > > floating on LKML for quite a few months now.
>> > >>>>      >
>> > >>>>      > I didn't realize that SBI-0.3 had been frozed.  That link is to a RC,
>> > >>>>      > the cooresponding v0.3.0 tag isn't in that repo.  Can you give me a
>> > >>>>      > pointer to the frozen spec?
>> > >>>>
>> > >>>>      Here's the link to SBI v0.3.0 tag:
>> > >>>>      https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0
>> > >>>>
>> > >>>>      We treat RC tags as frozen in SBI spec because no functional
>> > >>>>      changes are done in SBI spec after it is tagged as RC. We only
>> > >>>>      do typo fixes and clarifications on SBI spec RC release.
>> > >>>
>> > >>> Treating the 0.3.0-rc1 as frozen as soon as it's released is a
>> > >>> terrifying policy: some of the fixes I sent in after I saw rc1 released
>> > >>> change the actual meaning of the text, even if they were meant to change
>> > >>> them to what I thought the intended meaning was supposed to be.  That
>> > >>> means the actual text of 0.3.0-rc1 and 0.3.0 conflict with each other.
>> > >>> Given that frozen comes with a guarntee of backwards compatibility, does
>> > >>> that mean that the behavior allowed by 0.3.0-rc1 is compliant with the
>> > >>> SBI, even if it was likely just allowed by a wording mistake?
>> > >>>
>> > >>> If you're going to freeze things at rc1 then you really need to be quite
>> > >>> explicit about that, as generally the point of RCs is to elicit
>> > >>> review/testing.  Looks like I was the only person to have provided any
>> > >>> review, so I guess I was the only one who assumed "We don't expect any
>> > >>> significant functional changes. We will wait for any further feedback
>> > >>> and release the official v0.3 in a month or so." actually meant "this is
>> > >>> frozen".
>> > >>>
>> > >>>> Can you take this patch for Linux-5.14 ??
>> > >>>
>> > >>> No, sorry, it's way too late for that.  Please be specific about when
>> > >>> you freeze specifications in the future, so we can all stay on the same
>> > >>> page.
>> > >>
>> > >> I went and talked to Krste, and he says that there's a whole process for
>> > >> freezing extensions that this hasn't gone through.  They don't have
>> > >> anything written down that I can point to, but can you guys please just
>> > >> get on the same page about this?  It seems like every time I talk to
>> > >
>> > > Absolutely. The freezing extensions process is documented right now[1]
>> > > but that is only meant
>> > > for ISA/hardware/platform specifications. There is no process defined
>> > > for a SBI specification which is purely
>> > > a software specification because SBI specification release
>> > > processes(v0.1 and v0.2) predate these documented processes.
>> > > The SBI specification is owned by the Platform HSC which falls under
>> > > the purview of software HC.
>> > > You can see a detailed chart of the RVI organization at [2]. All the
>> > > aspects of SBI specification are discussed
>> > > in platform meetings[3] and frozen only after public review[4] and
>> > > approval from the platform working group
>> > > and the software HC. The official SBI specification(v0.3) will also be
>> > > available along with all other RISC-V specifications
>> > > once they figure out how to structure non-ISA specifications.
>> > >
>> > > I have cc'd Kumar (chair of the Platform HSC) and Philip (chair of the
>> > > software HC) in case they want to add anything.
>> > > I was not aware of the fact that Krste/Andrew are not aware of the
>> > > progress of the SBI specification.
>> > > I will raise this topic during the next meeting and make sure they are
>> > > in the loop as well.
>> > >
>> > >> someone from the RISC-V foundation I get a conflicting description of
>> > >> what's going on, and I'm entirely out of patience when it comes to
>> > >> getting blamed for all the chaos over there.
>> > >>
>> > > I agree the RVI process has not been very clear in the past. However,
>> > > that has changed a lot in recent times thanks to Mark and
>> > > other working group chairs. I don't think anybody is blaming you for
>> > > the delay in ratification of the RVI specifications.
>> > > There is a clear path for all the specifications to be ratified e.g.
>> > > the AIA and H extensions are planned to be frozen by the end of this
>> > > year.
>> > > Let me know if you want to see the timeline of each specification and
>> > > I can point you to the correct sheet.
>> > >
>> > > [1] https://docs.google.com/presentation/d/1nQ5uFb39KA6gvUi5SReWfIQSiRN7hp6z7ZPfctE4mKk/edit#slide=id.ga0a994c3c8_0_6
>> > > [2] https://docs.google.com/presentation/d/1eEVuu6lRZd9iiDnZQSZME7Q7svtTG3pGIKHPmZ79B8E/edit#slide=id.ga275a504df_0_9
>> > > [3] https://github.com/riscv/riscv-platform-specs/wiki
>> > > [4] https://lists.riscv.org/g/tech-unixplatformspec/message/1042
>> >
>> > https://github.com/riscv-non-isa/riscv-sbi-doc/releases/tag/v0.3.1-rc1
>> > has:
>> >
>> > "This tag the release candidate of version 0.3.1 of the RISC-V SBI
>> > specification. It doesn't have any significant changes other than typos.
>> > A new release is created to adapt the ratification process for non-ISA
>> > specifications defined by RVI recently."
>> >
>> > Has this patch to wait until release 0.3.1 of the SBI specification is
>> > ratified?
>> 
>> Not ratified, Frozen (officially as per newly defined RVI process)
>> 
>> > What is the timeline?
>> >
>
> According to this mail, the "SBI specification is considered as frozen
> now as per the RISC-V International policies":
> http://lists.infradead.org/pipermail/opensbi/2022-January/002357.html
>
> Therefore can we get this patch queued for 5.17-rc1?

Thanks.  Atish had actually pointed this out last night, but I wasn't at 
the computer.  This in on for-next.

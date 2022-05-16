Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9191528C05
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344298AbiEPRc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiEPRcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ABCDEF2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 559CF612D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D093FC385AA;
        Mon, 16 May 2022 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652722370;
        bh=C+8DnkQiB/fbUFTud5vWH4yzxrPp6tRfvOchMkKtD1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMNnoHdHRLWn6JpN6R7IruGuyFziCD7z91m1OPqjI3uHsgp2LtnJt3XtBseKrSiIn
         UQtZH3e5JVYkwYoeBqWsO5zdBA3Y1dSkPXccSe7RvOBE79vn5qGjUzlNph+AAA3ApK
         gXQu6ck7KiwI3Hh4+5W0UQrA29MivVLSp4D2sZe41Vh4X85IirgaNZqnNQW3OgAkqY
         0E51XLIBfy/MkUlTWCFsGlBEQa8MbKFaOVUEH22y72JjyQ/p78ZZdT/mPvmGMmy6WC
         fcpCN2lsuskrRDWE2Ig5J4W3uq8ZDhaYvcqbxNUdVskL6b03EZyJkt+AlFP64M8QYn
         gx8p9Mav4Agpg==
Date:   Tue, 17 May 2022 01:24:15 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 2/4] riscv: introduce unified static key mechanism for
 CPU features
Message-ID: <YoKIv2ATRdQfYbBf@xhacker>
References: <20220508160749.984-1-jszhang@kernel.org>
 <20220508160749.984-3-jszhang@kernel.org>
 <CAK9=C2Xinc6Y9ue+3ZOvKOOgru7wvJNcEPLvO4aZGuQqETXi2w@mail.gmail.com>
 <YnkoKxaPbrTnZPQv@xhacker>
 <CAOnJCU+XR5mtqKBQLMj3JgsTPgvAQdO_jj2FWqcu7f9MezNCKA@mail.gmail.com>
 <YoCollqhS93NJZjL@xhacker>
 <CAAhSdy3_av5H-V_d5ynwgfeZYsCnCSd5pFSEKCzDSDBbD+pGLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhSdy3_av5H-V_d5ynwgfeZYsCnCSd5pFSEKCzDSDBbD+pGLA@mail.gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 08:19:37PM +0530, Anup Patel wrote:
> On Sun, May 15, 2022 at 12:54 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Wed, May 11, 2022 at 11:29:32PM -0700, Atish Patra wrote:
> > > On Mon, May 9, 2022 at 7:50 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > >
> > > > On Mon, May 09, 2022 at 09:17:10AM +0530, Anup Patel wrote:
> > > > > On Sun, May 8, 2022 at 9:47 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > > > >
> > > > > > Currently, riscv has several features why may not be supported on all
> > > > > > riscv platforms, for example, FPU, SV48 and so on. To support unified
> > > > > > kernel Image style, we need to check whether the feature is suportted
> > > > > > or not. If the check sits at hot code path, then performance will be
> > > > > > impacted a lot. static key can be used to solve the issue. In the past
> > > > > > FPU support has been converted to use static key mechanism. I believe
> > > > > > we will have similar cases in the future.
> > > > >
> > > > > It's not just FPU and Sv48. There are several others such as Svinval,
> > > > > Vector, Svnapot, Svpbmt, and many many others.
> > > > >
> > > > > Overall, I agree with the approach of using static key array but I
> > > > > disagree with the semantics and the duplicate stuff being added.
> > > > >
> > > > > Please see more comments below ..
> > > > >
> > > > > >
> > > > > > Similar as arm64 does(in fact, some code is borrowed from arm64), this
> > > > > > patch tries to add an unified mechanism to use static keys for all
> > > > > > the cpu features by implementing an array of default-false static keys
> > > > > > and enabling them when detected. The cpus_have_*_cap() check uses the
> > > > > > static keys if riscv_const_caps_ready is finalized, otherwise the
> > > > > > compiler generates the bitmap test.
> > > > >
> > > > > First of all, we should stop calling this a feature (like ARM does). Rather,
> > > > > we should call these as isa extensions ("isaext") to align with the RISC-V
> > > > > priv spec and RISC-V profiles spec. For all the ISA optionalities which do
> > > > > not have distinct extension name, the RISC-V profiles spec is assigning
> > > > > names to all such optionalities.
> > > >
> > > > Same as the reply a few minutes ago, the key problem here is do all
> > > > CPU features belong to *ISA* extensions? For example, SV48, SV57 etc.
> > > > I agree with Atish's comments here:
> > > >
> > > > "I think the cpu feature is a superset of the ISA extension.
> > > > cpu feature != ISA extension"
> > > >
> > >
> > > It seems to be accurate at that point in time. However, the latest
> > > profile spec seems to
> > > define everything as an extension including sv48.
> > >
> > > https://github.com/riscv/riscv-profiles/blob/main/profiles.adoc#623-rva22s64-supported-optional-extensions
> > >
> > > It may be a redundant effort and confusing to create two sets i.e.
> > > feature and extension in this case.
> > > But this specification is not frozen yet and may change in the future.
> > > We at least know that that is the current intention.
> > >
> > > Array of static keys is definitely useful and should be used for all
> > > well defined ISA extensions by the ratified priv spec.
> > > This will simplify this patch as well. For any feature/extensions
> > > (i.e. sv48/sv57) which was never defined as an extension
> > > in the priv spec but profile seems to define it now, I would leave it
> > > alone for the time being. Converting the existing code
> > > to static key probably has value but please do not include it in the
> > > static key array setup.
> > >
> > > Once the profile spec is frozen, we can decide which direction the
> > > Linux kernel should go.
> > >
> >
> > Hi Atish, Anup,
> >
> > I see your points and thanks for the information of the profile
> > spec. Now, I have other two points about isa VS features:
> >
> > 1. Not all isa extenstions need static key mechanism, so if we
> > make a static key array with 1:1 riscv_isa <-> static key relationship
> > there may be waste.
> >
> > For example, the 'a', 'c', 'i', 'm' and so on don't have static
> > key usage.
> 
> Not all isa extensions but a large number of them will need a static
> key. It's better to always have one static key per ISA extension
> defined in cpufeatures.c

Currently, RISCV_ISA_EXT_MAX equals to 64 while the base ID is 26.
In those 26 base IDs, only F/D and V need static key, it means
we waste at least 24 static keys.

> 
> For example, F, D, V, Sstc, Svinval, Ssofpmt, Zb*, AIA, etc.
> 
> >
> > 2.We may need riscv architecture static keys for non-isa, this is
> > usually related with the linux os itself, for example
> > a static key for "unmap kernelspace at userspace".
> > static keys for "spectre CVE mitigations"
> > etc.
> 
> These things look more like errata or workarounds so better
> to use that framework instead of ISA extensions (or features).

Currently, the errata workarounds are implemented with ALTERNATIVEs
but I believe sometime we may need static key to implement the
workarounds. However this can be checked later. Now I worried about
the static key waste above.

Thanks

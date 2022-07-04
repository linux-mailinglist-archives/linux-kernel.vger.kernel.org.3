Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5836565C96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiGDRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGDRJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB23511A36
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:09:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 677D961521
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FE1C341D1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656954575;
        bh=Um74VEI3JxHcz8FDRGAiWVUNuyk2Y2i4GBLAq54v5s0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vH1ACDnAOIBP7LSR5Gway+gxOl7zbLOA2muLRdWKyn21uxTJs0bGcytHe0Ob6CQW/
         MTRyzW6y8i7r4iWDGKJaWYHa2WIN4USUPc5IOp9mNItt7dU0Our6h3zXsTDaysKn7Q
         1bCSHKvWh4dDURhYEW+BYKGwh1ky35dTZiUJDG1pzv9htFkbqRH2kHB94tXcUFOPsc
         GNIHuvB1o7A0vJfKZWZ+QJlgRQcuVGlLuxTDWmli5tOBpiwyibpePsn4DaQXhq78Gf
         gEPTWVtyqNfuMsGn7ifi6nb9qgx31IqTVl8m+YVj5LcC9APk+DYLsBvcjYGUlPTK41
         NGK+Sz5DnQ+qw==
Received: by mail-oi1-f175.google.com with SMTP id y77so13566472oia.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:09:35 -0700 (PDT)
X-Gm-Message-State: AJIora/k1vmDVirb6btns1bwqciCQvWOzwyen55uPzdjWBkYBGLYPtVT
        YKgfIseasxeMtT+SAetNxy6F0/uaAoPUBZ9brUM=
X-Google-Smtp-Source: AGRyM1sahgoRXg4Rzbf0/gmHR3RNP37cUxpO88Ud1QW1I/Znw7jgxtkIkBfkP6ZcjDK/UZIkdHCwZeqw3SVjKPNYBPU=
X-Received: by 2002:a05:6808:18a1:b0:337:5:30cf with SMTP id
 bi33-20020a05680818a100b00337000530cfmr11082396oib.228.1656954574851; Mon, 04
 Jul 2022 10:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <1656777473-73887-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <20220704103523.GC31437@willie-the-truck> <73f0c53b-fd17-c5e9-3773-1d71e564eb50@linux.alibaba.com>
 <20220704111402.GA31553@willie-the-truck> <4accaeda-572f-f72d-5067-2d0999e4d00a@linux.alibaba.com>
 <20220704131516.GC31684@willie-the-truck> <2ae1cae0-ee26-aa59-7ed9-231d67194dce@linux.alibaba.com>
 <20220704142313.GE31684@willie-the-truck> <6977c692-78ca-5a67-773e-0389c85f2650@linux.alibaba.com>
 <20220704163815.GA32177@willie-the-truck>
In-Reply-To: <20220704163815.GA32177@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 4 Jul 2022 19:09:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
Message-ID: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance degradation
To:     Will Deacon <will@kernel.org>
Cc:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
        baolin.wang@linux.alibaba.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, david@redhat.com, jianyong.wu@arm.com,
        james.morse@arm.com, quic_qiancai@quicinc.com,
        christophe.leroy@csgroup.eu, jonathan@marek.ca,
        mark.rutland@arm.com, thunder.leizhen@huawei.com,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rppt@kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 at 18:38, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 04, 2022 at 10:34:07PM +0800, guanghui.fgh wrote:
> > Thanks.
> >
> > =E5=9C=A8 2022/7/4 22:23, Will Deacon =E5=86=99=E9=81=93:
> > > On Mon, Jul 04, 2022 at 10:11:27PM +0800, guanghui.fgh wrote:
...
> > > > Namely, it's need to use non block/section mapping for crashkernel =
mem
> > > > before shringking.
> > >
> > > Well, yes, but we can change arch_kexec_[un]protect_crashkres() not t=
o do
> > > that if we're leaving the thing mapped, no?
> > >
> > I think we should use arch_kexec_[un]protect_crashkres for crashkernel =
mem.
> >
> > Because when invalid crashkernel mem pagetable, there is no chance to r=
d/wr
> > the crashkernel mem by mistake.
> >
> > If we don't use arch_kexec_[un]protect_crashkres to invalid crashkernel=
 mem
> > pagetable, there maybe some write operations to these mem by mistake wh=
ich
> > may cause crashkernel boot error and vmcore saving error.
>
> I don't really buy this line of reasoning. The entire main kernel is
> writable, so why do we care about protecting the crashkernel so much? The
> _code_ to launch the crash kernel is writable! If you care about preventi=
ng
> writes to memory which should not be writable, then you should use
> rodata=3Dfull.
>

This is not entirely true - the core kernel text and rodata are
remapped r/o in the linear map, whereas all module code and rodata are
left writable when rodata !=3D full.

But the conclusion is the same, imo: if you can't be bothered to
protect a good chunk of the code and rodata that the kernel relies on,
why should the crashkernel be treated any differently?

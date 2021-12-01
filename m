Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48F2464534
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346344AbhLADCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 22:02:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229731AbhLADCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 22:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638327540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4BVobWc8X9sJwevm+EBIIDhYcgiVeWUwDPJ5DXAQgTo=;
        b=SU5DWnaJVWpyg5ndtffCQOJhkbOvSxU92/CUpWc5RTuehXkmQa+V+Sd9hc0QOk/5rXZBFQ
        yoqdfJRaf0xam+WI96uFchRtmLvR66MWZE/wvqF8bwJa3DgKzaAYw69c293IbLgRyh0Sjw
        J6hyBajix07jsE0K+Af9pz5B1w+t8KE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-OrFdvEmrNI6bbWX1QfGvHA-1; Tue, 30 Nov 2021 21:58:58 -0500
X-MC-Unique: OrFdvEmrNI6bbWX1QfGvHA-1
Received: by mail-ed1-f72.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso18747683edb.15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4BVobWc8X9sJwevm+EBIIDhYcgiVeWUwDPJ5DXAQgTo=;
        b=JaHDsmaCiddXZnGmBgO4IgEJ2c/TzpSygFNsWRahDjhVt93W0DT6BKtzWI2YziDFaO
         I/JnT5UgY6lTdGKhJwTUasq1XqE+7xi1888uhDSw3pqXwsO6R8TP8XXwjGeFi+ssiLu8
         mbhUw2tusANZTNQ+/+22tv3b7p/R5vFC7wmLQIIlln556Ou/IsYtosg/JPxw2s0bQVKi
         /IV52/5M3m/eZzmaz/2+rOpFzKYphoh+RQg6MQLMA80yIuAECtlOWkCW+6d95BX9rhyl
         AwgxXwnY5NK/oA2/oxc06JdmjW/zNBB06wb/fMPB1IfRKVKgLXUiKCBphk5/NCFSsU0R
         pxGA==
X-Gm-Message-State: AOAM5300v1Wmwoz08JUeM/765PlQ3OdV2pSX64fgV+IoCMfMrjg1SkmS
        AJqEPwwb3y1SGXkYCt4YBGXOMYdOunlOx5754uRNvBN4fSAikpEI5h7wUACsyIzd1wMsDAkdIxH
        nZwD8BVyDTKyX4GP7E+oS0L7RzAST/voNQScJgjd7
X-Received: by 2002:a50:fb16:: with SMTP id d22mr4465049edq.367.1638327537737;
        Tue, 30 Nov 2021 18:58:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzL7+hFiZ7XkfzJIfqci5Jn+cAtPo+VQOJrHSI1MBuWP0rWY9c55kf1rq+0YMOYPx4EWtWCJSODBb+rZA+f8Wk=
X-Received: by 2002:a50:fb16:: with SMTP id d22mr4465020edq.367.1638327537553;
 Tue, 30 Nov 2021 18:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20211129014007.286478-1-wefu@redhat.com> <20211129014007.286478-2-wefu@redhat.com>
 <10924379.EydaIB8Zb3@diego>
In-Reply-To: <10924379.EydaIB8Zb3@diego>
From:   Wei Fu <wefu@redhat.com>
Date:   Wed, 1 Dec 2021 10:58:46 +0800
Message-ID: <CA+YCwKnwkdWY2b6XtAwM=ZmQ=mVMMDnG3s746GQA_DLhLVtBSg@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions
 support for Svpbmt
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Anup Patel <anup.patel@wdc.com>, atishp04@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Guo Ren <guoren@kernel.org>,
        =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Liu Shaohua <liush@allwinnertech.com>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        taiten.peng@canonical.com,
        Aniket Ponkshe <aniket.ponkshe@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Gordan Markus <gordan.markus@canonical.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Lustig <dlustig@nvidia.com>,
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
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,
Thanks for your correction ,  this was my typo when I did the "sed" to
replace the word.
I need to make a V5 ASAP

On Wed, Dec 1, 2021 at 2:46 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Montag, 29. November 2021, 02:40:06 CET schrieb wefu@redhat.com:
> > From: Wei Fu <wefu@redhat.com>
> >
> > Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
> > in the DT mmu node. Update dt-bindings related property here.
> >
> > Signed-off-by: Wei Fu <wefu@redhat.com>
> > Co-developed-by: Guo Ren <guoren@kernel.org>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Docume=
ntation/devicetree/bindings/riscv/cpus.yaml
> > index aa5fb64d57eb..9ff9cbdd8a85 100644
> > --- a/Documentation/devicetree/bindings/riscv/cpus.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
> > @@ -63,6 +63,16 @@ properties:
> >        - riscv,sv48
> >        - riscv,none
> >
> > +  mmu:
> > +    description:
> > +      Describes the CPU's MMU Standard Extensions support.
> > +      These values originate from the RISC-V Privileged
> > +      Specification document, available from
> > +      https://riscv.org/specifications/
> > +    $ref: '/schemas/types.yaml#/definitions/string'
> > +    enum:
> > +      - riscv,svpmbt
>
> shouldn't that be "riscv,svpbmt" ? [the m is at the wrong location it see=
ms]
>
> > +
> >    riscv,isa:
> >      description:
> >        Identifies the specific RISC-V instruction set architecture
> >
>
>
>
>


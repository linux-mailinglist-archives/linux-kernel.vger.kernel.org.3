Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595B65849E3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiG2Cqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiG2Cqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:46:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D81261723
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFECC61DDB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29750C4347C
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659062794;
        bh=w4Wkpn0druzPuiqSOhHxN7Fku75Q30SBmK1KU9uVjn0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r1VZnR41b0F/2zvn35yxe37yr0wgVu/7CaQhktQtwol3ZENRxDnC5NIKYzw7QyHYA
         RS8o6RcoqSdNI1KRYchZZI/XdSs3Qn6nnAOmp4TIhY/VZWTFOhsfY+R5GFWiIIx+1k
         N7EHps2jiCQr15qf7jAIH/SW1ZWsbdIBAKvsHBqLv/VfYVC4CgwcyZOSWF0YEvcZbc
         WqAHB0eN/2zc3ScVwqWGaIQt1X94mc2ivwgJNschmyXvx/PM5rHid5VdHG4XCa2265
         IjYKpjH51AHMu44/j0gjwmBtJ+RMAZlt/RbTUBYtoSfwcFQKsyZQt/6T0L2/Y1UcNE
         ZnGgj0Y4JbHXg==
Received: by mail-vs1-f49.google.com with SMTP id k3so3303412vsr.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:46:34 -0700 (PDT)
X-Gm-Message-State: AJIora84F2h5kHbVg9nXl7tpA/3Y98W10HR9DawaB6CmDgMJGlcjR6v0
        wkn1TBFDmtNbJM3QH9UAouphasQ0RgYSmt5ixHI=
X-Google-Smtp-Source: AGRyM1u6SxglJ8d+1eIrMCQU+a1v3FvbM3qnTSGMMaf6Z3NWacIpU9z4O4rYWdTNnPSEGJNamNzbWeLA7BVZWT1v3ZI=
X-Received: by 2002:a05:6102:3d3:b0:358:8a04:30cb with SMTP id
 n19-20020a05610203d300b003588a0430cbmr530018vsq.43.1659062793140; Thu, 28 Jul
 2022 19:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
 <e95cfe70e2e5faa5b9cdc9452bdb3ab8d664aff0.camel@xry111.site>
 <CAAhV-H5nuP2xYREtZuJnq3Sr+JpVbOzLDw+N1ep5yFSUd1+nFQ@mail.gmail.com> <615b5bc79c9e48409361bde1af9374cacb06ec9c.camel@xry111.site>
In-Reply-To: <615b5bc79c9e48409361bde1af9374cacb06ec9c.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 29 Jul 2022 10:46:19 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7Fr5OEZCq+C88BWmT2fvW3aZBnFpjx9dgJXNNwVtp8Uw@mail.gmail.com>
Message-ID: <CAAhV-H7Fr5OEZCq+C88BWmT2fvW3aZBnFpjx9dgJXNNwVtp8Uw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] LoongArch: Stop using undocumented assembler options
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Thu, Jul 28, 2022 at 9:10 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Thu, 2022-07-28 at 20:25 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Thu, Jul 28, 2022 at 8:03 PM Xi Ruoyao <xry111@xry111.site> wrote:
> > >
> > > Now we can handle GOT and GOT-based relocations properly, remove the
> > > undocumented `-Wa,-mla-{global,local}-with-{pcrel,abs}` assembler
> > > hacks.
> > I think "-Wa,-mla-{global,local}-with-{pcrel,abs}" may be regular
> > options rather than "hacks". If I'm right, the title and commit
> > message should be updated. And we can send patches to binutils to make
> > them "documented".
>
> How about changing the message to:
>
>    GCC 13 no longer generates la.global and la.local in assembly, but
>    produces explicit PC-relative relocations to local symbols and GOT
>    entries for global symbols instead.  As the result, -Wa,-mla-* are no
>    longer sufficient to control the code generation for symbol address
>    loading.  As now we can handle GOT and GOT-based relocations
>    properly, remove those options to use GOT for global symbol address
>    consistently.
GCC 13 can still generate la.global and la.local, so "GCC 13 no longer
generates la.global and la.local in assembly by default" may be
better. And "undocumented" in the title should be "non-preferred", I
think.

Huacai

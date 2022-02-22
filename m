Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AB24C0400
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiBVVnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiBVVnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:43:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D760078;
        Tue, 22 Feb 2022 13:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB8D61728;
        Tue, 22 Feb 2022 21:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E0C340EF;
        Tue, 22 Feb 2022 21:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645566159;
        bh=PLvJIjwxcItttFn5g3yYR3EOOKh3FdanRC1f86KA47E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZHs+AO/Bo7V4Qvp2xXjliLl6RvjLC+/5WAW8DfSRpnqbMxbxqq+9c4RjUzY+x9wPI
         E8wBTJc/jRtPGWx1b7H61XfyxL6Da7ilbgL8QydO6x8BV6PnqNG4SyZY2vIguPV6fJ
         40WoondIT+dZa+wvr5qH/aiqc4d0F4tvsjaOtp/6x1CxweJtt48LbIS4SdqIUL6iZ+
         6G8U4xkSG7Z4NMm9f2kVNSzjQJwrRePXGajAxhHEb7+tcmNFqpxgUh8rYlzkoW9Ofg
         RtjVbJ2qViKuuB7IHXSYZoXi4U+LttpWdp/HDHtEHMOb/I3zGG9W+7NVkExtQWkCbi
         ap0DB5LgWpHiw==
Received: by mail-wr1-f49.google.com with SMTP id o24so35999765wro.3;
        Tue, 22 Feb 2022 13:42:39 -0800 (PST)
X-Gm-Message-State: AOAM530WJXiWSzDntKxVJXKRK6iHORNVtBFyQCPHx/KZJ8DPbX49tMWj
        F2sNm8Fw4IMLEeUXrgQVwLSaLsqjOe9MuGEqVL0=
X-Google-Smtp-Source: ABdhPJx2jWRjeZYzUpkKQ3ZfTJ+Iy5EP3jz75g4PW40bwNaBmfr2YueydgTqUHsrR74Xq2tiZFSQ7oOMVWF8LLqYCpI=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr21257685wri.219.1645566158039; Tue, 22
 Feb 2022 13:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20220222155345.138861-1-tsbogend@alpha.franken.de>
 <CAK8P3a0QV7y_gFv=VHGKVWjXyYmFFZRrXj3m52d21Fyydib4NQ@mail.gmail.com> <20220222195806.GA17107@alpha.franken.de>
In-Reply-To: <20220222195806.GA17107@alpha.franken.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 22 Feb 2022 22:42:22 +0100
X-Gmail-Original-Message-ID: <CAK8P3a16UjuM0Dz-ERahAfzkAD9D7Cc3sd3yT_e7cVio=qvgPA@mail.gmail.com>
Message-ID: <CAK8P3a16UjuM0Dz-ERahAfzkAD9D7Cc3sd3yT_e7cVio=qvgPA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Handle address errors for accesses above CPU max
 virtual user address
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 8:58 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Tue, Feb 22, 2022 at 06:04:07PM +0100, Arnd Bergmann wrote:
> > On Tue, Feb 22, 2022 at 4:53 PM Thomas Bogendoerfer
> > <tsbogend@alpha.franken.de> wrote:
> > >
> > > Address errors have always been treated as unaliged accesses and handled
> > > as such. But address errors are also issued for illegal accesses like
> > > user to kernel space or accesses outside of implemented spaces. This
> > > change implements Linux exception handling for accesses to the illegal
> > > space above the CPU implemented maximum virtual user address and the
> > > MIPS 64bit architecture maximum. With this we can now use a fixed value
> > > for the maximum task size on every MIPS CPU and get a more optimized
> > > access_ok().
> > >
> > > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> >
> > Thank you for addressing this. Should I add this patch to my series
> > ahead of "mips: use simpler access_ok()"? That way I can keep it all
> > in my asm-generic tree as a series for 5.18.
>
> yes please add it to your series.

Done now.

> >
> > It might be clearer to use TASK_SIZE_MAX here instead of XKSSEG,
> > to match the check in access_ok(). If you like, I can change that while
> > applying.
>
> I had TASK_SIZE_MAX in an intermediate version, but decided to go with XKSSEG,
> because it's what this check is about. It's about checking what the MIPS
> architecture defined.

Right, makes sense.

Thanks,

        Arnd

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B94F11C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 11:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352264AbiDDJQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 05:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351372AbiDDJQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 05:16:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DF13B3D4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 02:14:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1483B80315
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C4BC2BBE4;
        Mon,  4 Apr 2022 09:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649063652;
        bh=NKL1EMyqM5qjBiWdcT5gUouD5/1b34+eJQzWDgHHZs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoT/vNIgOLQ06jEs199YdWMr0/J5wbhY/ICzffkk7/nQxqZybEI0cI696tgVBdcfL
         EKPcer4PgO2goyaXxILTEzk2vkWTKaj6sD+0Va4ckSoxtYIhr7EyOu7EuC1NTgr+8G
         DC+H2jkyXcyT8eGy05kETEuJPEyLu2UxGs//FwUCYU9RK3OnzXfJKgmsDad+QFMPcz
         ccuGhFopKlCT0o1y8xhLeYsajQjpdc1aEwm0whETvmtlpucSshlJ4IXXH0K/cAOXXq
         afrP12ojdhp/RUyKnuVudJW8qwj/WbG5Z46TFEhVC+7OcBxeJ6Saz/v97JRdmnQmzS
         ShtPfIUh9Ge8g==
Date:   Mon, 4 Apr 2022 10:14:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andrew Pinski <pinskia@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        GCC Mailing List <gcc@gcc.gnu.org>, f.fainelli@gmail.com,
        maz@kernel.org, marcan@marcan.st,
        LKML <linux-kernel@vger.kernel.org>, opendmb@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/io: Remind compiler that there is a memory side
 effect
Message-ID: <20220404091405.GB22649@willie-the-truck>
References: <20220401164406.61583-1-jeremy.linton@arm.com>
 <Ykc0xrLv391/jdJj@FVFF77S0Q05N>
 <CA+=Sn1k23tzMKbMWKW7c3EBoXidJCT-k_k_oF_sKTsGLJTKTnw@mail.gmail.com>
 <CAMj1kXHMK8PNpXGayfO6qxkA1VdkXmkJdLh29fwSJyOG0ZnSGA@mail.gmail.com>
 <CAMj1kXGpWNJSQ6My5EM1ctHgH3WDjTqLwVocxjmiNzK7hBYhBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGpWNJSQ6My5EM1ctHgH3WDjTqLwVocxjmiNzK7hBYhBQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2022 at 09:47:47AM +0200, Ard Biesheuvel wrote:
> On Sun, 3 Apr 2022 at 09:47, Ard Biesheuvel <ardb@kernel.org> wrote:
> > On Sun, 3 Apr 2022 at 09:38, Andrew Pinski <pinskia@gmail.com> wrote:
> > > It might not be the most restricted fix but it is a fix.
> > > The best fix is to tell that you are writing to that location of memory.
> > > volatile asm does not do what you think it does.
> > > You didn't read further down about memory clobbers:
> > > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers
> > > Specifically this part:
> > > The "memory" clobber tells the compiler that the assembly code
> > > performs memory reads or writes to items other than those listed in
> > > the input and output operands
> > >
> >
> > So should we be using "m"(*addr) instead of "r"(addr) here?
> >
> > (along with the appropriately sized casts)
> 
> I mean "=m" not "m"

That can generate writeback addressing modes, which I think breaks
MMIO virtualisation. We usually end up using "Q" instead but the codegen
tends to be worse iirc.

In any case, for this specific problem I think we either need a fixed
compiler or some kbuild magic to avoid using it / disable the new behaviour.

We rely on 'asm volatile' not being elided in other places too.

Will

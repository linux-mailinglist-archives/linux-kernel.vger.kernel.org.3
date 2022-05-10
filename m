Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2014521CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbiEJOwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345189AbiEJOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC59F6FD1B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:11:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1153560C6B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7391C385C2;
        Tue, 10 May 2022 14:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652191890;
        bh=k3aDsiEt3We5CETf9vWvSB7Ro1g28Lp3PICM7pFJakk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMVyGRNDuUxZt3GikLsYZIZZEdIc0KdfT/7OgZjnwt7f7uVcDuzpyRlSAvFrr0r6v
         dFMep80g9lCRy5imsRbXL3Z+Bn/P7nSaU5ZZbuJJzkpahmtw6xQ3vdjAxSfBSA7wss
         EX+KfKQVbaKN+xIES7Fu71/5n/a+Ib9dNnrPtInK1IVm1uxI/SIVOH/TfSGrwXCguW
         lO6Ki/XlCk/KGKKYrc9iE7KHqQhVNZif4AXWenb1p/H+721j+b/X7vSaZucc3BZD0K
         qaMkFCAyyQQb2TvSqmhY6yZZSOcDQ3PkHZOXTNovfYltX/YM/ENYsRJMjBIuGmOJCy
         B+XUIk/343+MQ==
Date:   Tue, 10 May 2022 15:11:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Message-ID: <20220510141124.GB28104@willie-the-truck>
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
 <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
 <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:01:26PM +0200, Arnd Bergmann wrote:
> On Tue, May 10, 2022 at 1:53 PM Verdun, Jean-Marie <verdun@hpe.com> wrote:
> >
> > Hi Arnd,
> >
> > >    Hi Nick,
> >
> > >    This seems a bit more complex than necessary. Can't you just use a custom
> > >    inline asm with an ex_table entry to catch the fault? Have a look at
> > >    __get_user_asm() for an example.
> > >
> > >           Arnd
> >
> > We got inspired from debug_reg_hook within the same source file
> >( ./arch/arm/kernel/hw_breakpoint.c ). We chose that path to keep coherency
> > within the source code. We can implement the same fix by using an ex_table
> > entry, but this will create two different ways at catching unknown instruction
> > within the same source file. Will that be ok ?
> 
> I got a little lost trying to find where the breakpoint instruction comes
> from that gets trapped here, but I would guess that they had to do this
> using an undef_hook because the ex_table approach does not work
> there for some reason.
> 
> I would still pick the ex_table method here if that works.

IIRC, the ex_table handlers are called only for data aborts and are intended
to be used to handle cases where we take a fault on a memory access (e.g.
translation fault). In this case, we're taking an undefined instruction
exception on a cp14 access and so the undef_hook is the right thing to use.

Will

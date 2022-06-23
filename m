Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F21557734
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiFWJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiFWJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:55:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE21C2E9C3;
        Thu, 23 Jun 2022 02:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63F23B82236;
        Thu, 23 Jun 2022 09:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63210C3411B;
        Thu, 23 Jun 2022 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655978144;
        bh=3tgSj2b7F5bqM8rHpJ7bzxzD2TUoAE/bbCKa8uujIzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZgvzyZeua6gp2AlwNoBJJfJCKKDtkcP0jOcabqo4Ve6xzhfqozU3hvrBwzHaUJyql
         Kn69u/AcTlTOq4NG6WmG9HOBfZc+myqE7DJETCuRE9/61tGz20fCKrR3Vc/Re7eWk2
         YKVg1yFopUitiP8xoZYB171/fITa9+k7OIhhtfos=
Date:   Thu, 23 Jun 2022 11:55:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: Default async probing for DT based systems
Message-ID: <YrQ4naL9SJGbh+yJ@kroah.com>
References: <CGME20220616032522eucas1p19a6c8718f01fa61c2fee795fb8945a92@eucas1p1.samsung.com>
 <CAGETcx8z4dn1j05Za6nfDeC3v4r1yo30Nqu=1K2BEsvLcqqybQ@mail.gmail.com>
 <d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com>
 <CAGETcx8e0QDbaqHGm1O8y6zwrBCwRitsRFXeUPt0w6uFx9k6+g@mail.gmail.com>
 <CAGETcx-MHwex8tHLB1d71MAP01-3OPDZSNCUBb3iT+BtrugJmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-MHwex8tHLB1d71MAP01-3OPDZSNCUBb3iT+BtrugJmQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 07:36:24PM -0700, Saravana Kannan wrote:
> On Fri, Jun 17, 2022 at 11:04 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 2:04 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> > >
> > > Hi Saravana,
> > >
> > > On 16.06.2022 05:24, Saravana Kannan wrote:
> > > > Hi,
> > > >
> > > > TL;DR: I want to improve boot times by enabling async probing by
> > > > default for DT based systems. Can you give it a shot please?
> > >
> > > Yes, I've gave it a try on my test systems. It looks that there are a
> > > few issues. The first one, the most obvious to notice, is related to
> > > __request_module() calls from various drivers and frameworks. Here are
> > > some examples:
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 3 PID: 73 at kernel/kmod.c:136 __request_module+0x230/0x600
> > > Modules linked in:
> > > CPU: 3 PID: 73 Comm: kworker/u12:5 Not tainted 5.19.0-rc2-next-20220615+
> > > #5203
> > > Hardware name: ARM Juno development board (r1) (DT)
> > > Workqueue: events_unbound async_run_entry_fn
> > > pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > > UDC core: g_ether: couldn't find an available UDC
> > > pc : __request_module+0x230/0x600
> > > lr : __request_module+0x228/0x600
> >
> > Ah, I think I know what these might be. Going by memory,
> > __request_module() from asyc thread context has some issues for module
> > loading. So I think a check was added like this. And I think the check
> > is triggering when it shouldn't (this isn't module context here).
> 
> My memory was right and this is indeed the spurious warning that was
> meant to cover a potential deadlock in a module load path. I was
> trying to disable this warning till we hit the point in the boot flow
> where request_module() can actually succeed. But I got stuck trying to
> figure it out.
> 
> It looks like the usermode helper that's used for module loading
> triggered by request_module() is enabled in populate_rootfs() that
> runs well before most of the initcalls are done. I was under the
> impression that init with pid 0 would be the first userspace thread
> that can start. But I don't see anything obvious that prevents the
> usermode helper from running and loading a module before init process
> has been exec'ed after we set system_state to SYSTEM_RUNNING.
> 
> Can someone clarify when is the earliest request_module() can succeed?

It can succeed very very early, when we have the initial ramfs mounted
before init runs as you sometimes need the modules there to be able to
load the device that init is on.

thanks,

greg k-h

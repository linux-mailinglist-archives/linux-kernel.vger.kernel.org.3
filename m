Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01744EE237
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiCaUB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 16:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240855AbiCaUBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 16:01:55 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ABFB17335E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 13:00:07 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22VJxwec026309;
        Thu, 31 Mar 2022 21:59:58 +0200
Date:   Thu, 31 Mar 2022 21:59:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Ben Greear <greearb@candelatech.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic - not syncing: Attempted to kill init!
 exitcode=0x00007f00 since 5.17
Message-ID: <20220331195958.GA26284@1wt.eu>
References: <bbf2d268-a93d-afdc-a836-0fdb878be10e@candelatech.com>
 <20220331034343.GC23200@1wt.eu>
 <794a9c23-d3b9-c454-8f78-760060f0b9f2@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <794a9c23-d3b9-c454-8f78-760060f0b9f2@candelatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:36:17AM -0700, Ben Greear wrote:
> On 3/30/22 8:43 PM, Willy Tarreau wrote:
> > Hi Ben,
> > 
> > On Wed, Mar 30, 2022 at 02:27:56PM -0700, Ben Greear wrote:
> > > Run /init as init process
> > > Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> > > /init: error whitsc: Refined TSC clocksource calibration: 2903.996 MHz
> > > le loading shareCPU: 2 PID: 1 Comm: init Not tainted 5.17.0+ #12
> > > d libraries: libclocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x29dc020bb13, max_idle_ns: 440795273180 ns
> > > rt.so.1: cannot Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> > > open shared objeCall Trace:
> > > ct file: No such <TASK>
> > >   file or directo dump_stack_lvl+0x47/0x5c
> > > ry
> > 
> > The coincidence between this error about your userland "libclocksource"
> > and the messages about the clock sources being refined makes me wonder
> > if there could be an error experienced during this lib's initialization
> > at a moment where the list of clocksources appears empty or opening one
> > of the /sys file is temporarily refused. I suspect that making a much
> > larger or much smaller initrd could change the initialization order
> > enough to prevent such an event from happening, but that sounds a bit
> > odd :-/
> > 
> > Willy
> 
> For whatever reason, it was quite reproducible yesterday.  I notice that it
> often (50+% of the time) failed on soft reboot, but I don't think it failed
> a single time when I then went and powered it down fully and powered it back on.
> 
> So possibly it is some un-initialized memory somewhere that is exacerbating
> some problem.
> 
> I will keep a watch on these errors and see if they always related to libclocksource.
> Looks like 'rt.so.1' is what it cannot find though?  So maybe nothing particular to
> do with /sys?

I really don't know, not knowing these libs. We could imagine that the
former only falls back on the latter when failing to find what it needs
in /sys. Of course I'm not trying to invent a scenario, just to find a
few rational explanations to what you're observing, as it's certainly
strange. Maybe other tests could involve trying the reset button and
also kexec to introduce some variations in the reboot methods.

It sort-of reminds me a BIOS bug I faced a decade ago by which a server
would randomly hang on soft reboot, and I finally figured that the BIOS
couldn't handle reboots triggered by CPUs other than CPU0. The workaround
I proposed then was to always use "taskset -c 0 reboot" and that one
would never fail. Maybe you're observing sort of a variation of this,
where some devices are not correctly initialized or your initrd gets
some parts corrupted when loaded from the wrong CPU, just guessing.

Cheers,
Willy

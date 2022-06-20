Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F655182B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbiFTMFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbiFTMFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:05:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF549F46
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655726699; x=1687262699;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zlOGCbpZsDTOv8id4TzRHzmuKGU55jpwJvGWEKomHEo=;
  b=ASwjmzVdrpIVB7zs4i84TmIj26ByLbpZ/Py5/v+IiHmg5JwlG9Z//A0A
   papfFFl0LP0VEFLhFcUscRxjK3ArAte2yqc1AHgVED/drfWQgdtJ9Gk11
   zkA+5ZSnEhpiVR5apz/IzhL/s24BO4bivflIWlJOH9p0EgCFNq8Og3lMa
   t2876FyGq1lLbO32JxrVkq6Aqj0x2IWdRoUjtTsBq0MMhHwwocms21dYe
   A4KlDB1s5BhT3HmyWYrCBWyc1vmnvZYh6J11tNWXScrb4KfgMTNL0djOg
   VvyRWL65ySBCjk0IWzhWuBu5xc87rZx29DUbMopEjtSa7JTB53x6lYZUT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259700181"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259700181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:04:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643090582"
Received: from lspinell-mobl1.ger.corp.intel.com ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 05:04:56 -0700
Date:   Mon, 20 Jun 2022 15:04:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
cc:     =?ISO-8859-15?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: Boot stall regression from "printk for 5.19" merge
In-Reply-To: <YrBeXDHAF7vxybyP@alley>
Message-ID: <b49a384d-5558-a9f8-d01e-60c6e5751a8f@linux.intel.com>
References: <20220619204949.50d9154d@thinkpad> <87r13kwawb.fsf@jogness.linutronix.de> <20220620112936.48fcb2a4@thinkpad> <YrBdjVwBOVgLfHyb@alley> <YrBeXDHAF7vxybyP@alley>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-682412862-1655726699=:2433"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-682412862-1655726699=:2433
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 20 Jun 2022, Petr Mladek wrote:

> Resending with Ilpo, driver maintainer, in CC.
> 
> On Mon 2022-06-20 13:44:17, Petr Mladek wrote:
> > On Mon 2022-06-20 11:29:36, Marek Behún wrote:
> > > On Mon, 20 Jun 2022 00:29:16 +0206
> > > John Ogness <john.ogness@linutronix.de> wrote:
> > > > On 2022-06-19, Marek Behún <kabel@kernel.org> wrote:
> > > > > causes a regression on arm64 (Marvell CN9130-CRB board) where the
> > > > > system boot freezes in most cases (and is unusable until restarted by
> > > > > watchdog), or, in some cases boots, but the console output gets mangled
> > > > > for a while (the serial console spits garbage characters).  
> > > 
> > > attaching bootlogs and config.
> > 
> > This is the log when the system booted:
> > 
> > > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd083]
> > > [    0.000000] Linux version 5.19.0-rc2-00410-g9776fe0f424b (kabel@dellmb) (aarch64-unknown-linux-gnu-gcc (Gentoo Hardened 10.3.1_p20211126 p0) 10.3.1 20211126, GNU ld (Gentoo 2.37_p1 p2) 2.37) #491 SMP Mon Jun 20 11:00:54 CEST 2022
> > > [    0.000000] Machine model: Marvell Armada CN9130-CRB-B
> > > [    0.000000] earlycon: uart8250 at MMIO32 0x00000000f0512000 (options '')
> > > [    0.000000] printk: bootconsole [uart8250] enabled
> > 
> > Early console enabled.
> > 
> > > [    0.000000] NUMA: No NUMA configuration found
> > [...]
> > > [    0.062565] rcu: Hierarchical SRCU implementation.
> > > [    0.062589] printk: bootconsole [uart8250] printing thread started
> > 
> > The early console started being handled by the kthread.
> > 
> > > [    0.073843] smp: Bringing up secondary CPUs ...
> > > [    0.074238] Detected PIPT I-cache on CPU1
> > [...]
> > > [    1.067359] io scheduler kyber registered
> > > [    1.120214] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
> > > [    1.120577] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
> > > [    1.137980] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
> > > [    1.166562] printk:[ console [ttyS0] printing thread started
> > >  [    1.166564] printk: console [ttyS0] enabled
> > 
> > 2nd console was added using the properly initialized serial port.
> > It should use the same physical port as the early console.
> > 
> > Both early console and proper console driver has its own kthread.
> > 
> > >    1.166486] f0512000.serial: ttyS0 at MMIO 0xf0512000 (irq = 22, base_baud = 12500000) is a 16550A
> > 
> > The line is malformed. I wonder if both early console and proper
> > console used the same port in parallel.
> > 
> > > [    1.166567] printk: bootconsole [uart8250] disabled
> > > [    1.185422] printk: bootconsole [uart8250] printing thread stopped
> > 
> > The early console was disabled. Only the properly initialized serial
> > console is used. All should be fine now.
> > 
> > 
> > > [    1.188773] brd: module loaded
> > > [    1.190567] loop: module loaded
> > [...]
> > > [    5.316958] Freeing unused kernel memory: 2752K
> > > [    5.364349] Run /sbin/init as init process
> > 
> > And I did not catch any further problem.
> > 
> > So, it looks like that con->write() code is not correctly serialized
> > between the early and normal console.
> > 
> > 
> > Now, let's see the last lines of failing logs:
> > 
> > 
> > > [    1.071214] io scheduler kyber registered
> > > [    1.124272] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
> > > [
> > 
> > > [    1.067314] io scheduler kyber registered
> > > [    1.120226] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
> > > [    1.120603] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
> > > [    1.137975] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
> > > [    1.138248] mv_xor_v2 f0420000.xor: Marvell Version 2 XOR driver
> > > [    1.
> > 
> > > [    1.067214] io scheduler kyber registered
> > > [    1.120098] armada-ap806-pinctrl f06f4000.system-controller:pinctrl: registered pinctrl driver
> > > [    1.120466] armada-cp110-pinctrl f2440000.system-controller:pinctrl: registered pinctrl driver
> > > [    1.137871] mv_xor_v2 f0400000.xor: Marvell Version 2 XOR driver
> > > [    1.138160] mv_xor_v2 f0420000.xor: Marvell Version 2 XOR driver
> > > [
> > 
> > All three logs end in the middle of a line. If you compare it with the
> > "working" log then the end 1-3 lines before the normal console was added.
> > 
> > The console output might is delayed because of the threads. Most
> > likely, the output ended when both early and normal console driver
> > started to use the same port.
> > 
> > I am going to check the driver...

Perhaps try reverting 8f3631f0f6eb ("serial/8250: Use fifo in 8250 
console driver") if there's yet another unexplored corner hit.

-- 
 i.

--8323329-682412862-1655726699=:2433--

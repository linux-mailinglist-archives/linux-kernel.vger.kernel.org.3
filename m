Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9102C4DADFE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355046AbiCPKAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350398AbiCPKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:00:11 -0400
X-Greylist: delayed 441 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Mar 2022 02:58:57 PDT
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CE38764BE7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:58:57 -0700 (PDT)
Received: (qmail 5861 invoked from network); 16 Mar 2022 09:51:35 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 16 Mar 2022 09:51:35 -0000
Received: (nullmailer pid 4066 invoked by uid 1000);
        Wed, 16 Mar 2022 09:51:35 -0000
Date:   Wed, 16 Mar 2022 09:51:35 +0000
From:   Jamie Heilman <jamie@audible.transient.net>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: system locks up with CONFIG_SLS=Y; 5.17.0-rc
Message-ID: <YjGzJwjrvxg5YZ0Z@audible.transient.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been (somewhat unsuccessfully) trying to bisect a hard lock-up
of my workstation that occurs when I'm running 5.17 rc kernels a few
seconds after I start a kvm guest instance.  There is no output to
any log, everything locks up completely, sysrq doesn't even work
anymore.  As bisection progressed closer and closer to the branch
where straight-line-speculation mitigation was enabled, and as bisect
landing me between 9cdbeec40968 ("x86/entry_32: Fix segment exceptions")
and 3411506550b1 ("x86/csum: Rewrite/optimize csum_partial()") wasn't
resulting in clear results (my system definately starts Oopsing and
gets so hosed up that I'm forced to reboot, but it isn't quite as dire
as sysrq continues to function) I decided to just try a build with
CONFIG_SLS disabled, and it turns out that works just fine.  Sooo...

This system uses a Intel Core2 Duo E8400 processor.
working config (CONFIG_SLS=N) and dmesg at:
http://audible.transient.net/~jamie/k/sls.config-5.17.0-rc8
http://audible.transient.net/~jamie/k/sls.dmesg

(I don't think the dmesg of CONFIG_SLS=Y is really any different.)

As far as I know the guest kernel I hand to qemu doesn't really
matter, but the gist of my qemu command line is:

qemu-system-x86_64 -m 2048 -name "$NAME" -machine pc,accel=kvm \
    -nographic -no-user-config -nodefaults -boot strict=on \
    -rtc base=utc -smp 1,sockets=1,cores=1,threads=1 \
    -chardev pipe,id=char0,path="$DIR/monitor" \
    -chardev pty,id=char1 \
    -device isa-serial,chardev=char1 \
    -device virtio-blk-pci,drive=blk0,bootindex=1 \
    -device virtio-net-pci,netdev=net0,"mac=$IF_MAC" \
    -device virtio-rng-pci,rng=rng0,max-bytes=1024,period=3000 \
    -drive "id=blk0,file=/dev/S/$NAME,if=none,format=raw,cache=none" \
    -mon chardev=char0,id=monitor,mode=control \
    -netdev "tap,id=net0,ifname=$NAME,script=no,downscript=no" \
    -object rng-random,id=rng0,filename=/dev/random


No clue what additional debugging would help to enable here, if
anything.  As you can see from the dmesg, I'm using gcc 11.2.0 from
Debian unstable, 4:11.2.0-2 to be exact.  Let me know what other
information would be useful.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

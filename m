Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9453671C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354467AbiE0Stg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbiE0Stc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:49:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756AF33A29
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9votgmhHpYorQPAJ5lxeWrrs6HhZXSCpoG+A+4NC6uY=; b=oSl/PUPJCsf94A/Qb2wk4PSlSj
        /2UZaMKBOaocKb0n/ODfWUK4Xq4BTSvj262Ucpc6JURv2a/f3RWdNlZbi4JE9n288caO3afIrJ8bm
        kjfhZQQTAS+t6Yi2dlvnKbtifILCeWAtiQPiaCIn2NgpJCxN4l6T4lF/reNSgQNvCBEK3i1BNWl1a
        eECAqQIdaThKcCMpSAZhRdMtGVe3SL9sMMHQygfhmkf4yqnYj2+2NKUXYQsX/HnWIZh28ZN0nJxPn
        rQE000np8WEVDXx7pTPpbi/+NSaWezi4x55YEI6xj3cBYH6ImKHx4codOe3uw1WUiENWir+8f7x4U
        E5MeMe3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuf1Q-000mnT-GK; Fri, 27 May 2022 18:49:16 +0000
Date:   Fri, 27 May 2022 11:49:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Vincent Blut <vincent.debian@free.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Fehlig <jfehlig@suse.com>,
        Dan =?utf-8?B?xIxlcm3DoWs=?= <dcermak@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        David Gow <davidgow@google.com>, Arnd Bergmann <arnd@arndb.de>,
        mcgrof@kernel.org
Subject: [kdevops reboot-limit] x86-64 kernel stalls 1/10,000 reboots
 v5.17-rc7
Message-ID: <YpEdLOB+iWdjrTts@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When one is putting effort into automation on running fstests or
blktests on a guest many times over and over again often one can run
into odd failures from the guest not coming up. To rule out distro bugs
(dhcp, dnsmasq, libvirt) from a basic reboot I put together a test which
is now part of kdevops which simply reboots the guest as many times as
you want. I call this test a reboot-limit test.

The current default simple test will try to reboot the guest 100 times.
The concept of a "test steady state" is defined as repeating the test
successfully a number of times and is useful for non-deterministic tests
or test suites. So if a test steady state is 50 then with this test, the
test steady state would be acheived with 500 successful reboots.

From my experience in automation with fstests and blktests (both full of
*some* undeterministic tests) I strive to pick test steady state goal
which will keep a system busy for about 1 week. Higher steady state
goals beyond this are possible but one should work our way up gradually.
So by default today I have kdevops with a default steady state goal of
100 for reboot-limit and this takes about 1 week to complete 10,000
reboots.

Around 2021-09-08 debian-testing on linux-next worked flawlessly and I had
achieved about 1 million reboots, which gave me confidence that if other
distro / kernel combinations had issues the issue lied elsewhere and it
could be reported.

The first reported bug based on this test was for OpenSUSE [0] and those
issues are still under investigation.

Move to today and I see now a failure on debian-testing on the guest, with
debian-testing also on the host but with kernel 5.16.0-6-amd64 on the
host. The first issue is reported already [1] and has an easy temporary fix
which I came up with:

--- /etc/network/if-up.d/chrony.old	2022-05-24 16:40:53.112439882
+0000
+++ /etc/network/if-up.d/chrony	2022-05-24 16:41:23.452471796 +0000
@@ -5,6 +5,7 @@
 [ -x /usr/sbin/chronyd ] || exit 0
  
   if [ -e /run/chrony/chronyd.pid ]; then
   +    systemctl is-system-running --wait
        chronyc onoffline > /dev/null 2>&1
fi

With that applied and when using v5.17-rc7 you end up with a failed
reboot stall on the shutdown side of things after perhaps some odd
complaints by the kernel. The stall ends up with:

[  OK  ] Stopped System Logging Service.
[  OK  ] Stopped Unattended Upgrades Shutdown.
[  OK  ] Stopped Regular background program processing daemon.
[  OK  ] Stopped Getty on tty1.
[  OK  ] Stopped Serial Getty on ttyS0.
[   16.148956] __common_interrupt: 5.33 No irq handler for vector

I don't see the issue present when using the distro kernel
5.17.0-1-amd64, and with v5.10.105, so I will increase the steady state
there from 100 to 10000 so to aim for 1 million reboots next.  Since the
failure on v5.17-rc7 happened on reboot number 8,919 it means it could
very well be that the test can still fail on v5.17 vanilla, or upstream,
the failure rate may just be really really low, like 1/10,000.

In so far as v5.17-rc7 I've taken time do do my own analysis of this on
korg#216040 [2] so far, however since this is reproducible, I figured
I'd let others know and let others experiment to see what they get as
well.

Any ideas?

PS. It would be good to get this sort of simple test running on perhaps
uml and other architectures.

[0] https://bugzilla.opensuse.org/show_bug.cgi?id=1190632
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1011533
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216040

  Luis

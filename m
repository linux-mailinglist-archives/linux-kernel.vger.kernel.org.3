Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA29481043
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 07:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbhL2GUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 01:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbhL2GUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 01:20:09 -0500
X-Greylist: delayed 1137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Dec 2021 22:20:08 PST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 22:20:08 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2S1A-00FYol-8j; Wed, 29 Dec 2021 06:00:56 +0000
Date:   Wed, 29 Dec 2021 06:00:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Duyck <alexanderduyck@fb.com>,
        linux-um@lists.infradead.org
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
Message-ID: <Ycv5mF+gfGxlmmQL@zeniv-ca.linux.org.uk>
References: <202111180219.YkyoBMpf-lkp@intel.com>
 <CANn89iJfh+x-s4GtWJcyRFpMmSvvyq-r1TGV4sDLXy3F50zD6w@mail.gmail.com>
 <CANn89iJj4zeNUiXCmG=rSejbHAwPhBEPKUv1tPL9ig=e4vg7pQ@mail.gmail.com>
 <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZZ4upqWGMOY+r56@hirez.programming.kicks-ass.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 05:00:58PM +0100, Peter Zijlstra wrote:

> Dear um folks, is this indeed the best solution? It's a bit sad to have
> to add this to x86_64, but if that's the way it is...

Something like this, perhaps? (absolutely untested)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index e5a7b552bb384..a58b67ec8119d 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -23,7 +23,6 @@ generic-y += softirq_stack.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += word-at-a-time.h
 generic-y += kprobes.h
 generic-y += mm_hooks.h
 generic-y += vga.h
diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index 95d26a69088b1..a812cc35092c6 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,6 +9,7 @@ endmenu
 config UML_X86
 	def_bool y
 	select GENERIC_FIND_FIRST_BIT
+	select DCACHE_WORD_ACCESS
 
 config 64BIT
 	bool "64-bit kernel" if "$(SUBARCH)" = "x86"

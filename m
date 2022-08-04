Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D560589ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbiHDLHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiHDLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:06:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6253554C8C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:06:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1803D20F0A;
        Thu,  4 Aug 2022 11:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659611216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=lbPlKb7LwIvqYjwNMTxprCTKeZtWQl8xE8bU1BIQY5U=;
        b=r4hKx3BMLI7nVPbXvonJNlAm07BOikvS6qiLlpcKBMq0l6WV0pvIc5U/fYWHmhP9UdkJsj
        9oquS43xaH8Yhed6KFViFYDTeUVQg1sEOusDajRfFM+tBFa8ef4xGsQ4FBaTUGKrW2QqBy
        Ia5PlXZ2kHHbj00ig0DLpWJ2UUWgbOA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 89F382C141;
        Thu,  4 Aug 2022 11:06:55 +0000 (UTC)
Date:   Thu, 4 Aug 2022 13:06:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 5.20 (sane changes)
Message-ID: <YuuoT1n6cosaVoiF@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the latest and only sane printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.20-sane

==================================

- Allow to read kernel log in gdb even on 32 bits systems.

- More granular check of the buffer usage in printf selftest.

- Clang warning fix.

==================================

I am going to be even more transparent when there is anything controversial
and discuss it in advance.

----------------------------------------------------------------
Antonio Borneo (1):
      scripts/gdb: fix 'lx-dmesg' on 32 bits arch

Justin Stitt (1):
      lib/test_printf.c: fix clang -Wformat warnings

Rasmus Villemoes (1):
      lib/test_printf.c: split write-beyond-buffer check in two

 lib/test_printf.c          | 21 +++++++++++++++++----
 scripts/gdb/linux/dmesg.py |  9 +++------
 scripts/gdb/linux/utils.py | 14 ++++++++++++--
 3 files changed, 32 insertions(+), 12 deletions(-)

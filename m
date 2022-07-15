Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E455766CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 20:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiGOSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiGOSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 14:34:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96FD12D33
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 11:34:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8E1AD200D9;
        Fri, 15 Jul 2022 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657910055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=WTuW+7pySv2mjnvZPDaFyWvMrGPz00ceUXfdENQm05M=;
        b=e9s34Ix4huMzITijFglCxZ1MvWSjRs76ErU3q/NpmnBXTgbscqiXomTeJL0lVqjqMyOH7k
        2XG6B5CGQEhCdIVttBfoCMDEkRoLWWPz3JmKaNr+mRbqfboNjLh31fZHG6kbBhdes/ZRMT
        wJigatkkuf2JObmaXrokJfSPugq3Pw8=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37F672C141;
        Fri, 15 Jul 2022 18:34:15 +0000 (UTC)
Date:   Fri, 15 Jul 2022 20:34:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk fixup for 5.19-rc7
Message-ID: <YtGzI9tWpB2wpioB@alley>
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

please pull a printk fixup

git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.19-rc7

======================================

- Make pr_flush() fast when consoles are suspended.

======================================

pr_flush() was added together with the printk kthreads but it
makes sense on its own. This is why we kept it. It is pity
that the regression was found this late. But it is trivial
to fix.

----------------------------------------------------------------
John Ogness (1):
      printk: do not wait for consoles when suspended

Petr Mladek (1):
      Merge branch 'rework/kthreads' into for-linus

 kernel/printk/printk.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

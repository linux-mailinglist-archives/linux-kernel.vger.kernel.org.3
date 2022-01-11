Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C776548AF92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiAKObA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:31:00 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiAKOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:30:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BEFE91F37C;
        Tue, 11 Jan 2022 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641911457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Ms7JVezFSGFwH18aEA0TBRHZ8O4jg8TI2v2Ol+GrE+A=;
        b=isz3MIq9V73JN5jzut6/hHxTdV5oX2J1bWYP+ERJJ1M9dHCubaCRZwCFOAZ/zsyb+S7K0D
        E0bgaQQ9K6l2ka0NX7p4CqQBuRfXRYyPYMxUK+lrBjaO2MreT2mAvtYHAg2Mcw7WMtajOn
        1pH5hOEaI4Q8b9RMkrcz+3Uo7csaymA=
Received: from alley.suse.cz (unknown [10.100.224.162])
        by relay2.suse.de (Postfix) with ESMTP id 1238EA3B89;
        Tue, 11 Jan 2022 14:30:56 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Down <chris@chrisdown.name>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Scull <ascull@google.com>,
        Will Deacon <will@kernel.org>, Jason Baron <jbaron@akamai.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [RFC 0/2] printk: Remove cyclic include dependencies with printk.h
Date:   Tue, 11 Jan 2022 15:30:44 +0100
Message-Id: <20220111143046.14680-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"make headerdep" reports two cycles where printk.h is involved. Both are
a bit complicated. All involved headers provide inlined functions that
have to be inlined because they add caller-specific metadata.

There are several possible solutions:

1. Ignore the problem because the cycles do not cause any real problem
   at the moment. I would say that it works by chance. See the patches
   for more details.


2. Move the printk-calls from the headers into .c sources so that printk.h
   is included in .c instead of .h. It is relatively easy except that it
   makes the code a bit more complicated.


3. Use a simple declaration somewhere. It is problematic because
   the inlined functions are more complex.

   But printk() is complex because it adds metadata for the list
   of strings in /sys/kernel/debug/printk/index. The index already misses
   a lot of strings that are printed via some subsystem specific wrappers.
   It should be acceptable to miss the few strings used in the affected
   headers.


This patchset implements the 3rd solution. It does not complicate
the existing code. It is quite the opposite. It splits the long
printk.h. It puts some low-level definitions into separate printk_core.h.
The lightweight header file might be useful also in other situations.

What do you think, please?

Petr Mladek (2):
  printk/dynamic_debug: Remove cyclic dependency between printk.h and
    dynamic_debug.h
  printk/bug: Remove cyclic dependency between bug.h and printk.h

 MAINTAINERS                   |  1 +
 include/asm-generic/bug.h     |  4 +-
 include/linux/dynamic_debug.h | 10 ++--
 include/linux/printk.h        | 68 +--------------------------
 include/linux/printk_core.h   | 87 +++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+), 74 deletions(-)
 create mode 100644 include/linux/printk_core.h

-- 
2.26.2


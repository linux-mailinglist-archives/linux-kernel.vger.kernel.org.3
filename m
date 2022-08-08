Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA8058C1B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiHHCmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiHHClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9221BA
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cAZQycysCODqFhAu/M10j6by0BGm4a/NlhRQ+Q5eoj4=; b=kVe3wxN5qiwYa2COGvtzkB7svP
        SvsHylhLVA8LahVABjWTQ/wcqRgghuYrGDjAEvLY7OMnlQxY3URnKLE/PQvUWnLX/LgS60TAyH3pa
        JytOCgBE9SRdw/5o/lldxTSgrf7KljtUj/r2BFDgiXZPT0nDO0OsSHDz+/nygDEdxEZy2q8cZS7s+
        +b79LwWyszyGZAvmjxlU16DvoP+1oBCls8ztUj757gYQ8jp0FvwHN4OXO+hqQIGTfNALRgNPKOaMx
        slyWs3uuTmCPj6xK6cx4/qF5K2Vic0RbfxkNEb66qubClBl9XqSrXrkubuG0cdVC3I24Z4FDt1EVG
        1gQz/XWg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshw-00DVRN-I4; Mon, 08 Aug 2022 02:41:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH v5 00/32] Printbufs
Date:   Mon,  8 Aug 2022 03:40:56 +0100
Message-Id: <20220808024128.3219082-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[all this code is from Kent, I'm helping him out because he's having
trouble with git send-email and OAUTH]

This should (hopefully) be the final iteration of this patch series.

Previous discussion:
https://lore.kernel.org/linux-mm/20220620004233.3805-1-kent.overstreet@gmail.com/

Changes since v4:

 - %pf(%p) format extension has been dropped for now, since it turned out to be
   a bit controversial. I think we're going to want it, but I'm leaving it for a
   future patch series.
 - There was a small off by one error in the patch converting
   trace_events_synth. The original code using seq_buf had to calculate the size
   of the string to allocate; since printbufs have native support for heap
   allocating strings, the version of the patch in this series just uses that
   for a nice cleanup.

What are printbufs, and why?
============================

Printbufs are like the existing seq_buf, with some differences and new features:

 - Heap allocation (optional)
   
   Currently, we have no standard mechanism for printing to a heap-allocated
   string: code that needs to do this must calculate the size of the buffer to
   allocate, which is tedious and error prone. IOW, this is a major ergonomic
   improvement.

 - Indent level

   Any time we're printing structured multi-line data, proper indenting makes
   the output considerably more readable. Printbufs have state for the current
   indent level, controlled by printbuf_indent_add() and printbuf_indent_sub()
   and obeyed by prt_newline().

   In the future this may work with just \n, pending work to do this without
   performance regressions.

 - Tab stops

   Printing reports with nicely aligned columns is something we do a _lot_, and
   printbufs make this a lot easier. After setting tabstops (byte offsets from
   start of line), prt_tab() will output spaces up to the next tabstop, and
   pr_tab_rjust() will right justify output since the previous output against
   the next tabstap. 

   In the future this may work with just \t, pending work to do this without
   performance regressions.

Why a new data structure, instead of extending seq_buf?
=======================================================

Some semantic changes were required. The main ones were:

 - printbufs have different overflow semantics vs. seq_buf, to support
   snprintf() which is required to return the number of characters that were
   written even when an empty buffer is passed 

 - seq_buf has a readpos member which printbuf drops, since it's only for
   tracing.

Also, a number of the existing seq_buf users were converted to printbuf's heap
allocation functionality, replacing open coded string size calculations and
allocations.

Given all this, adding the new thing and converting existing users one by one
felt like the more incremental/bisectable approach.

Goals of this patch series:
===========================

 - A unified API for functions that output strings (i.e. pretty printers).

   Currently, we've got a bit of a mess of different calling conventions for
   functions that output strings. There's sprintf/snprintf style, seq_buf, and
   various other variations of passing raw character pointers around.

 - Low level helpers for building up strings (prt_char(), prt_str(), etc.).

   This replaces a _lot_ of low level pointer arithmetic in vsprintf.c, and
   elsewhere, with proper helpers.

 - Cleanup of pretty-printers in vsprintf.c

   Currently, we have a lot of pretty-printers in vsprintf.c invoked by various
   %p extensions. However, arguments to those pretty printers are passed as
   additional format string characters, instead of normal function arguments,
   and we have the code that decodes format strings mixed with pretty-printer
   code, which is not great for readability and makes those pretty-printers
   unnecessarily tied to vsprintf.c internal details.

   One of my goals is to give those pretty-printers normal function call
   interfaces, and separate out the format-string parsing: this patch series
   does some of the prep work. I've got more patches in progress in that vein,
   but this patch series is big enough as is so I'm leaving them for later.

Kent Overstreet (32):
  lib/printbuf: New data structure for printing strings
  lib/string_helpers: Convert string_escape_mem() to printbuf
  vsprintf: Convert to printbuf
  lib/hexdump: Convert to printbuf
  lib/string_helpers: string_get_size() now returns characters wrote
  lib/printbuf: Heap allocation
  lib/printbuf: Tabstops, indenting
  lib/printbuf: Unit specifiers
  vsprintf: Improve number()
  vsprintf: prt_u64_minwidth(), prt_u64()
  test_printf: Drop requirement that sprintf not write past nul
  vsprintf: Start consolidating printf_spec handling
  vsprintf: Refactor resource_string()
  vsprintf: Refactor fourcc_string()
  vsprintf: Refactor ip_addr_string()
  vsprintf: Refactor mac_address_string()
  vsprintf: time_and_date() no longer takes printf_spec
  vsprintf: flags_string() no longer takes printf_spec
  vsprintf: Refactor device_node_string, fwnode_string
  vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
  Input/joystick/analog: Convert from seq_buf -> printbuf
  mm/memcontrol.c: Convert to printbuf
  clk: tegra: bpmp: Convert to printbuf
  tools/testing/nvdimm: Convert to printbuf
  powerpc: Convert to printbuf
  x86/resctrl: Convert to printbuf
  PCI/P2PDMA: Convert to printbuf
  tracing: trace_events_synth: Convert to printbuf
  d_path: prt_path()
  ACPI/APEI: Add missing include
  tracing: Convert to printbuf
  Delete seq_buf

 arch/powerpc/kernel/process.c             |   16 +-
 arch/powerpc/kernel/security.c            |   75 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   34 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |   16 +-
 drivers/acpi/apei/erst-dbg.c              |    1 +
 drivers/clk/tegra/clk-bpmp.c              |   21 +-
 drivers/input/joystick/analog.c           |   23 +-
 drivers/pci/p2pdma.c                      |   21 +-
 fs/d_path.c                               |   35 +
 include/linux/dcache.h                    |    1 +
 include/linux/kernel.h                    |   12 +
 include/linux/printbuf.h                  |  257 ++++
 include/linux/seq_buf.h                   |  162 --
 include/linux/string.h                    |    5 +
 include/linux/string_helpers.h            |    8 +-
 include/linux/trace_events.h              |    2 +-
 include/linux/trace_seq.h                 |   17 +-
 kernel/trace/trace.c                      |   45 +-
 kernel/trace/trace_dynevent.c             |   34 +-
 kernel/trace/trace_events_filter.c        |    2 +-
 kernel/trace/trace_events_synth.c         |   53 +-
 kernel/trace/trace_functions_graph.c      |    6 +-
 kernel/trace/trace_kprobe.c               |    2 +-
 kernel/trace/trace_seq.c                  |  111 +-
 lib/Makefile                              |    4 +-
 lib/hexdump.c                             |  246 ++--
 lib/printbuf.c                            |  258 ++++
 lib/seq_buf.c                             |  397 -----
 lib/string_helpers.c                      |  224 +--
 lib/test_hexdump.c                        |   30 +-
 lib/test_printf.c                         |    6 -
 lib/vsprintf.c                            | 1640 ++++++++++-----------
 mm/memcontrol.c                           |   54 +-
 tools/testing/nvdimm/test/ndtest.c        |   22 +-
 34 files changed, 1855 insertions(+), 1985 deletions(-)
 create mode 100644 include/linux/printbuf.h
 delete mode 100644 include/linux/seq_buf.h
 create mode 100644 lib/printbuf.c
 delete mode 100644 lib/seq_buf.c

-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2089550E20
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbiFTAmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiFTAmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:42:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FCDA187
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:37 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 43so14017844qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9dQ6/5I6Ax505mazhuw1Ffh+ePc0tjQgjDBMimjh8o=;
        b=CXxqJhfz4MfvCvDwPElTtqA/7CfxEoUx/4j41luaiyXTTW+Myif81Lvncz79doq7RV
         4wLfLJVJX4CbV97/vJP+bBE+yfEAKR9tAZxRaiLHJ4aM5+helq7OvYwN+lrqbvRBxhsp
         JZOoJgDPZZPqNkis4sOqZLpSgiWwoXz7hyHmkRmU6U9oFT1mKp3wd9Rz0QQLybc9uVYQ
         hAlcW+CbaADICAKtljdE298GAi166keI1fb8+crSHbkwzP9UMaGpN6EWeQlXsvuHaVUs
         jf2pdZ3vBUYaqoImJiMtRzEXa4q7wwf60wTfBBoV8hKdcQjlveYmHswzby1zdsrDOfkw
         2Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9dQ6/5I6Ax505mazhuw1Ffh+ePc0tjQgjDBMimjh8o=;
        b=hhPVTrQTjygcyUEi+HgXLAkg0qKCCrCFhM/JWLvgQ6f8KZMwD2CaMZtMj8cpnJS3w6
         n7Oxn9gIHV7/6O9G/ixocmkwSccvvDa+vXFvKsKSd0DkWSopNGKk5jxPSCWbVDTDpBs8
         PWooTkvAEcXpFTsq4rAkMKq24L8LfsZmesuZtyyg80VPXDaIhBx5euh3ZA24mHwNvST/
         u4gnre55pyUMFHsPs4Zt4Ts1/fHRpfqv2XjoEu503YcuL1Ro6SsTjn9y3zYAHbXeZiJT
         byD/E+boQtClV4KIdDs7kW/LlKlw9ZQVmDDJ+pfSUWAHEhSH892LCZ/cjn78vA17JS1a
         U3Ow==
X-Gm-Message-State: AJIora+98NrIpEfUmXxOsUU6diWg7e6J+8maN4c4GDTYIi6gOu7qStZ4
        pr3v+6bbGTu8VvgIW+0NGHLgTpa251FOtAM=
X-Google-Smtp-Source: AGRyM1vIWFMh9tYneqSwqWtx8vMubJTJJqtNl6QLXelNliQ8VAGPbTAojpbaay/Jn9iWxGxbukwyGg==
X-Received: by 2002:a05:622a:1649:b0:306:6a7b:2c22 with SMTP id y9-20020a05622a164900b003066a7b2c22mr17970894qtj.66.1655685755990;
        Sun, 19 Jun 2022 17:42:35 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a400400b006a6d4261f40sm12185580qko.111.2022.06.19.17.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:35 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 00/34] Printbufs - new data structure for building strings
Date:   Sun, 19 Jun 2022 20:41:59 -0400
Message-Id: <20220620004233.3805-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous discussions:
https://lore.kernel.org/all/20220419203202.2670193-1-kent.overstreet@gmail.com/
https://lore.kernel.org/all/20220519172421.162394-1-kent.overstreet@gmail.com/
https://lore.kernel.org/all/20220604193042.1674951-1-kent.overstreet@gmail.com/

Git repo:
https://evilpiepirate.org/git/bcachefs.git/log/?h=printbuf_v4

Changes since v3:
  Bugfixes and performance improvements, the latest iteration of this patch
  series has been baking in the bcachefs tree and that shook out some bugs.

  Rasmus pointed out that -fno-strict-aliasing is going to cause gcc to generate
  nasty code, and indeed it unfortunately does but according to worst case
  scenario microbenchmarks it's not a problem for actual performance. Using
  memcpy() and memset() in the printbuf helpers _was_ a problem for performance,
  so that's been fixed.

-----------

Core idea: Wouldn't it be nice if we had a common data structure and calling
convention for outputting strings?

The core concept this patch series is aimed at cleaning up and standardizing is
that of a "pretty-printer", which is now a function like prt_foo() or
foo_to_text():

    void foo_to_text(struct printbuf *out, struct foo)

What this patch series does or enables:

 - It becomes quite a bit easier to write composable pretty printers! This is
   huge.

 - A ton of code that works in terms of raw char * pointers and lengths
   (snprintf style, and many weird variations) gets cleaned up, with error prone
   raw pointers arithmetic replaced by proper helpers

 - A ton of code that emits either directly via printk() or to other places
   (sysfs, debugfs) can now output to printbufs, and becomes more reusable and
   composable

 - Countesy of Matthew Wilcox, the new and very cool %pf() format string, which
   allows passing a pretty printer function and its arguments to sprintf() and
   family. This means we can now call type specific pretty-printers without
   adding them to lib/vsprintf.c and writing a bunch of crazy
   parsing-and-dispatch code. For example,

     printk("%pd", dentry);

   becomes

     printk("%pf(%p)", prt_dentry, dentry);

   My OOM debugging & reporting patch series that builds off of this uses this
   to solve a very real problem that Michal Hocko brought up at LSF - with this
   we write shrinkers_to_text(), slab_to_text() which can _also_ now be used for
   reporting in debugfs (which Roman has been working on), as well as in the
   show_mem() report - the "%pf()" syntax lets us print the output of those
   functions without allocating (and having to preallocate) a separate buffer.

 - Some new formatting helpers:
   
   Nicely aligned text is much easier to read, and something that we want a
   _lot, but outputting nicely aligned text with printf() is a pain in the ass.
   Printbufs add tabstops, which can be used for right or left justification -
   simple, easy. prt_tab() emits spaces up to the next tabstop, prt_tab_rjust()
   advances to the next tabstop right justifying text since the previous
   tabstop.

   Printbufs also add an indent level, obeyed by prt_newline() which can be very
   useful for multi line output.

   In the future, \n and \t in format strings may learn to obey these as well.

 - Optional heap allocation - no need to statically allocate buffers on the
   stack and guess at the output size.

 - Lots of consolidating and refactoring
   
   This series replaces seq_buf, which does basically what an earlier version of
   printbufs did.

   A good chunk of lib/string_helpers.c, as well as lib/hexdump.c are converted
   (and simplified!).

   Pretty printers in lib/vsprintf.c previously outputted to buffers on the
   stack and then copied _that_ to the actual output buffer, that's all gone
   (replaced by proper helpers for outputting chars and strings), and they also
   used printf_spec for argument passing in ad-hoc ways. This patch series does
   a lot towards converting them to more standard pretty printers that can be
   called via %pf() instead of having to live in lib/vsprintf.c. Still to do:
   format string decoding for argument passing is a mess that's scattered all
   over the place.

In the course of working on this patch series, I've spotted a _lot_ more
consolidation and refactoring that needs to be done - we've got a ton of API
fragmentation leading to lots of code duplication.

But I'm already really excited about what this patch series enables.

Cheers!

Kent Overstreet (34):
  lib/printbuf: New data structure for printing strings
  lib/string_helpers: Convert string_escape_mem() to printbuf
  vsprintf: Convert to printbuf
  lib/hexdump: Convert to printbuf
  vsprintf: %pf(%p)
  lib/string_helpers: string_get_size() now returns characters wrote
  lib/printbuf: Heap allocation
  lib/printbuf: Tabstops, indenting
  lib/printbuf: Unit specifiers
  lib/pretty-printers: prt_string_option(), prt_bitflags()
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

 Documentation/core-api/printk-formats.rst |   22 +
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
 include/linux/pretty-printers.h           |   10 +
 include/linux/printbuf.h                  |  253 +++
 include/linux/seq_buf.h                   |  162 --
 include/linux/string.h                    |    5 +
 include/linux/string_helpers.h            |    8 +-
 include/linux/trace_events.h              |    2 +-
 include/linux/trace_seq.h                 |   17 +-
 kernel/trace/trace.c                      |   45 +-
 kernel/trace/trace_dynevent.c             |   34 +-
 kernel/trace/trace_events_filter.c        |    2 +-
 kernel/trace/trace_events_synth.c         |   32 +-
 kernel/trace/trace_functions_graph.c      |    6 +-
 kernel/trace/trace_kprobe.c               |    2 +-
 kernel/trace/trace_seq.c                  |  111 +-
 lib/Makefile                              |    4 +-
 lib/hexdump.c                             |  246 +--
 lib/pretty-printers.c                     |   60 +
 lib/printbuf.c                            |  253 +++
 lib/seq_buf.c                             |  397 -----
 lib/string_helpers.c                      |  224 +--
 lib/test_hexdump.c                        |   30 +-
 lib/test_printf.c                         |   33 +-
 lib/vsprintf.c                            | 1723 ++++++++++-----------
 mm/memcontrol.c                           |   68 +-
 tools/testing/nvdimm/test/ndtest.c        |   22 +-
 37 files changed, 2050 insertions(+), 1976 deletions(-)
 create mode 100644 include/linux/pretty-printers.h
 create mode 100644 include/linux/printbuf.h
 delete mode 100644 include/linux/seq_buf.h
 create mode 100644 lib/pretty-printers.c
 create mode 100644 lib/printbuf.c
 delete mode 100644 lib/seq_buf.c

-- 
2.36.1


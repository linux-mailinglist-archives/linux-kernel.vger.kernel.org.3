Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1980852DB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiESRY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbiESRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE52AA30A1;
        Thu, 19 May 2022 10:24:30 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id a9so3631596pgv.12;
        Thu, 19 May 2022 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heShdPjUkQ8+JBgX4tOJfq2w1VNjC+2A7g0K5jxFZ4M=;
        b=Sx1hc/wWJXW5FtKMwAcLPWO/DjI1leftUZIfPeJsDBP89EwPamQfnqfxOMyPrKUUUW
         Wl0c7n8o690wAIt0amZp9etLHpgAoIlwD+y40MymMKB+3+9hCXGyznalVmgeJvRVJ3D+
         vtCutaXZ5RBx+cbMPnanwXB9b+4gzi94nHfol5IDCFUc2GD2qr73gA1pXplv+qgXlT8a
         lD1j0gSry7GAB9toeh/0ozAwTo5mLKi7MHfi19+fwRT5aReLXW25uVZUk8uD1VXc5hVx
         JwuI6zuHZZYbZ85TAvqqYbP94xCnaEFsm5MoPrWMzq6P9B1PjqxdWdLK25B2Q+iGgrO5
         uxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=heShdPjUkQ8+JBgX4tOJfq2w1VNjC+2A7g0K5jxFZ4M=;
        b=xixO6yKu/uSvtFeyQ1432cf1fhIWmGiSZ3yY6LXKwcHJPDD7TW2GPL0yrJDZm7Zmfs
         1EpcpAU+K9z8a+MfAqyYVRyxe7i4xtUVQsWH9xlhGgpuSbxyMlG6bxO/xgGQzb3XvEq+
         xFQ46kilgTOYFlDO3gMvEo1K6a6nBWPrcgqAT+TIFcm/mwCdhslfK0EmCzG5c2DrrQNE
         cy3UAzlhxFC4qlUAuDr7poQwfQaYsxoxgzw0B6agjB7YXy3x/rldtYjZkmelwDZHAui5
         djgVcH1VHRevyl+pNpNWu/yfbbuYnBDcA/efdX4FjS8rALomQU3Kl8DWVhzml3QibOKe
         Sq4A==
X-Gm-Message-State: AOAM531OGcO3xLHC4W+8uY2HP3RIOgk2BmpGYxg+9B4GQNh+6oZrMVM+
        waY6TN74jE5uioQm3/zqOpBynQXgxDqj
X-Google-Smtp-Source: ABdhPJyDo9PNyo1VcJOEXA6NT8QYwgusA2ly6GSoKqMUuAsmEH3FY+vrrsIzqKnshcYrIolyTav2Fg==
X-Received: by 2002:a63:f91a:0:b0:3f2:8963:78c4 with SMTP id h26-20020a63f91a000000b003f2896378c4mr4688519pgi.593.1652981069848;
        Thu, 19 May 2022 10:24:29 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:28 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 00/28] Printbufs (now with more printbufs!)
Date:   Thu, 19 May 2022 13:23:53 -0400
Message-Id: <20220519172421.162394-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
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

So there's a lot of new stuff since the first posting:

 - Printbufs have been broken up into multiple patches that each add distinct
   functionality - this is intended to make it easier to review and to see
   what's used for what

 - Printbufs now support both auto-heap allocated buffers, and external/static
   buffers: this was required for the vsprintf.c refactoring, and means they're
   (almost) a direct replacement for seq_buf

 - The big thing: a new %pf(%p) format string extension for calling pretty
   printers from printf (idea from Matthew Wilcox)

   This is intended to replace most of our other format string extensions: e.g.
   instead of writing
     printf("%pg", bdev);

   You'd now write
     printf("%pf(%p)", bdev_name, bdev);

   The advantage of this is that pretty printers no longer have to live in
   lib/vsprintf.c, and they're much more discoverable - you can cscope to the
   pretty printer!

   And my hope is that this will help induce people to write lots more pretty
   printers; since they can now live with the code they're printing and don't
   require touching code in vsprintf.c, there's less friction to creating new
   ones.

   We hope to standardize this extension as %(%p), but since gcc's printf format
   checking doesn't yet understand that we're going with %pf(%p) for now.

   Currently, we only support pointer arguments to pretty-printers. I think we
   can improve this in the future to support at least integer arguments as well,
   i.e. "%(%u)" will eventually work. This will require using libffi to do it
   correctly, but it looks like libffi is nearly suitable for in kernel use (it
   supports all linux architectures, and configured with the features we want it
   compiles down to practically nothing).

 - Massive vsprintf.c refactoring

   printbufs are now the core data structure used by vsprintf.c - we're not
   passing around a bunch of raw char pointers anymore! yay!

   This gets us a sane standard calling convention for pretty printers - i.e.,
   we need this for %pf(%p).

   Couple notes on the refactoring:

   - printf_spec has become a dumping ground of state, passed everywhere and
     used inconsistently. The refactoring attempts to improve this, and
     centralize printf_spec handling as much as possible near/in the top level
     code that handles format strings. Some %p extensions use
     field/width/precision in nonstandard ways; the refactoring patches make it
     clearer where this is going on.

   - a _lot_ of pretty printers were allocating secondary buffers on the stack,
     mainly to avoid ever writing past the terminating null in the output
     buffer. There was a test that checked for this, but it had no documentation
     where the requirement came from nor does that requirement make any sense,
     so I deleted it (if anyone knows anything about it, speak up!). The code
     now takes the approach of just writing to the output buffer and then
     truncating afterwards if required by the precision argument.

     Yay, less stack usage!

   - format string parsing is still a mess: I'd like to consolidate that to only
     happen in one place, but that's going to be a much more involved
     refactoring - and if we just switch to new-style calling pretty printers
     directly, we'll be able to just delete all that code.

 - More seq_buf conversions

   Using printbufs to clean up vsprintf.c meant adding a second, non
   heap-allocated mode, so printbufs now do almost everything seq_buf does -
   seq_buf has a read_pos member for some reason (tracing?) that I didn't get
   into.

   So now seq_buf is just used by the tracing code, and that can also probably
   be converted to printbuf, but seq_buf is Steven's thing so I'll let him take
   a look before getting into that.

Kent Overstreet (28):
  lib/printbuf: New data structure for printing strings
  vsprintf: Convert to printbuf
  vsprintf: %pf(%p)
  lib/string_helpers: string_get_size() now returns characters wrote
  lib/printbuf: Heap allocation
  lib/printbuf: Tabstops, indenting
  lib/printbuf: Unit specifiers
  lib/pretty-printers: pr_string_option(), pr_bitflags()
  vsprintf: Improve number()
  vsprintf: pr_u64_minwidth(), pr_u64()
  vsprintf: Lift pr_hex_bytes() out from hex_string()
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

 Documentation/core-api/printk-formats.rst |   19 +
 arch/powerpc/kernel/process.c             |   16 +-
 arch/powerpc/kernel/security.c            |   75 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   34 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |   16 +-
 drivers/clk/tegra/clk-bpmp.c              |   21 +-
 drivers/input/joystick/analog.c           |   37 +-
 drivers/pci/p2pdma.c                      |   17 +-
 include/linux/kernel.h                    |    4 +
 include/linux/pretty-printers.h           |   11 +
 include/linux/printbuf.h                  |  225 +++
 include/linux/string_helpers.h            |    8 +-
 lib/Makefile                              |    2 +-
 lib/pretty-printers.c                     |   81 ++
 lib/printbuf.c                            |  252 ++++
 lib/string_helpers.c                      |   18 +-
 lib/test_printf.c                         |   23 +-
 lib/vsprintf.c                            | 1612 ++++++++++-----------
 mm/memcontrol.c                           |   68 +-
 tools/testing/nvdimm/test/ndtest.c        |   22 +-
 20 files changed, 1527 insertions(+), 1034 deletions(-)
 create mode 100644 include/linux/pretty-printers.h
 create mode 100644 include/linux/printbuf.h
 create mode 100644 lib/pretty-printers.c
 create mode 100644 lib/printbuf.c

-- 
2.36.0


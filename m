Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADD53D846
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiFDTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiFDTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:30:52 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D022518
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:30:51 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a184so4813982qkg.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6G1DFAvxmzl+wISIcuzYI9FASO1J+ClitdEYqbU0B9A=;
        b=gxFjT7iIcuvO101svbLnG991pgCh+FCdR6UP4jzDB0BctuR0JRiv0ID9izKUI4FD5U
         NAchjTub3+IiL1r37HhTqUmPvVwMHMHqYoDpswEKdtdZS2MI7YN8Y54mvPsmiq/mJ6gy
         VeJ3Dz0/Q2FkV285+5BmHRgqvqsjWbshO3v2e0vdJWGdwhRNkZhvzd/d9PKQnqgs/gGb
         w9vMGBYXPkPhhqBVI7KiWVk4CvAoZz88Fhs8edhkcud4h6qbYbF+QruW7Dk39mdl/aJd
         PNNmi2eoH0aH+7UlZJ8MG9zV7MKSwnsv/tuVNPPlFL8TpWQTvCPTq3z/drr0SqFG+9Xy
         QtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6G1DFAvxmzl+wISIcuzYI9FASO1J+ClitdEYqbU0B9A=;
        b=U1/DCKJFT9ZoEAcLgHUf3tKMp/lMPxoVtRjXEoQ6UZvUgyNDg32ARW1eA/FNnO7ppU
         bD4UduByG/L7Bo7fB4RgDqfmQWXPZJhvlV284ILGe0hMxpgjQEQNK/CRuKBE3ZxnqzCS
         NaaAI/8xrovU5TebcckIvejC1RbeG6HzwrFdj+N4ngyxUr7UpnT2oNIvtBq4A7iDg/cO
         H7LiBKftCvJcPE8vHtRh5Rtpn6qPkqlInbjQ36nIt0smWpPBq5/6EnGgQdCEOaLK6043
         zDeaH1oYJxukBq1a+1jtp0/wqd4/TWWqLwxxREcGLlXuyY9RPB/AHtABjXmBeBLxYbOp
         qyrA==
X-Gm-Message-State: AOAM530YxXXRrXq24pPLVjrYmkWglV0ZJPCmkli9jR0iVemXV3SZCDy+
        Yo1oG3uDX5lxBQW4C9EIbA5O/82ck8n+
X-Google-Smtp-Source: ABdhPJy0y6g3VJwycW9B3LO+fLxzKbjqnJAlg0CHMa7UdRSEz0DurbJ2Zcfhn74PDfyeEM7JiaShiw==
X-Received: by 2002:a37:614a:0:b0:6a6:af3b:e9cb with SMTP id v71-20020a37614a000000b006a6af3be9cbmr2121720qkb.744.1654371049514;
        Sat, 04 Jun 2022 12:30:49 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:30:48 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 00/33] Printbufs
Date:   Sat,  4 Jun 2022 15:30:09 -0400
Message-Id: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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

Printbufs, your new data structure for all your string-building and outputting
needs!

git repo: https://evilpiepirate.org/git/bcachefs.git/log/?h=printbuf_v3

Benefits:
 - Replaces passing & returning raw char * pointers and lengths in a ton of
   places, including especially vsprintf.c, with a much saner calling convention
 - New helpers which greatly simplify and cleanup aforementioned vsprintf.c
 - New standard calling convention/naming for pretty printers!
 - New printf format string - %pf(%p) - for calling pretty printers by passing
   them to sprintf instead of sticking them in vsprintf.c behind weird dispatch
   code
 - printbufs can auto-heap allocate! No need for statically sized buffers,
   unless you want to do that
 - Tabstops and indenting, for greatly improved formatting of multi-line output

...and probably more that I've forgotten to mention.

Changes since last patche:

New namespace prefixes:
-----------------------

We're not overloading pr_* anymore: any standard library code that outputs to a
printbuf should use the prt_ prefix. This is not for printbuf control code -
that uses the printbuf_ prefix; prt_ is just for things that print.

string_escape_mem():
--------------------

string_escape_mem() has now been properly converted to printbufs instead of just
adding a printbuf-style wrapper; the new printbuf helpers simplify that code
quite a bit.

hexdump:
--------

The hexdump code has been converted to printbuf and also reorganized and cleaned
up quite a bit, with better naming too. We now have
 - prt_hex_bytes(), for printing a few hex bytes, with optional grouping
 - prt_hex_line(), for printing a whole line of hex output with ascii characters
   at the end
 - prt_hex_dump(), for printing a whole multiline hex dump

Important behaviour change:

Previously, the hex dump code would _byte swap the output on little endian_.
Since this is not exactly standard behaviour for a hex dumper (binutils doesn't
do this), and is confusing as hell if you're trying to map byte offsets in
structs to your hex output, I've dropped it. Since we only use the hex dumper in
debug output, nothing should break, but to avoid confusion I've put this front
and center in the commit message for that patch.

tracing:
--------

This iteration of the patch series finally converts tracing to printbufs, which
is the last seq_buf user and that code is now also deleted. The tracing
conversion was pretty uneventful, not much to say here (except that it had its
own unique implementation of hex dumping with byte swabbing on little endian;
this is now replaced with just a call to prt_hex_bytes()).

Kent Overstreet (33):
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
  tracing: Convert to printbuf
  Delete seq_buf

 Documentation/core-api/printk-formats.rst |   22 +
 arch/powerpc/kernel/process.c             |   16 +-
 arch/powerpc/kernel/security.c            |   75 +-
 arch/powerpc/platforms/pseries/papr_scm.c |   34 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |   16 +-
 drivers/clk/tegra/clk-bpmp.c              |   21 +-
 drivers/input/joystick/analog.c           |   23 +-
 drivers/pci/p2pdma.c                      |   17 +-
 fs/d_path.c                               |   34 +
 include/linux/dcache.h                    |    1 +
 include/linux/kernel.h                    |   12 +
 include/linux/pretty-printers.h           |   10 +
 include/linux/printbuf.h                  |  245 +++
 include/linux/seq_buf.h                   |  162 --
 include/linux/string.h                    |    5 +
 include/linux/string_helpers.h            |    8 +-
 include/linux/trace_events.h              |    2 +-
 include/linux/trace_seq.h                 |   14 +-
 kernel/trace/trace.c                      |   45 +-
 kernel/trace/trace_dynevent.c             |   34 +-
 kernel/trace/trace_events_filter.c        |    2 +-
 kernel/trace/trace_events_synth.c         |   32 +-
 kernel/trace/trace_functions_graph.c      |    6 +-
 kernel/trace/trace_kprobe.c               |    2 +-
 kernel/trace/trace_seq.c                  |  111 +-
 lib/Makefile                              |    4 +-
 lib/hexdump.c                             |  246 +--
 lib/pretty-printers.c                     |   59 +
 lib/printbuf.c                            |  252 +++
 lib/seq_buf.c                             |  397 -----
 lib/string_helpers.c                      |  141 +-
 lib/test_hexdump.c                        |   30 +-
 lib/test_printf.c                         |   26 +-
 lib/vsprintf.c                            | 1716 ++++++++++-----------
 mm/memcontrol.c                           |   68 +-
 tools/testing/nvdimm/test/ndtest.c        |   22 +-
 36 files changed, 1943 insertions(+), 1967 deletions(-)
 create mode 100644 include/linux/pretty-printers.h
 create mode 100644 include/linux/printbuf.h
 delete mode 100644 include/linux/seq_buf.h
 create mode 100644 lib/pretty-printers.c
 create mode 100644 lib/printbuf.c
 delete mode 100644 lib/seq_buf.c

-- 
2.36.0


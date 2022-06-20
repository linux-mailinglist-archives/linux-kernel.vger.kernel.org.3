Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87EF550F30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiFTETl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Jun 2022 00:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiFTETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:19:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22CC295BB
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:19:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-xc5O7tanPo2ikZ1Vp4r_Kw-1; Mon, 20 Jun 2022 05:19:34 +0100
X-MC-Unique: xc5O7tanPo2ikZ1Vp4r_Kw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.36; Mon, 20 Jun 2022 05:19:31 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.036; Mon, 20 Jun 2022 05:19:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "pmladek@suse.com" <pmladek@suse.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "enozhatsky@chromium.org" <enozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Thread-Topic: [PATCH v4 00/34] Printbufs - new data structure for building
 strings
Thread-Index: AQHYhD6oUJ9HZdIC7US1XHhH4yp3Qa1XsEIg
Date:   Mon, 20 Jun 2022 04:19:31 +0000
Message-ID: <0a5901f8460f452a89c9b0cda32fb833@AcuMS.aculab.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet
> Sent: 20 June 2022 01:42
> 
> Previous discussions:
> https://lore.kernel.org/all/20220419203202.2670193-1-kent.overstreet@gmail.com/
> https://lore.kernel.org/all/20220519172421.162394-1-kent.overstreet@gmail.com/
> https://lore.kernel.org/all/20220604193042.1674951-1-kent.overstreet@gmail.com/
> 
> Git repo:
> https://evilpiepirate.org/git/bcachefs.git/log/?h=printbuf_v4
> 
> Changes since v3:
>   Bugfixes and performance improvements, the latest iteration of this patch
>   series has been baking in the bcachefs tree and that shook out some bugs.
> 
>   Rasmus pointed out that -fno-strict-aliasing is going to cause gcc to generate
>   nasty code, and indeed it unfortunately does but according to worst case
>   scenario microbenchmarks it's not a problem for actual performance.

Just copy some of the structure members to local variables
and, if necessary, write them back at the end.

> Using
>   memcpy() and memset() in the printbuf helpers _was_ a problem for performance,
>   so that's been fixed.
> 
> -----------
> 
> Core idea: Wouldn't it be nice if we had a common data structure and calling
> convention for outputting strings?
> 
> The core concept this patch series is aimed at cleaning up and standardizing is
> that of a "pretty-printer", which is now a function like prt_foo() or
> foo_to_text():
> 
>     void foo_to_text(struct printbuf *out, struct foo)
> 
> What this patch series does or enables:
> 
>  - It becomes quite a bit easier to write composable pretty printers! This is
>    huge.
> 
>  - A ton of code that works in terms of raw char * pointers and lengths
>    (snprintf style, and many weird variations) gets cleaned up, with error prone
>    raw pointers arithmetic replaced by proper helpers
> 
>  - A ton of code that emits either directly via printk() or to other places
>    (sysfs, debugfs) can now output to printbufs, and becomes more reusable and
>    composable
> 
>  - Countesy of Matthew Wilcox, the new and very cool %pf() format string, which
>    allows passing a pretty printer function and its arguments to sprintf() and
>    family. This means we can now call type specific pretty-printers without
>    adding them to lib/vsprintf.c and writing a bunch of crazy
>    parsing-and-dispatch code. For example,
> 
>      printk("%pd", dentry);
> 
>    becomes
> 
>      printk("%pf(%p)", prt_dentry, dentry);
> 
>    My OOM debugging & reporting patch series that builds off of this uses this
>    to solve a very real problem that Michal Hocko brought up at LSF - with this
>    we write shrinkers_to_text(), slab_to_text() which can _also_ now be used for
>    reporting in debugfs (which Roman has been working on), as well as in the
>    show_mem() report - the "%pf()" syntax lets us print the output of those
>    functions without allocating (and having to preallocate) a separate buffer.

I really think that is a bad idea.
printk() already uses a lot of stack, anything doing a recursive
call is just making that worse.
Especially since these calls can often be in error paths
which are not often tested and can already be on deep stacks.

	David

> 
>  - Some new formatting helpers:
> 
>    Nicely aligned text is much easier to read, and something that we want a
>    _lot, but outputting nicely aligned text with printf() is a pain in the ass.
>    Printbufs add tabstops, which can be used for right or left justification -
>    simple, easy. prt_tab() emits spaces up to the next tabstop, prt_tab_rjust()
>    advances to the next tabstop right justifying text since the previous
>    tabstop.
> 
>    Printbufs also add an indent level, obeyed by prt_newline() which can be very
>    useful for multi line output.
> 
>    In the future, \n and \t in format strings may learn to obey these as well.
> 
>  - Optional heap allocation - no need to statically allocate buffers on the
>    stack and guess at the output size.
> 
>  - Lots of consolidating and refactoring
> 
>    This series replaces seq_buf, which does basically what an earlier version of
>    printbufs did.
> 
>    A good chunk of lib/string_helpers.c, as well as lib/hexdump.c are converted
>    (and simplified!).
> 
>    Pretty printers in lib/vsprintf.c previously outputted to buffers on the
>    stack and then copied _that_ to the actual output buffer, that's all gone
>    (replaced by proper helpers for outputting chars and strings), and they also
>    used printf_spec for argument passing in ad-hoc ways. This patch series does
>    a lot towards converting them to more standard pretty printers that can be
>    called via %pf() instead of having to live in lib/vsprintf.c. Still to do:
>    format string decoding for argument passing is a mess that's scattered all
>    over the place.
> 
> In the course of working on this patch series, I've spotted a _lot_ more
> consolidation and refactoring that needs to be done - we've got a ton of API
> fragmentation leading to lots of code duplication.
> 
> But I'm already really excited about what this patch series enables.
> 
> Cheers!
> 
> Kent Overstreet (34):
>   lib/printbuf: New data structure for printing strings
>   lib/string_helpers: Convert string_escape_mem() to printbuf
>   vsprintf: Convert to printbuf
>   lib/hexdump: Convert to printbuf
>   vsprintf: %pf(%p)
>   lib/string_helpers: string_get_size() now returns characters wrote
>   lib/printbuf: Heap allocation
>   lib/printbuf: Tabstops, indenting
>   lib/printbuf: Unit specifiers
>   lib/pretty-printers: prt_string_option(), prt_bitflags()
>   vsprintf: Improve number()
>   vsprintf: prt_u64_minwidth(), prt_u64()
>   test_printf: Drop requirement that sprintf not write past nul
>   vsprintf: Start consolidating printf_spec handling
>   vsprintf: Refactor resource_string()
>   vsprintf: Refactor fourcc_string()
>   vsprintf: Refactor ip_addr_string()
>   vsprintf: Refactor mac_address_string()
>   vsprintf: time_and_date() no longer takes printf_spec
>   vsprintf: flags_string() no longer takes printf_spec
>   vsprintf: Refactor device_node_string, fwnode_string
>   vsprintf: Refactor hex_string, bitmap_string_list, bitmap_string
>   Input/joystick/analog: Convert from seq_buf -> printbuf
>   mm/memcontrol.c: Convert to printbuf
>   clk: tegra: bpmp: Convert to printbuf
>   tools/testing/nvdimm: Convert to printbuf
>   powerpc: Convert to printbuf
>   x86/resctrl: Convert to printbuf
>   PCI/P2PDMA: Convert to printbuf
>   tracing: trace_events_synth: Convert to printbuf
>   d_path: prt_path()
>   ACPI/APEI: Add missing include
>   tracing: Convert to printbuf
>   Delete seq_buf
> 
>  Documentation/core-api/printk-formats.rst |   22 +
>  arch/powerpc/kernel/process.c             |   16 +-
>  arch/powerpc/kernel/security.c            |   75 +-
>  arch/powerpc/platforms/pseries/papr_scm.c |   34 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |   16 +-
>  drivers/acpi/apei/erst-dbg.c              |    1 +
>  drivers/clk/tegra/clk-bpmp.c              |   21 +-
>  drivers/input/joystick/analog.c           |   23 +-
>  drivers/pci/p2pdma.c                      |   21 +-
>  fs/d_path.c                               |   35 +
>  include/linux/dcache.h                    |    1 +
>  include/linux/kernel.h                    |   12 +
>  include/linux/pretty-printers.h           |   10 +
>  include/linux/printbuf.h                  |  253 +++
>  include/linux/seq_buf.h                   |  162 --
>  include/linux/string.h                    |    5 +
>  include/linux/string_helpers.h            |    8 +-
>  include/linux/trace_events.h              |    2 +-
>  include/linux/trace_seq.h                 |   17 +-
>  kernel/trace/trace.c                      |   45 +-
>  kernel/trace/trace_dynevent.c             |   34 +-
>  kernel/trace/trace_events_filter.c        |    2 +-
>  kernel/trace/trace_events_synth.c         |   32 +-
>  kernel/trace/trace_functions_graph.c      |    6 +-
>  kernel/trace/trace_kprobe.c               |    2 +-
>  kernel/trace/trace_seq.c                  |  111 +-
>  lib/Makefile                              |    4 +-
>  lib/hexdump.c                             |  246 +--
>  lib/pretty-printers.c                     |   60 +
>  lib/printbuf.c                            |  253 +++
>  lib/seq_buf.c                             |  397 -----
>  lib/string_helpers.c                      |  224 +--
>  lib/test_hexdump.c                        |   30 +-
>  lib/test_printf.c                         |   33 +-
>  lib/vsprintf.c                            | 1723 ++++++++++-----------
>  mm/memcontrol.c                           |   68 +-
>  tools/testing/nvdimm/test/ndtest.c        |   22 +-
>  37 files changed, 2050 insertions(+), 1976 deletions(-)
>  create mode 100644 include/linux/pretty-printers.h
>  create mode 100644 include/linux/printbuf.h
>  delete mode 100644 include/linux/seq_buf.h
>  create mode 100644 lib/pretty-printers.c
>  create mode 100644 lib/printbuf.c
>  delete mode 100644 lib/seq_buf.c
> 
> --
> 2.36.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


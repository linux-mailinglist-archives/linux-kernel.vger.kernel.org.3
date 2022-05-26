Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFA534C66
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiEZJRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiEZJRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:17:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF02C6E4C
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:17:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r71so936081pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=RCgUh5Lq8QPmTMiRgC0qjo8EnHunxrcEa1VXXIDed4s=;
        b=SNsVYqh2bpGXL6+XRcWO7v15rBAOUUDbH0ElMOaa0mQKLxAN2zPaFWhF7tPDGlWDe5
         w9cGGFZrf1KBwLEZ09p9vdHxaijfWIweXIR9bwUYHaingiUI+aAaSASt/2BNFbxUBCty
         jB19LifKy9aYwya2O3lEXmV7GOnIpWvcZdzGuNEFDMZIDv2qDwjA47MWD3Hc6HdJ68mb
         cagkJfKI62Od+so6/JhFk/VvKaAPhGcQ7/msrn0WRyq3H+UUERFPZ7VwRtWjWVh2gX4j
         3X/sUWy8BwU5xIIqmyeDtHQhdv/wILJ9loMcULskKHOhjEA56cGf2QB699/QPeqdJjfy
         BnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RCgUh5Lq8QPmTMiRgC0qjo8EnHunxrcEa1VXXIDed4s=;
        b=w1A6S4icl9bHup3risJh/ECDHZ3G1gtKc0Yy8VdzF5WVtDf8qpDggU6UO0RglVYtXy
         WfMLlMw3gv0yBlR50EkkdJUvVEFcqoQH9viSPJvBjoOW60jZr0c22+TH7JGpkI44888A
         Z7dEPJakNW3wEMT1Jl+vHMLkIlB349uVUxAdDE181VTrH1NmeV0Y0mUKnvOQsl0BQr85
         uD5SiV0G1aaVG6qsycShGVvWysNaCkcXpLtVXgGWt6yOkeQEh/RghfkosiyJ4aaGNHT6
         UGnTpuE8I/wa4HeLTkN5CNBcFug4ltHYxzdDx1X9yoVDW5t0yNxtM/dAz2evRJx/D0XO
         Sw1Q==
X-Gm-Message-State: AOAM532SIfcaMydh7AYIWDNa6nGyql7qh2k6o6MeI9rRChqqxtepSR5U
        Pgr57wfT8IrkHd3SkI9ijY0=
X-Google-Smtp-Source: ABdhPJxeftYE4Os0sLEuAQ/sB303gmPy587QszBwr5+LDbuh9IUtwDmEwduwMULLbXIr9i+2Z7E75A==
X-Received: by 2002:a05:6a00:21c8:b0:4c4:4bd:dc17 with SMTP id t8-20020a056a0021c800b004c404bddc17mr37569856pfj.57.1653556639659;
        Thu, 26 May 2022 02:17:19 -0700 (PDT)
Received: from localhost (subs02-180-214-232-6.three.co.id. [180.214.232.6])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7900f000000b00518ebba4462sm923204pfo.119.2022.05.26.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 02:17:18 -0700 (PDT)
Date:   Thu, 26 May 2022 16:17:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Howells <dhowells@redhat.com>
Subject: dangling pointer to '__str' error on ppc64_defconfig, GCC 12.1.0
Message-ID: <Yo9Fm/hdtac1t9sW@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Attempting to build ppc64_defconfig kernel with powerpc64-unknown-linux-gnu
(GCC 12.1.0) on v5.18, I got build error on ftrace.o:

  CC      arch/powerpc/kernel/trace/ftrace.o
  CC      init/init_task.o
In file included from ./include/asm-generic/bug.h:22,
                 from ./arch/powerpc/include/asm/bug.h:156,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:13,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:55,
                 from arch/powerpc/kernel/trace/ftrace.c:16:
arch/powerpc/kernel/trace/ftrace.c: In function 'ftrace_modify_code':
./include/linux/printk.h:446:44: error: using a dangling pointer to '__str' [-Werror=dangling-pointer=]
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                                            ^
./include/linux/printk.h:418:17: note: in definition of macro 'printk_index_wrap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                 ^~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:75:17: note: in expansion of macro 'pr_err'
   75 |                 pr_err("%p: replaced (%s) != old (%s)",
      |                 ^~~~~~
In file included from ./arch/powerpc/include/asm/code-patching.h:14,
                 from arch/powerpc/kernel/trace/ftrace.c:26:
./arch/powerpc/include/asm/inst.h:156:14: note: '__str' declared here
  156 |         char __str[PPC_INST_STR_LEN];   \
      |              ^~~~~
./include/linux/printk.h:418:33: note: in expansion of macro 'ppc_inst_as_str'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:75:17: note: in expansion of macro 'pr_err'
   75 |                 pr_err("%p: replaced (%s) != old (%s)",
      |                 ^~~~~~
arch/powerpc/kernel/trace/ftrace.c: In function '__ftrace_make_nop_kernel':
./include/linux/printk.h:446:44: error: using a dangling pointer to '__str' [-Werror=dangling-pointer=]
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                                            ^
./include/linux/printk.h:418:17: note: in definition of macro 'printk_index_wrap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                 ^~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:379:17: note: in expansion of macro 'pr_err'
  379 |                 pr_err("Not expected bl: opcode is %s\n", ppc_inst_as_str(op));
      |                 ^~~~~~
./arch/powerpc/include/asm/inst.h:156:14: note: '__str' declared here
  156 |         char __str[PPC_INST_STR_LEN];   \
      |              ^~~~~
./include/linux/printk.h:418:33: note: in expansion of macro 'ppc_inst_as_str'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:379:17: note: in expansion of macro 'pr_err'
  379 |                 pr_err("Not expected bl: opcode is %s\n", ppc_inst_as_str(op));
      |                 ^~~~~~
arch/powerpc/kernel/trace/ftrace.c: In function '__ftrace_make_call_kernel':
./include/linux/printk.h:446:44: error: using a dangling pointer to '__str' [-Werror=dangling-pointer=]
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                                            ^
./include/linux/printk.h:418:17: note: in definition of macro 'printk_index_wrap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                 ^~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:638:17: note: in expansion of macro 'pr_err'
  638 |                 pr_err("Unexpected call sequence at %p: %s\n", ip, ppc_inst_as_str(op));
      |                 ^~~~~~
./arch/powerpc/include/asm/inst.h:156:14: note: '__str' declared here
  156 |         char __str[PPC_INST_STR_LEN];   \
      |              ^~~~~
./include/linux/printk.h:418:33: note: in expansion of macro 'ppc_inst_as_str'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:638:17: note: in expansion of macro 'pr_err'
  638 |                 pr_err("Unexpected call sequence at %p: %s\n", ip, ppc_inst_as_str(op));
      |                 ^~~~~~
arch/powerpc/kernel/trace/ftrace.c: In function '__ftrace_make_nop':
./include/linux/printk.h:446:44: error: using a dangling pointer to '__str' [-Werror=dangling-pointer=]
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                                            ^
./include/linux/printk.h:418:17: note: in definition of macro 'printk_index_wrap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                 ^~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:205:17: note: in expansion of macro 'pr_err'
  205 |                 pr_err("Expected %08lx found %s\n", PPC_INST_LD_TOC, ppc_inst_as_str(op));
      |                 ^~~~~~
./arch/powerpc/include/asm/inst.h:156:14: note: '__str' declared here
  156 |         char __str[PPC_INST_STR_LEN];   \
      |              ^~~~~
./include/linux/printk.h:418:33: note: in expansion of macro 'ppc_inst_as_str'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:205:17: note: in expansion of macro 'pr_err'
  205 |                 pr_err("Expected %08lx found %s\n", PPC_INST_LD_TOC, ppc_inst_as_str(op));
      |                 ^~~~~~
./include/linux/printk.h:446:44: error: using a dangling pointer to '__str' [-Werror=dangling-pointer=]
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                                            ^
./include/linux/printk.h:418:17: note: in definition of macro 'printk_index_wrap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                 ^~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:139:17: note: in expansion of macro 'pr_err'
  139 |                 pr_err("Not expected bl: opcode is %s\n", ppc_inst_as_str(op));
      |                 ^~~~~~
./arch/powerpc/include/asm/inst.h:156:14: note: '__str' declared here
  156 |         char __str[PPC_INST_STR_LEN];   \
      |              ^~~~~
./include/linux/printk.h:418:33: note: in expansion of macro 'ppc_inst_as_str'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:139:17: note: in expansion of macro 'pr_err'
  139 |                 pr_err("Not expected bl: opcode is %s\n", ppc_inst_as_str(op));
      |                 ^~~~~~
arch/powerpc/kernel/trace/ftrace.c: In function '__ftrace_make_call':
./include/linux/printk.h:446:44: error: using a dangling pointer to '__str' [-Werror=dangling-pointer=]
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                                            ^
./include/linux/printk.h:418:17: note: in definition of macro 'printk_index_wrap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                 ^~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:506:17: note: in expansion of macro 'pr_err'
  506 |                 pr_err("Unexpected call sequence at %p: %s %s\n",
      |                 ^~~~~~
./arch/powerpc/include/asm/inst.h:156:14: note: '__str' declared here
  156 |         char __str[PPC_INST_STR_LEN];   \
      |              ^~~~~
./include/linux/printk.h:418:33: note: in expansion of macro 'ppc_inst_as_str'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
      |                                 ^~~~~~~~~~~
./include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
  446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
      |                          ^~~~~~~~~~~~~~~~~
./include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
arch/powerpc/kernel/trace/ftrace.c:506:17: note: in expansion of macro 'pr_err'
  506 |                 pr_err("Unexpected call sequence at %p: %s %s\n",
      |                 ^~~~~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:288: arch/powerpc/kernel/trace/ftrace.o] Error 1

I also hit this error on current master (commit babf0bb978e3c9
("Merge tag 'xfs-5.19-for-linus' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux")).

Thanks.

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

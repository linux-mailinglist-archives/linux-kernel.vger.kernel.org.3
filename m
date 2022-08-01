Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1570587161
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 21:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbiHAT2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiHAT2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 15:28:03 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 01 Aug 2022 12:28:01 PDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98983B71
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:28:01 -0700 (PDT)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 74D8E72C90B;
        Mon,  1 Aug 2022 22:20:17 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 40D424A5058;
        Mon,  1 Aug 2022 22:20:17 +0300 (MSK)
Date:   Mon, 1 Aug 2022 22:20:16 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: tools/objtool: check.c:11:10: fatal error: arch/elf.h: No such file
 or directory
Message-ID: <20220801192016.raoab6wtuimosocg@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

git bisect shows that commit b51277eb9775 ("objtool: Ditch subcommands")
included in v5.19 introduces build failure on aarch64 for tools/objtool:

  builder@aarch64:~/linux/tools$ make clean
  builder@aarch64:~/linux/tools$ make objtool
    DESCEND objtool
  make -C /usr/src/linux/tools/build CFLAGS= LDFLAGS= fixdep
    HOSTCC  fixdep.o
    HOSTLD  fixdep-in.o
    LINK    fixdep
  make -C /usr/src/linux/tools/lib/subcmd/ OUTPUT=/usr/src/linux/tools/objtool/
  make -C /usr/src/linux/tools/build CFLAGS= LDFLAGS= /usr/src/linux/tools/objtool/fixdep
    HOSTCC  /usr/src/linux/tools/objtool/fixdep.o
    HOSTLD  /usr/src/linux/tools/objtool/fixdep-in.o
    LINK    /usr/src/linux/tools/objtool/fixdep
    CC      /usr/src/linux/tools/objtool/exec-cmd.o
    CC      /usr/src/linux/tools/objtool/help.o
    CC      /usr/src/linux/tools/objtool/pager.o
    CC      /usr/src/linux/tools/objtool/parse-options.o
    CC      /usr/src/linux/tools/objtool/run-command.o
    CC      /usr/src/linux/tools/objtool/sigchain.o
    CC      /usr/src/linux/tools/objtool/subcmd-config.o
    LD      /usr/src/linux/tools/objtool/libsubcmd-in.o
    AR      /usr/src/linux/tools/objtool/libsubcmd.a
    LD      arch/arm64/objtool-in.o
    CC      weak.o
    CC      check.o
  check.c:11:10: fatal error: arch/elf.h: No such file or directory
     11 | #include <arch/elf.h>
	|          ^~~~~~~~~~~~
  compilation terminated.
  make[2]: *** [/usr/src/linux/tools/build/Makefile.build:97: check.o] Error 1
  make[1]: *** [Makefile:54: objtool-in.o] Error 2
  make: *** [Makefile:73: objtool] Error 2

This is on ALT Linux using gcc-12.

Thanks,


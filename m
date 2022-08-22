Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1327959C049
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 15:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbiHVNMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 09:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiHVNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:12:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B533E2E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 06:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 518B1B811FE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 13:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BF4C433B5;
        Mon, 22 Aug 2022 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661173935;
        bh=SiAIv6X2Q3SDevkUGpEJlAHs0fbikeFuvz77rYEBmLM=;
        h=Date:From:To:Cc:Subject:From;
        b=ZseYsuPxJl4C7J1GlHJnJxCSeS+0xOQmdr/wWirhal2oC8PyOsr5z0KAdTH//V2vY
         MsXvMob8jBLkpE5DnzZi8wquZ7PvsB9qgvURrCg+QKbNcVsbY3CYD7/JIhWHMq9Y1C
         5U/q9dTg6og8NuPUJNtqZ59e1A0xqz82LcdQOvaW/lgmw/G7Msq9gdehWGRxvz4tiM
         sk8AiT3q2fR7Oi3SGZ4aPADfYi7FlZb7sjAXLJeIcDttzT72WakfjBED5vKVSgwt/H
         2vqxMuyxzbFIVFLwSp/qcjs8RFIxlFVp4dHxCMVREpFU9KZ2mA4TwrwdQqfM+CVt1E
         EhEExxIJe2GVQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B2077404A1; Mon, 22 Aug 2022 10:12:12 -0300 (-03)
Date:   Mon, 22 Aug 2022 10:12:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [tools/ breakage] asm goto: eradicate CC_HAS_ASM_GOTO
Message-ID: <YwOArA3ZdI8WtVSU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

	The cset below broke tools/perf/, please either not update
tools/ headers (tools developers will notice the difference when
building tools by means of tools/perf/check-headers.sh and see what
is needed to keep it in sync) or do a 'make tools/all'.

	Someone seems to have sent a fix, I'll take a look.

- Arnaldo

    asm goto: eradicate CC_HAS_ASM_GOTO

    GCC has supported asm goto since 4.5, and Clang has since version 9.0.0.
    The minimum supported versions of these tools for the build according to
    Documentation/process/changes.rst are 5.1 and 11.0.0 respectively.

    Remove the feature detection script, Kconfig option, and clean up some
    fallback code that is no longer supported.

    The removed script was also testing for a GCC specific bug that was
    fixed in the 4.7 release.

    Also remove workarounds for bpftrace using clang older than 9.0.0, since
    other BPF backend fixes are required at this point.

    Link: https://lore.kernel.org/lkml/CAK7LNATSr=BXKfkdW8f-H5VT_w=xBpT2ZQcZ7rm6JfkdE+QnmA@mail.gmail.com/
    Link: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=48637
    Acked-by: Borislav Petkov <bp@suse.de>
    Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
    Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
    Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
    Reviewed-by: Ingo Molnar <mingo@kernel.org>
    Reviewed-by: Nathan Chancellor <nathan@kernel.org>
    Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>


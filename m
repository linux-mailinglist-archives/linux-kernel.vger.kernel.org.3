Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B134F1DA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383421AbiDDVd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379967AbiDDS3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:29:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066CD13F48
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:27:49 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h24so5424885pfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dGtvKHWRRXFlrf1Rt/BvAKG1RHxC0aWz145KvZzrENo=;
        b=nOfZU7x2UnIeCLknzPKi2K2NV/GRMgJqR38o8eG4/fpHwDyU5NLRishBCI8R5tjwOn
         lM/HErpHngCQl4W2rBNP/zSGb6EYTNxwK2jdFtZuROZ8ePSlsVb1j5jwf6CesMV/4gB0
         DwE8KQ9K5lEVfJlTC7Vosrkhd4fNIHxeGuJlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dGtvKHWRRXFlrf1Rt/BvAKG1RHxC0aWz145KvZzrENo=;
        b=mfuAgoZdLz1eowS2TQ028yaSwUacuzT2zd+dLn5ZeeRgKVKts/8soDSTe8gwMAwqwd
         k72cGmaue+GyJW4wgWTsSE3n3FjcDdHbaak7CR+9wqCpg0LTKX+a9SeZ8D6UKmYHpqBj
         249HvJo3AlMqXdJkKcLI82QoSbjX/Uz0wVgcooU2K1TwazKl2dQf9BmH9M7qvEfFsTz8
         BB4bQ0e/xIqkMgifKv5bsu7rD1I0ee6NfX2T4vyVoPDqww9T6z+qvSBzZ5+ovseapZ/4
         zeUzo1g1twZ+Xf5x/nqLqga5Dso3r3sU4UDuCD7CqOCTSlC5Ew9Mq7uXEBpofUglYDOT
         km9A==
X-Gm-Message-State: AOAM533XHXNxvyYqyFFZGdHLdThelAUoLR7O9xYlKiw/OfI3QBUxpOHF
        43Ps48AEeCksQ/2Fbt2HU6zrIQ==
X-Google-Smtp-Source: ABdhPJyEKpYSYX+aJEAUcFsXAVjGdJnhLZ8D24RyP/mW6pNStwMpTRZI+qrEsFPngRZtlTUwPYtkVg==
X-Received: by 2002:a62:1c8d:0:b0:4fa:8dcb:6da2 with SMTP id c135-20020a621c8d000000b004fa8dcb6da2mr885282pfc.19.1649096868412;
        Mon, 04 Apr 2022 11:27:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w79-20020a627b52000000b004fd8d1e5489sm12543463pfc.87.2022.04.04.11.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:27:47 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:27:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: vmlinux.o: warning: objtool: stackleak_erase()+0x35: call to
 ftrace_likely_update() leaves .noinstr.text section
Message-ID: <202204041125.500C28FD8@keescook>
References: <202204042008.sCQbEmVS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204042008.sCQbEmVS-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 04, 2022 at 08:22:33PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3123109284176b1532874591f7c81f3837bbdc17
> commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60 gcc-plugins/stackleak: Use noinstr in favor of notrace
> date:   8 weeks ago
> config: x86_64-randconfig-r012-20220404 (https://download.01.org/0day-ci/archive/20220404/202204042008.sCQbEmVS-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dcb85f85fa6f142aae1fe86f399d4503d49f2b60
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout dcb85f85fa6f142aae1fe86f399d4503d49f2b60
>         # save the config file to linux build tree
>         mkdir build_dir
>         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    vmlinux.o: warning: objtool: __wrgsbase_inactive()+0x26: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __rdgsbase_inactive()+0x23: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: fixup_bad_iret()+0x76: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: noist_exc_debug()+0x3c: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_nmi()+0xaa: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: poke_int3_handler()+0x3e: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_check_crashing_cpu()+0x15: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_start()+0x4e: call to __kcsan_check_access() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_gather_info()+0x5f: call to v8086_mode.constprop.0() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_read_aux()+0x93: call to mca_msr_reg() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: do_machine_check()+0x5f: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: exc_machine_check()+0x8e: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: mce_severity_amd.constprop.0()+0xca: call to mce_severity_amd_smca() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_nmi_enter()+0x45: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_nmi_exit()+0x38: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: enter_from_user_mode()+0x15: call to test_bit() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x1a: call to test_bit() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x15: call to test_bit() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x15: call to test_bit() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: irqentry_exit()+0x28: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: context_tracking_recursion_enter()+0x103: call to ftrace_likely_update() leaves .noinstr.text section
>    vmlinux.o: warning: objtool: __context_tracking_enter()+0x30: call to ftrace_likely_update() leaves .noinstr.text section
> >> vmlinux.o: warning: objtool: stackleak_erase()+0x35: call to ftrace_likely_update() leaves .noinstr.text section

I got CCed on this because of stackleak_erase() triggering, this, but it
appears to be an existing issue for other callers too. It looks like
__branch_check__() shouldn't be emitting ftrace_likely_update() calls
for noinstr functions...

I have no idea how a macro is meant to check for function attributes,
though... :(

-- 
Kees Cook

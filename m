Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB053F20A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 00:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiFFWSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 18:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiFFWR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 18:17:57 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1346D387
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 15:17:55 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59062)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL2o-004rGO-Ko; Mon, 06 Jun 2022 16:17:54 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53764 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nyL2n-006zvT-Nh; Mon, 06 Jun 2022 16:17:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20220606203802.158958-1-brgerst@gmail.com>
Date:   Mon, 06 Jun 2022 17:17:47 -0500
In-Reply-To: <20220606203802.158958-1-brgerst@gmail.com> (Brian Gerst's
        message of "Mon, 6 Jun 2022 16:37:54 -0400")
Message-ID: <87ilpd1lo4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nyL2n-006zvT-Nh;;;mid=<87ilpd1lo4.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19k9RHjFh4Bj2VKT8cIZOyM6JG4gRwQuIw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Brian Gerst <brgerst@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 369 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 10 (2.7%), b_tie_ro: 8 (2.2%), parse: 0.97 (0.3%),
         extract_message_metadata: 13 (3.5%), get_uri_detail_list: 1.43 (0.4%),
         tests_pri_-1000: 17 (4.6%), tests_pri_-950: 1.60 (0.4%),
        tests_pri_-900: 1.15 (0.3%), tests_pri_-90: 82 (22.3%), check_bayes:
        80 (21.8%), b_tokenize: 8 (2.1%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 2.6 (0.7%), b_tok_touch_all: 60 (16.3%), b_finish: 1.07
        (0.3%), tests_pri_0: 230 (62.3%), check_dkim_signature: 0.67 (0.2%),
        check_dkim_adsp: 3.4 (0.9%), poll_dns_idle: 1.38 (0.4%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 8 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/8] x86 signal code cleanups
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:

> The 32-bit signal code has significant differences from 64-bit, and
> those are duplicated for native and compat modes.  This patch series
> merges the 32-bit code into one file, and does some general cleanups
> in the x86 signal code.  There should be no functional changes.

At a quick skim I don't see anything scary in there.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Brian Gerst (8):
>   x86/signal: Remove sig parameter from frame setup functions
>   x86/signal: Remove sigset_t parameter from frame setup functions
>   signal/compat: Remove compat_sigset_t override
>   x86: Remove __USER32_DS
>   x86/signal: Merge get_sigframe()
>   x86/signal: Add ABI prefixes to frame setup functions
>   x86/signal/32: Merge native and compat 32-bit signal code
>   x86/signal/64: Move 64-bit signal code to its own file
>
>  arch/x86/entry/entry_64_compat.S              |   4 +-
>  arch/x86/ia32/Makefile                        |   2 -
>  arch/x86/include/asm/elf.h                    |   4 -
>  arch/x86/include/asm/fpu/signal.h             |   7 -
>  arch/x86/include/asm/segment.h                |   2 +-
>  arch/x86/include/asm/sighandling.h            |   9 +
>  arch/x86/include/asm/signal.h                 |   5 -
>  arch/x86/kernel/Makefile                      |   4 +-
>  arch/x86/kernel/signal.c                      | 654 +-----------------
>  .../ia32_signal.c => kernel/signal_32.c}      | 117 ++--
>  arch/x86/kernel/signal_64.c                   | 383 ++++++++++
>  arch/x86/xen/xen-asm.S                        |   8 +-
>  include/linux/compat.h                        |   2 -
>  include/linux/syscalls.h                      |   2 +
>  14 files changed, 493 insertions(+), 710 deletions(-)
>  rename arch/x86/{ia32/ia32_signal.c => kernel/signal_32.c} (82%)
>  create mode 100644 arch/x86/kernel/signal_64.c

Eric

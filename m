Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDA44AE229
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386002AbiBHTVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353742AbiBHTVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:21:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8EC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644348098; x=1675884098;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=ZmVHMWV+nZoo0GgHBFSRfytCV3O2I02QggHARdArZAE=;
  b=SL0IbheXlYw+X9UJ/6ib6IkrY18DPp0VCqGiYbmr/VE2BxQmgmbxoY4a
   RBBgitXUPguMGVORpubF45X9SdAHJq6vJxWZagBXlS9C0St1oOBUJGLb/
   eRKrBg+glXqOdShoMnNGwL0KaR93BBV1gnK6bpsgWTTYHQkFR1RXcgWn+
   r6KQmJsBpZX51Ateiq2suLSFOkPI7FZJeeqI7vZPF4xQPGwQNfYKM2eVT
   RWo6vDiI6bpFNyegemJucUJIDbINKn/hGqZXceXFgNZeJd2ZqICR7cUox
   nJF5Ng3bDG3AJdQw2fg8qv+aYz96+JV6jAJmjLoI+IO7uJCiQPni1rnrk
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="247864513"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="247864513"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 11:21:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="525670538"
Received: from fjshenx-mobl1.amr.corp.intel.com (HELO [10.209.58.226]) ([10.209.58.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 11:21:37 -0800
Message-ID: <2939ec67-4d27-13bb-e1a5-24fba0ba86c0@intel.com>
Date:   Tue, 8 Feb 2022 11:21:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     syzbot <syzbot+3c0a98026cec79f550a2@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
References: <000000000000b97df105d77d8a9b@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [syzbot] WARNING in fpregs_assert_state_consistent
In-Reply-To: <000000000000b97df105d77d8a9b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/22 00:31, syzbot wrote:
> Call Trace:
>  <TASK>
>  arch_exit_to_user_mode_prepare arch/x86/include/asm/entry-common.h:56 [inline]
>  exit_to_user_mode_prepare+0x57/0x290 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae

Just in case it saves anyone else the trouble...

This is a WARN_ON_FPU() that triggers inside
fpregs_assert_state_consistent() because TIF_NEED_FPU_LOAD is clear
while !fpregs_state_valid().

In other words, the FPU registers are *in*valid, but they're also not
marked to be reloaded.  They must be valid before returning to userspace.

The stack trace is not very helpful because it's almost empty on the
return to userspace.

I don't see anything x86-FPU-specific between 5.17-rc2 and the
linux-next commit in question.

I think we need to wait on a reproducer or a more revealing warning.

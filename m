Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD08148A8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348694AbiAKHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:49:37 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:42753 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235837AbiAKHth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:49:37 -0500
Received: from [192.168.0.5] (ip5f5aed25.dynamic.kabel-deutschland.de [95.90.237.37])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 936B761EA191E;
        Tue, 11 Jan 2022 08:49:34 +0100 (CET)
Message-ID: <94e48fcd-1dbd-ebd2-4c91-f39941735909@molgen.mpg.de>
Date:   Tue, 11 Jan 2022 08:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: kmemleak detects leak in msr_build_context
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Running Linux from commit bf4eebf8cfa2 (Merge tag 
'linux-kselftest-kunit-5.17-rc1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest), 
kmemleak reported the leak below:

```
unreferenced object 0xffff8914823de500 (size 64):
   comm "swapper/0", pid 1, jiffies 4294667581 (age 1253.406s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 04 10 01 c0 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<000000007f3b05e9>] __kmalloc+0x177/0x330
     [<0000000008104cca>] msr_build_context.constprop.0+0x32/0xbe
     [<00000000012bab4e>] msr_save_cpuid_features+0x28/0x2f
     [<00000000b7a2262e>] pm_check_save_msr+0x2e/0x40
     [<00000000cbe9d92d>] do_one_initcall+0x44/0x200
     [<0000000094deab7b>] kernel_init_freeable+0x1fc/0x273
     [<00000000d3dbaa56>] kernel_init+0x16/0x160
     [<0000000058c4a8b3>] ret_from_fork+0x22/0x30
```


Kind regards,

Paul

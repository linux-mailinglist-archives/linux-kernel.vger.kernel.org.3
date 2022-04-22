Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87D50C406
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbiDVWgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiDVWgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:36:31 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7FC22A7A3;
        Fri, 22 Apr 2022 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650664295; x=1682200295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0gVXv4zdiE+5GYP0dMIQyiSfQoI7LTDt1AyL2vYRv9g=;
  b=FUI0vUUZ7ml3FNftD5DjEsnJxUZmaunyt3MIV2AIYRrQw/o1nFLBBZx6
   Pr+niM46uOLml1krrnaMpQxxRjp/0ugROF3NShP1qGkMu9IH7uONQE+DW
   4VsbGXt0vro17kIXT+r/rlxIkz20naIwB5QsJfcH3YZMlfYOab4AeUZz5
   T5vnHWNbqYVHt7LG/jcSoLi7vXXQHRJg+Bzfg4OIJgtHu/QcTCHNyGxeJ
   yfEiedIPQiR3yyisxgASwa1OCY7WZ7r/CDQ6j7SNkGyaFLx1a/4EodAbh
   fTxK6Gd2emAZAp3fh1aXUwY9JvWlYAxU+G/sOnAHci/UkSt64ROqmxqJx
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245366524"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="245366524"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:51:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511753979"
Received: from mlbroadh-mobl2.amr.corp.intel.com (HELO guptapa-desk) ([10.212.136.108])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 14:51:33 -0700
Date:   Fri, 22 Apr 2022 14:51:32 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pelton, Kyle D" <kyle.d.pelton@intel.com>
Subject: Re: [PATCH] x86/cpu: Load microcode during restore_processor_state()
Message-ID: <20220422215132.3lmmgzkzhw36iabu@guptapa-desk>
References: <4350dfbf785cd482d3fafa72b2b49c83102df3ce.1650386317.git.pawan.kumar.gupta@linux.intel.com>
 <CAJZ5v0gQCzmnMX_1_6TCiexARJ99rtLKg58Ewi-xwUKUrGOQzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gQCzmnMX_1_6TCiexARJ99rtLKg58Ewi-xwUKUrGOQzg@mail.gmail.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:09:57PM +0200, Rafael J. Wysocki wrote:
>On Tue, Apr 19, 2022 at 6:52 PM Pawan Gupta
><pawan.kumar.gupta@linux.intel.com> wrote:
>>
>> From: Borislav Petkov <bp@suse.de>
>>
>> When resuming from system sleep state, restore_processor_state()
>> restores the boot CPU MSRs. These MSRs could be emulated by the
>> microcode. If microcode is not loaded yet, writing to emulated MSRs
>> leads to unchecked MSR access error:
>>
>>   [   28.702947] PM: Calling lapic_suspend+0x0/0x210
>>   [   28.703345] unchecked MSR access error: WRMSR to 0x10f (tried to write 0=x0000000000000000) at rIP: 0xffffffff9b2819e4 (native_write_msr+0x4/0x20)
>>   [   28.703357] Call Trace:
>>   [   28.703359]  <TASK>
>>   [   28.703361]  ? restore_processor_state+0x255/0x2d0
>>   [   28.703369]  x86_acpi_suspend_lowlevel+0x11f/0x170
>>   [   28.703374]  acpi_suspend_enter+0x4f/0x1f0
>>   [   28.703379]  suspend_devices_and_enter+0x6e0/0x7d0
>>   [   28.703384]  pm_suspend.cold+0x35c/0x3a7
>>   [   28.703388]  state_store+0x81/0xe0
>>   [   28.703392]  kobj_attr_store+0x12/0x20
>>   [   28.703396]  sysfs_kf_write+0x3f/0x50
>>   [   28.703399]  kernfs_fop_write_iter+0x13b/0x1d0
>>   [   28.703403]  new_sync_write+0x101/0x180
>>   [   28.703408]  vfs_write+0x217/0x2a0
>>   [   28.703413]  ksys_write+0x67/0xe0
>>   [   28.703417]  __x64_sys_write+0x1a/0x20
>>   [   28.703421]  do_syscall_64+0x3b/0x90
>>   [   28.703426]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>   [   28.703429] RIP: 0033:0x7fda13c260a7
>>   [   28.703434] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 =
>>   00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
>>   > 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
>>   [   28.703437] RSP: 002b:00007fffa4060268 EFLAGS: 00000246 ORIG_RAX: 000000=0000000001
>>   [   28.703441] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fda13c=260a7
>>   [   28.703443] RDX: 0000000000000004 RSI: 000055a41f65a570 RDI: 00000000000=00004
>>   [   28.703444] RBP: 000055a41f65a570 R08: 0000000000000000 R09: 00000000000=00004
>>   [   28.703446] R10: 000055a41f0cc2a6 R11: 0000000000000246 R12: 00000000000=00004
>>   [   28.703447] R13: 000055a41f657510 R14: 00007fda13d014a0 R15: 00007fda13d=008a0
>
>__restore_processor_state() is used during resume from both
>suspend-to-RAM and hibernation, but I don't think that the latter is
>affected by the issue at hand, because microcode should be loaded by
>the restore kernel in that case.  However, loading the boot processor
>microcode in __restore_processor_state() during resume from
>hibernation still works, although it is redundant in that case.
>
>It would be good to acknowledge the above in the changelog and also
>mention in it that the issue is specific to suspend-to-RAM (ACPI S3 on
>x86 PC systems).

Yes, it will be good to add this.

[...]
>> @@ -262,11 +263,18 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
>>         x86_platform.restore_sched_clock_state();
>>         mtrr_bp_restore();
>>         perf_restore_debug_store();
>> -       msr_restore_context(ctxt);
>>
>>         c = &cpu_data(smp_processor_id());
>>         if (cpu_has(c, X86_FEATURE_MSR_IA32_FEAT_CTL))
>>                 init_ia32_feat_ctl(c);
>
>The change of the ordering between the above and msr_restore_context()
>needs to be explained in the changelog too.

This patch is already queued in tip tree. I am not sure if we can update
the commit message in tip tree?

Thanks,
Pawan

>> +
>> +       microcode_bsp_resume();
>> +
>> +       /*
>> +        * This needs to happen after the microcode has been updated upon resume
>> +        * because some of the MSRs are "emulated" in microcode.
>> +        */
>> +       msr_restore_context(ctxt);
>>  }
>>
>>  /* Needed by apm.c */

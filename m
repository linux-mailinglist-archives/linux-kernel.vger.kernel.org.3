Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301DA4D0D6C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 02:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiCHBUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 20:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238576AbiCHBUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 20:20:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918D837009
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 17:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646702356; x=1678238356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9VShFtUnHahYjXoEmhuEaaKsxAaqPctuFnTiXKgAwlg=;
  b=D+ngteafjReZWyptzAB8yL1mNX8G/YdEODs8JzftLZDi6dn0awwK/Hpd
   B4GolPcx6jIKZ5vAXAF53QDxbC41nd4lz1qH7sob9q72v8wxTdwDT6eKy
   BK7TnmJo469HxcZRiOzXjVg8s0qryoyvxCZK+sh2z+wCLtzEwh3xSZOr1
   kO/bldyF5GfFeeYvBfR71l4MYVdjz61EGeaKHmOCBMS7pmIJmnUiRcHzO
   2hF/FWzC8nQ9YjyUwoFNiksCmOQlYCoCt/TWhnyBC0TgNqGqqsw4VGnh6
   2skx6XwQMyhMNiSBBly8vzUacEO1w3/e+khJYy+ewHdudibksIGdjlhRQ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="340987297"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="340987297"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 17:19:16 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="537357528"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.255.31.213]) ([10.255.31.213])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 17:19:08 -0800
Message-ID: <4a4a672f-a21e-f50d-9289-27456923f6df@intel.com>
Date:   Tue, 8 Mar 2022 09:19:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.1
Subject: Re: [PATCHv5 23/30] x86/boot: Avoid #VE during boot for TDX platforms
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-24-kirill.shutemov@linux.intel.com>
 <e8452e86-4063-c85b-5e21-c7cd6ce51423@intel.com>
 <20220307223353.f7cqzqispfeltvb2@black.fi.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20220307223353.f7cqzqispfeltvb2@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/2022 6:33 AM, Kirill A. Shutemov wrote:
> On Mon, Mar 07, 2022 at 05:29:27PM +0800, Xiaoyao Li wrote:
...
>> Even though CPUID reports MCE is supported, all the access to MCE related
>> MSRs causes #VE. If they are accessed via mce_rdmsrl(), the #VE will be
>> fixed up and goes to ex_handler_msr_mce(). Finally lead to panic().
> 
> It is not panic, but warning. Like this:
> 
> 	unchecked MSR access error: RDMSR from 0x179 at rIP: 0xffffffff810df1e9 (__mcheck_cpu_cap_init+0x9/0x130)
> 	Call Trace:
> 	 <TASK>
> 	 mcheck_cpu_init+0x3d/0x2c0
> 	 identify_cpu+0x85a/0x910
> 	 identify_boot_cpu+0xc/0x98
> 	 check_bugs+0x6/0xa7
> 	 start_kernel+0x363/0x3d1
> 	 secondary_startup_64_no_verify+0xe5/0xeb
> 	 </TASK>
> 
> It is annoying, but not fatal. The patchset is big enough as it is.
> I tried to keep patch number under control.
> 

I did hit panic as below.

[    0.578792] mce: MSR access error: RDMSR from 0x475 at rIP: 
0xffffffffb94daa92 (mce_rdmsrl+0x22/0x60)
[    0.578792] Call Trace:
[    0.578792]  <TASK>
[    0.578792]  machine_check_poll+0xf0/0x260
[    0.578792]  __mcheck_cpu_init_generic+0x3d/0xb0
[    0.578792]  mcheck_cpu_init+0x16b/0x4a0
[    0.578792]  identify_cpu+0x467/0x5c0
[    0.578792]  identify_boot_cpu+0x10/0x9a
[    0.578792]  check_bugs+0x2a/0xa06
[    0.578792]  start_kernel+0x6bc/0x6f1
[    0.578792]  x86_64_start_reservations+0x24/0x26
[    0.578792]  x86_64_start_kernel+0xad/0xb2
[    0.578792]  secondary_startup_64_no_verify+0xe4/0xeb
[    0.578792]  </TASK>
[    0.578792] Kernel panic - not syncing: MCA architectural violation!
[    0.578792] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
5.17.0-rc5-td-guest-upstream+ #2
[    0.578792] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
0.0.0 02/06/2015
[    0.578792] Call Trace:
[    0.578792]  <TASK>
[    0.578792]  dump_stack_lvl+0x49/0x5f
[    0.578792]  dump_stack+0x10/0x12
[    0.578792]  panic+0xf9/0x2d0
[    0.578792]  ex_handler_msr_mce+0x5e/0x5e
[    0.578792]  fixup_exception+0x2f4/0x310
[    0.578792]  exc_virtualization_exception+0x9b/0x100
[    0.578792]  asm_exc_virtualization_exception+0x12/0x40
[    0.578792] RIP: 0010:mce_rdmsrl+0x22/0x60
[    0.578792] Code: a0 b9 e8 75 4d fb ff 90 55 48 89 e5 41 54 53 89 fb 
48 c7 c7 9c c1 f6 b9 e8 4b 28 00 00 65 8a 05 97 52 b4 46 84 c0 75 10 89 
d9 <0f> 32 48 c1 e2 20 48 09 d0 5b 41 5c 5d c3 89 df e8 c9 5a 17 ff 4c
[    0.578792] RSP: 0000:ffffffffba203cd8 EFLAGS: 00010246
[    0.578792] RAX: 0000000000000000 RBX: 0000000000000475 RCX: 
0000000000000475
[    0.578792] RDX: 00000000000001d0 RSI: ffffffffb9f6c19c RDI: 
ffffffffb9ece016
[    0.578792] RBP: ffffffffba203ce8 R08: ffffffffba203cb0 R09: 
ffffffffba203cb4
[    0.578792] R10: 0000000000000000 R11: 000000000000000f R12: 
0000000000000001
[    0.578792] R13: ffffffffba203dc0 R14: 000000000000000a R15: 
000000000000001d
[    0.578792]  ? mce_rdmsrl+0x15/0x60
[    0.578792]  machine_check_poll+0xf0/0x260
[    0.578792]  __mcheck_cpu_init_generic+0x3d/0xb0
[    0.578792]  mcheck_cpu_init+0x16b/0x4a0
[    0.578792]  identify_cpu+0x467/0x5c0
[    0.578792]  identify_boot_cpu+0x10/0x9a
[    0.578792]  check_bugs+0x2a/0xa06
[    0.578792]  start_kernel+0x6bc/0x6f1
[    0.578792]  x86_64_start_reservations+0x24/0x26
[    0.578792]  x86_64_start_kernel+0xad/0xb2
[    0.578792]  secondary_startup_64_no_verify+0xe4/0xeb
[    0.578792]  </TASK>
[    0.578792] ---[ end Kernel panic - not syncing: MCA architectural 
violation! ]---


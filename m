Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F815A072E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 04:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiHYCMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 22:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiHYCMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 22:12:14 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B883E6A4A4;
        Wed, 24 Aug 2022 19:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661393533; x=1692929533;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=qNMsD1Aah+is/XJ5qwJ+l8d44fqcOVrcBjytcfqINrA=;
  b=ZQJHdXSsR8OlRwOVCA+9srDKS6MUH3QNwNU9uTo05MB0PK24qt45zTEW
   3Wvgqe8YNDSdyqI4vScS0x8jm16bIl67j4FiUqRI34GNAPEFEPRv1iNqs
   9jsf1MfH5eSLVlAzKgAMRh5kYuC8SCEyrN6K1GsTL/o1cOfURr9YPxjcE
   laCZWUVWSx8Yfm+qCYncflGTRWpPO/ZosJyoiApe6Yqfb1qKB5sBHvsgh
   urJCxjO6VKNJr4N1V1JSN9DaT2q+OqEFHWT/JXfhCUugkJDryHm7/LYcv
   pm8K7o69x5bWcQD53eMKTgaiV5ocF2GcvnEXCbZiNIR5mz+dNZ+DXMP7J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291692812"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291692812"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 19:12:13 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="643076996"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.212.40.238])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 24 Aug 2022 19:12:12 -0700
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Dave Hansen" <dave.hansen@intel.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        x86@kernel.org, "Reinette Chatre" <reinette.chatre@intel.com>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
 <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
Date:   Wed, 24 Aug 2022 21:12:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: Quoted-Printable
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1rfpqgjrwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul

On Tue, 23 Aug 2022 08:48:52 -0500, Paul Menzel <pmenzel@molgen.mpg.de> =
 =

wrote:

> Dear Dave,
>
>
> Am 20.08.22 um 08:13 schrieb Paul Menzel:
>
>> Am 19.08.22 um 20:28 schrieb Dave Hansen:
>>> On 8/19/22 09:02, Paul Menzel wrote:
>>>> On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
>>>>
>>>> ```
>>>> [    0.000000] Linux version 5.18.0-4-amd64  =

>>>> (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, =
 =

>>>> GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP  =

>>>> PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
>>>> [    0.000000] Command line: BOOT_IMAGE=3D/vmlinuz-5.18.0-4-amd64  =

>>>> root=3DUUID=3D56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
>>>> [=E2=80=A6]
>>>> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0  =

>>>> 07/06/2022
>>>> [=E2=80=A6]
>>>> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
>>
>>> Would you be able to send the entire dmesg, along with:
>>  The log message are attached to the first message, where I missed to=
  =

>> carbon-copy linux-sgx@ [1].
>>
>>>     cat /proc/iomem # (as root)
>>> and
>>>     cpuid -1 --raw
>>  I am going to provide that next week. (Side note, Intel might have  =

>> some Dell XPS 9370 test machines in some QA lab.)
>
> Please find both outputs at the end of the file.
>

Could you also check output of "sudo rdmsr -x 0x3a"?
Also was CONFIG_X86_SGX_KVM set?

If CONFIG_X86_SGX_KVM is not set and bit 17 (SGX_LC) of the MSR 3A not s=
et,
then I think following sequence during sgx_init is possible:

sgx_page_cache_init -> sgx_setup_epc_section
                        ->put all physical EPC pages in sgx_dirty_page_l=
ist.
Kick off ksgxd.
Later, sgx_drv_init returns none-zero due to this check:
     if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
         return -ENODEV;
sgx_vepc_init also returns none-zero if CONFIG_X86_SGX_KVM was not set.

And sgx_init will call kthread_stop(ksgxd_tsk):
     ret =3D sgx_drv_init();

     if (sgx_vepc_init() && ret)
         goto err_provision;
...
err_provision:
     misc_deregister(&sgx_dev_provision);

err_kthread:
     kthread_stop(ksgxd_tsk);


That triggers __sgx_sanitize_pages return early due to these lines:
     /* dirty_page_list is thread-local, no need for a lock: */
     while (!list_empty(dirty_page_list)) {
         if (kthread_should_stop())
             return;

And that would trigger (depends on timing?) the warning in ksgxd due to =
 =

non-empty sgx_dirty_page_list
at that moment.

Thanks
Haitao

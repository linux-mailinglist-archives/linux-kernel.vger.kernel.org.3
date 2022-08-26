Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC85A2527
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245245AbiHZJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244825AbiHZJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:54:40 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7147D1A392;
        Fri, 26 Aug 2022 02:54:38 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3092C61EA1932;
        Fri, 26 Aug 2022 11:54:35 +0200 (CEST)
Message-ID: <454c35a7-a86f-7c70-6ac3-15017af737ae@molgen.mpg.de>
Date:   Fri, 26 Aug 2022 11:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <04c9d5fa-5861-bbc3-3e2f-e18a73866645@molgen.mpg.de>
 <63a60042-4a4a-3bc3-5fa1-4495d80cc06c@molgen.mpg.de>
 <op.1rfpqgjrwjvjmi@hhuan26-mobl1.mshome.net>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <op.1rfpqgjrwjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Haitao,


Thank you for your reply. Just for the record:

Am 25.08.22 um 04:12 schrieb Haitao Huang:

> On Tue, 23 Aug 2022 08:48:52 -0500, Paul Menzel wrote:

>> Am 20.08.22 um 08:13 schrieb Paul Menzel:
>>
>>> Am 19.08.22 um 20:28 schrieb Dave Hansen:
>>>> On 8/19/22 09:02, Paul Menzel wrote:
>>>>> On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
>>>>>
>>>>> ```
>>>>> [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
>>>>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64 root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
>>>>> […]
>>>>> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
>>>>> […]
>>>>> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff
>>>
>>>> Would you be able to send the entire dmesg, along with:
>>>  The log message are attached to the first message, where I missed to 
>>> carbon-copy linux-sgx@ [1].
>>>
>>>>     cat /proc/iomem # (as root)
>>>> and
>>>>     cpuid -1 --raw
>>>  I am going to provide that next week. (Side note, Intel might have 
>>> some Dell XPS 9370 test machines in some QA lab.)
>>
>> Please find both outputs at the end of the file.
> 
> Could you also check output of "sudo rdmsr -x 0x3a"?

40005

> Also was CONFIG_X86_SGX_KVM set?

No, it’s not set in Debian’s Linux kernel configuration.

> If CONFIG_X86_SGX_KVM is not set and bit 17 (SGX_LC) of the MSR 3A not set,
> then I think following sequence during sgx_init is possible:

40005 = 0x09c45, so bit 17 (if starting from 0) is 0.

[…]


Kind regards,

Paul

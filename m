Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0AF5A090F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbiHYGq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiHYGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:46:25 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C997731369;
        Wed, 24 Aug 2022 23:46:23 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeca3.dynamic.kabel-deutschland.de [95.90.236.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id EF39461EA1930;
        Thu, 25 Aug 2022 08:46:20 +0200 (CEST)
Message-ID: <54818a03-93c0-8039-b847-d030785e725a@molgen.mpg.de>
Date:   Thu, 25 Aug 2022 08:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: WARNING: CPU: 1 PID: 83 at arch/x86/kernel/cpu/sgx/main.c:446
 ksgxd+0x1b7/0x1d0
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "Chatre, Reinette" <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <ce0b4d26-3a6e-7c5a-5f66-44cba05f9f35@molgen.mpg.de>
 <4253695b-85aa-a2fb-fbf6-718db8b6c20c@molgen.mpg.de>
 <46e3483b-a5ab-2a05-8a28-f9ea87e881c3@intel.com>
 <YwcBN+1Q7JiYC7cb@kernel.org> <YwcHnBTlobzSGgTj@kernel.org>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YwcHnBTlobzSGgTj@kernel.org>
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

Dear Jarkko,


Am 25.08.22 um 07:25 schrieb Jarkko Sakkinen:
> On Thu, Aug 25, 2022 at 07:57:30AM +0300, Jarkko Sakkinen wrote:
>> On Fri, Aug 19, 2022 at 11:28:24AM -0700, Dave Hansen wrote:
>>> On 8/19/22 09:02, Paul Menzel wrote:
>>>> On the Dell XPS 13 9370, Linux 5.18.16 prints the warning below:
>>>>
>>>> ```
>>>> [    0.000000] Linux version 5.18.0-4-amd64 (debian-kernel@lists.debian.org) (gcc-11 (Debian 11.3.0-5) 11.3.0, GNU ld (GNU Binutils for Debian) 2.38.90.20220713) #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1 (2022-08-10)
>>>> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.18.0-4-amd64 root=UUID=56f398e0-1e25-4fda-aa9f-611dece4b333 ro quiet
>>>> […]
>>>> [    0.000000] DMI: Dell Inc. XPS 13 9370/0RMYH9, BIOS 1.21.0 07/06/2022
>>>> […]
>>>> [    0.235418] sgx: EPC section 0x40200000-0x45f7ffff

>>> Would you be able to send the entire dmesg, along with:
>>>
>>> 	cat /proc/iomem # (as root)
>>> and
>>> 	cpuid -1 --raw
>>>
>>> I'm suspecting either a BIOS problem.  Reinette (cc'd) also thought this
>>> might be a case of the SGX initialization getting a bit too far along
>>> when it should have been disabled.
>>>
>>> We had some bugs where we didn't stop fast enough after spitting out the
>>> "SGX Launch Control is locked..." errors.
>>
>> For some reason the pages do not get properly sanitized:
>>
>> 	/* sanity check: */
>> 	WARN_ON(!list_empty(&sgx_dirty_page_list));
>>
>> EPC should be good, given that EREMOVE does not fail.
>> If SGX would be disabled, also EREMOVE should fail.
> 
> Sorry forgot that in no circumstances we're printing the
> error code inside __sgx_sanitize_pages(). I wrote a quick
> patch to address this (attached) [*].
> 
> Paul,
> 
> Any chance to try the patch out?

Yes, I am going to try it in the next days.

> It's pretty hard to attach e.g. kprobe to grab this info. Does it
> reproduce every single time?
Yes, on each boot up.

> Alternatively: what kind of workload is triggering this?
> I do own 2020 model XPS13, which might be able to
> reproduce the same issue.

The Dell XPS 13 9370 is from 2018 (Intel i5-8350U), so no idea if it 
happens with later processors.


Kind regards,

Paul


> [*] Also: https://lore.kernel.org/linux-sgx/20220825051827.246698-1-jarkko@kernel.org/T/#u

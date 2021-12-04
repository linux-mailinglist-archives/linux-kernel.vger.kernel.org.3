Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4464686D7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385332AbhLDSAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhLDSAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:00:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744EEC061751;
        Sat,  4 Dec 2021 09:56:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39E08B80CF9;
        Sat,  4 Dec 2021 17:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D2BC341C0;
        Sat,  4 Dec 2021 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638640603;
        bh=BZLokY/e8n8cCbxaQeUwUTq9iT+e2fx4OIzYgD+4xiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qss75gSDuxRDviBJEezahC8px9BbWMlpIvXPh5BfcD8k3e/sAY1QFl0EU+f+QzwkN
         9nYFubplRya2n7cZVKl3lpMi+Ptg0mo3+hZWMZrly3enYoc17KRAKE7pWu0a5Ljs4P
         HrhUrG7kJAM0dfXDQmCQ6eYQVEtU5psIaB2RbTgNQtPkVivvZWvmoyyr/OexQHQ1Yk
         NeRD0B4Yg4SKtzgWwvKG1T7rQRb1ZH//KLJqvNUXdFnZYaRZokC3EqCqNBPrXWtbVM
         0357PBLzAAVHHNIFfIyiGmWR93Eh0ymosOpbqF3eLc7pKQvgJxNUIIpNcDl1AbX4II
         mJQ7i3aWqoNTA==
Message-ID: <67993dd0-827e-5f08-d853-4fb0273adb5f@kernel.org>
Date:   Sat, 4 Dec 2021 09:56:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
 <c0aab85a-f6a1-ed5c-5540-b03778ffe24a@intel.com>
 <4f50b3b3-2cd5-30a4-5715-3350ef2174d9@kernel.org>
 <ea7708f6-a4c7-9f00-3c69-39cae0c7ac86@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <ea7708f6-a4c7-9f00-3c69-39cae0c7ac86@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 17:14, Reinette Chatre wrote:
> Hi Andy,
> 
> On 12/3/2021 4:38 PM, Andy Lutomirski wrote:
>> On 12/3/21 14:12, Reinette Chatre wrote:
>>> Hi Andy,
>>>
>>> On 12/3/2021 11:28 AM, Andy Lutomirski wrote:
>>>> On 12/1/21 11:23, Reinette Chatre wrote:
>>>>> Enclave creators declare their paging permission intent at the time
>>>>> the pages are added to the enclave. These paging permissions are
>>>>> vetted when pages are added to the enclave and stashed off
>>>>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>>>>> enclave PTEs.
>>>>>
>>>>
>>>> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change 
>>>> the EPCM permission bits however it likes with no oversight from the 
>>>> kernel.   So we end up with a whole bunch of permission masks:
>>>
>>> Before jumping to the permission masks I would like to step back and 
>>> just confirm the context. We need to consider the following three 
>>> permissions:
>>>
>>> EPCM permissions: the enclave page permissions maintained in the SGX 
>>> hardware. The OS is constrained here in that it cannot query the 
>>> current EPCM permissions. Even so, the OS needs to ensure PTEs are 
>>> installed appropriately (we do not want a RW PTE for a read-only 
>>> enclave page)
>>
>> Why not?  What's wrong with an RW PTE for a read-only enclave page?
>>
>> If you convince me that this is actually important, then I'll read all 
>> the stuff below.
> 
> Perhaps it is my misunderstanding/misinterpretation of the current 
> implementation? From what I understand the current requirement, as 
> enforced in the current mmap(), mprotect() as well as fault() hooks, is 
> that mappings are required to have identical or weaker permission than 
> the enclave permission.

The current implementation does require that, but for a perhaps 
counterintuitive reason.  If a SELinux-restricted (or similarly 
restricted) process that is *not* permitted to do JIT-like things loads 
an enclave, it's entirely okay for it to initialize RW enclave pages 
however it likes and it's entirely okay for it to initialize RX (or XO 
if that ever becomes a thing) enclave pages from appropriately files on 
disk.  But it's not okay for it to create RWX enclave pages or to 
initialize RX enclave pages from untrusted application memory. [0]

So we have a half-baked implementation right now: the permission to 
execute a page is decided based on secinfo (max permissions) when the 
enclave is set up, and it's enforced at the PTE level.  The PTE 
enforcement is because, on SGX2 hardware, the enclave can do EMODPE and 
bypass any supposed restrictions in the EPCM.

The only coupling between EPCM and PTE here is that the max_perm is 
initialized together with EPCM, but it didn't have to be that way.

An SGX2 implementation needs to be more fully baked, because in a 
dynamic environment enclaves need to be able to use EMODPE and actually 
end up with permissions that exceed the initial secinfo permissions.  So 
it needs to be possible to make a page that starts out R (or RW or 
whatever) but nonetheless has max_perm=RWX so that the enclave can use a 
combination of EMODPE and (ioctl-based) EMODPR to do JIT.  So I think 
you should make it possible to set up pages like this, but I see no 
reason to couple the PTE and the EPCM permissions.

> 
> Could you please elaborate how you envision PTEs should be managed in 
> this implementation?

As above: PTE permissions may not exceed max_perm, and EPCM is entirely 
separate except to the extent needed for ABI compatibility with SGX1 
runtimes.


[0] I'm not sure anyone actually has a system set up like this or that 
the necessary LSM support is in the kernel.  But it's supposed to be 
possible without changing the ABI.


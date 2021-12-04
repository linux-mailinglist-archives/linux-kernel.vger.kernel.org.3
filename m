Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40672468184
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383907AbhLDAqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345008AbhLDAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:46:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16309C061751;
        Fri,  3 Dec 2021 16:42:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF3D2B828E8;
        Sat,  4 Dec 2021 00:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D033CC341C0;
        Sat,  4 Dec 2021 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638578566;
        bh=izcozVyQPZZKpyUZmtUMrGRhOoAvYWr0mSgGhHCkad0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GFVwu9epnYFgE2cJCP7EP+3nNBVMU0lYzhGWhQDyIzao6zjGWiBhdxtA1Yvr/eWbQ
         b5Iva3VWOCkuYsUOPc8NGDOEhFalB2zZAO4/XZr6RYOMNYSbv1yhtitXJGNUCvcdox
         YtF0XV9tHBf3jJy3k3sKD02uEKuA06Rk+dg99epCePTWM6H5HwLf9YM4HPaYSmi9mb
         vdZ4GXJsdR4kGrpJvVJfR0C6dGp1u+ALnpkr5CjffRdkP0qOMIJs2NgkGM9S40iVYY
         QkbATShXHoaxt2fbBZnv/QtrXMST4uYCnwO56c5ZpMIl9OlKCtgRJdX2KU5XYKgbCJ
         d748Fs93KmORQ==
Message-ID: <b271bd29-1e7d-a10c-f71b-533938c77a0c@kernel.org>
Date:   Fri, 3 Dec 2021 16:42:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 10/25] x86/sgx: Support enclave page permission changes
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
 <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
 <4960c8f9-72e4-0f40-64e4-4384a76d1e69@kernel.org>
 <fc4a8c94-4e1a-be53-50fe-802f6f985eaa@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <fc4a8c94-4e1a-be53-50fe-802f6f985eaa@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 14:34, Reinette Chatre wrote:
> Hi Andy,
> 
> On 12/3/2021 11:38 AM, Andy Lutomirski wrote:
>> On 12/1/21 11:23, Reinette Chatre wrote:
>>> In the initial (SGX1) version of SGX, pages in an enclave need to be
>>> created with permissions that support all usages of the pages, from the
>>> time the enclave is initialized until it is unloaded. For example,
>>> pages used by a JIT compiler or when code needs to otherwise be
>>> relocated need to always have RWX permissions.
>>>
>>> SGX2 includes two functions that can be used to modify the enclave page
>>> permissions of regular enclave pages within an initialized enclave.
>>> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
>>> permissions while ENCLU[EMODPE] is run from within the enclave to
>>> extend enclave page permissions.
>>>
>>> Enclave page permission changes need to be approached with care and
>>> for this reason this initial support is to allow enclave page
>>> permission changes _only_ if the new permissions are the same or
>>> more restrictive that the permissions originally vetted at the time the
>>> pages were added to the enclave. Support for extending enclave page
>>> permissions beyond what was originally vetted is deferred.
>>>
>>
>> I may well be missing something, but off the top of my head, literally 
>> the only reason that EMODPR needs CPL0 (i.e. ENCLS) is that it 
>> requires a TLB flush IPI to take effect.  (Score one for AMD for being 
>> having superior hardware in this regard.)
> 
> My understanding also is that it is the need for TLB flush that require 
> the privilege but I am trying to get more information here.
> 
>>
>> Given that, I don't see any reason for the EMODPR operation to be 
>> treated as security sensitive -- it just needs to be implemented 
>> correctly.  I don't even see why the host should (or even can!) do any 
>> useful tracking of the EPCM state.
> 
> The OS needs to know the EPCM permissions to be able to install the 
> appropriate PTEs. If the enclave chooses to change the enclave page 
> permissions from within the enclave then user space needs to let the OS 
> know via the SGX_IOC_PAGE_MODP ioctl to ensure that the OS can install 
> correct PTEs in support of the permission change.
> 
> 
>> (But I am confused about one thing: to the extent an enclave actually 
>> needs EMODPR, is there anything in the hardware or anything that the 
>> enclave can do short of actually poking the page from all threads and 
>> confirming that a fault occurs to make sure the OS actually flushed 
>> the TLB?  ISTM a malicious host could attack an enclave by omitting 
>> the TLB flush and then exploiting an enclave but that would have been 
>> mitigated if the flush occurred.)
> 
> When enclave page permissions are restricted it requires the enclave to 
> accept the new permissions from within the enclave by running 
> ENCLU[EACCEPT]. This instruction requires that (it will fail otherwise) 
> the OS completed an ENCLS[ETRACK] on the affected page - essentially 
> ENCLU[EACCEPT] can only succeed if no cached linear-to-physical address 
> mappings are present. The ETRACK flow is elaborate and I attempted to 
> document it in patch 06/25. Essentially, SGX hardware flushes all cached 
> linear-to-physical mappings when an enclave is exited and with ETRACK it 
> can be ensured that all threads that were in an enclave at the time the 
> tracking started (in this case after ENCLS[EMODPR]), have exited.
> 

Does the enclave do something before asking for the ioctl to put the 
page in a state where the tracking is armed?  I read the SDM, but I 
probably read the wrong part of the SDM, and I may have missed this.

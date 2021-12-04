Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60046815B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383798AbhLDAlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:41:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55502 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhLDAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:41:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D714D62C6F;
        Sat,  4 Dec 2021 00:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E2FC341C1;
        Sat,  4 Dec 2021 00:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638578289;
        bh=FD2oFWYwBScVmqezYXUxMZO40kvitArlHgNQpRdnHW4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L80z/KzmIMnRTQB+U66Lw2pRrWDiZuK/33GKaqijHMRrSTR9Bh0RDlmCKCjF8BISU
         yrxho6WLkVKkw1MvbPElD0xLLd9T6qixtL4EprperX4E0+97pkQjlYlBqTLBOUH9sD
         t2tKguWCqhqSw5YABBx7NCmkTgdFG3q9/wZewZAVUTZ5Fdv1wfoyzPnOho6yD70frb
         Mmy12fRetSITV7Gy1TVGW3SwllsUMxu5Ih8+F7x5mWWaY+D1/VLSpYneIdoUI3Oz3w
         e317Nu0d9b4aKxwcsLtqpRz+351WxXTQybpen+UfF5lxrSsDl6rlGnjwQgG2b+HxXL
         DT6Yr8DVDQ87A==
Message-ID: <4f50b3b3-2cd5-30a4-5715-3350ef2174d9@kernel.org>
Date:   Fri, 3 Dec 2021 16:38:06 -0800
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
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <c0aab85a-f6a1-ed5c-5540-b03778ffe24a@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 14:12, Reinette Chatre wrote:
> Hi Andy,
> 
> On 12/3/2021 11:28 AM, Andy Lutomirski wrote:
>> On 12/1/21 11:23, Reinette Chatre wrote:
>>> Enclave creators declare their paging permission intent at the time
>>> the pages are added to the enclave. These paging permissions are
>>> vetted when pages are added to the enclave and stashed off
>>> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
>>> enclave PTEs.
>>>
>>
>> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change 
>> the EPCM permission bits however it likes with no oversight from the 
>> kernel.   So we end up with a whole bunch of permission masks:
> 
> Before jumping to the permission masks I would like to step back and 
> just confirm the context. We need to consider the following three 
> permissions:
> 
> EPCM permissions: the enclave page permissions maintained in the SGX 
> hardware. The OS is constrained here in that it cannot query the current 
> EPCM permissions. Even so, the OS needs to ensure PTEs are installed 
> appropriately (we do not want a RW PTE for a read-only enclave page)

Why not?  What's wrong with an RW PTE for a read-only enclave page?

If you convince me that this is actually important, then I'll read all 
the stuff below.

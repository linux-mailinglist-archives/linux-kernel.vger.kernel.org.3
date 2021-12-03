Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4F467E61
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353513AbhLCTmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:42:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45282 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353465AbhLCTmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:42:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77B8062CA9;
        Fri,  3 Dec 2021 19:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A23C53FCD;
        Fri,  3 Dec 2021 19:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638560328;
        bh=9bvRIjqCq3O68XxPYaggj9gpPynEul1wuU8aflyGXNg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kIJ7xz9wo5llTNncJ9avRrlMXdHK/UUNgmAKSNzpSXGYNN0LgDBJ3y/I5Eu5NfM46
         +QGzwA2d0+N8aatJWUodSJNeyVX6z/vupy8rlO9o/uw5hTgj3shQM457rOWwrqi5gs
         bE5J1q6VfvDK/vF6oqZsTLj2zxNz72SYa/i5xXdngzpDCpYKni4SoWG8AVGS7oBCVg
         XXfkTGHCYt1d2GtkueyyQswvEvLcZlFZlq9Tkvrz+peL/lq+uq2sYpSM+v/9oN5ZdV
         WFdKPlxyDsnK2ilwTiQ3ILz4m0V7bUGU5a8Pj+f8ai9JR/QIwmDR3o+ljCBA+jTLUi
         1UvmSGy84hhKA==
Message-ID: <4960c8f9-72e4-0f40-64e4-4384a76d1e69@kernel.org>
Date:   Fri, 3 Dec 2021 11:38:47 -0800
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
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <44fe170cfd855760857660b9f56cae8c4747cc15.1638381245.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 11:23, Reinette Chatre wrote:
> In the initial (SGX1) version of SGX, pages in an enclave need to be
> created with permissions that support all usages of the pages, from the
> time the enclave is initialized until it is unloaded. For example,
> pages used by a JIT compiler or when code needs to otherwise be
> relocated need to always have RWX permissions.
> 
> SGX2 includes two functions that can be used to modify the enclave page
> permissions of regular enclave pages within an initialized enclave.
> ENCLS[EMODPR] is run from the OS and used to restrict enclave page
> permissions while ENCLU[EMODPE] is run from within the enclave to
> extend enclave page permissions.
> 
> Enclave page permission changes need to be approached with care and
> for this reason this initial support is to allow enclave page
> permission changes _only_ if the new permissions are the same or
> more restrictive that the permissions originally vetted at the time the
> pages were added to the enclave. Support for extending enclave page
> permissions beyond what was originally vetted is deferred.
> 

I may well be missing something, but off the top of my head, literally 
the only reason that EMODPR needs CPL0 (i.e. ENCLS) is that it requires 
a TLB flush IPI to take effect.  (Score one for AMD for being having 
superior hardware in this regard.)

Given that, I don't see any reason for the EMODPR operation to be 
treated as security sensitive -- it just needs to be implemented 
correctly.  I don't even see why the host should (or even can!) do any 
useful tracking of the EPCM state.

(But I am confused about one thing: to the extent an enclave actually 
needs EMODPR, is there anything in the hardware or anything that the 
enclave can do short of actually poking the page from all threads and 
confirming that a fault occurs to make sure the OS actually flushed the 
TLB?  ISTM a malicious host could attack an enclave by omitting the TLB 
flush and then exploiting an enclave but that would have been mitigated 
if the flush occurred.)

--Andy

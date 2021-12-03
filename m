Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2D467E38
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382861AbhLCTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353754AbhLCTbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:31:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDE4C061751;
        Fri,  3 Dec 2021 11:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EEBFB828D3;
        Fri,  3 Dec 2021 19:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9F8C53FAD;
        Fri,  3 Dec 2021 19:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638559686;
        bh=sAJaLNzg+JVMUerDY4yeRe8FVaUg2LjpY6jSf5lZmcg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FxRyB3OnmGsrkVo7DOQ9T47jUs6CmY5H5Zzq/Fjf7mI1765jNRxrEHB/TbHLxoT/C
         5xoVEVv3cPFY2wee470DfWaMJTVVYNXc9OPCG59JqBKvbSFsRnlHtaRrlpp3pRuWSg
         uHbW9HFZchd1EsZ3epAuGQsG0ZBmURO3s83PnuSsvkzEE8njEU2RSA32/kXmmZEHJM
         xa6UcuqV48Qf5OUPTychoRyiBkoqmXcYvEdQZou+yNsO/FNLyTReIcqzye5A7ddR2j
         GPFmJ+C1eZ1W/3Mw1Ph+RRR8Y3y9JOMssUzzhj63NhzALYFzU+9dp8bI9AvRllPcU0
         6sXvoKQxiVu3g==
Message-ID: <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
Date:   Fri, 3 Dec 2021 11:28:04 -0800
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
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 11:23, Reinette Chatre wrote:
> Enclave creators declare their paging permission intent at the time
> the pages are added to the enclave. These paging permissions are
> vetted when pages are added to the enclave and stashed off
> (in sgx_encl_page->vm_max_prot_bits) for later comparison with
> enclave PTEs.
> 

I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change the 
EPCM permission bits however it likes with no oversight from the kernel. 
  So we end up with a whole bunch of permission masks:

The PTE: controlled by complex kernel policy

The VMA: with your series, this is entirely controlled by userspace.  I 
think I'm fine with that.

vm_max_prot_bits: populated from secinfo at setup time, unless I missed 
something that changes it later.  Maybe I'm confused or missed something 
in one of the patches,

vm_run_prot_bits: populated from some combination of ioctls.  I'm 
entirely lost as to what this is for.

EPCM bits: controlled by the guest.  basically useless for any host 
purpose on SGX2 hardware (with or without kernel support -- the enclave 
can do ENCLU[EMODPE] whether we like it or not, even on old kernels)

So I guess I don't understand the purpose of this patch	or of the rules 
in the later patches, and I feel like this is getting more complicated 
than makes sense.


Could we perhaps make vm_max_prot_bits dynamic or at least controllable 
in some useful way?  My initial proposal (years ago) was for 
vm_max_prot_bits to be *separately* configured at initial load time 
instead of being inferred from secinfo with the intent being that the 
user untrusted runtime would set it appropriately.  I have no problem 
with allowing runtime changes as long as the security policy makes sense 
and it's kept consistent with PTEs.

Also, I think we need a changelog message or, even better, actual docs 
in kernel, explaining the actual final set of rules and invariants for 
all these masks.

--Andy

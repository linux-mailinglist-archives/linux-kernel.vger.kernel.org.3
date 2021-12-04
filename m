Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5C468835
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbhLDXSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLDXSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:18:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1DC061751;
        Sat,  4 Dec 2021 15:15:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17982B80DB9;
        Sat,  4 Dec 2021 23:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A96C341C2;
        Sat,  4 Dec 2021 23:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638659701;
        bh=fTEwCEp9eDy9sHu7xu/Er563Q9B4q1dX344LnhruwM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GKjlksL5uqkY/8UgEQ0iHs/npYPh4O/W1wcHrX6I/+GoZ43f+YtTh8cYqc7vD6Pep
         w2j5gEH+mwwqCytnz39utyH6EHohCHH/7XPwRD09PkZ0V+fBdIwNpAZ1tSg/V/Rf9v
         eIb41l9qqZIgdcVBm8D2/KXaso4kYl0QqsDYdWMntoQjWwrgLBjxngjnGUgmoSM8xk
         uGdviVOMAUo1znJdVGXBg7NVkmKEEsQo8eFVHb1dMVTiMTlu0zu+rdwDmKBJN0ASXi
         hyK65X0Nk0uGXbAjjbV+5/cAqgJPdRAvSXcsLP2zRmR6kxtKgutk+q4q2izBWRIG+L
         yXOe4jvVNjL+w==
Date:   Sun, 5 Dec 2021 01:14:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/25] x86/sgx: Tighten accessible memory range after
 enclave initialization
Message-ID: <Yav2ckVPrHSgCw/5@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <66da195d44cbbed57b6840c5d20bb789c06fb99f.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66da195d44cbbed57b6840c5d20bb789c06fb99f.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:12AM -0800, Reinette Chatre wrote:
> Before an enclave is initialized the enclave's memory range is unknown.
> The enclave's memory range is learned at the time it is created via the
> SGX_IOC_ENCLAVE_CREATE ioctl where the provided memory range is obtained
> from an earlier mmap() of the sgx_enclave device. After an enclave is
> initialized its memory can be mapped into user space (mmap()) from where
> it can be entered at its defined entry points.
> 
> With the enclave's memory range known after it is initialized there is
> no reason why it should be possible to map memory outside this range.
> 
> Lock down access to the initialized enclave's memory range by denying
> any attempt to map memory outside its memory range.
> 
> Locking down the memory range also makes adding pages to an initialized
> enclave more efficient. Pages are added to an initialized enclave by
> accessing memory that belongs to the enclave's memory range but not yet
> backed by an enclave page. If it is possible for user space to map
> memory that does not form part of the enclave then an access to this
> memory would eventually fail. Failures range from a prompt general
> protection fault if the access was an ENCLU[EACCEPT] from within the
> enclave, or a page fault via the vDSO if it was another access from
> within the enclave, or a SIGBUS (also resulting from a page fault) if
> the access was from outside the enclave.
> 
> Disallowing invalid memory to be mapped in the first place avoids
> preventable failures.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index 342b97dd4c33..37203da382f8 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -403,6 +403,10 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
>  
>  	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
>  

Please write a comment here.

> +	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
> +	    (start < encl->base || end > encl->base + encl->size))
> +		return -EACCES;
> +
>  	/*
>  	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
>  	 * conflict with the enclave page permissions.
> -- 
> 2.25.1
> 

Otherwise, makes sense.

/Jarkko

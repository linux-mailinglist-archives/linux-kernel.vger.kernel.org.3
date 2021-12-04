Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32740468878
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhLEACn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:02:43 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35642 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhLEAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:00:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0B308CE0ECD;
        Sat,  4 Dec 2021 23:57:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AE0C341C2;
        Sat,  4 Dec 2021 23:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638662238;
        bh=QjU+6fpJOeMgqfE5RSKo+rNHHU3UJS8IDM+8vG2J4v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlciWgobo5SCQ2aDaiX9tSP1PX1+00wRgYKGzlC0n2OgkM2//SBemTBxyJ/vZQs8E
         A/0nuN9aotKrMcpUYSJZGB+iYKkkmp37eHcAomnzgI4dw2Zwk7Os8Xl74CjbsrRxpP
         2VeIYSiGyTy7h908mb8PqruQdyW+u7mYfBDf7Yf8/aA/2ACv04Tb/h8hqFXs9cpc1s
         XDkb35cuGVI6VBzBizkhuXjz+JAkQbeGNDSTImYl9yQOT1y9kvoGVfZaU/faYlsydZ
         r94fPvVxoHuVX5NnQGjFU+RioS5Dq2nYrBfmUWY/aAWZI7hLlgi2Ronu2KCiIYpitM
         x0oeP+fIbaR8g==
Date:   Sun, 5 Dec 2021 01:57:14 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, linux-sgx@vger.kernel.org, x86@kernel.org,
        seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YawAWmodeNaUbzV8@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com>
 <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 11:28:04AM -0800, Andy Lutomirski wrote:
> On 12/1/21 11:23, Reinette Chatre wrote:
> > Enclave creators declare their paging permission intent at the time
> > the pages are added to the enclave. These paging permissions are
> > vetted when pages are added to the enclave and stashed off
> > (in sgx_encl_page->vm_max_prot_bits) for later comparison with
> > enclave PTEs.
> > 
> 
> I'm a bit confused here. ENCLU[EMODPE] allows the enclave to change the EPCM
> permission bits however it likes with no oversight from the kernel.  So we
> end up with a whole bunch of permission masks:
> 
> The PTE: controlled by complex kernel policy
> 
> The VMA: with your series, this is entirely controlled by userspace.  I
> think I'm fine with that.
> 
> vm_max_prot_bits: populated from secinfo at setup time, unless I missed
> something that changes it later.  Maybe I'm confused or missed something in
> one of the patches,
> 
> vm_run_prot_bits: populated from some combination of ioctls.  I'm entirely
> lost as to what this is for.
> 
> EPCM bits: controlled by the guest.  basically useless for any host purpose
> on SGX2 hardware (with or without kernel support -- the enclave can do
> ENCLU[EMODPE] whether we like it or not, even on old kernels)
> 
> So I guess I don't understand the purpose of this patch	or of the rules in
> the later patches, and I feel like this is getting more complicated than
> makes sense.
> 
> 
> Could we perhaps make vm_max_prot_bits dynamic or at least controllable in
> some useful way?  My initial proposal (years ago) was for vm_max_prot_bits
> to be *separately* configured at initial load time instead of being inferred
> from secinfo with the intent being that the user untrusted runtime would set
> it appropriately.  I have no problem with allowing runtime changes as long
> as the security policy makes sense and it's kept consistent with PTEs.

This is a valid question. Since EMODPE exists why not just make things for
EMODPE, and ignore EMODPR altogether?

> Also, I think we need a changelog message or, even better, actual docs in
> kernel, explaining the actual final set of rules and invariants for all
> these masks.
> 
> --Andy

/Jarkko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A338468806
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355815AbhLDWHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:07:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40830 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352148AbhLDWHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:07:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3859BB80CF5;
        Sat,  4 Dec 2021 22:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BAF0C341C2;
        Sat,  4 Dec 2021 22:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638655449;
        bh=bQ1y8zePOz7aHC+wLXiH4tflwEcV6v7xTaaUFi1moLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JleWBQmB0LheAaXHcwobkTpOIYlKvOtiGIdaJAA+UhvqJNu1zoz2bGPfb+THNH1fF
         OfVbs3LqDdjzapza0rDZk4Y8prahWzL8rtI+cfKI5uaXFrkVSg4McXoCTa31ypfGRS
         /UKA+m2Uj6LLp+cZA5FXyJ8Sz4yexNQtiDWItJi2wo6exu31jQ51YSxp76dHq97KHP
         PQf03yb1euOkMEggk8kcilY8YIwgnvfpk3mOWgfKiM8/+wwZf2UBzLU/h0Ip9tTZmg
         fmesYkZCLcMTWMn6Cwe6JDiraR0OzFHqO02cb+UZQSCQFgjrY/+iqUblATs+WsfIpN
         s7ejib7mKZKYw==
Date:   Sun, 5 Dec 2021 00:04:05 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/25] x86/sgx: Add wrappers for SGX2 functions
Message-ID: <Yavl1csrk03Zj4ZW@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <50ad5005c451f41951327853fb450ba302eadb40.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ad5005c451f41951327853fb450ba302eadb40.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:00AM -0800, Reinette Chatre wrote:
> The SGX ENCLS instruction uses EAX to specify an SGX function and
> may require additional registers, depending on the SGX function.
> ENCLS invokes the specified privileged SGX function for managing
> and debugging enclaves. Several macros are used to wrap the ENCLS
> functionality.
> 
> Add ENCLS wrappers for the SGX2 EMODPR, EMODT, and EAUG functions
> that can make changes to pages of an initialized SGX enclave. The
> EMODPR function is used to restrict enclave page permissions
> as maintained within the enclave (Enclave Page Cache Map (EPCM)
> permissions). The EMODT function is used to change the type of an
> enclave page. The EAUG function is used to dynamically add enclave
> pages to an initialized enclave.
> 
> EMODPR and EMODT accepts two parameters and can fault as well as return
> an SGX error code. EAUG also accepts two parameters but does not return
> an SGX error code. Use existing macros for all new functions.
> 
> Expand enum sgx_return_code with the possible EMODPR and EMODT
> return codes.

These implementation details only obfuscate this commit message, and
it is way too high-level to be useful e.g. for kernel maintenance.

I'd replace it with something like:

"
Add wrappers for ENCLS leaf functions EAUG, EMODT and EMODPR,
which roughly take two steps:

1. EAUG creates a new EPCM entry.
   EMODT and EMODPR modify an existing EPCM entry.
2. Set either .PR = 1 (EMODPR), .MODIFY = 1 (EMODT) or .PENDING = 1 (AUG).

The bit is reset by the enclave by invoking ENCLU leaf function EACCEPT
or EACCEPTCOPY, which will result the EPCM change becoming effective.
"

The current commit message is also not addressing these:

1. What happens if enclaves accesses a memory address with either .PR,
   .MODIFY or .PENDING set in EPCM, other than by the means of EACCEPT
   or EACCEPTCOPY?
2. The calling conditions (e.g. concerning TLB's and ETRACK/IPI/etc
   dance related to it).


If this information was properly contained here, discussing about the
following commits would be much easier.

/Jarkko

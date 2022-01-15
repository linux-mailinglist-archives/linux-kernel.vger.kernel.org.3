Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C429F48F397
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiAOA5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:57:15 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:33530 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbiAOA5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:57:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD984CE24C2;
        Sat, 15 Jan 2022 00:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA99C36AE7;
        Sat, 15 Jan 2022 00:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642208230;
        bh=06ADzfc7RKtxkoU3WyKxt7yltv8c7PDVLQN2GhalWz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmZyBPj1vhVVL2tjS1t5FbWBRHFc/xOljQR70N4jrvHqZlSS3Lq9laJNqAKZIrsTd
         4xJLYTvctbo7hZJdjg9DSA716RoPInAK/CAzLlsIhfb0UCpIS4Y14Fp4lCxpecp58I
         JXVTjUDawxbxLaSl32tcEFZpGoSLGGcTiKuBHJ78W8Kg+1PNy3120PgcgLFXDkgBKZ
         7EFez8Q/eqMwfHlJZKIaZOVWeOF7v6NQrxuAiJ7qPMTRq9N3r3o8+sJ1+WNGcg+hU1
         yBkdK9zIaTiDv6C9UHTX9e8T6eX+EppC51OKmpWIWD8Ne5bkVAO1qUpHXtsD09IwEb
         D+HclfYCJnISQ==
Date:   Sat, 15 Jan 2022 02:56:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] x86/sgx: account backing pages
Message-ID: <YeIb2eeJ8H5l6omR@iki.fi>
References: <20220107181618.6597-1-kristen@linux.intel.com>
 <20220107181618.6597-3-kristen@linux.intel.com>
 <Ydm2Qk8JFwgdueZa@iki.fi>
 <fda3bb7bd557a37112a4f7c6c205871addda1bd3.camel@linux.intel.com>
 <ed190b80-75cb-3137-1d64-1a87e1ac930e@intel.com>
 <YeIN1RQydD1juJGA@iki.fi>
 <087852d2-e325-7cb9-dec2-e4cdf7aa5729@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <087852d2-e325-7cb9-dec2-e4cdf7aa5729@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 04:16:41PM -0800, Dave Hansen wrote:
> On 1/14/22 3:57 PM, Jarkko Sakkinen wrote:
> > Would it be a too big tretch to add these and make the whole scheme
> > fully legit? Does not sound like an extremely huge stretch and there is now
> > a full cycle amount of time make it happen before 5.18 merge window.
> 
> No, it's not a big stretch.  If anyone wants it for 5.18 (or whatever)
> just send the patch.

Fixing this to work with the current mainline is first and foremost
needed:

https://lore.kernel.org/linux-sgx/YeHqW8AaQ3HZZoQx@iki.fi/T/#t

With a fixeed version of that, wouldn't it be then just matter of calling
shmem_getpage() with SGX_NOALLOC to check the state of the file in both
calls?

/Jarkko

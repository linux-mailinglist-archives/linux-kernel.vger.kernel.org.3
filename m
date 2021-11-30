Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C9462B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 04:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237868AbhK3Dar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 22:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhK3Daq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 22:30:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4FC061574;
        Mon, 29 Nov 2021 19:27:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7DEDCCE172A;
        Tue, 30 Nov 2021 03:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34ED4C53FC1;
        Tue, 30 Nov 2021 03:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638242843;
        bh=UJ59smAJ6cnrGo7DP4M/0ZiI7nKL490BQsRhSwvFWU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qAze2l2nmIz/HVjzLMrqxuLtOAucddHBg2siTrJ8JSKT1Hu0RhKx3HqYEQj6CJIRI
         ZvCf4RC4H/7jNITntxBILScpPT4CkjGqr3JIvwC8M5DkUqEER4P6IdQOYS1wwfWOWs
         Yg9XJpS0LkzThwdrHpUNE1+Twrzs/wnmGZ5HkSkmJwNABs5zlMzo4jYgAh8DIcVsBC
         XwhXzJffU8QTihM1Rw4PyV4r/394ujigDExbmm7/8nagkOJ1Uao2QIUEdPfAHtPj3K
         WjO2DkWunP3Sr4AIvvfCcwiHkzwm06nC2gy9bCVzHd+u9ASOU12MJ3LV30m9e6Pprd
         8b4nEqI1HgglA==
Date:   Mon, 29 Nov 2021 19:27:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v3 00/15] x86: Support Key Locker
Message-ID: <YaWaGfwjLLbrBzHk@sol.localdomain>
References: <20211124200700.15888-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124200700.15888-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:06:45PM -0800, Chang S. Bae wrote:
> 
> == Non Use Cases ==
> 
> Bare metal disk encryption is the only use case intended by these patches.

If that's the case, why are so many encryption modes being added (ECB, CTR, CBC,
and XTS)?  Wouldn't just XTS be sufficient?

> * PATCH10-15: For the x86 crypto library, it first prepares the AES-NI code
>   to accommodate the new AES implementation. Then incrementally add base
>   functions and various modes support -- ECB, CBC, CTR, and XTS. The code
>   was found to pass the crypto test.

Did you test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y?

- Eric

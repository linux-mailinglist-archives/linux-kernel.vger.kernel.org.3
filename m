Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD09476736
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhLPBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPBJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:09:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F26C061574;
        Wed, 15 Dec 2021 17:09:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C28DB82163;
        Thu, 16 Dec 2021 01:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C8FC36AE1;
        Thu, 16 Dec 2021 01:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639616947;
        bh=Jf27dK9roxrnez4ATzWwzsKB6xYx1fjtM9ksvMNwNO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GouL3odHX66QAumtpqy5ABMPeZlduzHXlbbqgOyaoGVclCPRsTSmNBZyAUTAUAFFo
         b6D26AeMrPvkI8ShZWjvwf2arcmjbAahwMOZPmeeGgaWhxxkubxcvoCbjRyRskq2wl
         T0A7gv63XLvsQ7U0BAcap6WpahogXNYyqbkHkDV7UYpgFFasP3Z/RKAXuKzYcllDZB
         HPda9ZeArkLedjrH0MJ4s/qGrITKK4bEaEsmRk4NlC4tRaXhxpLeH7A3PLF5ZBwM8C
         BNXhsSik76Ri/zmMaf1aT5qqbpV4c8PG+imR9tVjgtlpS9D/YUY6InlNNkLEZ/Eh+C
         kd/QDVqbK6enw==
Date:   Wed, 15 Dec 2021 17:09:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com
Subject: Re: [PATCH v4 00/13] x86: Support Key Locker
Message-ID: <YbqRseO+TtuGQk5x@sol.localdomain>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 04:51:59PM -0800, Chang S. Bae wrote:
> == Disk Encryption Use Case ==
> 
> Disk encryption uses Key Locker to mitigate key exfiltration as follows:
> 
> 1. Configuration for Key Locker: AES-KL shows up in /proc/crypto as a
>    distinct cipher option. From there, tools like cryptsetup [5] can select
>    AES-KL vs AES-NI. For example,
> 
>    $ cryptsetup luksFormat --cipher="capi:xts-aes-aeskl-plain" <device>

plain64 is supposed to be used these days, not plain.

> Note: AES-KL has a performance tradeoff. See details in 'Performance'
> below.
> 
> 2. Disk encryption flow with key protection:
> 
> * The cryptsetup utility is responsible for loading the volume key into the
>   kernel's keyring and passing a reference of the key. Once dm-crypt [6]
>   has set up the volume, user space is responsible for invalidating the key
>   material so that only the key handle remains in memory. Cryptsetup does
>   this, e.g. via crypt_free_volume_key() and crypt_safe_free().
> 
> * The AES-KL code in the kernel's crypto library uses the key handle
>   instead of the actual clear text key.
> 
> == Non Use Cases ==
> 
> Bare metal disk encryption is the only use case intended by these patches.

Since dm-crypt is the use case for these patches, you probably should CC this
patchset to dm-devel@redhat.com so that the dm-crypt developers are aware of it.

> +-----------+---------------+---------------+
> | Cipher    |   Encryption  | Decryption    |
> | (AES-KL)  |    (MiB/s)    | (MiB/s)       |
> +-----------+---------------+---------------+
> | AES-CBC   |     505.3     |   2097.8      |
> | AES-XTS   |     1130      |   696.4       |
> +-----------+-------------------------------+

Why is AES-XTS decryption so much slower than AES-XTS encryption?  They should
be about the same.

Also, is the AES-CBC support really useful, given that for disk encryption,
AES-XTS is recommended over AES-CBC these days?

- Eric

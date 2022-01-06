Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B781486011
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 06:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiAFFHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 00:07:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42490 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiAFFHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 00:07:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 207EEB819BC;
        Thu,  6 Jan 2022 05:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E16EC36AE5;
        Thu,  6 Jan 2022 05:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641445664;
        bh=D7iMPaQNW7tDdQiXC0UqtchlPiGk1xwtrROv6L/y5+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZVIVTkIogNCJmdRqyC16r7sV+7EmNPiy06RMjCkcTMetZohSe7UVGz5An/w/kXMOh
         YGqy9ZBx/wOYNC8dGgEJzBN9LnCD8yCx/IhjoTvCGFAsAVRZn10cy4/vOeiUNB7z2T
         /n7vcg2xiFFG3FYN4/kxk6gf3AJmZp3fmxoT8QJZW/XzQvLbNUrma8PUy+ViuT3uWF
         Env82KZExxiKU+TYSdeRQeKyu3vdAigu+aGkz425jyTCAy4Gepzf0SaoRWLy8jKwzW
         9tEUA3RlxVx2wv/LP265jkNimJOtoKlItGxAGaz2El4kIqFwVobCqLDQrni4uQHzDl
         QY+5Pj19EEh2Q==
Date:   Wed, 5 Jan 2022 21:07:42 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Gairuboyina, Charishma1" <charishma1.gairuboyina@intel.com>,
        "Dwarakanath, Kumar N" <kumar.n.dwarakanath@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH v4 00/13] x86: Support Key Locker
Message-ID: <YdZ5HrOKEffBrQIm@sol.localdomain>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <YbqRseO+TtuGQk5x@sol.localdomain>
 <4101B942-6327-49A9-BE8B-9E51F0427F50@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4101B942-6327-49A9-BE8B-9E51F0427F50@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:55:17PM +0000, Bae, Chang Seok wrote:
> >> +-----------+---------------+---------------+
> >> | Cipher    |   Encryption  | Decryption    |
> >> | (AES-KL)  |    (MiB/s)    | (MiB/s)       |
> >> +-----------+---------------+---------------+
> >> | AES-CBC   |     505.3     |   2097.8      |
> >> | AES-XTS   |     1130      |   696.4       |
> >> +-----------+-------------------------------+
> > 
> > Why is AES-XTS decryption so much slower than AES-XTS encryption?  They should
> > be about the same.
> 
> Analyzing and understanding this with specific hardware implementation takes
> time for us. Will come back and update you when we have anything to share here.

Note that for disk encryption, decryption performance is usually more important
than encryption performance.  So your performance results are strange.

> > Also, is the AES-CBC support really useful, given that for disk encryption,
> > AES-XTS is recommended over AES-CBC these days?
> 
> Yes, we understand that AES-XTS is the primary option for disk encryption.
> 
> But it seems that AES-CBC had been used for disk encryption, [1]:
> 
>     Comparing XTS to CBC for hard disk encryption
>         If a storage device vendor is seeking FIPS 140-2 certification today,
>         they will typically use CBC encryption, or even ECB. CBC is a good
>         mode, ...

That document is very old.  XTS has been NIST-approved for over a decade now.

> 
> As long as it is factual that the mode was once popular, it can help somebody
> who wants to use Key Locker for an old disk image I think.

AES-CBC is/was usually used with ESSIV, in which case the key cannot be fully
protected by Key Locker.

I'm not sure you should bother to support legacy use cases, especially since it
might mislead users into choosing a worse algorithm.

- Eric

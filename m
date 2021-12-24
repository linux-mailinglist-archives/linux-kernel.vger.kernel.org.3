Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616E847F06D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344025AbhLXRmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 12:42:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42674 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhLXRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 12:42:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BF4620D3;
        Fri, 24 Dec 2021 17:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9BBC36AE8;
        Fri, 24 Dec 2021 17:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640367763;
        bh=g6XVpxzQARxtHmP/1T2ky85FNUldvcDQeWuopHo5gtY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W3iorgEaeUxfCvixYCZoOeLSKYSGKUE3OViD3MkCb8lfGSfH6RmPaSxtp+iTngyf2
         xRwST8EF5iRhTLJ3Cmpwd3/Ei1h7XybzTvX1pqIvd598Rei5WFHSzC0Y6o+U3q6a7d
         30u408fOF2MapmslmcJhJZImCxBNupady20q2FBZEMa+P7MmWg8IemfeKrcg/2JS1h
         VOGhuD55muNSHOAVRSdNk8JbWCZ43KAdq/qll4ptvQh4U33Jojrofl5wvHNjghla0g
         gIEvFs4Zcyl6cb7/n/wHzlakK21FleljJjzf00s8d/M2oce2mXinK81qSdkKzzlIKV
         MdEbwcU/u87DA==
Message-ID: <75ec3ad1-6234-ae1f-1b83-482793e4fd23@kernel.org>
Date:   Fri, 24 Dec 2021 09:42:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4 11/13] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
Content-Language: en-US
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, tglx@linutronix.de,
        bp@suse.de, dave.hansen@linux.intel.com, mingo@kernel.org,
        x86@kernel.org, herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
 <20211214005212.20588-12-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20211214005212.20588-12-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/21 16:52, Chang S. Bae wrote:
> Key Locker is a CPU feature to reduce key exfiltration opportunities while
> maintaining a programming interface similar to AES-NI. It converts the AES
> key into an encoded form, called the 'key handle'.
> 
> The key handle is a wrapped version of the clear-text key where the
> wrapping key has limited exposure. Once converted via setkey(), all
> subsequent data encryption using new AES instructions ('AES-KL') uses this
> key handle, reducing the exposure of private key material in memory.
> 
> AES-KL is analogous to that of AES-NI. Most assembly code is translated
> from the AES-NI code. They are operational in both 32-bit and 64-bit modes
> like AES-NI. However, users need to be aware of the following differences:
> 
> == Key Handle ==
> 
> AES-KL may fail with an invalid key handle. It could be corrupted or fail
> with handle restriction. A key handle may be encoded with some
> restrictions. The implementation restricts every handle only available
> in kernel mode via setkey().
> 

I find it a bit bizarre that this tries to be a drop-in replacement for 
normal AES.  Is this actually what we want, or do we want users to opt 
in to the KL implementation?

It seems like it might make more sense for tools like cryptsetup (or 
dm-crypt -- the actual layer is subject to some degree of debate) to 
explicitly create a key handle and then ask the kernel to use that key 
handle, not for the kernel to do this by magic.

What happens when someone applies your patches and runs dmsetup table 
--showkeys?

Why should the use of keylocker be part of the luksFormat operation? 
Surely a non-KL machine should still be able to decrypt a nominally 
KL-using volume in a pinch, for recovery purposes if nothing else.

--Andy

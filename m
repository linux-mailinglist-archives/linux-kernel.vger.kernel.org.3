Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDE4A02A4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiA1V0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiA1V0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:26:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C25FC061714;
        Fri, 28 Jan 2022 13:26:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o11so7637648pjf.0;
        Fri, 28 Jan 2022 13:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=cfMRAmoR1rDJZPsZIg2Mf9Md2XIapwAEopIEQIY7W8o=;
        b=D/F0HH3RAZHiHTuozAEIgdDuk7xHYPKxs8Vsjpdy/MFb1HGPaFzlxZb8fCK4DdpA8y
         pI45IeTGmWtsXn4dIC4UhI8jozVDWvoR+1B0XR/i5lZbVC8jHYh7vs45sQxt4r0iRhtJ
         l2GxQmIkfwFexUzY10Weo1sC04Y334JFLOTIGroXmvc+ic+mUqpxZAXCbYzE/u3M8QBo
         njNyaDcokUOJ6Dy5OY+Zc5CRNOc9mA6k80CI5QeI2UXk8udpMWloPkXMBTFHUfAxHe5k
         nsqPYWSxJ3Ga/azdEdsaIFTfQJW78K3dc3tAuRx++vURQpeh4rYNNc6m1GBHG/dvQYjt
         Hf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=cfMRAmoR1rDJZPsZIg2Mf9Md2XIapwAEopIEQIY7W8o=;
        b=IKpjN3pj0qH8sJ7yrqkAa6ym+NVcec57azWskxtnsJ05pH2f2LJGlQsu9tl/k6y9BR
         2QVEHrUNpDHGnqv3/cuWPnQsnwpNaVxOaEWubAofJZJssQ1EEffIWd0I+4Am/AwTH/2i
         XvHQvLonXUP8nz3zmoVVtdxzdt77s007bKxydrSU7Ocp1E+XHqzVmXnqnFqhnWJ5HHvu
         +ociCAICC9w6IBsdDRIn4RFGdfJoUXaCrnrG0bj2d39wIrgg7YNfj16YcY0CpqcG8SYS
         DiwL0qhMlUrm+6Hm1H7SgdXX3G4Q2qwLM61EUO3Sjf4klD2AjuDTpQ/Uny2CAZCVHY67
         o/qw==
X-Gm-Message-State: AOAM532i+rXZYtEVBMnBRzEpSuLIQ6rWr2pqav3jdxJsucMw4zqQ2S82
        ID1Xxxv6kIzEOYNLe9jkrmA=
X-Google-Smtp-Source: ABdhPJw2AbvTvknknuXeuDh9LX3olrj3jJ7bS4VvE9PCD9vElbzT59DmeU04zqG8l/DJMEQy7+q2ig==
X-Received: by 2002:a17:902:ecd0:: with SMTP id a16mr9965255plh.64.1643405167909;
        Fri, 28 Jan 2022 13:26:07 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id u18sm10656761pfk.14.2022.01.28.13.26.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jan 2022 13:26:07 -0800 (PST)
Subject: Re: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20220128173006.1713210-1-geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Finn Thain <fthain@linux-m68k.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <b1cd50eb-e476-b4bd-0b2f-b4a8699660f6@gmail.com>
Date:   Sat, 29 Jan 2022 10:26:01 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220128173006.1713210-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

for hwregs_present(), the exception fixup will handle any access error 
(through send_fault_sig()), so this should continue to work.

Why the special handling of VM_IO pages? Maybe hp300 had marked all IO 
register pages VM_IO to distinguish IO faults from VM faults...

The only other area I can imagine this might have an impact is the Mac's 
pseudo-DMA - FInn might want to give this some testing.

Cheers,

	Michael


Am 29.01.2022 um 06:30 schrieb Geert Uytterhoeven:
> When an application accesses a mapped frame buffer backed by deferred
> I/O, it receives a segmentation fault.  Fix this by removing the check
> for VM_IO in do_page_fault().
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> This check was never present in a fault handler on any other
> architecture than m68k.
> Some digging revealed that it was added in v2.1.106, but I couldn't find
> an email with a patch adding it.  That same kernel version extended the
> use of the hwreg_present() helper to HP9000/300, so the check might have
> been needed there, perhaps only during development?
> The Atari kernel relies heavily on hwreg_present() (both the success and
> failure cases), and these still work, at least on ARAnyM.
> ---
>  arch/m68k/mm/fault.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
> index 1493cf5eac1e7a39..71aa9f6315dc8028 100644
> --- a/arch/m68k/mm/fault.c
> +++ b/arch/m68k/mm/fault.c
> @@ -93,8 +93,6 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	vma = find_vma(mm, address);
>  	if (!vma)
>  		goto map_err;
> -	if (vma->vm_flags & VM_IO)
> -		goto acc_err;
>  	if (vma->vm_start <= address)
>  		goto good_area;
>  	if (!(vma->vm_flags & VM_GROWSDOWN))
>

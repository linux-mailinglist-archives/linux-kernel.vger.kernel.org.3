Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5474A3C92
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 03:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357376AbiAaCWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 21:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357364AbiAaCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 21:22:04 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C7FC061714;
        Sun, 30 Jan 2022 18:22:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x11so11238437plg.6;
        Sun, 30 Jan 2022 18:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=JGXTPagH6lGpW134YHUKaZWL6DYDw6uonUsSiyh80Mk=;
        b=mRIKsqAi6q6BRlmw319EOJWUNQPhRGX/WmZ8wWcIK/QsbIkuMzNBDKpusqXc1HDUFs
         vthGm5YCLFSMMuEYnrSbbofp/zx5jpf2zbm5wLlq6lMsOVVw0bY1Z3UJnzZFJvHbR6CL
         qZvNJOT0Ks9SD9fGX66M/gdiKoswTayxiT/6pemq0bvkwm/EJFEmJhwAtHaBQ3WpGF9H
         YQG7yrXFBCHvbh5+Mw6FCKQ4M/Nsbtrs7Q/aOlO4snXYQevufDhNmqrGDfjOHi2zKZKN
         oUrUTY1b9OuYu+VnUXrmzQoCt+R0o598mqBwEW/17Rzohhr9CvPmPyzJ/DPI+s2dgCBR
         E2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=JGXTPagH6lGpW134YHUKaZWL6DYDw6uonUsSiyh80Mk=;
        b=3idMjCb6FOz0WeLePf+pQ8czqxZawxXYW/fngh1vbNlrRt233lT6TZlH9ziKB63cVC
         C/TMSnZftuly/pol4Fa7KeqHS5Fva635Vm+BUl9gcgFTbCicDbxldwvUss/SEMcVLdtM
         KQb/dDajqegTSmVP3mLyN/PHC1wdLSh8Jz6jHIzs8nC4LtNQu7ovTmVvPxusjK4tfTpj
         0ixCjD/1BbSxbe2jcpMzAWHaMT8aGhKd348OMXU6K+FqvWwgJALyGWoNLXHxebV3UR0e
         xZlRzGKOgb8BMOe0fnTS2DV5IniAQpi8eXqMWX4EpivudrykPUAMHXMUXP0ADsg/y1Sk
         prJA==
X-Gm-Message-State: AOAM531YA2Ys4JmVwK0UTTsKOyMVtOxxchpsOXToioKuCTwsDFdkfFvK
        sHibkqlBDjqIHH4CdjyaLkpx13nMfhA=
X-Google-Smtp-Source: ABdhPJxfVGdQ7TqBy9J72ktgIeLw7gfqrn+WSBi2i7rEhrm0tQ6SW7M2T3U1jV45tJx53m9usEbUmw==
X-Received: by 2002:a17:902:bf06:: with SMTP id bi6mr18951344plb.24.1643595723326;
        Sun, 30 Jan 2022 18:22:03 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id f3sm15610628pfe.43.2022.01.30.18.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jan 2022 18:22:02 -0800 (PST)
Subject: Re: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20220128173006.1713210-1-geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c1034042-f8f4-b5c9-3b0a-8d1aa1efc8e7@gmail.com>
Date:   Mon, 31 Jan 2022 15:21:57 +1300
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

Am 29.01.2022 um 06:30 schrieb Geert Uytterhoeven:
> When an application accesses a mapped frame buffer backed by deferred
> I/O, it receives a segmentation fault.  Fix this by removing the check
> for VM_IO in do_page_fault().
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Works fine on my Falcon030 when applied to v5.16.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>

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

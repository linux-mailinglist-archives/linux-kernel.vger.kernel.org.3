Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39E4A32E2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353603AbiA3Aco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353593AbiA3Acn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:32:43 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614C2C06173B;
        Sat, 29 Jan 2022 16:32:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id p125so8728516pga.2;
        Sat, 29 Jan 2022 16:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=lgImJfjptdc33ZuQjXSFN+7hVN4hLMNWcHtJCWzb0jk=;
        b=YubEnvHsv/crv/QQxQbzdWy0fDh/hJi6DsG2ALzDJKTtR10XIsakvC9+nkSBu1WdFS
         XfBSh5P7XJHrytzbkcalqUKunVx5cQEUyPOPrz7Foy7uO20XFrYo7EtDG3LugITf17AC
         AYleJTKTWeKFiuXWKvStwRibqsv9HkDM4jwplWgBMRdecMIqQTmO8gE1ChALqDUj4LhF
         4pFCmA1nM7cfyYc+DyPSCoNE1L8X3JnagmHmt7vAsHpJjH0wLoL/4tbPQubzSixnmDFV
         YVmTfxmRg9qD9eGkQhnQPp2SfFDTDyrxatjk+n/xE8IVQn59h20dXLwoCc8gVsVwBX8E
         slUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=lgImJfjptdc33ZuQjXSFN+7hVN4hLMNWcHtJCWzb0jk=;
        b=AI6W3+ZpzbKe46j0I0wyfRtV98R4HIwXttI1sZ5jUcZo5bdhQuchdY2hZUx9vg19IF
         OhtA9cwJ83mLBsLSCjruAuwbeg7p1ptLY/rYHVizB1IGl76eRaa/mN0GH8/YuETMsAuw
         c7UmeYsfyoCaUiU+LaEssYZfrwxyxGKmNKDUROONehCqCsH1eibXDcU5mj9DiSV3PEJt
         3axMosciPKqR4fkcoLVyMnTj+EHTJ1pnXwhfIQYSVkkHV56OYRgcaqmDTvZHBd9fOuG1
         BBHDUDZ078FXEcn+13pYTTBGdy3aWnlLoC/cgD9QEI6pv62lAjyXnLvNDBCNbqCjPAjT
         OShg==
X-Gm-Message-State: AOAM530W3YlhXes3DEi6PGzKp/3CWJcvKv4kubYWpn677Pvh4JQAAOqN
        gt/viLEsWJtWadoov18JnPyIPcY0DnI=
X-Google-Smtp-Source: ABdhPJzEPfsjnGSZFRUq5OlVjEdAYdbrAKC61FZ5zRV/iwdi8PN7s751/DKYpysmpUagxm8TfPMiQA==
X-Received: by 2002:a63:6a87:: with SMTP id f129mr2144667pgc.0.1643502762598;
        Sat, 29 Jan 2022 16:32:42 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id l4sm14120413pfu.90.2022.01.29.16.32.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jan 2022 16:32:41 -0800 (PST)
Subject: Re: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20220128173006.1713210-1-geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <63c80eba-7c55-2a92-8078-c63cec3c9efb@gmail.com>
Date:   Sun, 30 Jan 2022 13:32:35 +1300
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

testing this patch on my Falcon 030, I'm seeing a weird error checking 
and mounting the root filesystem (pata-falcon). The system appears to 
sit idle, never completing the journal recovery and mount. Still 
investigating that.

Can't see how that would be caused by your patch, just saying I could 
not yet test it.

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

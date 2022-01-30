Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A44A34C0
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 07:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354263AbiA3G5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 01:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354238AbiA3G5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 01:57:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145F9C06173B;
        Sat, 29 Jan 2022 22:57:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d18so9838822plg.2;
        Sat, 29 Jan 2022 22:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=fM8q32grWZEZw0oluXIqvQZO4Mr5xfE86zn2yqSxGvI=;
        b=UgmUEAmno7gCdw3heMWy+S1n5AcBNQlLLAqPVtZtvbxtbRE2SaZVKIwzglsgdYdWW/
         9/u1vWPcu7Ee6fiCsP/qee/IBUdWiCjAn3doDwhBiWCI+O0Qh9BSOS9KwjlXEUlt+5gC
         yaEeDnz8tf+cdlCbfH9PcGXTaNpoH5IskOj+jUcQj0v6MheGW4YByKEMO4IZWjR8YJw5
         FbP7VE+y0C9v4VWibsNam3w1vaZ2Fsra2Tc+DoNGoDbCINdUx1R3+e3wzk4iP+Kcejs1
         cfJBYRId7FtK0ve96jRArRmXbXRONqSVVCE8ECIUTkqOeMGt5mB5I8V/Lq5i0Xe5l2Xr
         Lb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=fM8q32grWZEZw0oluXIqvQZO4Mr5xfE86zn2yqSxGvI=;
        b=FS+eMB4gTYoP/GjNOd+8ZkU7a0RzXAH8Hw/djhe5afaQ0AIqC4jrDaaBPlRUi/pl6I
         j2l3huyl6T20epgMy5EsGQpaneNHMr5T9tX+5E2mfrfssckKWPhOI172wixMmx34LT3H
         dVjbA1644a4Ah4UhugQrE/BBHE1gJNDtMyiK5hNX82HejeHSt80jRq9+HkoxbybIM/Lo
         VJHC8TgO9bUfB+CIdBL6JjwBp+I0bFZIgxgP9+qh64vdM9+B+EBcox/nPu11ANrDmfGq
         C0dw161+23IUSyyNKzgDbQ8AJq67KdofKGd8co1PNRkt796vjhKAW3O+ZZlbIdlLf4xI
         ZkaA==
X-Gm-Message-State: AOAM532zACxeL/DDEefWWAklb3uSRDmORUqpQAtGVO9YSKUV9Qu+odGS
        vnZEcEwCUUIZOxRDC3vrYfjw42PDsYQ=
X-Google-Smtp-Source: ABdhPJwOYscoSEhgZUw8VpKbyZ3DBjJeYIK+Rpi3YjORDvuU4L9mDd6LB3pqIxf2uUJ+uPSSsAnfZA==
X-Received: by 2002:a17:90b:3907:: with SMTP id ob7mr24092447pjb.193.1643525861276;
        Sat, 29 Jan 2022 22:57:41 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id z7sm14745441pfe.49.2022.01.29.22.57.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jan 2022 22:57:40 -0800 (PST)
Subject: Re: [PATCH] m68k: mm: Remove check for VM_IO to fix deferred I/O
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
References: <20220128173006.1713210-1-geert@linux-m68k.org>
 <63c80eba-7c55-2a92-8078-c63cec3c9efb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8913a0a2-9496-143c-18c2-f3023fd37ba0@gmail.com>
Date:   Sun, 30 Jan 2022 19:57:34 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <63c80eba-7c55-2a92-8078-c63cec3c9efb@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Am 30.01.2022 um 13:32 schrieb Michael Schmitz:
> Hi Geert,
>
> testing this patch on my Falcon 030, I'm seeing a weird error checking
> and mounting the root filesystem (pata-falcon). The system appears to
> sit idle, never completing the journal recovery and mount. Still
> investigating that.

Belay that - not related to your patch, must be some other regression 
since v5.16 that I'm seeing there.

Just ignore the noise ...

Cheers,

	Michael


> Can't see how that would be caused by your patch, just saying I could
> not yet test it.
>
> Cheers,
>
>     Michael
>
>
> Am 29.01.2022 um 06:30 schrieb Geert Uytterhoeven:
>> When an application accesses a mapped frame buffer backed by deferred
>> I/O, it receives a segmentation fault.  Fix this by removing the check
>> for VM_IO in do_page_fault().
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> This check was never present in a fault handler on any other
>> architecture than m68k.
>> Some digging revealed that it was added in v2.1.106, but I couldn't find
>> an email with a patch adding it.  That same kernel version extended the
>> use of the hwreg_present() helper to HP9000/300, so the check might have
>> been needed there, perhaps only during development?
>> The Atari kernel relies heavily on hwreg_present() (both the success and
>> failure cases), and these still work, at least on ARAnyM.
>> ---
>>  arch/m68k/mm/fault.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
>> index 1493cf5eac1e7a39..71aa9f6315dc8028 100644
>> --- a/arch/m68k/mm/fault.c
>> +++ b/arch/m68k/mm/fault.c
>> @@ -93,8 +93,6 @@ int do_page_fault(struct pt_regs *regs, unsigned
>> long address,
>>      vma = find_vma(mm, address);
>>      if (!vma)
>>          goto map_err;
>> -    if (vma->vm_flags & VM_IO)
>> -        goto acc_err;
>>      if (vma->vm_start <= address)
>>          goto good_area;
>>      if (!(vma->vm_flags & VM_GROWSDOWN))
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134D6488BDB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 19:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiAIS4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 13:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiAIS4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 13:56:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B6C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 10:56:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id p37so8867680pfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 10:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=wJEUw9ff5ZoyLDqzlPoT0/RMmRbe6oRM0UsL8abW2Hc=;
        b=nTW3bDU69D+maIKyxjfA6EnVwxU+mhMaNR5SCm/lYu7vEvl8ymOHumN8fBNq+OX+Mu
         yTq6u/xKNc7GPDJWaNOToTFg3dZ5cmgOvmoQ20gYdNMZeFPphC2pRDKDkGJxgX1jbDXq
         QvliYpvuMIXD2ENnu7p0OokAjEXoOY0OKh589ax8WNrIwQAcpbsRzk7ISDGME6hcfTzu
         8zsm/esLTe5a5vWid2Ki2BVcKuuhaeYsJghhu/mhgDCkOZxVTDcfJ/P5F1oXu1vTK6MZ
         XOd+cznTrxoaSh22tmlZDvHstM5yOjpy2g6S20yBQCFBpOfSOIfqa5MB+JLU7wBlddCR
         xksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=wJEUw9ff5ZoyLDqzlPoT0/RMmRbe6oRM0UsL8abW2Hc=;
        b=6LkWDdtAVBGbK8bX6NxIanApvJSGjiFIh1O+6VS8lL5KeOZ77EZ44v5WBNwXaF/WuX
         sPmbBrZp8+YC9mgz8HWC109BaZjgptR4rM37JRT3hsEB9qy7Jp0vxLYQrMJbCQ27CziB
         5OYf967gb6GAR/nG0teht0hMpy32Z+E0Bdf1Iirw4hIuWak8vNdE91IQY3Z1FIvQRqta
         xJ0BOedZ0UkM0Saw5g77gfaAycGNS7BSCOXlKIQ1+00IBgi3aBKD2CJBDgClllYp6zaI
         6RbEahefdyw7UVClz7V5zPL2fvE5JZmCW+XCaM7us90NHAYWBehnrVuGMmuJPQsUHxKU
         8l/w==
X-Gm-Message-State: AOAM531aYN685bxl3JpmUbmlicPoiiFG+CPLIyHx/gpE3ovGKbyFSPtp
        Eneq+PnPkJU3rad2pRHfVWdiPg==
X-Google-Smtp-Source: ABdhPJyr0zws2LdZ788TXsTMQDc/XOoIDXppwbYJus0GYLTDrTrLrpomN372UEv+yckAjiNujYAteQ==
X-Received: by 2002:a63:4a5f:: with SMTP id j31mr62757106pgl.222.1641754613260;
        Sun, 09 Jan 2022 10:56:53 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d4sm4216032pfu.50.2022.01.09.10.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 10:56:52 -0800 (PST)
Date:   Sun, 09 Jan 2022 10:56:52 -0800 (PST)
X-Google-Original-Date: Sun, 09 Jan 2022 10:55:49 PST (-0800)
Subject:     Re: [PATCH 1/3] riscv: Don't use va_pa_offset on kdump
In-Reply-To: <70fe8aa8bfe3923308e6248377577f58@mailhost.ics.forth.gr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr, stable@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mick@ics.forth.gr
Message-ID: <mhng-d399244b-db6d-40e5-9113-77baf96bf987@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 10:03:59 PST (-0800), mick@ics.forth.gr wrote:
> Hello Palmer,
>
> Any updates on those 3 patches ?

Sorry, I hadn't realized these were fixes so they got stuck in the 
queue0.  I do now remember you saying you had some fixes at the RISC-V 
conference, but I guess that got lost as well.  Including something like 
"fix" or "-fixes" in a subject line always helps, but if I miss stuff 
IRC's always a good bet as that'll at least make sure I see it when I'm 
in front of the computer -- there's a lot of people who want things at 
these conferences.

It's too late for fixes, but it looks like things have been broken for a 
while so these will have to all get backported to stable regardless.

This is on for-next.

Thanks!

>
> Regards,
> Nick
>
> Στις 2021-11-26 20:04, Nick Kossifidis έγραψε:
>> On kdump instead of using an intermediate step to relocate the kernel,
>> that lives in a "control buffer" outside the current kernel's mapping,
>> we jump to the crash kernel directly by calling
>> riscv_kexec_norelocate().
>> The current implementation uses va_pa_offset while switching to
>> physical
>> addressing, however since we moved the kernel outside the linear
>> mapping
>> this won't work anymore since riscv_kexec_norelocate() is part of the
>> kernel mapping and we should use kernel_map.va_kernel_pa_offset, and
>> also
>> take XIP kernel into account.
>>
>> We don't really need to use va_pa_offset on riscv_kexec_norelocate, we
>> can just set STVEC to the physical address of the new kernel instead
>> and
>> let the hart jump to the new kernel on the next instruction after
>> setting
>> SATP to zero. This fixes kdump and is also simpler/cleaner.
>>
>> I tested this on the latest qemu and HiFive Unmatched and works as
>> expected.
>>
>> v2: I removed the direct jump after setting satp as suggested.
>>
>> Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear
>> mapping")
>>
>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
>> Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
>> Cc: <stable@vger.kernel.org> # 5.13
>> Cc: <stable@vger.kernel.org> # 5.14

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84B471924
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 08:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhLLHi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 02:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLLHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 02:38:56 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6DC061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:38:56 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so41783218eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 23:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nrf+W6y7tzAcdy+dS0RWH81LBTCNwRRxZNixaO8eBYQ=;
        b=R1dLxUWhOUkRZ3b53qIKLJN3Fmw1KCHVN7UlbsTSStDSSnt4yLb/S6CuSJM3pCjaS9
         HldNsLfj/T43MN8Rf/iFCfdV9DI9L1zIB7ZRQ6FuaXempQA7Tmb8k3bl/CGt8ToJj7bE
         mmCy3APfe1azUhDAF6jnKizwK1etpRs4KZngowwGzK/2RthnqV5uliKhwdRsK/5t+RoH
         FHHjfJNsG5X2cZImmxA+B8q1sTcv6wU2ZBDYby+CHTIU4uk1SX31lDSsha5Os2FLb5oe
         HGnE3vnvM1UYQevkuVzDcbmq1RdgZORUF0u6pkwSm5dhPmtQP3aVrw89E6DuKciR2YhX
         UNuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nrf+W6y7tzAcdy+dS0RWH81LBTCNwRRxZNixaO8eBYQ=;
        b=7ksHLyLARGVOuvTdMP7nNXthMDUHGNM0/FXMdIpYS6tbqr8dnSQ6Xl3iE3xQSMMeQh
         TXcqYat6rigKZ7N+Hftr3aC7wYwCKfcpCjWDLhmm9RgEmcZeaIsclE80r1Xuu1eMLFeA
         e9rhLULLJDcJ1lhOc69gdRVdftneeNn3H7ZWpxHgxmx7aWBE4gCtGfWzNINr6taOwPxq
         bu0L5f30y/Nw+UaqwBqveDFQh3N0QP8sSE3YmtJgf543WN04Lyw0P5aDrY2D0vM/EZfo
         DW26I85vgPqARBoYXj7P7aM5ASnAmoMKHz0v20Y5G/l/GOePpemv9H6mzFQ+DiScJMsT
         62Hw==
X-Gm-Message-State: AOAM531Sd1ss9wfOVctTMBWZuiycG8AKguFkt2+NGWzNq/d2JpNC/DR8
        ZrJkVy8VLuH1kmVgCoH9DRKPNs4e3aVWa/puwg==
X-Google-Smtp-Source: ABdhPJz7+r91PGdqGga84T/aEJbOpCeKeq2fTEL2ANrTNQZMnPIv09oHaxx75nHI7gbCklwDx9PCoMUA3NfkQCHGxmo=
X-Received: by 2002:a05:6402:280b:: with SMTP id h11mr54403610ede.341.1639294734852;
 Sat, 11 Dec 2021 23:38:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab4:988d:0:0:0:0:0 with HTTP; Sat, 11 Dec 2021 23:38:54
 -0800 (PST)
In-Reply-To: <20211211173447.4155374-1-hjl.tools@gmail.com>
References: <20211211173447.4155374-1-hjl.tools@gmail.com>
From:   Alexey Dobriyan <adobriyan@gmail.com>
Date:   Sun, 12 Dec 2021 09:38:54 +0200
Message-ID: <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/21, H.J. Lu <hjl.tools@gmail.com> wrote:
> According to gABI, the entry point address in the ELF header gives the
> virtual address to which the system first transfers control, thus
> starting the process.  If the file has no associated entry point, this
> member holds zero.  Update the ELF loader to disallow an ELF binary
> with zero entry point address.  This fixes:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=215303
>
> Tested by booting Fedora 35 and running a shared library with zero entry
> point address:
>
> $ readelf -h load.so | grep "Entry point address:"
>   Entry point address:               0x0
> $ ./load.so
> bash: ./load.so: cannot execute binary file: Exec format error

Why not let it segfault?

> +	if (elf_ex->e_entry == 0)
> +		goto out;

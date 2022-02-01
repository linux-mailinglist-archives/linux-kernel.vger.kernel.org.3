Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4905E4A65BA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiBAUde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiBAUd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:33:27 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99212C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 12:33:26 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id y17so15327422ilm.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6G+WcjnWmWZaQhRnWSHvUr/fYsky3pk6F/savisetw=;
        b=S6YIuMY5Fm+oaiJY6rmrKKmVpoAYSiLE5Lme8sQjjSbjQd8T6WxRJ2kprv62ZTZQX8
         FD/7SdvBXJvC6ab4i/9fZL+PW+Smfo2jcOMolENHyjl5Mc7NAIZWa1SrGLoMFrZuROr4
         isR50HKiwMKGNoKKH3nZ8ywESgfVQ3B03ZivzYh5syhf5305yZ1/9Gb7KvV30i3hhXD8
         F8+20ed5Y9cwN8jjAc4pcmuKRSPXos9l2BCaSdX3yNiL7ipjVkjCFV2Fdp5FIqVJUHdK
         j6rfWoVjbKBJp4d+0zrsnj1/Bg+d+80dv8NYAbuLv4/CUjCmiulGE6VqBILiy6Q402Eu
         9Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6G+WcjnWmWZaQhRnWSHvUr/fYsky3pk6F/savisetw=;
        b=F3p5nkgQs9ZHfYdpbq1hheR0pcs6EPqxbuVIkrimWxoIGiZkHs/wyhxFuDF9/ZhXU6
         DdAEQkuBSG3byeDf2OVmpw2cp8uHOSLrQ96nIVYf8DvQb6keT1TINQDD+aju122sEXo4
         wTx7dB7yzuebsfnSjyxjJj9Aut450VEPC+327V5N8Rnl6Z7Fio6QIUnwJJxx+8yz7PX4
         hDIsX8BvSe3tPM1GrLu0SSy1Nerk+k/5STDBAiM+HZCFuKWLwejLldeksZ7xekWcoVfl
         vLM3AoqIbRERfaDSa8tibWQINm7Phv2eIo422jX2KkzYcMwIglCqZCv0x03L7D5dshUW
         BdWQ==
X-Gm-Message-State: AOAM532WGsRgF9XQp0xPWnNZ/iJ7DzJI3jbWeGXnCQOjtGgZ1yxMTG0Z
        5gj6d67E0a6dtqq+vY/giQC9+4Czyupae6b5d9ZEAg==
X-Google-Smtp-Source: ABdhPJxt5BhITP52pxY1SzyuFggap4azRQscz98h3E+b2+lwZLStdiP5LIkCCJzoMpGE/HPC+jFNF+Jsv1ACaVqYE0U=
X-Received: by 2002:a05:6e02:1708:: with SMTP id u8mr8462691ill.319.1643747605818;
 Tue, 01 Feb 2022 12:33:25 -0800 (PST)
MIME-Version: 1.0
References: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com>
In-Reply-To: <432231420.24682.1643727496135.JavaMail.zimbra@efficios.com>
From:   Chris Kennelly <ckennelly@google.com>
Date:   Tue, 1 Feb 2022 15:33:15 -0500
Message-ID: <CAEE+ybn_Cp1-T=2uB7xJqU2gEU-PxzsaV5jqCOupNp2cx_bK-Q@mail.gmail.com>
Subject: Re: Aligning tcmalloc with glibc 2.35 rseq ABI
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>,
        Florian Weimer <fweimer@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the heads up.

I did have a question about whether the new protocol would introduce
an extra memory reference while initializing a critical section.

* With initial-exec TLS, I can directly reference __rseq_abi.
* With the new ABI, I might need to ask glibc for the address of the
registered rseq structure in its thread data.

I saw https://lkml.org/lkml/2022/1/24/859 mention using %gs, but it
also mentions consulting "rseq_offset" in the address calculation.  Is
rseq_offset something I can resolve to a constant or would I need to
access a global for it, or does glibc take care of initializing %gs to
the address of the structure registered with the kernel (for the
current thread)?

Thanks,
Chris


On Tue, Feb 1, 2022 at 9:58 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi Chris,
>
> You will probably want to have a look at the userspace rseq ABI exposed by glibc 2.35 to ensure
> tcmalloc becomes compatible with it.
>
> If it helps, you can have a look at how I modified librseq to play nicely with glibc 2.35:
>
> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/
>
> Most relevant bits:
>
> https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/src/rseq.c#n108
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

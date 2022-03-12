Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082B4D719B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiCLXv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiCLXvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:51:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF21D70F59;
        Sat, 12 Mar 2022 15:50:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g20so15236968edw.6;
        Sat, 12 Mar 2022 15:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=52W9q0/ypkx4S9+DIODk0Uq0ox54c7w4kVL7674dQ6U=;
        b=V6u6FSysyXrFpEqLaS8USZ0d/6G6QTFgYmseRClD8M7pB4z7u2bTEjBFF7673m3PKA
         vFq4sC0Rl6wiomxzhicwIOF3OFpVENCGcc+1eEabZ14b7QzRkJqG/WqGvLH43owEOZEp
         fRDGH3qH+O1YVDblzXIVwNwikIzwQBnKKHR1ZKwtFRiF0p6wwsG6CCbF1oRKNxObB+cp
         cQJX75CZgowmTQWq9fVLe2i6F0wYMcKlHbNBaLywjFbTF/V5Dg6wobxDZeQIm7Jx4LNV
         ZmNg2MfRrz4QWcRDLzUMDVJfVnhW8LZZhyXQ7TpPKN0vmMDd6IkHdKK773rXrZn6Unlg
         rK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=52W9q0/ypkx4S9+DIODk0Uq0ox54c7w4kVL7674dQ6U=;
        b=6RakH3xNAVvbyP16qs2l0OintgdkhbRBSqcIO2MDchFtxfGjZ67YW8wzRnsU1UW+31
         4tAljGL8RyY9o5OoWLHU6KipCayxCDLSUWymnJCEqFoHA/IjzDKQZyzIQh8M4MMNGfI/
         rbU0SEqdH/FBdZ9iNuogRYdMqIJqfSnVeb45J/azLlCRSYCTStR6P754/BYEh4NpBIY5
         OLkdoQaZZ8keL8oMLEo2LHG8h0xsp1QBdUTjCsakJFa0Vi65FsdwHWBzrkvnrjBYV6xX
         1brvtik/X+azSy+8CldbT04GIVlXWqvgvldaIMnx5rrT5uO3ff9AzqOuhHDuVwVvkVZP
         /rJA==
X-Gm-Message-State: AOAM5309s6z+Bfqq/2KxzDS4Fn2h6NlXc5QtgVJf1R5UOkEq2PsCGOEY
        VanC5M7l/rC/c0u45Qc8S12JFozqMjeylrEsPjje/mKtiznEtA==
X-Google-Smtp-Source: ABdhPJzWFW75ZT9zrVaq52nEEfpfte20y2VtuaHjFpAHAVPPTUl/51VT3OJA32F9aRT8vuV2SaNwBB4CjE8UDcnkFZQ=
X-Received: by 2002:a05:6402:5143:b0:416:1327:4f95 with SMTP id
 n3-20020a056402514300b0041613274f95mr14260634edd.56.1647129046482; Sat, 12
 Mar 2022 15:50:46 -0800 (PST)
MIME-Version: 1.0
References: <20220312155603.1752193-1-guoren@kernel.org>
In-Reply-To: <20220312155603.1752193-1-guoren@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 12 Mar 2022 15:50:35 -0800
Message-ID: <CAMo8Bf+p1-DqeqHV45GcZEsp+BEd+iMfeHP+i0P+KO7nv8W7Ow@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: patch_text: Fixup last cpu should be master
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo Ren,

On Sat, Mar 12, 2022 at 7:56 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The origin idea is that when

The original

> the master CPU patch_text, others should wait for it. But current
> implementation is using the first CPU as master, which couldn't
> guarantee continue CPUs are waiting. This patch changes the last

guarantee that remaining CPUs are waiting.

> CPU as the master to solve the potaintial risk.

potential

>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Peter Zijlstra <peterz@infradead.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/patching.c      | 4 ++--
>  arch/csky/kernel/probes/kprobes.c | 2 +-
>  arch/riscv/kernel/patch.c         | 2 +-
>  arch/xtensa/kernel/jump_label.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

I'm curious, is there a specific issue that prompted this patch?

-- 
Thanks.
-- Max

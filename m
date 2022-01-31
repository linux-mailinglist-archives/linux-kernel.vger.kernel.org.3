Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6650C4A3CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 05:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbiAaEEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 23:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbiAaEEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 23:04:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA9C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 20:04:01 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z14-20020a17090ab10e00b001b6175d4040so11359338pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 20:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2PZ2ReSGHGAeYkAGF3C+7HR5tVC3KUspbF6aihY8lw=;
        b=ap9zalU88EN14mCGhIlwOi3lyOiy1tSHIN9Dgj8MbpB7hm6WVRgIThMmRbxCKh4Ge8
         vhxsrIiPAZfv4cemi+veflb8TZK+AcnYvFVKOjvxyimqOOydDYuR/fYfS7kr4u6r/eeG
         QFYgLz9j2Q/RQA8dkxxDaFAkuuvdVIjAPa7qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2PZ2ReSGHGAeYkAGF3C+7HR5tVC3KUspbF6aihY8lw=;
        b=DR7JNVsmHQ9x5C3JDOJvsVbM8b/YLZv9XkkVqGTcfJgSbvAMBx1cgnaxxDXsLteaxd
         GvocWklsKoXVsbBp4jeSMlsM/pWGKb1j/ijaB5fjOf953nVp1fWboLQwNkdTADaMFahG
         +XRaRW4I1GdllaOIdVD8/K4VLbESMzxltHrzYjiov4mqXt9jOYoHWhRy/sfHOlZbbEhx
         qn7HBfDOMPcUwV3eu93d3yP0K+oAHN/rcBMiMNf8Gn5eR6sp5w3DF22Mo0VjVoscrMcL
         pKDKnK3MpEcIgeg+q+gw00pwdFsxXkqI9h4BPAjzIoRHwsa7fXKmfw4xKKuoBNiRcfeD
         oh3w==
X-Gm-Message-State: AOAM53207k4VQR7RO0KGo0T4yiJkni8O2+J8VOCNSI556MEdjX+U2dNv
        ZriXuXHqBYLPyOqx0ao9vXUICQ==
X-Google-Smtp-Source: ABdhPJwCRAvTo+IGLvTNbpeFRUozTHodb0xd/zFfx+Ke0YLQiks4V+5XnWU60xBWogwGZxrYLwCzZA==
X-Received: by 2002:a17:902:e74a:: with SMTP id p10mr19170222plf.16.1643601841131;
        Sun, 30 Jan 2022 20:04:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id il18sm9460439pjb.27.2022.01.30.20.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 20:04:00 -0800 (PST)
Date:   Sun, 30 Jan 2022 20:04:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <202201302002.41A8DDA2@keescook>
References: <20220131100954.74a2034f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131100954.74a2034f@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:09:54AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from include/linux/string.h:253,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from arch/x86/include/asm/cpumask.h:5,
>                  from arch/x86/include/asm/msr.h:11,
>                  from arch/x86/include/asm/processor.h:22,
>                  from arch/x86/include/asm/timex.h:5,
>                  from include/linux/timex.h:65,
>                  from include/linux/time32.h:13,
>                  from include/linux/time.h:60,
>                  from include/linux/skbuff.h:15,
>                  from include/linux/tcp.h:17,
>                  from drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:33:
> In function 'fortify_memcpy_chk',
>     inlined from 'mlx5e_insert_vlan' at drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:211:2,
>     inlined from 'mlx5e_sq_xmit_wqe' at drivers/net/ethernet/mellanox/mlx5/core/en_tx.c:496:4:
> include/linux/fortify-string.h:325:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   325 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This should be fixed by:
https://lore.kernel.org/linux-hardening/20220124172242.2410996-1-keescook@chromium.org/
(I was expecting this to be in netdev by now.)

> In file included from include/linux/string.h:253,
>                  from include/linux/bitmap.h:11,
>                  from include/linux/cpumask.h:12,
>                  from arch/x86/include/asm/cpumask.h:5,
>                  from arch/x86/include/asm/msr.h:11,
>                  from arch/x86/include/asm/processor.h:22,
>                  from arch/x86/include/asm/timex.h:5,
>                  from include/linux/timex.h:65,
>                  from include/linux/time32.h:13,
>                  from include/linux/time.h:60,
>                  from include/linux/ktime.h:24,
>                  from include/linux/timer.h:6,
>                  from include/linux/netdevice.h:24,
>                  from include/trace/events/xdp.h:8,
>                  from include/linux/bpf_trace.h:5,
>                  from drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:33:
> In function 'fortify_memcpy_chk',
>     inlined from 'mlx5e_xmit_xdp_frame' at drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c:344:3:
> include/linux/fortify-string.h:325:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>   325 |                         __write_overflow_field(p_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This should be fixed in:
https://lore.kernel.org/linux-hardening/20220124172028.2410761-1-keescook@chromium.org/
(Again, this was expected to be in netdev by now.)

> Caused by various commits in the mlx5 driver interacting with the new
> memcpy checking.
> 
> I have disabled CONFIG_MLX5_CORE_EN for today while this gets sorted
> out properly.

Thanks!

-Kees

-- 
Kees Cook

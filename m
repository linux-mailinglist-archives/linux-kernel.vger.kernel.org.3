Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4C8498841
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbiAXSYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245211AbiAXSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:24:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:24:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id j16so5946905plx.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uhZIz3/JykOBz9VP0YFQFFJB6JHp3P7kosVSER8JbCs=;
        b=alUnBjwA9GnJNcB1VQbp/WSOeoyPUm7ct70T0RMkE/CVfVe0iGp5KNjxhHwR40ceTB
         6amxmfkC0OCiiUzzNflT0LH8nbTiIXGFiCnRTzrzB1Zm94fqLJkT7M5ODG5wwtdaegO4
         q9dcoLaWBG29OEiHULjhmJXDUEbMQUlUoOw/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uhZIz3/JykOBz9VP0YFQFFJB6JHp3P7kosVSER8JbCs=;
        b=nzIJmhHc7wMmnqWoOvXJcMVrG8QO6KtBY6OTGS1snoIbSPdml2SDBumCTBl+nP9+Ex
         To6/lxA1JE2f0Ts/65rcyZBFKhULBYA7qk5Im5pEHtYWtCs+jr4T+kB/KTapG8yDQYrO
         /iXj1sLeH1wYKsrMdIhXDJPBdmqHIKvX+9UZasevxnk8Ss+h4dna/kU7hW1b8xrVLrZm
         zCbl2B0+9ai1QmXIzzVZmt+7aGB0rI62F2A2vWnBfk4jAHVTbtNDESU7ph04KnyDitpE
         hWFR70+A/1HlW5XPQm5xjjk9pDBkYvxtcuS/o8p+V4kB9Y/nlA9bVJZZWGSiJzoa9XWe
         p0Jw==
X-Gm-Message-State: AOAM530/mzqts+YDAy2WiKdv6GL8hJX07lRo0vGUeadEqENxhabee+Tm
        MOC4lw5CcBu6rEQkMKZYwgvYvg==
X-Google-Smtp-Source: ABdhPJx/8XSSCE4pNF/rMKWRrUHHg7PdBjMRFPZ0Ya0DtIbcSeRdq+8k4YOK6JIR4In6vxCm3Y1BZw==
X-Received: by 2002:a17:902:bc88:b0:149:2032:6bcf with SMTP id bb8-20020a170902bc8800b0014920326bcfmr15462814plb.44.1643048675213;
        Mon, 24 Jan 2022 10:24:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm12311920pgu.17.2022.01.24.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:24:34 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:24:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-hardening@vger.kernel.org, Nico Pache <npache@redhat.com>
Subject: Re: [PATCH] kasan: test: fix compatibility with FORTIFY_SOURCE
Message-ID: <202201241024.DA581869@keescook>
References: <20220124160744.1244685-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124160744.1244685-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 05:07:44PM +0100, Marco Elver wrote:
> With CONFIG_FORTIFY_SOURCE enabled, string functions will also perform
> dynamic checks using __builtin_object_size(ptr), which when failed will
> panic the kernel.
> 
> Because the KASAN test deliberately performs out-of-bounds operations,
> the kernel panics with FORITY_SOURCE, for example:
> 
>  | kernel BUG at lib/string_helpers.c:910!
>  | invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>  | CPU: 1 PID: 137 Comm: kunit_try_catch Tainted: G    B             5.16.0-rc3+ #3
>  | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
>  | RIP: 0010:fortify_panic+0x19/0x1b
>  | ...
>  | Call Trace:
>  |  <TASK>
>  |  kmalloc_oob_in_memset.cold+0x16/0x16
>  |  ...
> 
> Fix it by also hiding `ptr` from the optimizer, which will ensure that
> __builtin_object_size() does not return a valid size, preventing
> fortified string functions from panicking.
> 
> Reported-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Marco Elver <elver@google.com>

Yup, more good fixes. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

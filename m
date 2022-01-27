Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42B49E7C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiA0Qll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiA0Qlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:41:39 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F73EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:41:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id y17so2950061plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LCmRUqeagqrmDIv1M1xM4hNMczReVWZ0/XfgL3nr9rA=;
        b=O0fr5UopoJBjwZittOtW82/OHDBeN0k2cD6+plRXAmiFvYevOGj4gFO0dQYyKT0RRT
         Rc31VYh33jA3BNL24xRIJgAULfU5WLeVIZjdhZmmqFXcYSgZXpeFqRyfTda9dNjSgS/D
         XmeiJxo75rWnG6wEFTTnUfZM+8oyLBw4tF5eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LCmRUqeagqrmDIv1M1xM4hNMczReVWZ0/XfgL3nr9rA=;
        b=2FNAyDPn4sTuduzwh8dmvikZ95iLKOH6ewwtmj0REjAkl/x7jHYx+jMLnnoeSirPhV
         CCLGDMA4Wl99xhoE//px9fU0xeN/u/OtHhW6dRdwvqiAPOquJ3xhuZOxv7OXSpAXUWbP
         LmuoHICLJYilQ9KQLT1UTGTOmegggRBo3S/IGAdCa5Hepek8k+8LDRiKnaSiUd+LBaT2
         q5zoUWToTgaL2iUnVqluQiKl6Is0C3pRHP5XRBrtAuG7evnUMeKv+gmhlId4dttSrUYe
         tgDRFAXahR47GPEvyNPFFuQllp2h+f6nHiUY9fWl8qUCOPopJDIGZR6VzqXKcGwT+LWj
         s8XA==
X-Gm-Message-State: AOAM532sP8KF2hIb1aLt2GA6Rpgkm9RUcn6ZXqDo7LAWDDioU6hGAfZY
        cM4qpsFDE/4ZwgC2lgm/Ig87vrpPS9qgng==
X-Google-Smtp-Source: ABdhPJzJW6R3idJobTt3sSvhxG0E7Y46UI6zj21S0XR1zYmEqNiH6DhdfpsDs6RfS5jYQFRo54k6iA==
X-Received: by 2002:a17:902:cec4:: with SMTP id d4mr3980202plg.56.1643301699142;
        Thu, 27 Jan 2022 08:41:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm6605615pfv.74.2022.01.27.08.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:41:38 -0800 (PST)
Date:   Thu, 27 Jan 2022 08:41:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <202201270834.4420E21F6@keescook>
References: <944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com>
 <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
 <20220124114548.30241947@gandalf.local.home>
 <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N>
 <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:46:49AM +0000, Mark Rutland wrote:
> I'm not sure how x86 works here; AFAICT the relocations are performed during
> decompression, but it looks like there's some special build-time processing
> associated with that, and the vmlinux doesn't contain standard ELF relocations.
> 
> Kees, IIUC you added the x86_64 support there, can you shed any light on if/how
> this works on x86?

I think Sven beat me to it, and this was answered in
https://lore.kernel.org/lkml/yt9dy231gzae.fsf@linux.ibm.com
but let me know if anything needs further info.

An additional note is that x86 is built with "-2G addressing"
(-mcmodel=kernel). There was some work done to make it actually
PIE, which would allow the KASLR base to move further:
https://github.com/KSPP/linux/issues/38

-Kees

-- 
Kees Cook

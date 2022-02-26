Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1F4C5310
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiBZBg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBZBg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:36:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD4205876
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:35:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so6442229pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 17:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WpU9pCYtYHOq/uhaCsMM/7Jj3sPtOe5SaReKe0eszxI=;
        b=K+J7F9HzV/9Sz2xGcjH6EyDqDjhx+eBWkUzD+F07R9mvbWF7RdqTa4735O5p6O4Ie0
         Au48mtHHDm/DdLoRoYDZbv8ge5D4Qe+qughCaJojbHdvwkouodhSAvwlA92Uuk4rbE2F
         ODF0loMxDpYS2JHEUDW2z4mwoFot5F+FyaIcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpU9pCYtYHOq/uhaCsMM/7Jj3sPtOe5SaReKe0eszxI=;
        b=KSg+fC9M1dQgHIdiAnEgiR80Y34gGIMmiyss1OB1qgpDc9kGtP6UKUjb5rAFhzoP5o
         CCTrc02w5ihkCe6ly/yWMHAViYLEtsvvUvwSwL1OnWVtJGNZwqdIB6v/ptv2u5KY5DJm
         4u9+YNtA3ByZhA8VroNV8Ng9ON9PBrTrL4j29qYNDtQUCUcuglKvacuA/Ufe6Fzrx0h7
         9kkzzvANanwO63UoRhyzwzh/yMXGDFHwgXxqmaJD7WVDRZKpdBL/Z+pYSCiFTM2kBf1G
         M1MOzN0LYGR/jbCVKWAjxDa2ZERvr/+7qlnKYYaPuili+v5nOrV+wgtSz/YpAAtX5l7F
         VtAg==
X-Gm-Message-State: AOAM530/APL1nzOQ8eSZmkoIYFjtv0xohugq6kexk1bLTXe9tMh+xJ7B
        z1Xx8+MbYNi0VdyW0sXwCr/zRg==
X-Google-Smtp-Source: ABdhPJzzGQp7d+uCevH36MY309ZkNeJKKafuPCRtKeMtR1sNdWqZbF3ofCp8kZwki+6glky8YIys/A==
X-Received: by 2002:a17:902:8d8b:b0:14f:795a:977a with SMTP id v11-20020a1709028d8b00b0014f795a977amr10167644plo.104.1645839350969;
        Fri, 25 Feb 2022 17:35:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5-20020a056a001a4500b004e177b8cbfdsm4601227pfv.197.2022.02.25.17.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 17:35:50 -0800 (PST)
Date:   Fri, 25 Feb 2022 17:35:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-mm@kvack.org,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] usercopy: Check valid lifetime via stack depth
Message-ID: <202202251728.1634F405@keescook>
References: <20220225173345.3358109-1-keescook@chromium.org>
 <20220225160157.680ecdea21ce81183059bb63@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225160157.680ecdea21ce81183059bb63@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 04:01:57PM -0800, Andrew Morton wrote:
> On Fri, 25 Feb 2022 09:33:45 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > Under CONFIG_HARDENED_USERCOPY=y, when exact stack frame boundary checking
> > is not available (i.e. everything except x86 with FRAME_POINTER), check
> > a stack object as being at least "current depth valid", in the sense
> > that any object within the stack region but not between start-of-stack
> > and current_stack_pointer should be considered unavailable (i.e. its
> > lifetime is from a call no longer present on the stack).
> > 
> > Introduce ARCH_HAS_CURRENT_STACK_POINTER to track which architectures
> > have actually implemented the common global register alias.
> > 
> > Additionally report usercopy bounds checking failures with an offset
> > from current_stack_pointer, which may assist with diagnosing failures.
> > 
> > The LKDTM USERCOPY_STACK_FRAME_TO and USERCOPY_STACK_FRAME_FROM tests
> > (once slightly adjusted in a separate patch) will pass again with
> > this fixed.
> 
> Again, what does this actually do?

One of the things that CONFIG_HARDENED_USERCOPY checks is whether an
object is overlapping the stack at all. If it is, it performs a number
of inexpensive bounds checks. One of the finer-grained checks is whether
an object cross stack frame within the stack region. Doing this with
CONFIG_FRAME_POINTER was cheap/easy. Doing it with ORC is too heavy, and
was left out (a while ago), leaving the courser whole-stack check.

The LKDTM tests try to exercise the cross-frame cases to validate the
defense. They have been failing every since (which was expected). More
below...

> 
> > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> A link to that report would shed some light.  But actually describing
> the user-visible impact right there in the changelog is preferable.

Yes, good point. The bug[1] involves multiple LKDTM tests and their
failure modes, so it wasn't a very clean pointer. But I will include it.

[1] https://github.com/kernelci/kernelci-project/issues/84

> It sounds like a selftest is newly failing, which makes it a
> userspace-visible regression, perhaps?

No, it's been failing since ORC was introduced, but the regression in
coverage (due to switching from FRAME_POINTER to ORC unwinder) was
minimal. While discussing this with Muhammad, I realized we did,
actually, have something that could be tested that was less than "the
entire stack area" and "each specific frame", and that was current stack
depth, so we gain back a little coverage.

> If so, do we have a Fixes: and is a cc:stable warranted?

I don't think it's warranted; it is technically a new feature.

-Kees

-- 
Kees Cook

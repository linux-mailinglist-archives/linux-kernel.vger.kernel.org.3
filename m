Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BE74A5136
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 22:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351171AbiAaVPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 16:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351142AbiAaVPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 16:15:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE18C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:14:59 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 192so13977352pfz.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 13:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PomGqS/ojw0AtqU3Fb7HbY+FvnyoZQSU3mF25QVJV7c=;
        b=Xn0LtiOPnZ1vxiTS8awYMFTe2/FhG6R5vFOU5b6DthICxjaiSEt3oU4Ss5OnfVHbuY
         oS5xHSkhz0GOTKg7+NsE2IPMSRIkVivQn1A7bCl+KW3AxDjiGjWF2jtYBv9/qDBzMxA9
         5RKrkuEXSkU/tKKnrl9aXQhtdaUUHAw0PAObM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PomGqS/ojw0AtqU3Fb7HbY+FvnyoZQSU3mF25QVJV7c=;
        b=z3jEeoamObwVgiUUE06zJgIf7xU5mFYS/fcmSs3yT90Ib0tH/RHDzv2TU5XfOzDzVH
         vd4H7tuH0FQOqtOaVuXoKZJcsWzmg2WvQ+2y6ZxNuStS8Xayr/eeqXJTzSEihvelFyKd
         JD9FWgK3xP6B+7VZv7aMuyp6onUWCE9lMerzy3Yu4cpM2FTevHw3Q7EoAfN6AKwMiC4u
         I+kLvdt8Vu4bPpmLnbWbY3v9Cv+IGSMBbtcOHeMxSuUoKyDS0zVlisBKzEgiD5pmEQo+
         ijdahqTnvoDK9/EHYpuaAJAQ+32HMJkEAe+TWJ0RZ+7CWo/pDrob2n3B3WUdw0mnn/Tu
         RlDw==
X-Gm-Message-State: AOAM531Z6BluaXz7rnyDMbwRKRrUFRIugXOgyQyhWKr2/HVlTU7Qnd84
        g6HvQEQAttb/tBnGF+Gfui4jRA==
X-Google-Smtp-Source: ABdhPJxixcp/Qg2tN2OKN473PxgWYy14w53S3JGe8e8/8ZnXhTR/q5o3PhRX0or1L9AEhH8XZWmwOA==
X-Received: by 2002:a62:e40f:: with SMTP id r15mr22514435pfh.24.1643663699526;
        Mon, 31 Jan 2022 13:14:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1sm29349483pgm.83.2022.01.31.13.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:14:59 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:14:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] stack: Introduce CONFIG_RANDOMIZE_KSTACK_OFFSET
Message-ID: <202201311314.2978E80C05@keescook>
References: <20220131090521.1947110-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131090521.1947110-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:20AM +0100, Marco Elver wrote:
> The randomize_kstack_offset feature is unconditionally compiled in when
> the architecture supports it.
> 
> To add constraints on compiler versions, we require a dedicated Kconfig
> variable. Therefore, introduce RANDOMIZE_KSTACK_OFFSET.
> 
> Furthermore, this option is now also configurable by EXPERT kernels:
> while the feature is supposed to have zero performance overhead when
> disabled, due to its use of static branches, there are few cases where
> giving a distribution the option to disable the feature entirely makes
> sense. For example, in very resource constrained environments, which
> would never enable the feature to begin with, in which case the
> additional kernel code size increase would be redundant.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

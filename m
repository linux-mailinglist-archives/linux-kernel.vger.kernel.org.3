Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1333F46C702
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbhLGWBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbhLGWBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:01:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93163C061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:57:48 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so2895008pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79gSIRlh17e8UNdhk1lnvWs5UXDP8Wc8qj8y2nanflY=;
        b=HII8I8N4bFzOOTgtyEfqLSlTs1ozwu3jd9Tie1CSyO0avbiNCHMvZXpu4wuBEj8xL/
         7l+xd0kFWM2XLtQNMDheDtaUDVpypBVtNJ48UbGxhH8f3WHABcTk1ibgqXz2UJ0TRznk
         UnFcSXgKgzydLcmDMTpRR2tYNuWeyrU7XiuQM9tD/nT8dtkMWobln+8wdNLOcLWPl4yD
         fj6ZmuhGLvr91KZTvXI5c3oYdRoiqAJ76wcQhNSi9jHrd0wfJcXVZO7vLoLORGvxRgKN
         nk2cY5qlJnnPirlh/zywv5Ry5x/sQa+G9CKPJHnIX52inJyAAN5vFMpP5PQiIkkLDFZm
         ozYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79gSIRlh17e8UNdhk1lnvWs5UXDP8Wc8qj8y2nanflY=;
        b=KfCEfweCLwD9FFEUhxklfps5up7+vGyii1VOft94x4XUt90CpYxJ086Kl3v8p2NZCF
         O5VUEqwU2M1YFrq9INEhEBkP4vt5v+VPbPb4hhLEu/4kFlS6btkiXU/Yi6vdv2+s/sKB
         QoOv1uznXlYBKYApzl9Vq974Of3z3iLi8BBCBpqTGaaXPubr44+Iksip48Wxf7zPjash
         lCjoJ6O6EcXKnPfafWmNCfWecKTHsYJiIDRTGPBp4wQm7mz35cbKFzUjO4rctDFzAz33
         kPEldf1qUlEnxdGzI6SO1jQVnDUb+f07LOteHuVO4FuoNQHq+Ixyh2qEswvMsBd7BR9R
         b4XQ==
X-Gm-Message-State: AOAM530SZHtZhFWSPyG4lHPwuxe2cj5ATRfFWTz3VCHvMKjH2AOPzD4U
        dyJWK1ZOrqSDoDJu+n4Le2ZY9w==
X-Google-Smtp-Source: ABdhPJz+qGO0w2Z/Slu6Gq14krFl2gnoxtZ3oOaAAu4DF0SJhOU3QW4ke5BxMk9EOfTabAZNahNtIQ==
X-Received: by 2002:a17:90b:2412:: with SMTP id nr18mr2345451pjb.233.1638914267914;
        Tue, 07 Dec 2021 13:57:47 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id na13sm493507pjb.11.2021.12.07.13.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 13:57:47 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:57:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/4] KVM: X86: Only get rflags when needed in
 permission_fault()
Message-ID: <Ya/Y1+6BR4exkTKK@google.com>
References: <20211207095039.53166-1-jiangshanlai@gmail.com>
 <20211207095039.53166-5-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207095039.53166-5-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> In same cases, it doesn't need to get rflags for SMAP checks.
> 
> For example: it is user mode access, it could have contained other
> permission fault, SMAP is not enabled, it is implicit supervisor
> access, or it is nested TDP pagetable.

I don't disagree that reading RFLAGS is silly and _may_ have worse performance,
but I'd prefer any change have actual numbers to justify that it's an improvement
or at least a wash / in the noise.

Too much of the MMU code (and KVM in general) has optimizations like this that
have bitrotted horribly over the years.  And in many/most cases, the original commit
didn't provide performance numbers, so it's not even clear that the "optimizations"
were _ever_ a net win.

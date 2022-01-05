Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036BD485BA1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbiAEW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiAEW3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:29:09 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E1CC061212
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 14:29:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id iy13so426669pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 14:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NlNJ4grmTdeP8Ezi+MHLWLR1H1WOrSKO/roOqPIpLbo=;
        b=lcWVbw4ShlPDOZFedTW9LKOrUtdb0j3Ok8QwjZL8FBH5aeSmphdXAviZUApWVabJb8
         7mZiOI+HYWoiuw9OnP1dEWf+3SAc2EemATQSiH+geyoR3m00KucUcyfLLH428z3KMu3f
         Sd3raTZPd0glAqzErWQNsYb8C+R27GgqE7Mlgz8JyXPcJAuv3jBIQfynG4tq1UvnI6/M
         DU+wvedrGddOUpODqItCFlOOjxzWK+KPv0jGTsIbfAkLwzMsB40eO9cP0zYyLedPWVT/
         UnVR1B8xFbscWQ2l1T8EWcI64u/gQWqHV0IFWaka7AmfIOaGTuG/8kmljTWb8b3hyu1x
         bnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NlNJ4grmTdeP8Ezi+MHLWLR1H1WOrSKO/roOqPIpLbo=;
        b=LaGIY7WEpiP25Mx3TtjJt72r3Lm0iBk1juybFUEySdMdIC2BWO0cc26j+CvF4A8x1R
         j+KDm6NQxhbq6tSNMMVWXzwklKluYQv45Gc8e8oTEAqoV2oWbx0epjOY7LyyzsFVgGTW
         FOkLY1++RcfR1ItV1ZHR4dLr/f19AgB8BQCEZHxBsMuHOZSahfqZBy7Nz5hxrEozO/v9
         /pZs5VhBeR602vy8AuxfKnFLDDyYMZzkgIh5YydKQpKHl2el2iU3xUc6xPMnKj1112Ac
         ISdcSk8IC2oy5ejGXYEyPU/2wFONBcCqODOpNzS8qu73df99JU0En7eY20O1BR1zURpn
         z5VQ==
X-Gm-Message-State: AOAM5301UO1VTqLYMAh/IoJ7SjawUUiKBJo/wlWAWniCsYf9zQPC2hc/
        HURV0bFLCZzE76UCLN78BL7cDQ==
X-Google-Smtp-Source: ABdhPJw/hS0IxkmtNQWaTfp7MjckeyXJKDDA6HAM1Mtx+suUSTVQ4BsX6dhq/PytaoZhbdgDvhwzKA==
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr6662981pjb.57.1641421749028;
        Wed, 05 Jan 2022 14:29:09 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id p6sm52463pgl.16.2022.01.05.14.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 14:29:08 -0800 (PST)
Date:   Wed, 5 Jan 2022 22:29:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Yang Zhong <yang.zhong@intel.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, pbonzini@redhat.com, corbet@lwn.net,
        shuah@kernel.org, jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v5 16/21] kvm: x86: Add CPUID support for Intel AMX
Message-ID: <YdYbsQ/q6VzR3m7d@google.com>
References: <20220105123532.12586-1-yang.zhong@intel.com>
 <20220105123532.12586-17-yang.zhong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105123532.12586-17-yang.zhong@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022, Yang Zhong wrote:
> From: Jing Liu <jing2.liu@intel.com>
> 
> Extend CPUID emulation to support XFD, AMX_TILE, AMX_INT8 and
> AMX_BF16. Adding those bits into kvm_cpu_caps finally activates all
> previous logics in this series.
> 
> Hide XFD on 32bit host kernels. Otherwise it leads to a weird situation
> where KVM tells userspace to migrate MSR_IA32_XFD and then rejects
> attempts to read/write the MSR.
> 
> Signed-off-by: Jing Liu <jing2.liu@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

No need for my SoB, I provided a very tiny snippet of code review.

> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---

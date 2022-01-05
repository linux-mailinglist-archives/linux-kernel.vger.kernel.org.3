Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208C0485799
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242501AbiAERqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242491AbiAERqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:46:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD48C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:46:39 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f8so26069930pgf.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kukafVx7055r8OcVvqLzxD7DUbrJSCUpCeX5KLtoe+4=;
        b=M22wNw8Ag6nNk/CCBGok616/uNIatExoP5zvfwTiJeJtGC2X3te82k04ifGULNQ3dp
         IZ4GhWDyehtar1ZxQFtOxwSG8KAlWvmeXwjL6IY8Gb8Mn8eME+l2Hyulw+6BxhXt42W7
         +qejfmnhDbh0fUwK+gbY0pixmm2l+xJpl25CMXciNAtSMgkp1tukQUcbPhy7scSIgWD2
         SQS/T21VRKmUgxTk9w9vC1fmO43KqNuVNk2I+ZJHRW52d/TnCNw/g/tcxktjrfUTFoIi
         7XfxeMEqeMCa1YRMk7r3X25peeefoYjMqrKApr5ZDbe8NPtESx0BhWHg+/d+qjnEKxbL
         IGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kukafVx7055r8OcVvqLzxD7DUbrJSCUpCeX5KLtoe+4=;
        b=P0Tgb0cnMpN/mhw+L6Rdiu1waCxCKMrj591aNOUolPa1ys4IIWBzDgP5Z9h2z0tYtR
         udCFw+ZNkU9cZIZ6C4BLt5/ry2Cr0a/YowFDQS1ad08l5xRT5mD6wbWvrXKQNc4h6FJ9
         0yCGo97QkTh3a8VjYNIAXctc0k6gniHLaj/KHU/duM7HocBT5tlI5z5/tqqkAEeCS/CQ
         Dq9TeH1fL5dIIKQJzN3qtiE4Ukgg+c1NsQ87lpRQTmWPrh1vqrVpyMOvOEbmK9xb65FP
         AiIppvyzNEqEFvM7a4sbZUDmp1Y9xSXYCN8CJpDp+im70Cxg5ocy2oQ69Wnbg0oJsJp6
         XlCA==
X-Gm-Message-State: AOAM531PH3MVBCpRx5/ztYryK5FACcwbrI2UQyFrPAqSKZJfSuJLaY60
        HSS5Vp6u6zwEUEUcn7WGIqk62w==
X-Google-Smtp-Source: ABdhPJyFwjYQf5hPBRwiSxtXmUuk3gBK75txy6WOHVYaJF2EbPU3M40gOP5ibeGVz1vFJzTc/ztwbg==
X-Received: by 2002:aa7:88ce:0:b0:4ba:efec:39e0 with SMTP id k14-20020aa788ce000000b004baefec39e0mr56680934pff.80.1641404798687;
        Wed, 05 Jan 2022 09:46:38 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l2sm45836425pfu.13.2022.01.05.09.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:46:38 -0800 (PST)
Date:   Wed, 5 Jan 2022 17:46:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2 2/5] KVM: SVM: allow to force AVIC to be enabled
Message-ID: <YdXZeuCKo58t3kD5@google.com>
References: <20211213104634.199141-1-mlevitsk@redhat.com>
 <20211213104634.199141-3-mlevitsk@redhat.com>
 <YdTJPTSsM1feVwt/@google.com>
 <dd7caa75ae9aef07d51043c01f073c6c23a3a445.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd7caa75ae9aef07d51043c01f073c6c23a3a445.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022, Maxim Levitsky wrote:
> On Tue, 2022-01-04 at 22:25 +0000, Sean Christopherson wrote:
> > This is all more than a bit terrifying, though I can see the usefuless for a
> > developer.  At the very least, this should taint the kernel.  This should also
> > probably be buried behind a Kconfig that is itself buried behind EXPERT.
> > 
> I used 'module_param_unsafe' which does taint the kernel.

Ah, neat, TIL.  Thanks!

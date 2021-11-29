Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A4A4626B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhK2W4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbhK2WzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:55:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62939C1A0D1F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:36:36 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so12240125pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 10:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tlAzD3aQxZNbhH82DiZEqP09YfqX3PXGzrFEKOt1BUE=;
        b=VMyEtGnE90jgPkfdArsfFQ73biEKasoDaOcmKYoZKhQrm4TkNFsD5TTOC+i1xSw4IA
         QwSOEIYqYFet0ZZuJcRlz/K5uFQE/fenSx0d0EnnQ6oZbMNHkjflfqpu20QoV/0Nih3R
         nMzQUwHTrrLjS0cxhTgTVwhC7ZASBaqm1glT2gMVZ9zfl+0rqU/1lxZr1KBKehahtfy9
         cXLL/bvyEMQd0qujLL/xmH/ESnBM3510+1Nuicl2fKEThRU8WVOA8JCJKg3STPnXD26P
         DDqxVmJCx2aXGJ6DArW+HHKb8MeCVbRgGp2m7sZZjJfZ78gCHNoKusXy9dix+Y0oTbAR
         QSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tlAzD3aQxZNbhH82DiZEqP09YfqX3PXGzrFEKOt1BUE=;
        b=gN/HWKT82a1jY8wCnEe3PbjCI2tIPnpdCsuF/jzRIEg0+e7axIQrzcxGgqBa2OUIRd
         vFqHNqDXMx7iyJx3hcKpYnT4apqyUxJpb/wa4Z3eOdh5oKlCtqlqCp+YY83Ea3l7reSF
         qkA8XhhWip+VCj3TCoR6LTKMhVw92gykyOuuIEsamC7MAPfQ1lviyVmPs67YRgKASete
         B0vVg7O8DtOM09OQORGG+kTWaJwHhHiKDVF9tdcEk22mJfEuPQhzE4bSMWS59DBkla3n
         m7kfKOMjDToOykoqq25W0GNw5bzAGxrAASFWkdcfr19v8SgAJexlWtYKwsmeNzlA7KG7
         MDpA==
X-Gm-Message-State: AOAM5320kxDovq1r/jgp7gthoXOc1Kxr8djzqkxCu65JKmhZJGT53asi
        J4Gh4dPJDrkD1lUaz2TlSClDKw==
X-Google-Smtp-Source: ABdhPJx8WtPK3FSjNprjLl/l1toByBy/n2qpSmC6t2XTOO85rqwFTlV9d2tAz2CyzikyPU9sLpNeRg==
X-Received: by 2002:a17:902:aa43:b0:143:e20b:f37f with SMTP id c3-20020a170902aa4300b00143e20bf37fmr61456504plr.65.1638210995742;
        Mon, 29 Nov 2021 10:36:35 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 95sm62436pjo.2.2021.11.29.10.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:36:35 -0800 (PST)
Date:   Mon, 29 Nov 2021 18:36:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     isaku.yamahata@intel.com, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [RFC PATCH v3 47/59] KVM: TDX: Define TDCALL exit reason
Message-ID: <YaUdr5tL7d+kpsX5@google.com>
References: <cover.1637799475.git.isaku.yamahata@intel.com>
 <eb5dd2a1d02c7afe320ab3beb6390da43a9bf0bc.1637799475.git.isaku.yamahata@intel.com>
 <87k0gwhttc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0gwhttc.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021, Thomas Gleixner wrote:
> On Wed, Nov 24 2021 at 16:20, isaku yamahata wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >
> > Define the TDCALL exit reason, which is carved out from the VMX exit
> > reason namespace as the TDCALL exit from TDX guest to TDX-SEAM is really
> > just a VM-Exit.
> 
> How is this carved out? What's the value of this word salad?
> 
> It's simply a new exit reason. Not more, not less. So what?

The changelog is alluding to the fact that KVM should never directly see a TDCALL
VM-Exit.  For TDX, KVM deals only with "returns" from the TDX-Module.  The "carved
out" bit is calling out that the transition from SEAM Non-Root (the TDX guest) to
SEAM Root (the TDX Module) is actually a VT-x/VMX VM-Exit, e.g. if TDX were somehow
implemented without relying on VT-x/VMX, then the TDCALL exit reason wouldn't exist.

> > Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> I'm pretty sure that it does not take two engineers to add a new exit
> reason define, but it takes at least two engineers to come up with a
> convoluted explanation for it.

Nah, just one ;-)

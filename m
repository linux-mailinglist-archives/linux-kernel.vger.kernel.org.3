Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762BA484821
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiADSyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbiADSyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:54:37 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752B7C061792
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 10:54:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id b22so32978876pfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SQ5RhW4eDilLMPyc9bhU13pImRzzY2v6QOM1pfo38V8=;
        b=koLsdr6Z61JJ8itgoPjSxMapq/jZq2JExRoeRGm6Ymo+FW+8kvDNi7OagSxtoWZ0Bv
         MpDDzuWq6PJlIuQrMxFucGluU//+qaA7EfcTiAxqg/r7fbBrXQ9s0pD3yFZMeQBRmL1I
         HC0Zs2FtSBPOW1aMVqALYm7qyi1D0MnQkk+gimnxmn6sWkOcBDiUTkeYKN5jzZHILcrK
         1HKQeEpg0n5BZFIo8RcMmERRLpASQhur4FwP9t3OO5ePpK+ZZrWwwzJxx1GcycyT0MPl
         9Z2neS0G/LH7+u9KEb20slYvlwJ7YjSYlkzFcCp14vRE/6gnBBMe41tXls0Zd5edwftV
         nXNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SQ5RhW4eDilLMPyc9bhU13pImRzzY2v6QOM1pfo38V8=;
        b=tB9/RH2RcFYUpvBRG6B/Bksj9shJnWUcZbjmItczqL/oo7l7KceqqDfu++rMMSKatT
         oVvh/yhhT/FXPaAzkindYPrWWFApHI0jTrmqZQvB63XxxzcqTx+meerTrVK7fc5N928D
         4C27XC278kjl8+gq/VDsz44U0eN/dNsCJuSCCQFPtfW+J1lGqPlm1+OJYUrHVs3vyM6y
         EeqHTusz0wYWPOGMhME3wOjj5p1sLCk2CIMDFf7atf1d6CWqgrMCpuYnMqDhFKjdnKPo
         xrAXBtQD3YO/ocsDxMWEIkOl3HzazzhgMnalX5dORlZjclJz+0GM/FvFrna37y84OFXL
         77uA==
X-Gm-Message-State: AOAM532APEPAQ8NS0GEfDJrrhAHIYSkFS19Kzu7xkdCtH93PpTphbBJ/
        2kfXhsJDZShyzn6bwxRzrt57WQ==
X-Google-Smtp-Source: ABdhPJxEEIHbK9iLF2pyO3jA67EY8/reMB2NWCdcLYwYiTxqjtxzPlY5MquS7i8gHE47KubqENvRBw==
X-Received: by 2002:a63:745d:: with SMTP id e29mr30542700pgn.213.1641322476764;
        Tue, 04 Jan 2022 10:54:36 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k141sm41488991pfd.144.2022.01.04.10.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:54:36 -0800 (PST)
Date:   Tue, 4 Jan 2022 18:54:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Yang Zhong <yang.zhong@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, corbet@lwn.net, shuah@kernel.org,
        jun.nakajima@intel.com, kevin.tian@intel.com,
        jing2.liu@linux.intel.com, jing2.liu@intel.com,
        guang.zeng@intel.com, wei.w.wang@intel.com
Subject: Re: [PATCH v4 00/21] AMX Support in KVM
Message-ID: <YdSX6NANtx0SXjfK@google.com>
References: <20211229131328.12283-1-yang.zhong@intel.com>
 <d43887b6-630c-446e-caee-dcbaa72f2466@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43887b6-630c-446e-caee-dcbaa72f2466@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022, Paolo Bonzini wrote:
> On 12/29/21 14:13, Yang Zhong wrote:
> > Highly appreciate for your review. This version mostly addressed the comments
> > from Sean. Most comments are adopted except three which are not closed and
> > need more discussions:
> > 
> >    - Move the entire xfd write emulation code to x86.c. Doing so requires
> >      introducing a new kvm_x86_ops callback to disable msr write bitmap.
> >      According to Paolo's earlier comment he prefers to handle it in vmx.c.
> 
> Yes, I do.

No objection, my comments were prior to seeing the patches that manipulated the
bitmap, e.g. in the earlier patches, having anything in vmx.c is unnecessary.
 
> >    - Directly check msr_bitmap in update_exception_bitmap() (for
> >      trapping #NM) and vcpu_enter_guest() (for syncing guest xfd after
> >      vm-exit) instead of introducing an extra flag in the last patch. However,
> >      doing so requires another new kvm_x86_ops callback for checking
> >      msr_bitmap since vcpu_enter_guest() is x86 common code. Having an
> >      extra flag sounds simpler here (at least for the initial AMX support).
> >      It does penalize nested guest with one xfd sync per exit, but it's not
> >      worse than a normal guest which initializes xfd but doesn't run
> >      AMX applications at all. Those could be improved afterwards.
> 
> The thing to do here would be to move
> MAX_POSSIBLE_PASSTHROUGH_MSRS/MAX_DIRECT_ACCESS_MSRS from VMX/SVM to core
> code.  For now we can keep the flag.
> 
> >    - Disable #NM trap for nested guest. This version still chooses to always
> >      trap #NM (regardless in L1 or L2) as long as xfd write interception is disabled.
> >      In reality #NM is rare if nested guest doesn't intend to run AMX applications
> >      and always-trap is safer than dynamic trap for the basic support in case
> >      of any oversight here.
> 
> Sean was justifying this with lack of support for nested AMX, but I'm not
> sure actually what is missing at all.  That is, an L1 hypervisor could
> expose AMX to L2, and then an L2->L0->L2 exit/reentry would have to trap
> #NM.  Otherwise it would miss an XFD_ERR update.

Ya, I was assuming there was something L0 needed to do to supported nested AMX,
but as Paolo pointed out there are no VMCS bits, so L0 just needs to correctly
handle #NM and MSR interceptions according to vmcs12.

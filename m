Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801E4626C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhK2W5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbhK2W5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:57:01 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB8C111CC6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:35:39 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so17633479pfe.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 09:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ih96BbBVwkaa/OAQ5xOmVRG9puh17aiQdZRT/C4C3Ak=;
        b=IB7kdk8Kw4Vt4issjhrdqTqcHxhUbTuN4QjXWmQJ78KndsOpzLhkIIyfu6MGZhY6I4
         lZGE7NR6DIi8zQ6m0ui9wMGtbw2+zKGUuh/DX325VFDyZ/cZZtzWk3vMIrgGE87o/+nQ
         sPjDQhimKVChuR72c+tvHLRvL1wRLaUmxMTk6zlU7g3dKTbI5g2M8l0NcOjt+0Syl5lm
         uGLFwejfa1499k3iVSzq0N47iiSUsbDV5jMVgHgv9FmqFxChnXP3OruuV7tXMoUcQaFh
         bHhdE0vxUZxZIADZtRIVAk6ExnZQYEbH0cC2bpDfiD8hN1pfzF6DuNs+in11fNm9rWP0
         l3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ih96BbBVwkaa/OAQ5xOmVRG9puh17aiQdZRT/C4C3Ak=;
        b=yzSGpjGNJpoThFhe9XOBGEWU/F7l5OFOsVNEcUoMC0/eIBuUQ9Z4pK3GOw59ChA5Bm
         azshrmZp9E9iuJw8IWBPBtzcttzBgrANgC1WqzB3nX/7aD1JxFxsj2cTBnmiPajTj8cU
         iFdeH+u4Bwlkj+jUTJB0nsZ7XGvvSq+vM/pbCptwiaa9bFdFwR9KU7zdkaIn8azQf3cU
         aWo3GFt4Ld+XbunbHcu3nQfs7FoWuxT48QdKqZI5aY2BkrQZs9E4T8cvTDGsx2r6vCsz
         DXAXMMt3KHoYwWCniiP/kFXvfWdN8TrNb/OAgwJTqmPMTDMSkHWf69Td2peGVN/z7KCf
         evXg==
X-Gm-Message-State: AOAM531St2f08uQBnMOPxUmWejK8RkQpyxgJAZFBFV/CR7D9llRc6Nvq
        TmAwKtaZo9IuC0ptoMDS/dWJwg==
X-Google-Smtp-Source: ABdhPJw8ktOad9TfV2nRroxY5SC1V237eK+PLNwpqF9SV/4/4MaSkNfSKd+yv/2Q/ltiECMCVFT5LQ==
X-Received: by 2002:a65:6488:: with SMTP id e8mr36312690pgv.416.1638207338797;
        Mon, 29 Nov 2021 09:35:38 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d9sm387607pjs.2.2021.11.29.09.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:35:37 -0800 (PST)
Date:   Mon, 29 Nov 2021 17:35:34 +0000
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
Subject: Re: [RFC PATCH v3 14/59] KVM: x86: Add vm_type to differentiate
 legacy VMs from protected VMs
Message-ID: <YaUPZj4ja5FY7Fvh@google.com>
References: <cover.1637799475.git.isaku.yamahata@intel.com>
 <60a163e818b9101dce94973a2b44662ba3d53f97.1637799475.git.isaku.yamahata@intel.com>
 <87tug0jbno.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tug0jbno.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021, Thomas Gleixner wrote:
> On Wed, Nov 24 2021 at 16:19, isaku yamahata wrote:
> > From: Sean Christopherson <sean.j.christopherson@intel.com>
> >
> > Add a capability to effectively allow userspace to query what VM types
> > are supported by KVM.
> 
> I really don't see why this has to be named legacy. There are enough
> reasonable use cases which are perfectly fine using the non-encrypted
> muck. Just because there is a new hyped feature does not make anything
> else legacy.

Yeah, this was brought up in the past.  The current proposal is to use
KVM_X86_DEFAULT_VM[1], though at one point the plan was to use a generic
KVM_VM_TYPE_DEFAULT for all architectures[2], not sure what happened to that idea.

[1] https://lore.kernel.org/all/YY6aqVkHNEfEp990@google.com/
[2] https://lore.kernel.org/all/YQsjQ5aJokV1HZ8N@google.com/

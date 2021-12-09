Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73946E022
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbhLIBUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbhLIBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:20:01 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB42C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 17:16:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5076060pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngoPwqqbhfOLLeyaWlockMByhsnvfUz95KBFPY/FjQE=;
        b=THMEvCQ4OgR2pWehVPf4SjhgrdSd0hwGC+zK3eOQX6gtv7UbSwvQZnNFnegvWv5SCl
         BN6nVQIemMjAC0X1lgvEubz33RbIClBv/bbS51nFydO17TKYOEeA/qEw9O5eugFQLQOO
         T8vWUQgc1p3bub/SpNfSLPraTa/vrsIyt142Eg4KVh/OZvCJ/duvL1aAhpbiovo+XzGc
         DCCy6cDK3JySX7UOlITdWRKpGeZzQDEDTyn2eOjY5WzIT+VJBczBwib04FlNNahwLU1q
         XR0yoRSsQFTsAe4hUQvyn7rqae8ZIYwonPlexVl9ZHco1YzI//sqilUpLp/0IqD2kFUL
         UxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngoPwqqbhfOLLeyaWlockMByhsnvfUz95KBFPY/FjQE=;
        b=GpRr/wpXXFJnsgUH+Kxz1NTF+NVpmwe0koIgKFZwjcPy1JPFoATYMf1pqm+iHneC+a
         U8Uhpz/6bBxtCMJXCeHPdo5XSUetqT6MgcjBaCVfNT6MnEft50xODBgDEPbStlrgnDQB
         bDAQUa4CL7t4+1rXykMF5jULHnwH01xIsEHPoQqYR93OHNNnjvpDKs6iUoIoXmuPtPrS
         ZyVLSIfOpOtrEea/3PiOGkxZOWBvoW69uE3m2jnMJfJm4xyHWD6boE8kwzNHh3R7Wj+m
         avgMS5aGJPFrAO7qjxZNnh4UkziXQq5qDWa41ZEMVOr7nV9MfRojud4/jgKk6MUg9b0a
         h2/A==
X-Gm-Message-State: AOAM5304M/DYlFhzH5QHNBQ6yUf8NQw1kktRaPfAM7/Q0ZMDIT0GRw7b
        f0x5NAWYY+sPR4ZHimwtGJbQGE3seDwuQg==
X-Google-Smtp-Source: ABdhPJxsVffgoFVWKf4rmd52sXQPLLkExYCQayiNn1FIpOuQK1LnqxzzkxJ7jmZOXIFUuuYuPgXl2g==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr11845971pjb.236.1639012587943;
        Wed, 08 Dec 2021 17:16:27 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q6sm3561347pgs.19.2021.12.08.17.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:16:27 -0800 (PST)
Date:   Thu, 9 Dec 2021 01:16:23 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 1/12] KVM: X86: Fix when shadow_root_level=5 && guest
 root_level<4
Message-ID: <YbFY533IT3XSIqAK@google.com>
References: <20211124122055.64424-1-jiangshanlai@gmail.com>
 <20211124122055.64424-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124122055.64424-2-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> If the is an L1 with nNPT in 32bit, the shadow walk starts with
> pae_root.
> 
> Fixes: a717a780fc4e ("KVM: x86/mmu: Support shadowing NPT when 5-level paging is enabled in host)

Have you actually run with 5-level nNPT?  I don't have access to hardware, at least
not that I know of :-)

I'm staring at kvm_mmu_sync_roots() and don't see how it can possibly work for
5-level nNPT with a 4-level NPT guest.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF796462620
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhK2Wrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbhK2Wqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:46:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A51C0E5F57
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:03:46 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id p13so10569933pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e6IniIPBHNP7py+Zam33DoxYy63SwgIR7otg/BdG92E=;
        b=Cj6DRb/Wr6k5aSs39FIg5V/eF44R9vY7GMesiE16J/NQVN2S4xdpIKtS/BRbR4Rj8U
         OouxLh9hb29auaUm18D71g1ptVUR11bBf1Mdvp8SBnsSxdwB4lB6FgiFHZo6I62fk9Fn
         2C0SBT2HoHJZsMQKqEwsMWb2MytUMe43Cdq6a1T1KBd9DQbGY2YAL/Z1bRgyRQ39hDzq
         ijRO5n/LKKg0f973z9rI3/E2XiF49bPArKVi71Tih5zynxaN6bREm+c/I3QfD+k4l2hA
         8sUs4Mpnqicux05pce1ItWbTYO3IjFUEHc5ENiYylFKZMgIvJsKMn+sYpfsvUc7Xdpdc
         j80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e6IniIPBHNP7py+Zam33DoxYy63SwgIR7otg/BdG92E=;
        b=MdHS8cpTpVsZuVhPaJPdRRnxA7J2VVCV9eARyu4ZlSdm4UuLZfAgNtH9r4KvJ351jT
         hkgh4aNnqPRHTso+h/gU/wqpQg3oJJluI56la30VIGy1A+37X2T3opJNLSGjK+bdsYqZ
         zxpvtJvZ8AnN3J6KCNhgjKTOCNvhLdHKH9QiIS6uq11o771JCe8IqZDBkTo8bvV88Qw/
         5Q+vW7b5t60VZClvLEvz01Jf5/tvtGWXV1XyT3vjqDd63wP53sPn+4sHCEL4uE4Sp0s6
         jIhJjhUOdgZBBXpP644zApGni/2fT/v6LT1FLkNiA7BWP8fxmMGmDzRKBGOdbBGVbpTg
         7Jag==
X-Gm-Message-State: AOAM531a+wiH2cW+qUuQwE2SeRYNkh/J9rLQvA1glwSKi596lkyy9iRR
        CsYu5rJzP82KxAe7RNfoOMYMUw==
X-Google-Smtp-Source: ABdhPJwajda0DS86iYJTa9gL3aBxhvPESOobKwV9vimr5RsblL3j0NBn5anBsPX7W8MkpZMvNYMYkA==
X-Received: by 2002:a63:d413:: with SMTP id a19mr3061139pgh.552.1638219825759;
        Mon, 29 Nov 2021 13:03:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g17sm106551pgh.46.2021.11.29.13.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 13:03:45 -0800 (PST)
Date:   Mon, 29 Nov 2021 21:03:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Igor Mammedov <imammedo@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: x86: Avoid overflowing nr_mmu_pages in
 kvm_arch_commit_memory_region()
Message-ID: <YaVALTZbutlVPz8k@google.com>
References: <cover.1637884349.git.maciej.szmigiero@oracle.com>
 <44edcde46d12c2f5376a1cd1429650acb506ebaf.1637884349.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44edcde46d12c2f5376a1cd1429650acb506ebaf.1637884349.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> With kvm->nr_memslot_pages capped at ULONG_MAX we can't safely multiply it
> by KVM_PERMILLE_MMU_PAGES (20) since this operation can possibly overflow
> an unsigned long variable.
> 
> Rewrite this "* 20 / 1000" operation as "/ 50" instead to avoid such
> overflow.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

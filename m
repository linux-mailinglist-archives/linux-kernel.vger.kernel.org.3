Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47AE4A0326
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351631AbiA1VsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351611AbiA1Vr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:47:59 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DD7C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:47:59 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id z131so6337184pgz.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gEFhmZLFOnXMQveiDfoP1+6Mljbbxm8tsJX8s0nRB78=;
        b=ZuM+rah6VlxJjLQN6XGuzLjNMOR8gefWcnDB4s6zlMlT6qajSenVWettyIecArWDnC
         Fq0slbwG5XONSEXFvWzvMRN9PXT1+IBmW6lwfBLr4Q9wyOX5ambmxjvNzbI+2898WjCK
         tf0bZSvggWSVNk+Exkq7K5V+qAYWlclBozqSSAbbIPaMFXdD2TDQj6ziFP3Kc5c6FoAP
         OW4n/CPH5jbNcRJLgNSBY35il5AQS5qh8n2ID/SNJxAeIi/N40gCxCj4Si00oLlZiMGx
         7T4OTsXHLOSivcWgzIWtNMKTJbdoOpXQjUfaczYJ0L39kRCHd6D/YQ/56kpj/Jz3jvAe
         eqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gEFhmZLFOnXMQveiDfoP1+6Mljbbxm8tsJX8s0nRB78=;
        b=aKdeDCxMQaBPAloZPtAwR17A3X/xUullfgIjqJ2I8FfY5MlXla+t3hkUcVV/N0+bH+
         LJJLLib515I/4CvTkDrePR/MKuxsjb9mFYtMXUcpxUN7JyZKlXPPW4n/jO35vg4UC/Ic
         3usYrJ333XGOOcW/DSn14CTpaMiYSAjuA0/i7s/6YBshu9C7nnNoGiMGJzrV9KXAPZQT
         uRyjcVIfAjV6pvQKqeWoaHk8RTYJe5RpovZFTGUFzVCx058gF/p+ksGdbwsnSrZMvQqB
         iTPD4yy16IpflJ3VzzjzLr3ZlALvFomY7Vp8Lr8Ve9X8VLXpIWW0KdhzeWYEKJ495xxe
         SRNQ==
X-Gm-Message-State: AOAM532v10PBFXos/RHFHixF2BEdj0Izttrmj4cDauSQBDN7wNHo71eS
        PIqyjfjW/bO4jIycBpZXN50ZrQ==
X-Google-Smtp-Source: ABdhPJwX5sN3fH7qxvbXfpsrKjhMhqnPjg2rx9bnF3SHFEOoCAYH0x1xlE0N3SmaKtEpvCSO3Qiw9Q==
X-Received: by 2002:a65:424d:: with SMTP id d13mr8034233pgq.82.1643406478387;
        Fri, 28 Jan 2022 13:47:58 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v13sm9977689pfi.201.2022.01.28.13.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 13:47:57 -0800 (PST)
Date:   Fri, 28 Jan 2022 21:47:54 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Michal Hocko <mhocko@suse.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix rmap allocation for very large memslots
Message-ID: <YfRkivAI2P6urdfn@google.com>
References: <1acaee7fa7ef7ab91e51f4417572b099caf2f400.1643405658.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1acaee7fa7ef7ab91e51f4417572b099caf2f400.1643405658.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Commit 7661809d493b ("mm: don't allow oversized kvmalloc() calls") has
> forbidden using kvmalloc() to make allocations larger than INT_MAX (2 GiB).
> 
> Unfortunately, adding a memslot exceeding 1 TiB in size will result in rmap
> code trying to make an allocation exceeding this limit.
> Besides failing this allocation, such operation will also trigger a
> WARN_ON_ONCE() added by the aforementioned commit.
> 
> Since we probably still want to use kernel slab for small rmap allocations
> let's only redirect such oversized allocations to vmalloc.
> 
> A possible alternative would be to add some kind of a __GFP_LARGE flag to
> skip the INT_MAX check behind kvmalloc(), however this will impact the
> common kernel memory allocation code, not just KVM.

Paolo has a cleaner fix for this[1][2], but it appears to have stalled out somewhere.

Paolo???

[1] https://lore.kernel.org/all/20211015165519.135670-1-pbonzini@redhat.com
[2] https://lore.kernel.org/all/20211016064302.165220-1-pbonzini@redhat.com

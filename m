Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93F4856B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 17:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241965AbiAEQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 11:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiAEQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 11:33:58 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678ECC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 08:33:58 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z3so29636227plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 08:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mtwlOuBMKulEOPBbjvkpfAsCuHwQtXlrNuDdtEXb3yk=;
        b=EkUkFARHU2bTF7/RsdlcwmXNRbvmXWA+oJmtnoljbNVOt20XG/bFxtZbLvtdVldEA3
         fZarFU2B41kGIYOIabEQFr2oFfXErkOOcS8onJpIIgaVv66U4aiReQgkHPhPWcJX4k37
         VgRBvjmZWrnjWvCU4o+3l3iQZ2wKA77XsuUaNWx0zFBSXRYL7G8RV1QZ6B3FZ55twhPN
         PVzQYBBPKbP233o+opplzKrGu47O3sHUHUbW+BlfW+5q7NXk4vXQLtE64FXK9jz03JaM
         zMNx27HLEFIQY3AcG9rPyi/UUvlUmigPu4TsoBuXwP67MYd7JZKEpDVYxa4ckE44xR/R
         Iyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mtwlOuBMKulEOPBbjvkpfAsCuHwQtXlrNuDdtEXb3yk=;
        b=4Ip41pZLmsKdLI45I83iNfrGE8sciBNcDYDtbtfbMs+NYM4o2t11RV6ZRgSYE5EOnw
         TrOX0upSdOURdI4KXiJzZkByCMwK3bz/T71YGDZ5sD6TuaMVhTsXXr4Do0lTT3UdD0pl
         L9vdTu3rYd5YMPEPRZUSdmzk73SsAIGhJ9MuByVi/uNzSrVylBd/2WOxlRtCz5uVkP0n
         qX9EVwTp81uLtJ616vn+Rh4O66eGt6YJqbiBnSbba+Lam6NG4KyejXjlz7DRr7BETKRD
         CcAwX6GNpAwWxajMrr/IZC5QBAoZvUV2xSFE7/xs31xK+TUcuwBb+F98dcyfidz3nl0t
         hTxA==
X-Gm-Message-State: AOAM533K4WcoUBQY6OdGTauNT+9rugXQ8P/XCqnsxN+K7CHwG+4l/Kic
        da0J4HGtL5Y9fqAElx55Cz62dUMqa3I9HA==
X-Google-Smtp-Source: ABdhPJwAH77KGApF2ahXvBPCwLm1aX7do+zvwNg3UmVLPOZV0wWwfJL25/RwoDJuA0yzTG3FmgdnSQ==
X-Received: by 2002:a17:902:a5c2:b0:149:caa1:2902 with SMTP id t2-20020a170902a5c200b00149caa12902mr4486562plq.57.1641400437776;
        Wed, 05 Jan 2022 08:33:57 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n28sm2103476pgl.7.2022.01.05.08.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 08:33:57 -0800 (PST)
Date:   Wed, 5 Jan 2022 16:33:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2 25/30] KVM: x86/mmu: Zap roots in two passes to avoid
 inducing RCU stalls
Message-ID: <YdXIcUcJ+6qg277s@google.com>
References: <20211223222318.1039223-1-seanjc@google.com>
 <20211223222318.1039223-26-seanjc@google.com>
 <YdTj/eHur+9Vqdw6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdTj/eHur+9Vqdw6@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022, David Matlack wrote:
> On Thu, Dec 23, 2021 at 10:23:13PM +0000, Sean Christopherson wrote:
> > Zapping at 1gb in the first pass is not arbitrary.  First and foremost,
> > KVM relies on being able to zap 1gb shadow pages in a single shot when
> > when repacing a shadow page with a hugepage.
> 
> When dirty logging is disabled, zap_collapsible_spte_range() does the
> bulk of the work zapping leaf SPTEs and allows yielding. I guess that
> could race with a vCPU faulting in the huge page though and the vCPU
> could do the bulk of the work.
> 
> Are there any other scenarios where KVM relies on zapping 1GB worth of
> 4KB SPTEs without yielding?

Yes.  Zapping executable shadow pages that were forced to be small because of the
iTLB multihit mitigation.  If the VM is using nested EPT and a shadow page is
unaccounted, in which case decrementing disallow_lpage could allow a hugepage
and a fault in the 1gb region that installs a 1gb hugepage would then zap the
shadow page.

There are other scenarios, though they are much more contrived, e.g. if the guest
changes its MTRRs such that a previously disallowed hugepage is now allowed.

> In any case, 100ms is a long time to hog the CPU. Why not just do the
> safe thing and zap each level? 4K, then 2M, then 1GB, ..., then root
> level. The only argument against it I can think of is performance (lots
> of redundant walks through the page table). But I don't think root
> zapping is especially latency critical.

I'm not opposed to that approach, assuming putting a root is done asynchronously
so that the high latency isn't problematic for vCPUs.  Though from a test coverage
perspective, I do like zapping at the worst case level (for the above flows).

And regarding the latency, if it's problematic we could track the number of present
SPTEs and skip the walk if there are none.  The downside is that doing so would
require an atomic operation when installing SPTEs to play nice with parallel page
faults.

> > @@ -846,6 +858,11 @@ static void tdp_mmu_zap_root(struct kvm *kvm, struct kvm_mmu_page *root,
> >  		}
> >  	}
> >  
> > +	if (zap_level < root->role.level) {
> > +		zap_level = root->role.level;
> > +		goto start;
> > +	}
> 
> This is probably just person opinion but I find the 2 iteration goto
> loop harder to understand than just open-coding the 2 passes.

Yeah, but it's clever!  I'll add another helper unless it turns out gross for
some reason. :-)

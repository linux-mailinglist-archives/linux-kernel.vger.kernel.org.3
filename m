Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089D9474EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238365AbhLNXwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238349AbhLNXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:52:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FFDC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:52:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c22-20020a17090a109600b001b101f02dd1so1356434pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wfIG+SGhHD6pwHJa5r5iuZJEx4PYENWt/4XZr/efceQ=;
        b=cIBPM3bHEpE2ripHOiKOPSLGgA7lZ+ZqU0S/mPkqDqPVym3/AAWp8sJDP0dSxgM7T1
         PU051KjRc5v62e2k62uh3WZaP0OdEBoCumHlzO8cArQyi9fS7DW/4n5Pv0N1KC3lGdP7
         Y1uyvYkLHdxIxdCDxSlyAScU4M9RZcPvX0I4b+KFaxAIsmdm60UG47VeCOoK4TK0uOmk
         y2IP3f7FiMo9Sr2ul1ktPv61KMUtXO3BhTmzw2L8zDHR84PDFa1phUk+8fRP2h+La9kG
         vtNFfNRc8ZABBbHPdvjAtoX8v3Br7f0sIejsiSdBpmNbb5KWAu1Lfbhyi2QLkphIT/J+
         OPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wfIG+SGhHD6pwHJa5r5iuZJEx4PYENWt/4XZr/efceQ=;
        b=Ym0MuuK3mV1ZSZmCegVXboV9KnFX4NGV/UebIACPmoPoo7HukKawkKPjfmC5f04keI
         6Qx+dICOnuxBoMqrCvy+K4gU/n1UAgUgdfk5YMnZpMmBmo5V53ocJ53L4QL58TrJN5Me
         d08yd4Xk0q0zP1uq+t3V4gUrEAK3/c5GldEdlj1lgp/WC/DcrsXN5Hp+/05vM9wrfoHA
         SLMUsu+0cngMfVN9aJPhHrTeK+qiX6y1yOVrZycvFFPp5pRv/hkzwZOY6XxtlAnx3kw9
         y91DAAepwKW4fQQFnHtnME6na6dJQEKajLYoqbGubyuuOsA+QRT3vobHdDDxqK9B5vFo
         p2eA==
X-Gm-Message-State: AOAM530kcMbHtC7PNG0QVz6XX+TplKYz52asCYwvWy4H2J6W9aGpZ9fz
        bjddKbLTT/bofVlnioQtSYcu7g==
X-Google-Smtp-Source: ABdhPJyKR+hA9rCXZ4UpvUMDta6mvhVNjcjAmZ+p+FU2D2jdj+1XjszxzMdCQJWFh43KY4Ze3JCUQw==
X-Received: by 2002:a17:902:c20d:b0:142:1009:585d with SMTP id 13-20020a170902c20d00b001421009585dmr8211293pll.83.1639525942789;
        Tue, 14 Dec 2021 15:52:22 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z22sm203225pfe.93.2021.12.14.15.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:52:22 -0800 (PST)
Date:   Tue, 14 Dec 2021 23:52:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hou Wenlong <houwenlong93@linux.alibaba.com>
Subject: Re: [PATCH 10/28] KVM: x86/mmu: Allow yielding when zapping GFNs for
 defunct TDP MMU root
Message-ID: <YbkuM4jEbJX6QQR6@google.com>
References: <20211120045046.3940942-1-seanjc@google.com>
 <20211120045046.3940942-11-seanjc@google.com>
 <CANgfPd_H3CZn_rFfEZoZ7Sa==Lnwt4tXSMsO+eg5d8q9n39BSQ@mail.gmail.com>
 <YbksiTgVdzN0Z6Dn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbksiTgVdzN0Z6Dn@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021, Sean Christopherson wrote:
> Assuming there is exactly one helper, that would also address my
> concerns with kvm_tdp_mmu_zap_invalidated_roots() being unsafe to call in parallel,
> e.g. two zappers processing an invalid root would both put the last reference to
> a root and trigger use-after-free of a different kind.

I take that back.  So long as both callers grabbed a reference to the root, multiple
instances are ok.  I forgot that kvm_tdp_mmu_zap_invalidated_roots() doesn't take
roots off the list directly, that's handled by kvm_tdp_mmu_put_root().

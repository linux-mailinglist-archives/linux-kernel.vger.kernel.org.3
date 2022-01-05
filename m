Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18516485ABF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244476AbiAEVeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbiAEVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:33:13 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9BC033270
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:32:56 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 205so552782pfu.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iz75eNeOMPClkyOOeLrV+wvs6NQGY9YHbUynqVGaBoA=;
        b=AB4tJ+dzW5ouj4RxmjR6PNX0hGu4E7KwgrPH5DSxzhQ0MRvdfkpV+KF4cH+uokvkgU
         KgycErH9ec+6Mna5PvJ4QafghedPWVWsVy/sDKWGS+GzOrimbxk4z/FLlBQtc1jXh5Nk
         3Qnw/txROmJ0mZt/jeQG8gBibEzFU51UTKyk3dXFgFphxJNKaqODUVGhwDLFhvEb1IWL
         A6J1gIYi/veevogwJpn00Y/8Ki3+evFr7kLy82yzQ9BtF/tv1mRHoLeSfPCaM7oy/1zR
         4bKjx7odp8pYd6sn1DEZrVtuCZ7gL7YgEhxyC9lOZkv1sgxVFewQPNqNI3LsNrEjc2Gs
         GFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iz75eNeOMPClkyOOeLrV+wvs6NQGY9YHbUynqVGaBoA=;
        b=0wKxbz6nDFzdnN71FSeIDVbuIjkWdS9AqOg115R/4VWIVeDBNS6+EjF7jCfDF31G78
         ZsLI7uWWd9Rhy7TUBsqbSKmqIqLDOHM1xNOuAz2ZxjBo3K5EfRBNpeOLiiQiHSYm6oyO
         5RSjE0hmzMJQ1e8YDwNQAIJVecIzifkRZm6Ji5va1QpE75P3Wcw6D92dVMRjggRAYVXv
         X3hKi8Vb1SGSmUmUPjzrxUXBG7RYhDPpUw7uEuWliiAr68+22pY6pJxYAk0dPccNif4X
         F7O5YxI41PCJvvU0Q0sehefyepuYyYtCS48/zJcHe/3BcDKt5CZUgdij/IR50vcuFs8H
         cUgA==
X-Gm-Message-State: AOAM533rVN5d8eaQ8oal0Ay2elYE+zJQ0hM4sSGUQUUo8By9Mm0j/Hbm
        3ofvPY3Ku/eiAeKrsT7E39JFnA==
X-Google-Smtp-Source: ABdhPJySi5TejS9nHZYYoGQ7nIG1FbKRoZsOt8J5uJvqnaWV1lK23NM8kHwxzbHlHuuCnzfnNGuipw==
X-Received: by 2002:a05:6a00:1a8c:b0:4bb:8593:e815 with SMTP id e12-20020a056a001a8c00b004bb8593e815mr55987089pfv.5.1641418375394;
        Wed, 05 Jan 2022 13:32:55 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o11sm4500pgk.36.2022.01.05.13.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 13:32:54 -0800 (PST)
Date:   Wed, 5 Jan 2022 21:32:51 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v2 24/30] KVM: x86/mmu: Allow yielding when zapping GFNs
 for defunct TDP MMU root
Message-ID: <YdYOg6UnRPJsznjC@google.com>
References: <20211223222318.1039223-1-seanjc@google.com>
 <20211223222318.1039223-25-seanjc@google.com>
 <YdTzkjOi2w+MVA2V@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdTzkjOi2w+MVA2V@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022, David Matlack wrote:
> On Thu, Dec 23, 2021 at 10:23:12PM +0000, Sean Christopherson wrote:
> > +	/*
> > +	 * Invalidate the root to prevent it from being reused by a vCPU, and
> > +	 * mark it defunct so that kvm_tdp_mmu_zap_invalidated_roots() doesn't
> > +	 * try to put a reference it didn't acquire.
> > +	 */
> > +	root->role.invalid = true;
> > +	root->tdp_mmu_defunct_root = true;
> 
> Ah ok so tdp_mmu_defunct_root indicates the root became invalid due to
> losing all its references while it was valid. This is in contrast to
> kvm_tdp_mmu_invalidate_all_roots() which marks roots invalid while they
> still have valid references.
> 
> But I wonder if tdp_mmu_defunct_root is necessary? It's only used to
> skip a put in zap_invalidated_roots. Could we instead unconditionally
> grab a reference in invalidate_all_roots and then unconditionally drop
> it?

Hmm, it's probably not necessary.  I added tdp_mmu_defunct_root before realizing
that that kvm_tdp_mmu_invalidate_all_roots() was wrong about this:

 * Roots which have a zero refcount should be skipped as
 * they're already being torn down.

IIRC, I added the second flag because I was trying to honor that (incorrect) logic,
and never reconsidered the need for a second flag once I got everything working.
The only downside would be keeping the memory for defunct roots around a wee bit
longer, and that's not a big deal.

I'll yank it out for the next version, assuming I didn't forget some detail...

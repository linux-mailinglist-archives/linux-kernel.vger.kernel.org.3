Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA04EF975
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbiDASEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbiDASEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:04:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5063B297
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:02:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s11so3274346pfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yBvT/RIL9LHH1Mgf37Nb2nJIQ03TuOvpTivVWxcN1v4=;
        b=Pv0XV1dHALOkjDJBg1gjNFFCD/fH4tBOKz+NF45/Hf8dNQb6h6XdKcZeXejGysCikr
         qH14VdW8YXObf+z6ElnoYM3OKnW8HYxQqU8K0Gld7765PiNynn2A7ihxsVW/WvxkXD2Y
         GTJGLhgFFovSvgvNYtbxttRScVZWG3PK8TPcmUgOUBlY3lq7tkSOzTZG5e2ROsAKsqGi
         xCB2FiKIeuLlY3FJ8p1G7pxclXEtYTX0bvaTDit8zgLGaBrEaDKxg2Bld52srP0tXr5D
         P8EXZpUCJtumcZP8CEHVL5rnYLTekmmboBgdhxs5tONCnPYBeamCUsqlji3x/77bFwth
         8ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBvT/RIL9LHH1Mgf37Nb2nJIQ03TuOvpTivVWxcN1v4=;
        b=pB8HxMUzKqF/DBBI1xhyaZVWjLFoh4drN0SJ6XLxChpHIGxEIXfDuMYfJ25cGndGLF
         c/kGcr9PcJ7QDNFi49csoqTQMzdURs14h/kXlVTePq7D8+oX/Z/6pWUhPR0vrpx6WTb7
         LLuxRNQkdhBDJFWUfCWv5JqFX+4wyWu3chSW75M+EMd52pZwxve/kCLJDAlWtHJSZtjt
         /oQd+tBpPG8biQFC0266tslgbbzAsXZHLUXKIq5mO4xxDl5byukL8hbGVKuM/nTRBv8u
         InX6zb1yrIsWUfyCaMy83m0KKiVJ+g+dJrbYdLK4bc1eApj66lRAuGwYvGnag8QccL2a
         Pp3g==
X-Gm-Message-State: AOAM532E5zaTRK0k8405uW4N7NSYjj/8KZ1eL57LYtovYOyhu1Z3J9OD
        DZxWKkYkMyBdoMnkivQcs4GcAg==
X-Google-Smtp-Source: ABdhPJwm3yL50kfR2zpLtlx5tRibJvFK2B4JSh+l1+8WCnDCvxbxlkwbsCvtZW3NlCs8tPNL/eCRew==
X-Received: by 2002:a05:6a00:1510:b0:4fa:f5fe:ffd5 with SMTP id q16-20020a056a00151000b004faf5feffd5mr12176247pfu.2.1648836167854;
        Fri, 01 Apr 2022 11:02:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w9-20020a056a0014c900b004fb2ca5f6d7sm3781681pfu.136.2022.04.01.11.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 11:02:47 -0700 (PDT)
Date:   Fri, 1 Apr 2022 18:02:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Orr <marcorr@google.com>
Cc:     Peter Gonda <pgonda@google.com>,
        "Nikunj A. Dadhania" <nikunj@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Mingwei Zhang <mizhang@google.com>,
        David Hildenbrand <david@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v1 0/9] KVM: SVM: Defer page pinning for SEV guests
Message-ID: <Ykc+QapbAdpd41PK@google.com>
References: <20220308043857.13652-1-nikunj@amd.com>
 <YkIh8zM7XfhsFN8L@google.com>
 <c4b33753-01d7-684e-23ac-1189bd217761@amd.com>
 <YkSz1R3YuFszcZrY@google.com>
 <5567f4ec-bbcf-4caf-16c1-3621b77a1779@amd.com>
 <CAMkAt6px4A0CyuZ8h7zKzTxQUrZMYEkDXbvZ=3v+kphRTRDjNA@mail.gmail.com>
 <YkX6aKymqZzD0bwb@google.com>
 <CAA03e5GXmo33OOyxb08L5Ztz1dP-OSsPzeo0HK73p9ShvnMmRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA03e5GXmo33OOyxb08L5Ztz1dP-OSsPzeo0HK73p9ShvnMmRg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 01, 2022, Marc Orr wrote:
> On Thu, Mar 31, 2022 at 12:01 PM Sean Christopherson <seanjc@google.com> wrote:
> > Yep, that's a big reason why I view purging the existing SEV memory management as
> > a long term goal.  The other being that userspace obviously needs to be updated to
> > support UPM[*].   I suspect the only feasible way to enable this for SEV/SEV-ES
> > would be to restrict it to new VM types that have a disclaimer regarding additional
> > requirements.
> >
> > [*] I believe Peter coined the UPM acronym for "Unmapping guest Private Memory".  We've
> >     been using it iternally for discussion and it rolls off the tongue a lot easier than
> >     the full phrase, and is much more precise/descriptive than just "private fd".
> 
> Can we really "purge the existing SEV memory management"? This seems
> like a non-starter because it violates userspace API (i.e., the
> ability for the userspace VMM to run a guest without
> KVM_FEATURE_HC_MAP_GPA_RANGE). Or maybe I'm not quite following what
> you mean by purge.

I really do mean purge, but I also really do mean "long term", as in 5+ years
(probably 10+ if I'm being realistic).

Removing support is completely ok, as is changing the uABI, the rule is that we
can't break userspace.  If all users are migrated to private-fd, e.g. by carrots
and/or sticks such as putting the code into maintenance-only mode, then at some
point in the future there will be no users left to break and we can drop the
current code and make use of private-fd mandatory for SEV/SEV-ES guests.

> Assuming that UPM-based lazy pinning comes together via a new VM type
> that only supports new images based on a minimum kernel version with
> KVM_FEATURE_HC_MAP_GPA_RANGE, then I think this would like as follows:
> 
> 1. Userspace VMM: Check SEV VM type. If type is legacy SEV type then
> do upfront pinning. Else, skip up front pinning.

Yep, if by legacy "SEV type" you mean "SEV/SEV-ES guest that isn't required to
use MAP_GPA_RANGE", which I'm pretty sure you do based on #3.

> 2. KVM: I'm not sure anything special needs to happen here. For the
> legacy VM types, it can be configured to use legacy memslots,
> presumably the same as non-CVMs will be configured. For the new VM
> type, it should be configured to use UPM.

Correct, for now, KVM does nothing different for SEV/SEV-ES guests.

> 3. Control plane (thing creating VMs): Responsible for not allowing
> legacy SEV images (i.e., images without KVM_FEATURE_HC_MAP_GPA_RANGE)
> with the new SEV VM types that use UPM and have support for demand
> pinning.
> 
> Sean: Did I get this right?

Yep.

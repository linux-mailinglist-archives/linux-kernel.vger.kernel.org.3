Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438E4B164D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343998AbiBJT2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:28:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343944AbiBJT2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:28:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD696D82
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:28:43 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m7so6123878pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 11:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MkCAJcsgDnZ4AMQg0YJZxLL5mg72sPEcPDTYT76wphA=;
        b=VITXk2hMcSEjC+OZoOeI41UdOAsXXnSae+vIO1t5uiJUDG3f+W8Ujvo0MzRncXcGSg
         USTmlZSg0keVqVzjOeEZQixEP8Pgeq2dITc6QO3lghqqFZQJxwqFTif5bEsHgDSzNkCQ
         2eE8SKwMDCYSs2aXYXFc+5kXVC2grvOSWZ9IMP+RmFomSSXp/fpnKoid/djrG+9ci/6+
         l5iMO0ARPss2aCLOgxxHGPRXtXwq90RSu87KgTi6DFizS3nL3ZLpvWb0tjEZ17BsVgSy
         52BW03EP4lmL4Hg/sREOKFYcn0GlisUdJyuwbMTWxFOmIkab9YrI1eHTWrNQ6y6lfoL4
         Hg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MkCAJcsgDnZ4AMQg0YJZxLL5mg72sPEcPDTYT76wphA=;
        b=SwwThwMChX8FG+y4xLD4gF89vNRzisJR7/JbS6VYQ9QP+4VjdAvYzZ3f1aCdevIjp5
         9SBUTj/GbwNUA/2uo0cPilFgi/N3S3GjoGI3gwXxYdWejrNwIo1PRev+7M+jibyel1bt
         bIpy0uk0sn5uyXvwllIIGbfwaoq2DMd66JyRzpE54DVj3kmhDpU3aM9+AWtL3U4TS6fR
         oB8Vv+WxWjt8P+JkU8J4vc3osH+z5nKpsQ8DmkZ/+I3vhbmEeecilxTndrryaJeLyF/r
         zdF6uwvL+OP/QKUf3v2e1fVZHXlrUS0PARf2BRKCHpOw2K3IJWsiRLQO0IWX/TYkd2Vl
         D1tw==
X-Gm-Message-State: AOAM533VObfg3WMwDY2ofgCXcE9HHA1HUORdUQRI2mmFQs5U/NjGYSZi
        zH2TH5UL87U8KNKCWtRPZG6ow1c3JDhxaQ==
X-Google-Smtp-Source: ABdhPJyGxrYzqC6mAoU/J4x4uF4c35ZsHYMs9x0CCV7EjCPecYGBzI+BZ67c1YA0cq2S+zuo8KoMXw==
X-Received: by 2002:a17:903:1c8:: with SMTP id e8mr8819514plh.75.1644521323208;
        Thu, 10 Feb 2022 11:28:43 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d8sm17720591pfj.179.2022.02.10.11.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:28:42 -0800 (PST)
Date:   Thu, 10 Feb 2022 19:28:39 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     David Matlack <dmatlack@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH 00/23] KVM: MMU: MMU role refactoring
Message-ID: <YgVnZy6RzX7Vrfru@google.com>
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <YgGmgMMR0dBmjW86@google.com>
 <YgGq31edopd6RMts@google.com>
 <CALzav=d05sMd=ARkV+GMf9SkxKcg9c9n5ttb274M2fZrP27PDA@mail.gmail.com>
 <YgRmXDn7b8GQ+VzX@google.com>
 <40930834-8f54-4701-d3ec-f8287bc1333f@redhat.com>
 <YgVDfG1DvUdXnd2n@google.com>
 <344042cf-099e-5e26-026a-c42d0825488e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344042cf-099e-5e26-026a-c42d0825488e@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022, Paolo Bonzini wrote:
> On 2/10/22 17:55, Sean Christopherson wrote:
> > > 	union kvm_mmu_page_role root_role;
> > > 	union kvm_mmu_paging_mode cpu_mode;
> > 
> > I'd prefer to not use "paging mode", the SDM uses that terminology to refer to
> > the four paging modes.  My expectation given the name is that the union would
> > track only CR0.PG, EFER.LME, CR4.PAE, and CR4.PSE[*].
> 
> Yeah, I had started with kvm_mmu_paging_flags, but cpu_flags was an even
> worse method than kvm_mmu_paging_mode.

We could always do s/is_guest_mode/is_nested_mode or something to that effect.
It would take some retraining, but I feel like we've been fighting the whole
"guest mode" thing over and over.

> Anyway, now that I have done _some_ replacement, it's a matter of sed -i on
> the patch files once you or someone else come up with a good moniker.
> 
> I take it that "root_role" passed your filter successfully.

Yep, works for me.  I almost suggested it, too, but decided I liked mmu_role
marginally better.  I like root_role because it ties in with root_hpa and root_pga.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7374701EC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhLJNl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbhLJNkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:40:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C718C061D7E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:37:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so14884072wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 05:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UMyDDswc1FZItAV+NSBPgTMyKyf2+D9Oge1wredtc7c=;
        b=Hd1kuvSf5n0DrJQqp7698lcVKXaMe/TLA/TGhOMfEQB+SDBrEZSfhys+1IT/Y9TNyo
         FL8OV6pI6tCoxkvRHdGU1Yb0vpUYv9NpLbrYPsFAhL0emDoOlMJ8koYvMmkU1N1c+g/o
         a+6RuJ+GeMiN9MGhCLm4Xe5H2oksD2RfUEfIT0cDRa47DtJrc6B/2rirhTiqEnjLknZg
         Edm9SBItDyelahvSPfyZd7mfbz0+0T4ipL34oS5YwSFmZOS+jm+2AstTmdnupYqn7yS4
         bXnwlWddpKU7TKBOqNuxT+m/f+GADIey098ZH+N1FWcJiCWqUTlDRfdOZ5imoUiEH2mt
         F4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMyDDswc1FZItAV+NSBPgTMyKyf2+D9Oge1wredtc7c=;
        b=P+I6wo0tA//l/72r0OKcQdyRmmneqxv8b800BQ+l8yXYKKpq2gkhZZ4ljBh+uLKOg1
         n+38/QjzDFwjmJ+SkQTH0oIFx3psVyJ+FNyy0PIbjE8RyPM2mxsed3B3wqqnZxJgumKV
         TtNfX+niyH85N0BCKmnlrsZng/zm0O4mDYwChNOqTJ+7sfANffi2PAozwlj5BtgTsQxQ
         uNSlGuPMLiUiNXysCmQsBvk8jsvItY6GZyBVPw1zbHkSQDALGWNkKnS4E+UA6YRsrk1p
         MJepGykLhIZXyfuNmSZ1CZnZtBCGynJ1qYuFSt2tWmFC6YJr0AAhKNlsm19/C/IpnedI
         6ytQ==
X-Gm-Message-State: AOAM530K8qdYHn815uB4xHz9lvlnU0G+V3oMHiLTli+ND82rFdLMk9xB
        R5IkFlHhGV5QKHn+hB0iv023Cw==
X-Google-Smtp-Source: ABdhPJyK1FJ33ENKdaCNwdVJ8F5MUTfJNljKx5SySODi49ZDvjnWhgaYlWH5OSJlvG5ocohi1ih2Ow==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr14499141wrd.3.1639143436764;
        Fri, 10 Dec 2021 05:37:16 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:76c1:fb36:1e22:8677])
        by smtp.gmail.com with ESMTPSA id a1sm3408752wri.89.2021.12.10.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 05:37:16 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:37:12 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 01/15] KVM: arm64: Check if running in VHE from
 kvm_host_owns_hyp_mappings()
Message-ID: <YbNYCJOOARfUPKq1@google.com>
References: <20211201170411.1561936-1-qperret@google.com>
 <20211201170411.1561936-2-qperret@google.com>
 <20211209101053.GA1833@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209101053.GA1833@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 Dec 2021 at 10:10:54 (+0000), Will Deacon wrote:
> On Wed, Dec 01, 2021 at 05:03:55PM +0000, Quentin Perret wrote:
> > The kvm_host_owns_hyp_mappings() function should return true if and only
> > if the host kernel is responsible for creating the hypervisor stage-1
> > mappings. That is only possible in standard non-VHE mode, or during boot
> > in protected nVHE mode. But either way, non of this makes sense in VHE,
> > so make sure to catch this case as well, hence making the function
> > return sensible values in any context (VHE or not).
> > 
> > Suggested-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/mmu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 326cdfec74a1..f8f1096a297f 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -239,6 +239,9 @@ void free_hyp_pgds(void)
> >  
> >  static bool kvm_host_owns_hyp_mappings(void)
> >  {
> > +	if (is_kernel_in_hyp_mode())
> > +		return false;
> 
> This looks identical to:
> 
> https://lore.kernel.org/r/20211208152300.2478542-7-qperret@google.com

Yep, I figured it made more sense in the other series as it's not
strictly related to this one, so ... :)

Cheers,
Quentin

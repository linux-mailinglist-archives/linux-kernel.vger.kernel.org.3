Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7957B4D1FD3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbiCHSMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiCHSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:12:49 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890A956C01
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:11:52 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id w37so17159327pga.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Pry/tblt+LFz/ggmn7l+mL5TXcjGxyxDzyRMHHrD8E=;
        b=iiRcRwY3T/AIQxyvmUxxl1ZXTM+Xe219CCId+5cHhXYm4c3M6EVpr4PKX7CJaMoIWV
         ddBgaReZfIareX8mQH3/EDVMLkf3QmnT97AxxrBs0ENRPKtVc3L/BRUGbw6rmXk2k1Cj
         JXRGOZIPm1vCu0LrXvNOzZuEIG3jp9/w1SSe7PWBjUO+kgr4d7tWBS5cgoKGfPUxkDY/
         Mv015bQPu8KnmdbY0wbPJHeVVf2uoFriqXCErz23oAOVmDkqBlVe15dqCd3z9yIvE+Sz
         PAhtWZPpIWxnoJY0mZK5hpFPjO/r27QnbAKo+5yyxWmVPWU9jkzA2f4lCPAm4NrouF+5
         cDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Pry/tblt+LFz/ggmn7l+mL5TXcjGxyxDzyRMHHrD8E=;
        b=uEXJW2kHiMS9pmzP+rVVTd4eXBP4TzD8ivLBgUz+NwDKw+kZtWYm0MJS4GktBJnmyj
         vrnv0OW6SW/WRlIEuPJpe9eFkceXpI0bqfryP28Fpxgl21Lb4tIsVJsKg0Ajab1U2xWz
         lvB4a0hzELomYMWY8khCAe3RgQlrEUZg4VRHvVzeqRc/V0avLbbMVy7Su3AEfLE6Fcnv
         PDb42YosZvZJvy0EE0srnoXhie8ZW5hwn9bCs4Z+/2UfWERppCErKKaIH4+QWZkPEwqh
         Pacj6FosKVG9S4K1fVj8I2pPosxfnCFHhgVoSA5HpJbrDAgVeiaR+u4HsRJW9kUTYPT8
         Pzmw==
X-Gm-Message-State: AOAM533r+JOWKrAxteLZDpboYgQaBY2jhgf2vD7XjbsKIOo10dxHLCcn
        8RaLOget9FYMwS0RDGLxbzwMNO23X5tBzQ==
X-Google-Smtp-Source: ABdhPJw23H0nMwGNL6c3/E2MhVBKJ1wt+jn6EjAyDOMFMNYr+UJ2kNf1ahIjaSEq4gg2mdWjlpX8VA==
X-Received: by 2002:a05:6a00:781:b0:4f4:2a:2d89 with SMTP id g1-20020a056a00078100b004f4002a2d89mr19305230pfu.13.1646763111731;
        Tue, 08 Mar 2022 10:11:51 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00194900b004e1583f88a2sm20437955pfk.0.2022.03.08.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:11:51 -0800 (PST)
Date:   Tue, 8 Mar 2022 18:11:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH v2 12/25] KVM: x86/mmu: cleanup computation of MMU roles
 for two-dimensional paging
Message-ID: <YiecYxd/YreGFWpB@google.com>
References: <20220221162243.683208-1-pbonzini@redhat.com>
 <20220221162243.683208-13-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221162243.683208-13-pbonzini@redhat.com>
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

On Mon, Feb 21, 2022, Paolo Bonzini wrote:
> Inline kvm_calc_mmu_role_common into its sole caller, and simplify it
> by removing the computation of unnecessary bits.
> 
> Extended bits are unnecessary because page walking uses the CPU mode,
> and EFER.NX/CR0.WP can be set to one unconditionally---matching the
> format of shadow pages rather than the format of guest pages.

But they don't match the format of shadow pages.  EPT has an equivalent to NX in
that KVM can always clear X, but KVM explicitly supports running with EPT and
EFER.NX=0 in the host (32-bit non-PAE kernels).

CR0.WP equally confusing.  Yes, both EPT and NPT enforce write protection at all
times, but EPT has no concept of user vs. supervisor in the EPT tables themselves,
at least with respect to writes (thanks mode-based execution for the qualifier...).
NPT is even worse as the APM explicitly states:

  The host hCR0.WP bit is ignored under nested paging.

Unless there's some hidden dependency I'm missing, I'd prefer we arbitrarily leave
them zero.

> The MMU role for two dimensional paging does still depend on the CPU mode,

Heh, don't think it's necessary to spell out TDP, and I think it would be helpful
to write it as "non-nested TDP" since the surrounding patches deal with both.

> even if only barely so, due to SMM and guest mode; for consistency,
> pass it down to kvm_calc_tdp_mmu_root_page_role instead of querying
> the vcpu with is_smm or is_guest_mode.

The changelog should call out this is a _significant_ change in behavior for KVM,
as it allows reusing shadow pages with different guest MMU "role bits".  E.g. if
this lands after the changes to not unload MMUs on cr0/cr4 emulation, it will be
quite the functional change.

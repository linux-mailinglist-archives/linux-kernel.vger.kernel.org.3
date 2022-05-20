Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1FC52EFC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351154AbiETPxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351129AbiETPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:53:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1EA1796FA
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:53:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id u15so8064609pfi.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lx+nl7VeLrf/CTJ8drtKDv6VCqA31QTPV0ep4+J3dTg=;
        b=W321M1AcLukYYDCqtH244bla3kkLc6KVoTboRKxaLKZIVJC5y4fbyDytF2QFK53Brq
         0tiU95MX1ZE3G/TkqbgdvLTHgJwRYJHLFTyA6V9i6H7sq8J6+YvSTRu/VQ37cN3VV4hu
         dYsgC2xUSUUvsap+FQPV6HYkFWAexhYSZVQOH5tv7KL1WZqb5FD8+I3mJhBw4GrvoELN
         b8LG5I7iA01HFsiEmCLYfGMnj9qyP4edq3pxqBktd41qONSYMGMTHlb4AdJYFkTPK9hA
         JOlvAiuyMRVxdtq6XoELNfuHEkEXO4fqmS/9fXXlJK2BpKmJ6untieUlzwFIrZWb7dlZ
         pV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lx+nl7VeLrf/CTJ8drtKDv6VCqA31QTPV0ep4+J3dTg=;
        b=2ByeywREfovqDx8u7qoLbkj1UmSOd3JV3EE+OAVSvm7/3YOwjMF4FVUoWQFhRk0sQQ
         iDCNAlqSUDlF+LI3hCODdwKdRb2yJy1eF2gSCX4EBsmUjNcNbomHpXcIQZmH1P3kYgt7
         SUNU1w5UlvOdESxYpICGxWKFMYaZRzb2bbpM1jjRZGxbAO669iDT3tzFOevRZVFiOQO5
         0S6InW9kZoF04Rdj48ecMpndZUsdT6dLaAcQejmdau5z3w2iyR+GhVj8AMPAQPnC2aDI
         mInvLHbw+LHLj/1xXWVypT0nc5gk07etdreOgbOICXcl5rdknloSPX1/7DBC7kxViO2Z
         RJKg==
X-Gm-Message-State: AOAM531Phpzu801SKB+wEHGgmcndrF4TlIMmHAl++cnoBPZzLtntjFmW
        bIE8p8RT6pZ/Vfk3tuhWyA8/kg==
X-Google-Smtp-Source: ABdhPJxD8ynohDBMMSIIIDOkKbnQIEson1KKtbGkjsSWa1SroL7o9tri3BHtV41lUTiSz+niBWtayQ==
X-Received: by 2002:a05:6a00:c95:b0:517:f266:465 with SMTP id a21-20020a056a000c9500b00517f2660465mr10605760pfv.42.1653062018833;
        Fri, 20 May 2022 08:53:38 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h131-20020a628389000000b0050dc762812csm1988224pfe.6.2022.05.20.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:53:38 -0700 (PDT)
Date:   Fri, 20 May 2022 15:53:34 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH v3 6/8] KVM: Fully serialize gfn=>pfn cache refresh via
 mutex
Message-ID: <Yoe5fkBzmnABpn2G@google.com>
References: <20220429210025.3293691-1-seanjc@google.com>
 <20220429210025.3293691-7-seanjc@google.com>
 <d84d9853-d055-50b6-669f-de2f24304f15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d84d9853-d055-50b6-669f-de2f24304f15@redhat.com>
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

On Fri, May 20, 2022, Paolo Bonzini wrote:
> On 4/29/22 23:00, Sean Christopherson wrote:
> > diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> > index 05cb0bcbf662..eaef31462bbe 100644
> > --- a/virt/kvm/pfncache.c
> > +++ b/virt/kvm/pfncache.c
> > @@ -157,6 +157,13 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
> >   	if (page_offset + len > PAGE_SIZE)
> >   		return -EINVAL;
> > +	/*
> > +	 * If another task is refreshing the cache, wait for it to complete.
> > +	 * There is no guarantee that concurrent refreshes will see the same
> > +	 * gpa, memslots generation, etc..., so they must be fully serialized.
> > +	 */
> > +	mutex_lock(&gpc->refresh_lock);
> > +
> >   	write_lock_irq(&gpc->lock);
> >   	old_pfn = gpc->pfn;
> > @@ -248,6 +255,8 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
> >    out:
> >   	write_unlock_irq(&gpc->lock);
> > +	mutex_unlock(&gpc->refresh_lock);
> > +
> >   	gpc_release_pfn_and_khva(kvm, old_pfn, old_khva);
> >   	return ret;
> 
> Does kvm_gfn_to_pfn_cache_unmap also need to take the mutex, to avoid the
> WARN_ON(gpc->valid)?

I don't know What WARN_ON() you're referring to, but there is a double-free bug
if unmap() runs during an invalidation.  That can be solved without having to
take the mutex though, just reset valid/pfn/khva before the retry.

When searching to see how unmap() was used in the original series (there's no
other user besides destroy...), I stumbled across this likely-related syzbot bug
that unfortunately didn't Cc KVM :-(

https://lore.kernel.org/all/00000000000073f09205db439577@google.com


diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 72eee096a7cd..1719b0249dbc 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -228,6 +228,11 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
        if (!old_valid || old_uhva != gpc->uhva) {
                void *new_khva = NULL;

+               /* blah blah blah */
+               gpc->valid = false;
+               gpc->pfn = KVM_PFN_ERR_FAULT;
+               gpc->khva = NULL;
+
                new_pfn = hva_to_pfn_retry(kvm, gpc);
                if (is_error_noslot_pfn(new_pfn)) {
                        ret = -EFAULT;
@@ -251,11 +256,7 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
                        /* Nothing more to do, the pfn is consumed only by the guest. */
                }

-               if (ret) {
-                       gpc->valid = false;
-                       gpc->pfn = KVM_PFN_ERR_FAULT;
-                       gpc->khva = NULL;
-               } else {
+               if (!ret) {
                        gpc->valid = true;
                        gpc->pfn = new_pfn;
                        gpc->khva = new_khva;
@@ -283,6 +284,11 @@ void kvm_gfn_to_pfn_cache_unmap(struct kvm *kvm, struct gfn_to_pfn_cache *gpc)

        write_lock_irq(&gpc->lock);

+       if (!gpc->valid) {
+               write_unlock_irq(&gpc->lock);
+               return;
+       }
+
        gpc->valid = false;

        old_khva = gpc->khva - offset_in_page(gpc->khva);


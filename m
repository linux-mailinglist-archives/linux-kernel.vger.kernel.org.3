Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B290F58327A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiG0SyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbiG0Sxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:53:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B70B63921
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:51:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so3022720pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 10:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofQJSU73p95X2wrdmZUMPm40+n8Nm3wKjXkzp0hyl7g=;
        b=XmZYEReTJM3L7fsK9TWdOjLKfiG9/dDjYBZctld/7WfLBTg+GpLZP2jGoashiK9oHp
         eBm/HwHa2XW04PRn2hCGJt0upBpvHEYVpCiwCg5X8G7IXxs3Cs0Qndk/EIJ4N41pWu+A
         uj/eS/a5c+iIOwKlO+a6Ue5DQFtzabKxozxkXlq7c4Djl4nvCbCTiPJEz0IPCeP4+Pkt
         JdbgOOGW8+EXaNOv72WVWEIDXEXNtyPuUytZlnDFRZxXNdJ1uouTqywvt6dIWUjnbgDE
         wueqn9+4Fqyt/EdrrtSAPE1Z1/Hvx9ZgJBSj1NFEQ7ndSpcJWCcjqMPUbVbb5bZRzr/V
         Jq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofQJSU73p95X2wrdmZUMPm40+n8Nm3wKjXkzp0hyl7g=;
        b=3dPCnXQGg0nKS9hnfehxiyOgVXGp1Dw+8wyavp5wYEqWFMT/TlSgigaLcBt13vdGFR
         gEdRc9aFQrEHQmDqhwFXEemPXOTBvjXPu6M80e8vyclzRWBkURmf8wBsZEf8H6k0Pmcj
         MVOVcMsXkp0Ta1PorGRcwhBoAc8UGFa0+fkYft2rNJti3f5YCuTZDbjdKZaHDlKOQF4u
         bQdXPMobLqe5TITB1zb8o67yPy2LOSNhWRuthGQghqVqJ6NNdNk0Bfn6mHKval37hkAc
         otwjag6hl0Wu7VIuyUteJUeMfpJj54gIAd/nYZCqDn/xpSWaoIacsbd2QUFPDoHhG6Hg
         BR0Q==
X-Gm-Message-State: AJIora/H4P1qN6f6JfgfiiTC2adKOGoDFSvFWqbga24yKzzM+BhThj2y
        0O0sDmwwT92WfZ1YryTP68ymGo9f2MaKbg==
X-Google-Smtp-Source: AGRyM1vV8JXIJhF+qJqT0Dzy5IsQQCabBg+/G8IdfcmHqMbpVts8NvQp/ObpyQrGa62H8vdRbxZsvg==
X-Received: by 2002:a17:90a:728f:b0:1f2:4a4c:6c39 with SMTP id e15-20020a17090a728f00b001f24a4c6c39mr5912043pjg.43.1658944316853;
        Wed, 27 Jul 2022 10:51:56 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7961d000000b0052b8240840dsm14703835pfg.145.2022.07.27.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:51:56 -0700 (PDT)
Date:   Wed, 27 Jul 2022 17:51:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Hao Peng <flyingpenghao@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm: mmu: fix typos in struct kvm_arch
Message-ID: <YuF7OCqZ7/57P+El@google.com>
References: <CAPm50aKursUrDpgqLt7RT-VoSfBJswsnR2w1sVAt5mburmdd8g@mail.gmail.com>
 <CALzav=eccuGWGpBs=tp5RO_wJqQecGRwDAPi+tyPkMcYrbrPoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=eccuGWGpBs=tp5RO_wJqQecGRwDAPi+tyPkMcYrbrPoA@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022, David Matlack wrote:
> On Wed, Jul 27, 2022 at 3:58 AM Hao Peng <flyingpenghao@gmail.com> wrote:
> >
> > From: Peng Hao <flyingpeng@tencent.com>
> >
> > No 'kvmp_mmu_pages', it should be 'kvm_mmu_page'. And
> > struct kvm_mmu_pages and struct kvm_mmu_page are different structures,
> > here should be kvm_mmu_page.
> > kvm_mmu_pages is defined in arch/x86/kvm/mmu/mmu.c.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index e8281d64a431..205a9f374e14 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -1272,8 +1272,8 @@ struct kvm_arch {
> >         bool tdp_mmu_enabled;
> >
> >         /*
> > -        * List of struct kvm_mmu_pages being used as roots.
> > -        * All struct kvm_mmu_pages in the list should have
> > +        * List of struct kvm_mmu_page being used as roots.
> 
> I agree that "struct <name>s" is a bad/misleading way to make a struct
> plural in comments. The way I prefer to do it is "<name> structs".
> That avoids changing the <name> and still makes it clear it's plural.

+1, I like that approach.  FWIW, "struct kvm_mmu_pages" will likely be renamed in
the not-too-distant future[*], but I think it's still worth changing this to follow
David's suggestion.

[*] https://lore.kernel.org/all/20220605064342.309219-13-jiangshanlai@gmail.com

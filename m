Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8803857BE93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiGTTae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiGTTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:30:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0714C60B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:30:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso3219008pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R5uXVH2fF6MLNsy3ov8PgE+td36txTWTocMZT8dvLYI=;
        b=tUpMUK3CXSSqTqSsNSyfVAvczsgHExIXku9xqI2aVqo1miZ2YkD3PMPf2FBcMhkjcd
         MsiaoSCo9lYd6hv+ZaRJ6uEjQes7UhEna1YSkBfFfdQAXJ/VBGQm7rhNioqj6Bdt8uSl
         InihP5ilTMzjnWZ6PuyyBWnJ2NTd79b/iLx+di0EouWVPLw8G+gEzblFjAuFqzhl8oEw
         9BEGp+dK3ji3CAa/FgNF5qi6E39MeG1tYhxTBOaMm5COP+PefRVEAMBhhN+GkUnEjEeq
         iwPIM+v+dAh+pqgN1nBSQs53MAf8aZBxq2QzKEvjnkLNQKmpo+2/SEYU69xKYzJzM7rE
         MzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5uXVH2fF6MLNsy3ov8PgE+td36txTWTocMZT8dvLYI=;
        b=q5as1RWNBF1CMW+kWiQqx+UChqbI7iW8m/EF1qgYgVjhqKmLhC4y2UUn06dOG0+G1u
         rSe1fEeUZnFytHJMUkDbdMr7atb6SymHADN8c1gsH7ecpTwDimvNlAL3dVdnQRvlyUXf
         gkpgGUXfywcrIhzs94xnS0+nJQcIk3X8zHULmqgI8GeEs+4GIOwnPcGp1p7eNXesTHEO
         9o/xCC61v7faVEPqJya1MF/MSgPnBf32lVmJUKjHDXL0kobPuY7rm8O5kqCKz30RAi6k
         vhg8yOBTL3HHHFz9PFHJwWMZODumqLiYQ6kHtDsrenUlh511Dc/IL6XwfuWFd4Vbq785
         OCEg==
X-Gm-Message-State: AJIora92h8Q+6BGl4lte0Rr6ei9WxCOQoq5aNzncIV/S9SMCBFX6R8lx
        mKtEny3d46NiALksP6re6VLQow==
X-Google-Smtp-Source: AGRyM1tlJFRF6jvLi7awZ5dPz8ZJtIbvG2kAT2rNAIgzUDVRyGPlrPubscUCaK4m92UlkWxr985t2Q==
X-Received: by 2002:a17:90b:38d0:b0:1f0:5205:4b5c with SMTP id nn16-20020a17090b38d000b001f052054b5cmr7013547pjb.201.1658345430481;
        Wed, 20 Jul 2022 12:30:30 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902710800b0015e8d4eb1d7sm14122579pll.33.2022.07.20.12.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:30:29 -0700 (PDT)
Date:   Wed, 20 Jul 2022 19:30:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kechen Lu <kechenl@nvidia.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Somdutta Roy <somduttar@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v4 5/7] KVM: x86: add vCPU scoped toggling for
 disabled exits
Message-ID: <YthX0brdWCZVFB3n@google.com>
References: <20220622004924.155191-1-kechenl@nvidia.com>
 <20220622004924.155191-6-kechenl@nvidia.com>
 <YthMZvWpZ+3gNUhM@google.com>
 <DM6PR12MB35008628D97A59AA302E772FCA8E9@DM6PR12MB3500.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB35008628D97A59AA302E772FCA8E9@DM6PR12MB3500.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022, Kechen Lu wrote:
> > > @@ -6036,14 +6045,17 @@ int kvm_vm_ioctl_enable_cap(struct kvm kvm,
> > >                       break;
> > >
> > >               mutex_lock(&kvm->lock);
> > > -             if (kvm->created_vcpus)
> > > -                     goto disable_exits_unlock;
> > > +             if (kvm->created_vcpus) {
> > 
> > I retract my comment about using a request, I got ahead of myself.
> > 
> > Don't update vCPUs, the whole point of adding the !kvm->created_vcpus
> > check was to avoid having to update vCPUs when the per-VM behavior
> > changed.
> > 
> > In other words, keep the restriction and drop the request.
> > 
> 
> I see. If we keep the restriction here and not updating vCPUs when
> kvm->created_vcpus is true, the per-VM and per-vCPU assumption would be
> different here? Not sure if I understand right:
> For per-VM, we assume the per-VM cap enabling is only before vcpus creation.
> For per-vCPU cap enabling, we are able to toggle the disabled exits runtime.

Yep.  The main reason being that there's no use case for changing per-VM settings
after vCPUs are created.  I.e. we could lift the restriction in the future if a
use case pops up, but until then, keep things simple.

> If I understand correctly, this also makes sense though.

Paging this all back in...

There are two (sane) options for defining KVM's ABI:

  1) KVM combines the per-VM and per-vCPU settings
  2) The per-vCPU settings override the per-VM settings

This series implements (2).

For (1), KVM would need to recheck the per-VM state during the per-vCPU update,
e.g. instead of simply modifying the per-vCPU flags, the vCPU-scoped handler
for KVM_CAP_X86_DISABLE_EXITS would need to merge the incoming settings with the
existing kvm->arch.xxx_in_guest flags.

I like (2) because it's simpler to implement and document (merging state is always
messy) and is more flexible.  E.g. with (1), the only way to have per-vCPU settings
is for userspace to NOT set the per-VM disables and then set disables on a per-vCPU
basis.  Whereas with (2), userspace can set (or not) the per-VM disables and then
override as needed.

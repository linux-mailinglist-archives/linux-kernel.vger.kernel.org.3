Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24CD4CAC6D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiCBRsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbiCBRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:48:17 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31726DF43
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:47:30 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 12so2292651pgd.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IR7vRHJ9tfwFEn8BQ6kjOYEEDgHMyDmSWCw9NBALgao=;
        b=GUs30lq1TSTPUltPcu+38Q92TF0fpNldhU2WZaLlbQCsoKVq4Wr0k21MJgrkXnT1Zn
         AOTPB7OoG5AE6yrCFTjM7+ulyuYxXtB/2q5sbKAG+a2K/hzCl8s2nj7ircztSrFCzSi1
         rLogmNVpJAcbbDI4eIfLwNmtpE9NT6Ou7CXpVFs1FUN2qBJZd9fo/+brz+vZATVkASi3
         aMeXVzbMHdMsUHFrA8pwDo5l46g9DRHBnsSjvUoqF8vksgqe4I4HOavAnD+MZaM0jYu3
         Q1CNIVwYEssVy8mstWz4z/B9zL4azDjaW09BUDGT8clbXL0Ruo4hfZLP+mDga4/ZG0Fx
         TEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IR7vRHJ9tfwFEn8BQ6kjOYEEDgHMyDmSWCw9NBALgao=;
        b=FAsfjfq0l9fFtrv4f9PkD3SsCDnyOr7kaAYPkHcBopn9HUSpW5mlU3J2iTTSveU2WO
         L1laufhA7iYh4Ajl8kcNx4909tH8+k1A9/2NUpUUw0l6PGl3dYX7ceVKgkZqie88ax+u
         PBsyG38s7CYkfgGQ4osYtXT+6a59QS099KnBAvkhQomllqZpnBGzSZgzvHy3s7O2c6lC
         Hs/oGS66WaPv/PAGhfjTytIcsF/E/tHwlTDBd4bxmSDcwVmxB3URmSNovLaJNIuVxWyQ
         8Or1DVrwKnCwueP2YBudISiYVYB4jMr6Idsd2swSNMNr8BhE3cSr4irLZmpBmkN7HaQb
         fDug==
X-Gm-Message-State: AOAM532xDpACwsDiwuRY/c/dQLIlZp1zkxNA+8HQNs3nVaNDq9825Ie4
        u4VAuuD6tCvtlMRtaQLxE4DPfA==
X-Google-Smtp-Source: ABdhPJxRhwGLp89W00/Tfuv49vRaAb4wTlkEiEsLfuc/hXdVElQ8UDRCSsygO/pyAgSyeggCDbz8Nw==
X-Received: by 2002:a63:5547:0:b0:374:4ec0:bad0 with SMTP id f7-20020a635547000000b003744ec0bad0mr26750370pgm.169.1646243249944;
        Wed, 02 Mar 2022 09:47:29 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h2-20020a656382000000b00370648d902csm16198083pgv.4.2022.03.02.09.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:47:29 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:47:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
Subject: Re: [PATCH] KVM: allow struct kvm to outlive the file descriptors
Message-ID: <Yh+trXegvWs+e5l3@google.com>
References: <20220302174321.326189-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302174321.326189-1-pbonzini@redhat.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022, Paolo Bonzini wrote:
> Right now, the kvm module is kept alive by VFS via fops_get/fops_put, but there
> may be cases in which a kvm_get_kvm's matching kvm_put_kvm happens after
> the file descriptor is closed.  One case that will be introduced soon is
> when work is delegated to the system work queue; the worker might be
> a bit late and the file descriptor can be closed in the meantime.  Ensure
> that the module has not gone away by tying a module reference explicitly
> to the lifetime of the struct kvm.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 64eb99444688..e3f37fc2ebf1 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1131,6 +1131,9 @@ static struct kvm *kvm_create_vm(unsigned long type)
>  	preempt_notifier_inc();
>  	kvm_init_pm_notifier(kvm);
>  
> +	/* This is safe, since we have a reference from open(). */
> +	__module_get(THIS_MODULE);

This isn't sufficient.  For x86, it only grabs a reference to kvm.ko, not the
vendor module.  Instead, we can do:

	if (!try_module_get(kvm_chardev_ops.owner))
		return ERR_PTR(-EINVAL);

And then on top, revert commit revert ("KVM: set owner of cpu and vm file operations").
vCPUs file descriptors hold reference to the VM, which means they indirectly hold a
reference to the module. So once the "real" bug of struct kvm not holding a reference
to the module is fixed, grabbing a reference when a VM/vCPU inode is opened becomes
unnecessary.

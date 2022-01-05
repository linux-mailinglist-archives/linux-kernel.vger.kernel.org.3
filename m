Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFACC484FC5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbiAEJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:07:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238747AbiAEJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641373641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zLHo5gatlAz4K5AXtvrHLogJItKyAj7DCmCIcRo2WqU=;
        b=WYEfu7A8sB0UTmKWDonhEIlrZQQGlmEeFf6OjYC1X/wUwZGE0Yfs/I9gp+SP9Jg8eNexmq
        J4S5CboVXz1pg20++okdfxAiUKU6aGdShEsS8O1UCkCc196wcA54ZCRZiIwNxWHkmvh3pg
        fvqlnZCoU6Qrz2aNvAVTn6FCOV2zAXg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-3nxHPzGXMMKCyNl2eFBT8g-1; Wed, 05 Jan 2022 04:07:17 -0500
X-MC-Unique: 3nxHPzGXMMKCyNl2eFBT8g-1
Received: by mail-pg1-f198.google.com with SMTP id c75-20020a63354e000000b003408e4153d1so21124829pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 01:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zLHo5gatlAz4K5AXtvrHLogJItKyAj7DCmCIcRo2WqU=;
        b=LKbO+8c01mC7MeYRVcm0sUZQlfb9DiK3bvi6j8Axz3+GdoprkeSkSaOdlgT3lld5un
         igFEdVqmBtkZtaNlDUd39kNEPzHIBSBzq4hGq54BxpvPMOWnCOx16NSwh5ye3nQvYWqx
         i2SF9lRJ/19EMxnY20OvDVpjdWHog1btyQlQOm6ffVW5Qozgk0ik93t3A+gg96dpTnuu
         klypCWG5+JqkyraE2KpXJNH3JrC5EkkBRKM0mcV+2Jf6alWGhM29UsBC/3bqeYstuwvD
         nfNA8WJgR7L8vAMP1xLd1VXRCTWvyCURuApTJxhCrOZK3ASWtiji+iP5hPUuMfyf9qLK
         Nrtw==
X-Gm-Message-State: AOAM532zMmjZwIzixeX67R5w0+qmKa96kDeM6bv1EKwwBda6B6NmvH4I
        L6wDzoW02/Lxd1MRrmvKPLblwkvZOg+u63kX6CVxHUsMzokPNorHtktU+V7BrJgg2ooqpEjjwJn
        uIka9NzsA0m8kay2YsGvaX37K
X-Received: by 2002:a17:90a:ff17:: with SMTP id ce23mr2935539pjb.164.1641373636637;
        Wed, 05 Jan 2022 01:07:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygM2moouakshCbTCfB6/j7aKotwHT4x7eDd+T3cw/smwNCpvmGYdchc35/8RBcj8F/v0HOrQ==
X-Received: by 2002:a17:90a:ff17:: with SMTP id ce23mr2935527pjb.164.1641373636403;
        Wed, 05 Jan 2022 01:07:16 -0800 (PST)
Received: from xz-m1.local ([191.101.132.50])
        by smtp.gmail.com with ESMTPSA id g5sm47343621pfj.143.2022.01.05.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 01:07:15 -0800 (PST)
Date:   Wed, 5 Jan 2022 17:07:10 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Nikunj A Dadhania <nikunj@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vasant.hegde@amd.com,
        brijesh.singh@amd.com
Subject: Re: [PATCH v2] KVM: x86: Check for rmaps allocation
Message-ID: <YdVfvp2Pw6JUR61K@xz-m1.local>
References: <20220105040337.4234-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220105040337.4234-1-nikunj@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:33:37AM +0530, Nikunj A Dadhania wrote:
> With TDP MMU being the default now, access to mmu_rmaps_stat debugfs
> file causes following oops:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 7 PID: 3185 Comm: cat Not tainted 5.16.0-rc4+ #204
> RIP: 0010:pte_list_count+0x6/0x40
>  Call Trace:
>   <TASK>
>   ? kvm_mmu_rmaps_stat_show+0x15e/0x320
>   seq_read_iter+0x126/0x4b0
>   ? aa_file_perm+0x124/0x490
>   seq_read+0xf5/0x140
>   full_proxy_read+0x5c/0x80
>   vfs_read+0x9f/0x1a0
>   ksys_read+0x67/0xe0
>   __x64_sys_read+0x19/0x20
>   do_syscall_64+0x3b/0xc0
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>  RIP: 0033:0x7fca6fc13912
> 
> Return early when rmaps are not present.
> 
> Reported-by: Vasant Hegde <vasant.hegde@amd.com>
> Tested-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> ---
> 
> v1: https://lore.kernel.org/kvm/20220104092814.11553-1-nikunj@amd.com/T/#u
> 
> Check the rmaps inside kvm_mmu_rmaps_stat_show() as the rmaps can be
> allocated dynamically (Peter Xu)
> 
>  arch/x86/kvm/debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
> index 543a8c04025c..9240b3b7f8dd 100644
> --- a/arch/x86/kvm/debugfs.c
> +++ b/arch/x86/kvm/debugfs.c
> @@ -95,6 +95,9 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file *m, void *v)
>  	unsigned int *log[KVM_NR_PAGE_SIZES], *cur;
>  	int i, j, k, l, ret;
>  
> +	if (!kvm_memslots_have_rmaps(kvm))
> +		return 0;
> +
>  	ret = -ENOMEM;
>  	memset(log, 0, sizeof(log));
>  	for (i = 0; i < KVM_NR_PAGE_SIZES; i++) {
> -- 
> 2.32.0
> 

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8149C849
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240479AbiAZLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:09:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240462AbiAZLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:09:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643195339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPtwTDwHghQtVyxWRc+Fq5g+xzmJLLojUxCSBluBiYo=;
        b=VmXvMu6uli0+sYiiCxIur/HSuspf+qdY38HyEjeBOFnKU4D9+gunA7UGZq/y6wiKdDJU3p
        LPsPLYtGjTBlcP6HM/tWM3iPUIgS0wpQvpJRacN9TIg/5e0RNuiUnBaXy8zeIqb1nwfsAj
        1N49nX/5HAVyhpAGMNraA2yuwvxFlwg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-l2sYW9rKN6q9lzoLsmHlsg-1; Wed, 26 Jan 2022 06:08:58 -0500
X-MC-Unique: l2sYW9rKN6q9lzoLsmHlsg-1
Received: by mail-ed1-f70.google.com with SMTP id bc24-20020a056402205800b00407cf07b2e0so6036398edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:08:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hPtwTDwHghQtVyxWRc+Fq5g+xzmJLLojUxCSBluBiYo=;
        b=o4GOR618LVqQDM4Sjx3I9Hr8lkF6RbrD+p6KQLcP++drOzsyX/GL/K82kM/OciGvdn
         3uRyTbrNT9aPQ2IxVDFNTOMwRJ8PnoV6f6CxryfGQ17Se3LBZOeyt5ZjU+Y/AbS9Vc87
         cqLniV4bEQsID1SDwiG7WuMhSgbHOT/HD7G2Jokyd6xiTtPKK370zwmgjjZSgYYa9M6E
         ECv2cE0FTCj9wg8dPNFw4+B4yyQ0+hp5S1XKiWiw08P2j/kV4dylCMYchtvgIRlVC4TS
         3FVNzzzMAnA24FCUx+wLY9bH+i+ELvUt5ADCeQVFp0WxoKtcyNmTac5u6Mlxj3xbcWjE
         AZaA==
X-Gm-Message-State: AOAM533giUkD3P2aPjibpWh5gP2FLz6ZG/I0GxepWmkatf9QQJK9jhDl
        QTQAdz3YvGixHLU00WnzClA2S2Fd0qOk8PZVQy0nZbqrfuJ/RXcn+om11jbSA/vvYHW0G3Qa8Yd
        Jp9JTwYCh0nzdlNu+oFHfoFTH
X-Received: by 2002:a17:907:7ea8:: with SMTP id qb40mr12708724ejc.541.1643195337424;
        Wed, 26 Jan 2022 03:08:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdUKeSXIU4o2kPWVGr2pmhV25aDoIatAXpL9c40+cFEd5lpNFyesBxrQl6LE484+Sgc9ijKA==
X-Received: by 2002:a17:907:7ea8:: with SMTP id qb40mr12708697ejc.541.1643195337159;
        Wed, 26 Jan 2022 03:08:57 -0800 (PST)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id dc24sm7251220ejb.201.2022.01.26.03.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:08:56 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+be576ad7655690586eec@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86: Free kvm_cpuid_entry2 array on post-KVM_RUN
 KVM_SET_CPUID{,2}
In-Reply-To: <20220125210445.2053429-1-seanjc@google.com>
References: <20220125210445.2053429-1-seanjc@google.com>
Date:   Wed, 26 Jan 2022 12:08:55 +0100
Message-ID: <875yq6iwjc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Free the "struct kvm_cpuid_entry2" array on successful post-KVM_RUN
> KVM_SET_CPUID{,2} to fix a memory leak, the callers of kvm_set_cpuid()
> free the array only on failure.
>
>  BUG: memory leak
>  unreferenced object 0xffff88810963a800 (size 2048):
>   comm "syz-executor025", pid 3610, jiffies 4294944928 (age 8.080s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 0d 00 00 00  ................
>     47 65 6e 75 6e 74 65 6c 69 6e 65 49 00 00 00 00  GenuntelineI....
>   backtrace:
>     [<ffffffff814948ee>] kmalloc_node include/linux/slab.h:604 [inline]
>     [<ffffffff814948ee>] kvmalloc_node+0x3e/0x100 mm/util.c:580
>     [<ffffffff814950f2>] kvmalloc include/linux/slab.h:732 [inline]
>     [<ffffffff814950f2>] vmemdup_user+0x22/0x100 mm/util.c:199
>     [<ffffffff8109f5ff>] kvm_vcpu_ioctl_set_cpuid2+0x8f/0xf0 arch/x86/kvm/cpuid.c:423
>     [<ffffffff810711b9>] kvm_arch_vcpu_ioctl+0xb99/0x1e60 arch/x86/kvm/x86.c:5251
>     [<ffffffff8103e92d>] kvm_vcpu_ioctl+0x4ad/0x950 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4066
>     [<ffffffff815afacc>] vfs_ioctl fs/ioctl.c:51 [inline]
>     [<ffffffff815afacc>] __do_sys_ioctl fs/ioctl.c:874 [inline]
>     [<ffffffff815afacc>] __se_sys_ioctl fs/ioctl.c:860 [inline]
>     [<ffffffff815afacc>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:860
>     [<ffffffff844a3335>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff844a3335>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84600068>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> Fixes: c6617c61e8fe ("KVM: x86: Partially allow KVM_SET_CPUID{,2} after KVM_RUN")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+be576ad7655690586eec@syzkaller.appspotmail.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/cpuid.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3902c28fb6cb..0a08db384fb9 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -346,8 +346,14 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
>  	 * KVM_SET_CPUID{,2} again. To support this legacy behavior, check
>  	 * whether the supplied CPUID data is equal to what's already set.
>  	 */
> -	if (vcpu->arch.last_vmentry_cpu != -1)
> -		return kvm_cpuid_check_equal(vcpu, e2, nent);
> +	if (vcpu->arch.last_vmentry_cpu != -1) {
> +		r = kvm_cpuid_check_equal(vcpu, e2, nent);
> +		if (r)
> +			return r;
> +
> +		kvfree(e2);
> +		return 0;
> +	}
>  
>  	r = kvm_check_cpuid(vcpu, e2, nent);
>  	if (r)
>
> base-commit: e2e83a73d7ce66f62c7830a85619542ef59c90e4

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks!

-- 
Vitaly


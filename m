Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C7448433F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiADOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:22:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231665AbiADOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kd7NsJXI8gYpybe5mVP7ztpJR15QwvvZgvb8pedcJXM=;
        b=axoRBK6p3Lp99Int9sYSISRZcVBIdf6hNqcTxmkQHN0A7etKV1aoblUsGk8fa4eZNJfamm
        paP0xkktK/gtvMLmSnYunPARdTdSKwT29vMe7Ix9gB40WKECnKuvAvUC3szlgAvgfGNAkQ
        u6jx0mmr3Pc02UjB2lFnq6xslgjVSAU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-Iow8871EPYWZkZm1a6t1eg-1; Tue, 04 Jan 2022 09:22:11 -0500
X-MC-Unique: Iow8871EPYWZkZm1a6t1eg-1
Received: by mail-wm1-f69.google.com with SMTP id g189-20020a1c20c6000000b00345bf554707so16764969wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Kd7NsJXI8gYpybe5mVP7ztpJR15QwvvZgvb8pedcJXM=;
        b=63WWLWYKZUrN5J/pXPPf37XBtLH+bZzvX5aUx4kqCJJXjgUC3ujX2rvFvbNQx5+TQ0
         Fuy+mGVBni7DosohCpqKEgNVlcBPqtb9KkqVniS3U8xqewP7qvRVsfDTylsjVBH5RE+X
         xQHaCYNadX2aNPtud7mMTLGke1zLv8rGB385lDYA5AO99AN5odBNoMBNGVPoBSJWBu1s
         rQne/6+2+IRX8Qu32Y52Hf534GK8uTaY5wsa17xstl744PjfDOxdftz5a7AYjtH4/Z8e
         HjwvpfPz/nqdKFRVyie6rPzdzg2f0lc+QcDoWUNADzNE8TyfxFEGyLQBSRmqV7JdWA/F
         0Spw==
X-Gm-Message-State: AOAM531EAPY8Okv7Wz3QTGlSwoed/AWbrp9BfeLsu/UnbCd6TdDMYMIQ
        VhzY/6aT/aoDBGp7Um6HqXXSg6kv4RLbLHDnljARliJAY5Ac/7+GCE5l+N4chfdtVY5hq8tpnK7
        e3kWsa4nEEjUtw6IV1iM/JtwE
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr43117679wmq.109.1641306129990;
        Tue, 04 Jan 2022 06:22:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw32qpFKWD69dT7hryNwrsfqQlIKMprgz5fqX/4Bi/8nva34KM25ikuyModAt0N7b2C0ORoeQ==
X-Received: by 2002:a05:600c:3589:: with SMTP id p9mr43117653wmq.109.1641306129690;
        Tue, 04 Jan 2022 06:22:09 -0800 (PST)
Received: from [192.168.3.132] (p5b0c62bd.dip0.t-ipconnect.de. [91.12.98.189])
        by smtp.gmail.com with ESMTPSA id r11sm38357940wrw.5.2022.01.04.06.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 06:22:09 -0800 (PST)
Message-ID: <7eb40902-45dd-9193-37f1-efaca381529b@redhat.com>
Date:   Tue, 4 Jan 2022 15:22:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 kvm/queue 01/16] mm/shmem: Introduce
 F_SEAL_INACCESSIBLE
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com
References: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
 <20211223123011.41044-2-chao.p.peng@linux.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211223123011.41044-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.12.21 13:29, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
> the file is inaccessible from userspace in any possible ways like
> read(),write() or mmap() etc.
> 
> It provides semantics required for KVM guest private memory support
> that a file descriptor with this seal set is going to be used as the
> source of guest memory in confidential computing environments such
> as Intel TDX/AMD SEV but may not be accessible from host userspace.
> 
> At this time only shmem implements this seal.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/uapi/linux/fcntl.h |  1 +
>  mm/shmem.c                 | 37 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index 2f86b2ad6d7e..e2bad051936f 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -43,6 +43,7 @@
>  #define F_SEAL_GROW	0x0004	/* prevent file from growing */
>  #define F_SEAL_WRITE	0x0008	/* prevent writes */
>  #define F_SEAL_FUTURE_WRITE	0x0010  /* prevent future writes while mapped */
> +#define F_SEAL_INACCESSIBLE	0x0020  /* prevent file from accessing */

I think this needs more clarification: the file content can still be
accessed using in-kernel mechanisms such as MEMFD_OPS for KVM. It
effectively disallows traditional access to a file (read/write/mmap)
that will result in ordinary MMU access to file content.

Not sure how to best clarify that: maybe, prevent ordinary MMU access
(e.g., read/write/mmap) to file content?

>  /* (1U << 31) is reserved for signed error codes */
>  
>  /*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 18f93c2d68f1..faa7e9b1b9bc 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1098,6 +1098,10 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
>  		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
>  			return -EPERM;
>  
> +		if ((info->seals & F_SEAL_INACCESSIBLE) &&
> +		    (newsize & ~PAGE_MASK))
> +			return -EINVAL;
> +

What happens when sealing and there are existing mmaps?


-- 
Thanks,

David / dhildenb


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D66502C42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354799AbiDOPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354794AbiDOPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:04:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A571B7C5B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so11966019pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Az4fGj41zOdvkfI9EKM24+0aqWRfUg0i44LnNLGYmEM=;
        b=n/ITxv/qMhJcXJbybE8llTliBfr1k8JJIzO2zL/ZNTGbt7v3hjI7fWhhJSpIUOVn8o
         cdpZ7SRiz3M7qD56Hi5kGz9SkKdxY/KMLZCJ8j67oaob5VkwDiq2VOxG3cFQ+7Ch/HgV
         hjgtWwVDObmDvtJS1lgGc3HBH2SQcHLt5+TArE9Rp9VHezDXcP60FMj902nhDtQZbK+M
         OuHowPFzQaF1UZT0qECi+VRyyR4Rap2D+F3YMxwT3HUQtmEAYMR2BPJ5TJgeYAFX9qx1
         W3q5OUtLUZcL2lj0yylPC2tJZ2hJZt4XrDP6mjpFxhvUg3ZrEA1s6bJbvISQixv1MGNO
         T+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Az4fGj41zOdvkfI9EKM24+0aqWRfUg0i44LnNLGYmEM=;
        b=KRqCt7SMru92Qj0WoPi3ru5vYRUn04Ijqh+tm/JQMuo7Z2rEkSRLODLRNp1SZC7QWG
         LmB4F4A7fAJ3HapVsEKOZy0ztdQ4hD53MHTGhY4YeqTaoIavAi/J3zO22/c7CIZh2m9O
         XEBJFacxw8NTF9pIJkx/JRfLy3PYWBJM9Oayqg+J9s+FVFUuhq8qh0wFdxho03IkNz9c
         P6X3GE0EoGsLyVMY96ZekBzQPmtSooZdiABhsbH6vWRg6o4qsB07yU7i1OakTD7nhXqv
         Vwn+izTzCt5WKTX2m+E4sImRr4DDWx9g9AwLx+25Q5w2olkxK9uu2eZo2sLOWnt0O5fE
         DW/Q==
X-Gm-Message-State: AOAM532ntdWQdnlYwakbrZBBfqBvI+V9HGTLqU6GFR/x4niad6zN8xam
        I/rpUIyLkIhQYj73IMspkz2avg==
X-Google-Smtp-Source: ABdhPJymh7kAEgYCaObPRMje0xl3Oiwg/sQm394mC6KLFbzt8LkrelPDymNdNsDi4naPj3WzojXOIQ==
X-Received: by 2002:a17:90b:3a82:b0:1cb:9ba8:56a5 with SMTP id om2-20020a17090b3a8200b001cb9ba856a5mr4641840pjb.16.1650034916361;
        Fri, 15 Apr 2022 08:01:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id v4-20020a622f04000000b005057a24d478sm3162719pfv.121.2022.04.15.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:01:55 -0700 (PDT)
Date:   Fri, 15 Apr 2022 15:01:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Kai Huang <kai.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Robert Hu <robert.hu@intel.com>,
        Gao Chao <chao.gao@intel.com>
Subject: Re: [PATCH v8 8/9] KVM: x86: Allow userspace set maximum VCPU id for
 VM
Message-ID: <YlmI4N1erENL9HyV@google.com>
References: <20220411090447.5928-1-guang.zeng@intel.com>
 <20220411090447.5928-9-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411090447.5928-9-guang.zeng@intel.com>
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

On Mon, Apr 11, 2022, Zeng Guang wrote:
> @@ -11180,6 +11192,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	struct page *page;
>  	int r;
>  
> +	if (vcpu->vcpu_id >= vcpu->kvm->arch.max_vcpu_ids)

This belongs in pre-create.

> +		return -EINVAL;
> +
>  	vcpu->arch.last_vmentry_cpu = -1;
>  	vcpu->arch.regs_avail = ~0;
>  	vcpu->arch.regs_dirty = ~0;

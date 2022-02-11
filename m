Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5256E4B24AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349588AbiBKLpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:45:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBKLpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:45:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16A5DF04
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644579932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ8YEo22ps5NigvvVJRI9VbNgqerPawLnII9A47TtAk=;
        b=ao0Fg8SA/54JqVenKHZkgEW8SzDK6HEaJYIZ0bqqulrHuI5r5hMuM6RFUiYxiJJte/Hd3g
        xmCKlXD5UryjO21XF0p765udnizJ1qooy00qlez5tuRITwHzxHNAWFoNI7M6LFd7fqKkUE
        lnybS0VmwPb7XhQsUEBB9mDtyNGyTSI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-HUZvmEmHNO6foEXv4qgMMA-1; Fri, 11 Feb 2022 06:45:31 -0500
X-MC-Unique: HUZvmEmHNO6foEXv4qgMMA-1
Received: by mail-wr1-f70.google.com with SMTP id q21-20020adfab15000000b001e57c9a342aso122048wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 03:45:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DQ8YEo22ps5NigvvVJRI9VbNgqerPawLnII9A47TtAk=;
        b=i84fHD5I+CxMhUAChGHQdhQackTezfSlWFotZGFlxR9G7bZ8me+I6SEo0e+h6pn5/t
         huuZd/fXhpXbRbXH9Z9lVpyJoKm6SG3y5hTsdbNv3gW5QKwpcfByAVwQIWyRlTXUdmSJ
         CzgdQPQ6svPIowNFzEMPFWgMAGrHd2gCjurayOzag6zDFDEZG7/OLf295We3O1TF2GbB
         9IfrJOYQFW5nQxP7GE6wJ80cN3xBiQnG8dU3tjZMU/cMNBMkxAbp4pp+eBPR91wkYvua
         n7dcPUDxzX9oBSZHhbGC+ryzFMOJF0QXUaCX0mihSI08xEOf2lSLJ3QmKixB9TMbIi7i
         V1+A==
X-Gm-Message-State: AOAM53096lwiewqCJJPqINlFMmcSWHifB/sbw/HZm6Z6Zre4uAJ8KJ/L
        29GXp/CWZuhSoAsmYM0Nbbp+Vd0kuOOV/wM5+6jlPoDsydyT8GAiWj12CR/UQVoovJW130OyfGw
        NNnMEffGq6K6teBu1kJteeke3
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr1079852wrr.168.1644579929886;
        Fri, 11 Feb 2022 03:45:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyyHxJw23lPiOuOKGQuFMysTofU8rIByb81GZfOLYpN/WVJ5RLk+oIb8abUTzeFuBojd/jcoQ==
X-Received: by 2002:a5d:42c2:: with SMTP id t2mr1079834wrr.168.1644579929581;
        Fri, 11 Feb 2022 03:45:29 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id u11sm17593465wrt.108.2022.02.11.03.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 03:45:28 -0800 (PST)
Message-ID: <51fcfb88-417b-e638-78b7-bbca82d8bd8b@redhat.com>
Date:   Fri, 11 Feb 2022 12:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 09/12] KVM: MMU: look for a cached PGD when going from
 32-bit to 64-bit
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <20220209170020.1775368-10-pbonzini@redhat.com> <YgW8ySdRSWjPvOQx@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YgW8ySdRSWjPvOQx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 02:32, Sean Christopherson wrote:
> Maybe cached_root_find_and_rotate() or cached_root_find_and_age()?

I'll go for cached_root_find_and_keep_current() and 
cached_root_find_without_current(), respectively.

> 
> Hmm, while we're refactoring this, I'd really prefer we not grab vcpu->arch.mmu
> way down in the helpers.  @vcpu is needed only for the request, so what about
> doing this?
> 
> 	if (!fast_pgd_switch(vcpu, new_pgd, new_role)) {
> 		/*
> 		 * <whatever kvm_mmu_reload() becomes> will set up a new root
> 		 * prior to the next VM-Enter.  Free the current root if it's
> 		 * valid, i.e. if a valid root was evicted from the cache.
> 		 */
> 		if (VALID_PAGE(vcpu->arch.mmu->root.hpa))
> 			kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOT_CURRENT);
> 		return;
> 	}

I tried, but it's much easier to describe the cache functions if their 
common postcondition is "vcpu->arch.mmu->root.hpa is never stale"; which 
requires not a struct kvm_vcpu* but at least a struct kvm*, for the MMU 
lock.

I could change kvm_mmu_free_roots and cached_root_* to take a struct 
kvm* plus a struct kvm_mmu*.  Does that sound better?

Paolo


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A294F57DD1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiGVJG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiGVJGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:06:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C34820EE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658480778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rbYwuV3i4PqAHK5ld50ISeNUCppbs4nL1D7WPVjNER8=;
        b=da0VQSJgvECgujXXJxyhf3PTi478WSUJ2lYWaCgW1QSc471DrFVyJUEy0/t6IiqgCIMKyG
        5dmgK3aycoPgNoqw54XF8NRoRoPW0I8rqXNtg+XrPBf2XxREr/1UNqsD/gHrTCXiOy3Yc+
        +ll5WGJ42+JStEeyEhs5omkKktnu14E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-Uw6QHmyvN0aAqro2nBYH0Q-1; Fri, 22 Jul 2022 05:06:16 -0400
X-MC-Unique: Uw6QHmyvN0aAqro2nBYH0Q-1
Received: by mail-wm1-f69.google.com with SMTP id n19-20020a05600c3b9300b003a314062cf4so3626518wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=rbYwuV3i4PqAHK5ld50ISeNUCppbs4nL1D7WPVjNER8=;
        b=6oW/4rC+XbpaAJ7/zME3NRafVg4IzublKof929lW7IVBvrlGUL/trghxXPOiJ33J3A
         wUIbIA6i0E3dFH0KaBPwrOPqJ727TslR8YXIT2zwgGnJ2OJYAy17AsskXnG/ZO82PArJ
         ePkVh5ZDQGvHUt7Pvc19KSkOtnoFaB+Lnjsa2ukygmEf89BmQwFqUhfwjuIGlIZFidOQ
         f0+2xhyxl/QohLQ/xSbibTHaWrUWHln2OWmOQmCXLjVNlNVocgLO0CBsofLK0GUmBdzi
         N8kj+5D3pWJpp8Pd7NTaLHp3uvKdZsDJibsOpcMgn/UhMy+zUevjAZ+KBqZGalgGvfhK
         i8sA==
X-Gm-Message-State: AJIora84Ncqn+rBWgwAbGO6gy4ZZGZ7cWWSa501kb/o9f4gHzQT3visP
        2adnyXv0N5CbeIeyxMy+NjVaI77i7Fd6E0dxi2uFaNguAtWAP6LgHkYtzflTHxkQtVLTGiqo6tW
        hESbwy+O6fSOmQ/664hnvOYgm
X-Received: by 2002:adf:db51:0:b0:21e:41c2:c2e8 with SMTP id f17-20020adfdb51000000b0021e41c2c2e8mr1810843wrj.452.1658480775038;
        Fri, 22 Jul 2022 02:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sseLStw14oJt7duxvShbI7FdU+s/HM9kzzuXgW+lC0wBk1bXpXWTeYkdzVUHcidYvvr0xarw==
X-Received: by 2002:adf:db51:0:b0:21e:41c2:c2e8 with SMTP id f17-20020adfdb51000000b0021e41c2c2e8mr1810813wrj.452.1658480774794;
        Fri, 22 Jul 2022 02:06:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id f8-20020a05600c4e8800b003a31673515bsm9457159wmq.7.2022.07.22.02.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:06:14 -0700 (PDT)
Message-ID: <2f5c2242-0c73-9770-9e17-9c87c27c2f05@redhat.com>
Date:   Fri, 22 Jul 2022 11:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Li <ercli@ucdavis.edu>,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>
References: <20220607213604.3346000-1-seanjc@google.com>
 <20220607213604.3346000-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 06/15] KVM: nVMX: Keep KVM updates to BNDCFGS ctrl bits
 across MSR write
In-Reply-To: <20220607213604.3346000-7-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/22 23:35, Sean Christopherson wrote:
> From: Oliver Upton <oupton@google.com>
> 
> Since commit 5f76f6f5ff96 ("KVM: nVMX: Do not expose MPX VMX controls
> when guest MPX disabled"), KVM has taken ownership of the "load
> IA32_BNDCFGS" and "clear IA32_BNDCFGS" VMX entry/exit controls. The ABI
> is that these bits must be set in the IA32_VMX_TRUE_{ENTRY,EXIT}_CTLS
> MSRs if the guest's CPUID supports MPX, and clear otherwise.
> 
> However, commit aedbaf4f6afd ("KVM: x86: Extract
> kvm_update_cpuid_runtime() from kvm_update_cpuid()") partially broke KVM
> ownership of the aforementioned bits. Before, kvm_update_cpuid() was
> exercised frequently when running a guest and constantly applied its own
> changes to the BNDCFGS bits. Now, the BNDCFGS bits are only ever
> updated after a KVM_SET_CPUID/KVM_SET_CPUID2 ioctl, meaning that a
> subsequent MSR write from userspace will clobber these values.
> 
> Uphold the old ABI by reapplying KVM's tweaks to the BNDCFGS bits after
> an MSR write from userspace.
> 
> Note, the old ABI that is being preserved is a KVM hack to workaround a
> userspace bug; see commit 5f76f6f5ff96 ("KVM: nVMX: Do not expose MPX VMX
> controls when guest MPX disabled").

Actually this is not a userspace bug.  It's an L1 workaround for running 
*correct* L1 userspace without a *kernel* bugfix on L0, namely commit 
691bd4340bef ("kvm: vmx: allow host to access guest MSR_IA32_BNDCFGS").

But thanks for writing the incorrect commit message, because now that 
I've actually looked at the history, I'm going to say screw 6 year old 
kernels used as L0.  Let's just revert commit 5f76f6f5ff96.

I've applied patches 1-5, let's see how bad the conflicts are in the 
rest of the series.

(This shows another reason why sometimes series seem to be cursed and 
don't get reviews: maintainers having a fuzzy feeling that *something* 
is wrong with them and putting off the review until it finally clicks).

Paolo


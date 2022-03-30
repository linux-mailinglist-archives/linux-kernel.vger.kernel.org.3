Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27174ECEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351257AbiC3VcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbiC3Vb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:31:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E84D31537
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:30:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id m18so16777949plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CEn6/r/ZGWZXMZUmYVZng4ORZ5vSmBzYTb0jFRLq/+s=;
        b=Ho8F6Xq8qKK2HpwU9EwkyiwMfxHIJQpoTAefD2KLP9A0iI8ML1um5jK0N2q62sr7VS
         huUNGp0Wf9WnphzezrqjyJ08bUthbDN5KVRXRXpB9SSTYPmRcnvP/X1yydWUEJ6dA5Mu
         I97oxhDUYtlDRsrbHFdZfIZEHLcS8HtNTrv3BJBy1kOW1m1cKvkwgHI1HQjPuWGEYIz/
         Af9N3g3XfKW2OBv5pESpWUplVlGNbwAVjYeY4LsorzXgSGeXgIBq7LhhtTRUt6DGfd/J
         uCe7JuvdrpKf9baDfvy2VttDBsoh+GeKz+ZRFGOwxp3EBjTaoTLo5WxRWCMtbOgNM9Ud
         ulqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CEn6/r/ZGWZXMZUmYVZng4ORZ5vSmBzYTb0jFRLq/+s=;
        b=nskFr/2+8w/OLM+bh5xa+jKUTd+zvfUjMSGlpoSC0ea0re4WxahhzLriOpRO7koRs5
         HfTpdqzj2Ab3hYL/wgclLwzH/UfipyvMCKke5kNFCRQHSq4O0OzXhaFKg6igWCeH4jk4
         ioVnteviDpzBenrgfaIk8Fp6vHHGciCOQ3x1g+ydtFajxRJYPmQgMAe577V5YZF8fWZm
         dEVmwwciR5W7urv2Ay+e2UPSd2/6iFZk4AUv+zdJlnUUJVQ+S5M4osadYcxzOtf6qu47
         qmOuSALZm6FNHeo9s1g9yOKq6fMbJmge0NM9Hp90kmsYoumdbVpOzC0cdg8cJMcBi8MW
         G7Pw==
X-Gm-Message-State: AOAM533RSnWOyt9jkruKv0Wy9gAmKfu4qI7iZE2ljjqnYuy4BiSwsGpQ
        PgFJRAsNm38vdd3a/Hu4yIjR2w==
X-Google-Smtp-Source: ABdhPJzGrFsFwbETc7V80bx6/F6lVNAxOGHD1/e87cIIBZh9XMIJwTglJJow2P4f1hCgZhBQmhdHuQ==
X-Received: by 2002:a17:902:c40e:b0:154:80a7:95c9 with SMTP id k14-20020a170902c40e00b0015480a795c9mr1866571plk.28.1648675811664;
        Wed, 30 Mar 2022 14:30:11 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a0cc300b001c743a2b502sm7491468pjt.43.2022.03.30.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 14:30:10 -0700 (PDT)
Date:   Wed, 30 Mar 2022 21:30:07 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] KVM: VMX: Expose PKS to guest
Message-ID: <YkTL323reMAWh80M@google.com>
References: <20220221080840.7369-1-chenyi.qiang@intel.com>
 <20220221080840.7369-7-chenyi.qiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221080840.7369-7-chenyi.qiang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022, Chenyi Qiang wrote:
> @@ -7454,6 +7455,13 @@ static __init void vmx_set_cpu_caps(void)
>  
>  	if (cpu_has_vmx_waitpkg())
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_WAITPKG);
> +
> +	/*
> +	 * If not support VM_{ENTRY, EXIT}_LOAD_IA32_PKRS,
> +	 * don't expose the PKS as well.
> +	 */

I wouldn't bother with the comment, this pattern is common and the behavior is
self-explanatory.

> +	if (cpu_has_load_ia32_pkrs())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_PKS);
>  }

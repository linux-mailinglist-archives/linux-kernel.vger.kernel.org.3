Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46A4EB752
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 02:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiC3AGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 20:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240597AbiC3AGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 20:06:31 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8613C4B4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:04:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id jx9so19016331pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OgjJyyATF+VpKVfS263tcfkmJwjPd/6odIj5AGpDNko=;
        b=gCQ3jdfhflu3bdBEFaAex0ySn2wXJz7Jxqj0htlNfMGmtPrBJmmNx8jO48TX5WONv3
         p38xKI70ciK9S5qXQ8/Adi2v4SHMdgCRVqKZbsLIlth2ZuldfNuAODHKixUCyuptx/Ur
         0ZVBdigI7st85WCG1iA2P2Ri95q5J/TxcE6rBahwqSb015rqAYDnZnayHdESHWCSLGtc
         A4isiqszKYrrMKoZX5pxzj/ODjbSsiJTfeFR+vB3ZBUHnZSZdNqLjm0wwRCvBOO1qLp3
         wRH+BgGSfyD+bkEYKtsLZCzU+KviKUF7lfZsRoqISlS4wyVtMbRK1uBNGwC+2g9JPKYC
         H2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OgjJyyATF+VpKVfS263tcfkmJwjPd/6odIj5AGpDNko=;
        b=secaiK8KLGPPtpWG5xaM83WA1fV5MJl70X4g0kOprUDpGAcyTjMNoMDTjV6CIFEjOH
         xAzahTMpVJEcu2heoLxOxNBqDnWxg0WoFQ6KdqPhWglA0nIggfKaNgcz/a14gywlLlRd
         95nmT6lvFo/5lCBmfA33ePhj80GJMlrXB5kwnU/J39uhfv6XwpRRvdq0Qy5fIBPJfupG
         HdlUw47nGjfccmy/uYPMNlbXtDSlZalQ4Wg/GqAhIKqfk+PfiBK336s++SWVsS65mppv
         iRzvShC+uUPgWAxWG3GUQRSzRCC+Tblxf9gYjj2c+pMnPmMW1srK2/qQXGNCa4KvbUDq
         5gtA==
X-Gm-Message-State: AOAM532vOTyg8zyc7FuruBegnGPI4nXldZgoDVfCw3hdxIXXcxRvTCAJ
        uAyrenGjj94WKBYGjc0mIXvC1g==
X-Google-Smtp-Source: ABdhPJzfe9uXePNEmJMBtGk9vGYh7XnJhCdQ8ToGQFiqRnXzThNrzQ48fSmP81E5Y3ar4jzdygNzIw==
X-Received: by 2002:a17:903:244d:b0:154:3772:6b32 with SMTP id l13-20020a170903244d00b0015437726b32mr32458415pls.70.1648598685719;
        Tue, 29 Mar 2022 17:04:45 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0024c500b004fae56b2921sm20798974pfv.167.2022.03.29.17.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 17:04:45 -0700 (PDT)
Date:   Wed, 30 Mar 2022 00:04:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH RESEND 2/5] KVM: X86: Add guest interrupt disable state
 support
Message-ID: <YkOembt1lvTEJrx0@google.com>
References: <1648216709-44755-1-git-send-email-wanpengli@tencent.com>
 <1648216709-44755-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648216709-44755-3-git-send-email-wanpengli@tencent.com>
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

On Fri, Mar 25, 2022, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Let's get the information whether or not guests disable interruptions.

This is missing critical information for _why_.  It took me some staring to
understand that this allows querying IRQs from a _different_ vCPU, which needs
caching on VMX due to the need to do a VMREAD.

> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/x86.c              | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 50f011a7445a..8e05cbfa9827 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -861,6 +861,7 @@ struct kvm_vcpu_arch {
>  		bool preempt_count_enabled;
>  		struct gfn_to_hva_cache preempt_count_cache;
>  	} pv_pc;
> +	bool irq_disabled;

This is going to at best be confusing, and at worst lead to bugs  The flag is
valid if and only if the vCPU is not loaded.  I don't have a clever answer, but
this needs to have some form of guard to (a) clarify when it's valid and (b) actively
prevent misuse.

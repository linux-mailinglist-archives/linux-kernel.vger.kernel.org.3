Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E734AF90C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiBISLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238717AbiBISLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:11:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAC6C05CB86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 10:11:04 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y18so2891212plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 10:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oY+tYRFthah59PWP99vpDNgjsdfGaS6KaNNBy4kyZY=;
        b=aIJ24nni0G/fFJt3Fk+Xrt1tAddfS8z21PSTPIGPtEOhxBCBIEnzhKwiV19vmBX7MT
         oISG6XEqBsvTSfcGjfrNRzVUmG4G7AVBM0gFg4LHytZ9J5bSvcffaPEM5cml6AqH0occ
         w77hsSKNqCJOr56BrPDZw2uhnmAomC7Hk8H/pOEYde30JF755leO6n1GwZiJy7c+3J8K
         DyQ3vUw/cNfbmWx0UoC0QRlfTTinQmhcd3MzcizC76fS4GKfwPQTqUlQmYwlDDkf/jGD
         tamup+L/i7ikb7HssLBKpqu9jRU4kCPaWb0CzSItdYdqcUxapMlQyZSwhQWZ27JVJnNb
         U4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oY+tYRFthah59PWP99vpDNgjsdfGaS6KaNNBy4kyZY=;
        b=M/mbqZzBRpyxUBIthjvNpPbCv0hKPm4U64/imEH4tSKF3ve4AmXIg577gj7awJAxQx
         ZCud4neGeH1NjhQKhFS/RwHzbK8bRi3r27inOCyNVHuEODL/TkQcXxVIwWYABdSfpav7
         t7V1jmI/nC+n4X5i3QCd3h5sXJW0xdN7bmwwFgTHhomRcHEy4ATToLAStNzQQKvUdTEc
         9Wlykg6jJ1TCCSgq+SgESWUYblQ99APItnSmv9R/ROhTb9HvreT14JbXt3bmu93UglSx
         hMxJI+GTp98GpGSIbaTeS8zmDbx83jCf45IJevxp9HxDhwm0gOaDXm9+eqpr9vzkmKqB
         sSOw==
X-Gm-Message-State: AOAM531AM+24RmkV1kxhpjSHXV/1nIFlSO+dah8pjS3kmn5bdlNHYfBS
        xIg0CFPTrW2a5tUXo7YE+db+Kw==
X-Google-Smtp-Source: ABdhPJw5SX55TSX40RJDqvn5ur0+05uMulApiGgLUV22l/7HKoDCbNKoi1CdN2tzogRriUQTKhyblA==
X-Received: by 2002:a17:902:dac7:: with SMTP id q7mr3279304plx.125.1644430263971;
        Wed, 09 Feb 2022 10:11:03 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id my18sm6854817pjb.57.2022.02.09.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:11:03 -0800 (PST)
Date:   Wed, 9 Feb 2022 18:10:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] KVM: x86: Move check_processor_compatibility from
 init ops to runtime ops
Message-ID: <YgQDswKRZrTnbmeN@google.com>
References: <20220209074109.453116-1-chao.gao@intel.com>
 <20220209074109.453116-2-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209074109.453116-2-chao.gao@intel.com>
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

On Wed, Feb 09, 2022, Chao Gao wrote:
> so that KVM can do compatibility checks on hotplugged CPUs. Drop __init
> from check_processor_compatibility() and its callees.
> 
> use a static_call() to invoke .check_processor_compatibility.
> 
> Opportunistically rename {svm,vmx}_check_processor_compat to conform
> to the naming convention of fields of kvm_x86_ops.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

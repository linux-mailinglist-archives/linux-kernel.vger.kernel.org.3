Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABF457C1AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 02:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiGUAjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 20:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiGUAjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 20:39:06 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEEB753B2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:39:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p6-20020a17090a680600b001f2267a1c84so1962126pjj.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 17:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZCvXrPjjErSLUuzMTz+5ZrP+PuktZrygBcWKu8/5ddg=;
        b=JmRzJAhNTQpxe8+ZZNSS6vVxO1/9JHVeBG188CDghVvTpej1p+g7jogw95Ntql33IG
         FqAO08kSaIyx9OBiHqi+ZpjtOkJPYSGNIecNOgBIpF1gYZbU24leW5OXdJN65suqPzCw
         KbxhF51kBHlbM9tXR9bDemWhLVajSS77vun86fRmeqpGjm+SEspyy+NGiDu37cG4ZmCo
         BAY9BDcfaew5BFQRMyfTWjy2ktqHcGkm222aEjhpWDH1LQGovq85qX5YL+I7RFl2ugTS
         WJ8K69MsCkGqAS4cOb9itmKPvXZXTTkOICIuKbdxdW/+v3CbrU7ZcvfuaQp1s1I+ww7f
         d6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZCvXrPjjErSLUuzMTz+5ZrP+PuktZrygBcWKu8/5ddg=;
        b=fgDXa6A0LV+qF12+gwEMqa3/bDW+bWS5T2V2IBUjH0cfPO5OaVy1Yxc6FPWAxXbTeg
         n/qi6Ah3mIdeqIrg1bm74so96X+S2UXviejzIOhSdN4u6API2BG25xWYuLZXXIKbyB7N
         XHkx/sS964q8oi/yiX+bhBMbHqlMRESppzr64C0vWRVQhya9XkqK/5xtXDKv/kmjli5j
         bTJhYBeHQ5FPVjUkmI4wdOUCpaxD3vo1O6mGH816Q6KDZgUXUNx1hNFwki5PFmboAz4x
         NDzDqlR2BYEIyAQU0Y6ibSvqzgg1ak+OnchQScOIm0buaaLXLg5knzLTrohDcK3z2Pmv
         IW6A==
X-Gm-Message-State: AJIora94HvydmwVF2kF/t0C9c63fdlcPmkKVlFKpvWJwjhwMR7LbROXb
        u96edl5k/14AaucL2kkTezF2vw==
X-Google-Smtp-Source: AGRyM1uu0fpq63erLsH6+fNwO6hGDiULbei4kfZB9O3NkuU1bVPJ6GPdNwcEt5DSQfOrXl9jOhCo+A==
X-Received: by 2002:a17:90b:3c0d:b0:1f2:31c9:7481 with SMTP id pb13-20020a17090b3c0d00b001f231c97481mr87582pjb.244.1658363945785;
        Wed, 20 Jul 2022 17:39:05 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id b3-20020aa79503000000b00528669a770esm246340pfp.90.2022.07.20.17.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:39:05 -0700 (PDT)
Date:   Thu, 21 Jul 2022 00:39:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 10/11] KVM: x86: SVM: use smram structs
Message-ID: <YtigJfHmyTr3eE5v@google.com>
References: <20220621150902.46126-1-mlevitsk@redhat.com>
 <20220621150902.46126-11-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621150902.46126-11-mlevitsk@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022, Maxim Levitsky wrote:
> +	if (!guest_cpuid_has(vcpu, X86_FEATURE_SVM))

I think you want X86_FEATURE_LM, not X86_FEATURE_SVM.

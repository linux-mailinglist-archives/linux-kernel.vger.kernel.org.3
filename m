Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242915A168E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiHYQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243011AbiHYQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:20:03 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A925B865
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:20:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f17so14113729pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=WAj0AHoiwnkmFJmmfno3NergegJGg1EwrtdnvbOAI9o=;
        b=a5lj54YXr+P5Qzt2j9UpZH3fRt8z3UbyRuIuMJCb8+0NjkeROBRHnn/SsP6sy3BW86
         CR+5GOL6/1GL0MBSUdpOQec4+jDUd6UBi1wH/VIHfGhGsl5/EVmEStjzf3a5W6dS/kr5
         P+2mKmMPBtgQc2aX4x+DQz1GoMkA1/eJkGsnURjxGdPdxY9eVo6loMDIXiPu3+Q7loLM
         oovo7rYFIyhFK4YE7SVemYrKViXvSSgZUAV6PkVBQja59EvX4lKjNSTVdj/LJe0lQPhD
         5zmb288RbHTZvpuiBNK4OJJ2+cYailmAl8XSF+goSukeFWn2PwxU/mYfc+wTcI01NlW0
         EVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=WAj0AHoiwnkmFJmmfno3NergegJGg1EwrtdnvbOAI9o=;
        b=ZTlTU1sC/EbS2dJ1nA/D0XVhRL49KlWUqhEppjExSljYaXAp1FT8V9XSQxFMA/eFx5
         Lin0zpdC4uZ2MOjtS3+vtgTS+WxDQwlibXS9xGpMJUKl6naehSZOEeZNfSkwMZkpOS/d
         yktM6s2eN3BdIkfRIBTvCXR4Olu/5Zc1FkLVggYruoJYV3J/K8u9gsCDzHtEXAIM/NTW
         rnh3RLGi9o/NUbpXJxFaJKSjUdbNEtBfkwimi+KjAAxcJecClZFYsXzhntIZDcrso5tQ
         m6yLS+iTtBjetULZwlnYxHKF0b4WPlww6QXfRwuDobaVAeaN/IF/4ojLpYNVANk9xDiO
         Ez/A==
X-Gm-Message-State: ACgBeo3SLVnGmuZk8uAIWXHaNwHwQf/DoHjh8YR5+Md0k8qs46+WafbV
        NDj4EQO+QxRy3poNLQqMU4qMh/yl+8vekQ==
X-Google-Smtp-Source: AA6agR63kTdxJt3IwFH3SprzjdLCpiJhtIgy3SaxUDsr7aKI7q57qkSrsP8Tke9HSTXe5G5SJzo4BQ==
X-Received: by 2002:a63:1725:0:b0:42b:4300:358 with SMTP id x37-20020a631725000000b0042b43000358mr3915004pgl.536.1661444400571;
        Thu, 25 Aug 2022 09:20:00 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id d62-20020a623641000000b0052d2cd99490sm15388101pfa.5.2022.08.25.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:20:00 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:19:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, yang.zhong@intel.com
Subject: Re: [RFC PATCH 1/2] KVM: x86: Add a new system attribute for dynamic
 XSTATE component
Message-ID: <YwehLNws0WBNRDgN@google.com>
References: <20220823231402.7839-1-chang.seok.bae@intel.com>
 <20220823231402.7839-2-chang.seok.bae@intel.com>
 <YwabSPpC1G9J+aRA@google.com>
 <08e59f2d-24cb-dca8-b1b8-9e80f8a85398@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08e59f2d-24cb-dca8-b1b8-9e80f8a85398@intel.com>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022, Chang S. Bae wrote:
> On 8/24/2022 2:42 PM, Sean Christopherson wrote:
> Maybe this is a policy decision. I don't think that
> ARCH_REQ_XCOMP_GUEST_PERM goes away with this. Userspace may still use the
> arch_prctl() set. But then it makes more sense and consistent to use
> ARCH_GET_XCOMP_SUPP in first place, instead of KVM_X86_XCOMP_GUEST_SUPP, no?

KVM_X86_XCOMP_GUEST_SUPP is needed so that userspace understands what _KVM_
supports.

> > If QEMU wants to assert that it didn't misconfigure itself, it can assert on the
> > config in any number of ways, e.g. assert that ARCH_GET_XCOMP_GUEST_PERM is a
> > subset of KVM_X86_XCOMP_GUEST_SUPP at the end of kvm_request_xsave_components().
> 
> Yes, but I guess the new attribute can make it simple.

Adding new uAPI and new exports to eliminate one line of userspace code is not a
good tradeoff.  Am I missing something?  This really seems like solution looking
for a problem.

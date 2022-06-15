Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC04454CA68
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbiFONzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349036AbiFONzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:55:36 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A825C6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:55:34 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x138so11496896pfc.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cBZGCZ1ZBD21PpBDQ3oItDkWcZgN/+XlTCNT19zbuNY=;
        b=E/drkdPuRhwd4tbccr4C5OiRxOF3aIEi2beGOFn6UFNSZh4UOnzHmpzTPrkO3J8VJN
         DdAyNFnsGZ6WwMlKc2we2gtNQdkhp2fj4BraSY2xjqvg7W8sqZXOPAAIm0wNiIRrzS+M
         PKN9OZ87Wl8SJ9nvZ3zI1Ksl4tZjGkti6ObhdXVv3QkK06oXXcrzzmkD6s/xFnECJl6f
         mxn10PNOb5rHvHoREP5SBseDSeegDp58LCk+fEE7pvdyoeyjVImRWhY4/ObxpSbSX232
         UDwRd/vYxUe5V3BNuvx07oxZ1WDu5RMzQM0U+H+xs/wpYD8LAOka9woYtDqKsr9/9p5w
         2XRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBZGCZ1ZBD21PpBDQ3oItDkWcZgN/+XlTCNT19zbuNY=;
        b=yre3E2ppJxiA7CNdvT+kwFwOJ5ZykO7o2Qgr3Aixsg8WE7/l3FmIZJJmIJYHoKX1ag
         eXxN41+kDts/JswnQny/2GwZMpqwtpgUFgtFLdltI0AnAm42eOSHksJ3KfJydmj2RfU9
         2GrIG7wFxbYh7rwJIK1jGaDuS0LO9gAU8mXk/qHuqjmDFHWMaV06T4B8MQ9m7lPecDJF
         6xNAr3OrczUOV6LsNiLLC2E/kHjtiMAhKCaHz2sVx9Al9gZcaPufUbwfooQ1fQOTGSbS
         50AGynWIj0+vH5qVEaRHkfmUimV07XrBE9yczdOUDXySy1IRhF30i6Ouo9F1J4vcSHOm
         W6Jg==
X-Gm-Message-State: AOAM531wAGv8oK76phR3mSdIU05+DeOhb+Y68qW7syP1QOL1qIfOyADc
        BNUy1BJDpX9KFNex0ti+cvcKEQ==
X-Google-Smtp-Source: ABdhPJyQkbB2LQNHeu3UBJJJCpRcvXSS8IW5H88xJG+NEaavS1oX6TfXL8dR804vTQgNf9ND0U++Hw==
X-Received: by 2002:aa7:98cd:0:b0:520:5200:1c07 with SMTP id e13-20020aa798cd000000b0052052001c07mr10012950pfm.13.1655301333698;
        Wed, 15 Jun 2022 06:55:33 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090302c200b00168d9630b49sm7240585plk.307.2022.06.15.06.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 06:55:33 -0700 (PDT)
Date:   Wed, 15 Jun 2022 13:55:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] KVM: x86: Drop @vcpu parameter from
 kvm_x86_ops.hwapic_isr_update()
Message-ID: <Yqnk0dBO9ILywV3R@google.com>
References: <20220614230548.3852141-1-seanjc@google.com>
 <20220614230548.3852141-3-seanjc@google.com>
 <c7f07be6-3674-4553-0ae9-548886ba9b6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7f07be6-3674-4553-0ae9-548886ba9b6f@redhat.com>
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

On Wed, Jun 15, 2022, Paolo Bonzini wrote:
> On 6/15/22 01:05, Sean Christopherson wrote:
> > Drop the unused @vcpu parameter from hwapic_isr_update().  AMD/AVIC is
> > unlikely to implement the helper, and VMX/APICv doesn't need the vCPU as
> > it operates on the current VMCS.  The result is somewhat odd, but allows
> > for a decent amount of (future) cleanup in the APIC code.
> > 
> > No functional change intended.
> 
> Yeah, that's a bit odd; what it saves is essentially the apic->vcpu
> dereference.  I don't really like it, so if you want to have a v2 that
> passes the struct kvm_lapic* instead (which is free and keeps irr/isr
> functions consistent), I'll gladly switch.  But I _have_ queued the series
> in the meanwhile, so that's a good reason to ignore me.

I'll send a v2 and just drop the patch.  Looking at it again, it's still very odd
and I oversold the cleanup.   And the affected paths are either unlikely() or the
even slower RESET / SET_STATE flows.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08115B2284
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiIHPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbiIHPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:36:49 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282D6D275D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:36:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id bh13so17137565pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2K9yM4gO41snBVkzSq5EbskGviVZmCwT6wLF/ufhIYw=;
        b=eOY85B940AXHYy+oPrDkHL0fYBRXMXzR15PBj3Yo+s1i8shl+Ap7Yx1fbAQY55wWCK
         xt6521ImSs8s5Whia4oKKRh2eZhW4fbH7uIAMpisA0QvAajdsBvfufs5fxhwkoQnuJEz
         SZm6vxWvXuIGr8b7rQjuqeIM6lAE9qd9GUYK1CRgEhlHhD9mQx+eKmmgm3iqWS11WJ7f
         6qOza+GGGYuo1OaBMEH+liqrLBEDlGZ+cVTwv8VORq2Ju/rPzj5qukNtVzolQForclVx
         NIt+vIQ+wwVUUWFifY1yUmEKL4OTC5YJuwpu7058wqN0ZXzLJOosRprkeyHjdqZ+BN4y
         KKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2K9yM4gO41snBVkzSq5EbskGviVZmCwT6wLF/ufhIYw=;
        b=t/dj0llIHBbARrYZjWCz6tq8qiu45Wb5srH/XnFx+fp3XtgIPeg/9BAc+cP52C+xY7
         AlEL2TOpu3iTrkeikKHqjRMwkQWc1RKdeTpl4u9nEHxpMG0aVyIVMOt2HRIyhxiYjU2I
         O8xHN1KmpsZYHSlRdYA8tY8vPns/DSMdvt1l83XK9MfP0LftLxigVpFAPDcpQ0BiZcw9
         CDjijd4gAcG0rwr15X0AOZqnATlPV/e3yj41TffL3k+AEc6bRxgNiQaRFwIXhVwRuvl2
         ZF6q0kFOfCyEW8zgRItcBvJC6O2n8AoO3FzvSjyg2dwJ3nkyFGTed8UAYq2EDabGBGSx
         /GNw==
X-Gm-Message-State: ACgBeo23GM9WVQjZUW48wyp2puehbrZroP2D2v/FIysuh9TuAWaTVOIR
        nAnRCR3Cc3gzhaIK1o0DjrYhhg==
X-Google-Smtp-Source: AA6agR45NKB24H1MECWu4RCNOiCuz2m4d7TqOiG98PFWhMBlSe3Zk3mpex9v2oADnT8mPlJXDGuskA==
X-Received: by 2002:a63:4719:0:b0:42c:5586:de2 with SMTP id u25-20020a634719000000b0042c55860de2mr8612184pga.158.1662651406849;
        Thu, 08 Sep 2022 08:36:46 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ms9-20020a17090b234900b002006428f01esm1914152pjb.55.2022.09.08.08.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:36:46 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:36:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        mlevitsk@redhat.com
Subject: Re: [PATCH v3 0/7] KVM: x86: never write to memory from
 kvm_vcpu_check_block
Message-ID: <YxoMCp+rMV1ZmRlU@google.com>
References: <20220822170659.2527086-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822170659.2527086-1-pbonzini@redhat.com>
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

On Mon, Aug 22, 2022, Paolo Bonzini wrote:
> The following backtrace:
> Paolo Bonzini (6):
>   KVM: x86: check validity of argument to KVM_SET_MP_STATE

Skipping this one since it's already in 6.0 and AFAICT isn't strictly necessary
for the rest of the series (shouldn't matter anyways?).

>   KVM: x86: make vendor code check for all nested events
>   KVM: x86: lapic does not have to process INIT if it is blocked
>   KVM: x86: never write to memory from kvm_vcpu_check_block
>   KVM: mips, x86: do not rely on KVM_REQ_UNHALT
>   KVM: remove KVM_REQ_UNHALT
> 
> Sean Christopherson (1):
>   KVM: nVMX: Make an event request when pending an MTF nested VM-Exit

Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

with a cosmetic cleanup to kvm_apic_has_events() and the MTF migration fix squashed
in.

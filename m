Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE8E4BBC7D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237231AbiBRPw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiBRPwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:52:25 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF736330
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:52:09 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id d16so8217398pgd.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TSRYisI11TAgCQBrFqDAThitIb+GPMmpzMU4WS3apc=;
        b=NdyomdpsrJELKx7oL9mgw4SmSILqmSgqrkTyigEVnxocv/MaFbeTc02oW/6+Sy7XO1
         RLmhvlmBewehRotjQLwpLRiDeeV7xp/vtOQGLZj3S+/ngCoIQS3Wvoor+75nZ6t0hjH/
         4WY6yxQ6aTjR0shAZ1py6WqiIQEpxLEtl6y2DDXR1etz+Z30Ur5ZlVaXBqINnl7dWXUZ
         Fbcuk9sBSMANatmLJfkImQ1SCrQUXedbF4+mpWo9VeS4ah+Yhmh0BAvs5WwvDm3n8rus
         AmF9a1C70u26CKXoaOm53+u+ndiFTF49myq7rhT97pPrjHeYDE95S5o/tvfFCcMNwMd5
         GqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TSRYisI11TAgCQBrFqDAThitIb+GPMmpzMU4WS3apc=;
        b=1m2HS8adQSzJAsmqcXgwfmUrQN0/bEBhY/AlkQfPaupYEUKlrwYiTVAK/ShRjIRKmt
         lIFImWaFTIAu7MYQlI9SistPxD5kIa4RqBMDvR5puEluoGtl3uNkYrPq5S037CYXyNLS
         UA/V/SYKUVJIalEdcqYN/sAsJbMEP6rO7apf+vfqguziKfs/YUl97PowQsyy55SS4C3A
         sKmEJ+97ZQHyGXTbWKuwpD65o2SwaaSg//DPZ8DLJjo71dYXjxSbxpnmsH3lfoCxi8mJ
         KbVj32tShbSNsDi9qyvMly/A/gb21mizk5uKJAaJ2e/Up3KWRV0Czyeeip5vKMRKl90e
         4JTg==
X-Gm-Message-State: AOAM533Vv92h63X3REczlG6QBuKxr2Au9aDIofo02GIXhLhJoOE9+r5z
        Eei6wR3sVgpcaYkiZPDJKaIqJg==
X-Google-Smtp-Source: ABdhPJzQvFTK1YdORlSGsV0PeaQIkdrquMN8iJ7oendQPTrI9bCRs0tpiXuV/2zxQMCbsmNcaenNBA==
X-Received: by 2002:a63:6a85:0:b0:35d:8508:9208 with SMTP id f127-20020a636a85000000b0035d85089208mr6817828pgc.17.1645199528759;
        Fri, 18 Feb 2022 07:52:08 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h20sm3321728pfq.162.2022.02.18.07.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:52:08 -0800 (PST)
Date:   Fri, 18 Feb 2022 15:52:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] KVM: x86: remove KVM_X86_OP_NULL and mark
 optional kvm_x86_ops
Message-ID: <Yg/ApEKNxiGSUF0K@google.com>
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217180831.288210-4-pbonzini@redhat.com>
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

On Thu, Feb 17, 2022, Paolo Bonzini wrote:
> The original use of KVM_X86_OP_NULL, which was to mark calls
> that do not follow a specific naming convention, is not in use
> anymore.  Instead, let's mark calls that are optional because
> they are always invoked within conditionals or with static_call_cond.
> Those that are _not_, i.e. those that are defined with KVM_X86_OP,
> must be defined by both vendor modules or some kind of NULL pointer
> dereference is bound to happen at runtime.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>

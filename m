Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308AC4BBE86
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiBRRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:38:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiBRRiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:38:04 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D5275FF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:37:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id z4so8443917pgh.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0PWeW9TOznAf0ie4DW4wq8JQF3QFYCHLxww3wrnBvIU=;
        b=EbN3I3lYaAI7NQqvx2UJS389LeGKPjaMtDfqoQzJTN0G61W24z//yc8dPA2PC1Jwcj
         CxxC8sGYs92+Cw1MCQMex93ncWLm+H8G5pdH3Ry6QuT9jFVs3GGhlYg6QF5O0fI1DvBz
         3id1Oq3H7wJh/dM/4SwVGarwAIHBWsQCypbX/vWMEAJY+M6f7VmZdRzMmWqhAoE0G6Y4
         YBHGvmACdfu3onCnIsztcLT4AG1BwCAXWFDkKX7iPMJLf/V86WyqVBGa+Rr4vBSLJ+yP
         bY6OmucqxeVD+gad8EPQKp68GfsvXUEUsytdnoBtGpTbDmm+8fR6ISafdWhx/CmbD1pu
         +bgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0PWeW9TOznAf0ie4DW4wq8JQF3QFYCHLxww3wrnBvIU=;
        b=4gbSRQ4kIE3lAWpuz0jKeMAXtT2xLGIg7n7I+cdPyMEkBQcad/LswVA7isgYC91mv8
         zJGJWvR7Ib6EiiGXWa3Oapop16ZExQ9MUVk7WogYPY75suU/vqRrIy45k5B4X8jMWvlE
         r34D3diZnHwstIhA02wDHrWqOgicU488yBKDPIMbGcbPgcxt4wJ05IFiPkczR4rwHSvW
         6evpCQJdfa4+H9/huMjmBdEpKsxx3ysKitv7S98swhoIZC5tJM8ym5kKU9i7knAacdIk
         FIw/YYoBQ4tQJF4eUvZaIPHxZ+a/84uFScsAhRrq4zO+nri2udeaW14Zu+ebl3cxkCQz
         voOA==
X-Gm-Message-State: AOAM530yBTO5q67qShPisMPnrKo7hBF5gJTm6/sjtDRPXU3XvOOrDmKm
        Z1Z5WPNA3FRb6K/mnwcIN3YMxA==
X-Google-Smtp-Source: ABdhPJxPjF9hfb1SnD6YEsWPIM6IK1NZPPVDWfLQopr0tBJG+dQxi8BDWwjveHiXvj2DocWKtP9RmQ==
X-Received: by 2002:a63:d4e:0:b0:34d:fedc:46e1 with SMTP id 14-20020a630d4e000000b0034dfedc46e1mr7160586pgn.407.1645205863942;
        Fri, 18 Feb 2022 09:37:43 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id c23sm3527710pfi.136.2022.02.18.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:37:43 -0800 (PST)
Date:   Fri, 18 Feb 2022 17:37:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 5/6] KVM: x86: make several AVIC callbacks optional
Message-ID: <Yg/ZZMAz7XZ6wn/u@google.com>
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-6-pbonzini@redhat.com>
 <Yg/IGUFqqS2r98II@google.com>
 <eff2543a-10ab-611a-28e2-18999d21ddd8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eff2543a-10ab-611a-28e2-18999d21ddd8@redhat.com>
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

On Fri, Feb 18, 2022, Paolo Bonzini wrote:
> On 2/18/22 17:23, Sean Christopherson wrote:
> > The "AVIC" callbacks are being deleted, not
> > made optional, it's kvm_x86_ops' APICv hooks that are becoming optional.
> 
> Maybe "make several APIC virtualization callbacks optional".

Works for me.

> > > +KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
> > 
> > apicv_post_state_restore() isn't conditional, it's implemented and wired up
> > unconditionally by both VMX and SVM.
> 
> True, on the other hand there's no reason why a hypothetical third vendor
> would have to support it.  The call is conditional to apicv_active being
> true.

Ah, right, even if the the static_call_cond() is unnecessary because we want to
make the hook mandatory if APICv is supported, APICv itself may not be supported.

With the new shortlog,

Reviewed-by: Sean Christopherson <seanjc@google.com>

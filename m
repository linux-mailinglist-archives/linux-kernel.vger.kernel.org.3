Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBB9514D55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356703AbiD2Ojo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377580AbiD2OjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:39:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D320196
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:35:48 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so10670920pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xzOPqzABS1nn10SFsKraP30CXjOcxe5i5LRmTq00vq4=;
        b=OtLJiInqAuYIoacxZCT7Y5xsyPousHs93Nc1Z7C6HsmDByhW/K3+9dUg8/gLZJXNuu
         +E5ZzsFQQZMB+Tf56QgXPtrLXgWond+HOSkCR7nbqFR+R5cklAFPvf6DEPeWD9T3H4j4
         RIe8LWLwMe1OU17fuaC0BIxmSZGFLN8jAdu1FzEQlf2sTALrR/hOGwipxepdmFcksrgp
         GKWID9t175PZC5jATnvrw39hvKLSjG9oHlt73ELdOSFeo8LHTuh6NXZnjJrhAGR8eGsr
         YtgXQVhY0eb3Jg2dEkW6LhWJAqpsL58HmO3bDkAhiI1JWewIElvEdq49egmGlbZoe5ny
         iyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xzOPqzABS1nn10SFsKraP30CXjOcxe5i5LRmTq00vq4=;
        b=nGxGpMaeX7fnCzmp4k3uUH5tK9F6hSOl26uzWBOfpsefleuV4B+ceTXOMPgqAwqcOp
         /6ZNJv49ZbWpJOsSxF2Uc/dVsI757nlPW32F0kQ6kKzBsHwMs04x43uZ4C6JouI66jMN
         vIBnDbnbwzOaJsa5CdNBW4GKqXO9Df54FQ9HVWxpxLtIpTGffxBV23tShs6D/EEAPk4l
         Y715nSfKfnQhlFfQDHHebiqhhNFgYG1LzVhUF67lhoK1qQU6OG/TtSZdkfQdU+iE2B67
         Z/fN1gT4Z3G5XybK0h1/I5TSo7WRHaukP9JD9o/cYM78oyDY7EVKiXGoxCsVNtngaxZr
         jJgg==
X-Gm-Message-State: AOAM5303zdRTJchOSPDa2GLrPPbfln5lOJPglkS+RD2+REn0X9mpvIaQ
        pOzPIoFiwpX9X/qTPYs8H2GmuA==
X-Google-Smtp-Source: ABdhPJzPPvpjjUg7d3EJhwF0w6+Bk6GIAwzBw2RDYI/6H6CGZOIBYXHvNvxD8Uu1fFNy6Lpeg2pbvA==
X-Received: by 2002:a17:902:ef45:b0:156:1858:71fc with SMTP id e5-20020a170902ef4500b00156185871fcmr38772270plx.23.1651242947441;
        Fri, 29 Apr 2022 07:35:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g17-20020a625211000000b005056a6313a7sm3191028pfb.87.2022.04.29.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:35:46 -0700 (PDT)
Date:   Fri, 29 Apr 2022 14:35:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mingwei Zhang <mizhang@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86/mmu: fix potential races when walking host page
 table
Message-ID: <Ymv3vwBEgCH0CMPH@google.com>
References: <20220429031757.2042406-1-mizhang@google.com>
 <4b0936bf-fd3e-950a-81af-fd393475553f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0936bf-fd3e-950a-81af-fd393475553f@redhat.com>
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

On Fri, Apr 29, 2022, Paolo Bonzini wrote:
> > +out:
> > +	local_irq_restore(flags);
> > +	return level;
> > +}
> > +EXPORT_SYMBOL_GPL(kvm_lookup_address_level_in_mm);
> 
> Exporting is not needed.
> 
> Thanks for writing the walk code though.  I'll adapt it and integrate the
> patch.

But why are we fixing this only in KVM?  I liked the idea of stealing perf's
implementation because it was a seemlingly perfect fit and wouldn't introduce
new code (ignoring wrappers, etc...).

We _know_ that at least one subsystem is misusing lookup_address_in_pgd() and
given that its wrappers are exported, I highly doubt KVM is the only offender.
It really feels like we're passing the buck here by burying the fix in KVM.

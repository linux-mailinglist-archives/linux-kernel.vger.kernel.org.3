Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BE1515025
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378736AbiD2QFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378726AbiD2QFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:05:18 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135625EDFC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:02:00 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id s137so6850848pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wxlbr9fWxkJ/PvUYSQaUCDuvsAWuZ1gUZ7NZOyO7NWI=;
        b=ig/N09Lqy0/iC+IgF7BMHpLu6LgwF1YAzHzJnJnnp5iDh5f8/+v4Fu2cFHjnJPGRlQ
         60kkoeOCzSEwVBbcK5+zQAzJkFQjM76r9d4r1uWBwF9SzmXOrBr6UKzBUxh7l3lSofml
         gqDzahsTyp+h1fF3eKQrQoenH69ir3LQx06+vla+1ZQpfEjFRzSL9Pa1vxwsnsRwJ+Op
         +wEFqWixsr4T2aGJRSKxP4w2xMDY/KOhs8j8UJNb+yywxsNhmU7oBn0NOxK3bsQSlNq8
         IQfOf/QJZtlScjxI45WpOoOtTRAvU4qELVv6bkuO3JkkTW2Gzn7g6Po0nqxkXIstQ73Z
         z5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wxlbr9fWxkJ/PvUYSQaUCDuvsAWuZ1gUZ7NZOyO7NWI=;
        b=fI1VWykf6lfpq/LT5TuCyIwJXQjrD2KGEmqoEtxDVMsuHSzJVchH9aga9B3zKmpiiL
         jTxlHdiRtU92mPJ/coPgSnfuawEHLvEQylv2VzlorooFS5qDU4yVWzLno1jO2VnAnCDo
         gtrajl4uN5rt5CsA3+1eUzaoUFAqhLw5i/aFWmSXSu0yK4EJnGLG1jqVeYE0Ozw5yype
         RChw9aJxPrIZoCo1DLB0GzUluHyrpvxH1pJUYK2riWAM7UNURYnJ3fNurZaMfspmRrhh
         9LFewsXXL/RSLWNour/fEudSDmTLxe6rIwuZekWteMtC/OLcRGBEZx3sKzix4VF6tshV
         n+RQ==
X-Gm-Message-State: AOAM5311ViX2+6FHbc0AWUPQRM2B1UGzBRKQvhu+yLquYCM3ROznQfNe
        wCKONGxgXvyWrSHEiU5xfZJ1Fg==
X-Google-Smtp-Source: ABdhPJzgHIWIsLan2gxS4+e/SQEWi1cv4Ux9jTPqhzYQRjA03S3dOckbBSzhJExUWR+LLl8+nbMpJg==
X-Received: by 2002:a63:4862:0:b0:385:fb1d:fc54 with SMTP id x34-20020a634862000000b00385fb1dfc54mr65383pgk.57.1651248119289;
        Fri, 29 Apr 2022 09:01:59 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z15-20020a056a001d8f00b004fda37855ddsm3193393pfw.168.2022.04.29.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 09:01:58 -0700 (PDT)
Date:   Fri, 29 Apr 2022 16:01:55 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Do not create SPTEs for GFNs that exceed
 host.MAXPHYADDR
Message-ID: <YmwL87h6klEC4UKV@google.com>
References: <20220428233416.2446833-1-seanjc@google.com>
 <337332ca-835c-087c-c99b-92c35ea8dcd3@redhat.com>
 <Ymv1I5ixX1+k8Nst@google.com>
 <20e1e7b1-ece7-e9e7-9085-999f7a916ac2@redhat.com>
 <Ymv5TR76RNvFBQhz@google.com>
 <e5864cb4-cce8-bd32-04b0-ecb60c058d0b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5864cb4-cce8-bd32-04b0-ecb60c058d0b@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022, Paolo Bonzini wrote:
> On 4/29/22 16:42, Sean Christopherson wrote:
> > On Fri, Apr 29, 2022, Paolo Bonzini wrote:
> > > On 4/29/22 16:24, Sean Christopherson wrote:
> > > > I don't love the divergent memslot behavior, but it's technically correct, so I
> > > > can't really argue.  Do we want to "officially" document the memslot behavior?
> > > > 
> > > 
> > > I don't know what you mean by officially document,
> > 
> > Something in kvm/api.rst under KVM_SET_USER_MEMORY_REGION.
> 
> Not sure if the API documentation is the best place because userspace does
> not know whether shadow paging is on (except indirectly through other
> capabilities, perhaps)?

Hrm, true, it's not like the userspace VMM can rewrite itself at runtime.

> It could even be programmatic, such as returning 52 for CPUID[0x80000008].
> A nested KVM on L1 would not be able to use the #PF(RSVD) trick to detect
> MMIO faults.  That's not a big price to pay, however I'm not sure it's a
> good idea in general...

Agreed, messing with CPUID is likely to end in tears.

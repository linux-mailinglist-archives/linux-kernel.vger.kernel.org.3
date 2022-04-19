Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF352507262
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354138AbiDSP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354128AbiDSP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:59:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6096237E9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:57:05 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bg9so24462688pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2IVJA9h4AsV7fdP5RR4o8gCQ+ZpBOfmpsTUUjgtfTgk=;
        b=X9M83V5D8lhzOXWTQBMWIi+QSOTYARshN+qmDjkRjIDjplwOZAVSl9n4QYiwBU6kkT
         uAajHveSR72AVT03JMZU+boOtanRqh6VxmcneLJpDY/mREC5tXkm31+8JzdYCF2VXPRh
         LHR+bYDlO/6FURSkM09GIT6h7V91j6RpsjR7vXqh6bIv/xOFNTrkxE8rXLcWCm/nwUhh
         OXHuWgdziSX/MmCcAN+GHYLn0CW0tvOY9KpbF1/CXeg15SpIxy//maouD8nXopFFyQuH
         9nodT9suzU9URBViF4DGa0AC/hG/GwUIYv7v/AJM/Z7+UhzvtCfJ0A8hxwHdH/a5/d7g
         trog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2IVJA9h4AsV7fdP5RR4o8gCQ+ZpBOfmpsTUUjgtfTgk=;
        b=ARDwLyuQZtzfmarH/b4HwbGnT0L6W7R2YTc5gAoPAwOShcorEKAJwoP9UtXUrJEzjT
         r9jk0xs25E/MKTs9RyhswcHykYVJB2/UPDehUTPVcJpBVJtqaUruRuye88WV8q6gyG6x
         9f819s3czPq3th6lfzlgoXtwXKqaOoawcjkx5n3wZ3GYS1Lqrzju5glHNh0tkyzThXO5
         Vu1xmQmolffd+jOBb8tcNW3gr0LyyNUcssitUONnMiDIDutVl+72+EdEPEs6ZznlwcYY
         QmSSJ3wBKN5Ilch/A6JXft4zggUcsyS7oikjGM2opZ+k8ifI3cNs+fLNFhukVm6o+NJg
         tGNg==
X-Gm-Message-State: AOAM5316Sky+MmpZ2EyqibcF640J59/anxFiD9ZE2fNjpMJGuelG7/ju
        AcCwnPEbs7RxsgQO8/JPrulKZg==
X-Google-Smtp-Source: ABdhPJzWe4VX/mMeEzkWHWvRah65F9AEwBCNvqZ54IZOLOY6jsc/BWNoLgMC+MBr8DiCYP0HKu9ctQ==
X-Received: by 2002:a62:1b91:0:b0:50a:64d0:58a2 with SMTP id b139-20020a621b91000000b0050a64d058a2mr14100337pfb.38.1650383824998;
        Tue, 19 Apr 2022 08:57:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090a859100b001bc20ddcc67sm19986662pjn.34.2022.04.19.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:57:04 -0700 (PDT)
Date:   Tue, 19 Apr 2022 15:57:00 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gaoning Pan <pgn@zju.edu.cn>,
        Yongkang Jia <kangel@zju.edu.cn>
Subject: Re: [PATCH 2/4] KVM: nVMX: Defer APICv updates while L2 is active
 until L1 is active
Message-ID: <Yl7bzNi9HjbgIAQ5@google.com>
References: <20220416034249.2609491-1-seanjc@google.com>
 <20220416034249.2609491-3-seanjc@google.com>
 <227adbe6e8d82ad4c5a803c117d4231808a0e451.camel@redhat.com>
 <Yl2FXfCjvkNgM4w3@google.com>
 <8b2ff3dc317db18c8128381d5d62057a90f68265.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2ff3dc317db18c8128381d5d62057a90f68265.camel@redhat.com>
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

On Tue, Apr 19, 2022, Maxim Levitsky wrote:
> On Mon, 2022-04-18 at 15:35 +0000, Sean Christopherson wrote:
> > On Mon, Apr 18, 2022, Maxim Levitsky wrote:
> > > On Sat, 2022-04-16 at 03:42 +0000, Sean Christopherson wrote:
> > > When L2 uses APICv/AVIC, we just safely passthrough its usage to the real hardware.
> > > 
> > > If we were to to need to inhibit it, we would have to emulate APICv/AVIC so that L1 would
> > > still think that it can use it - thankfully there is no need for that.
> > 
> > What if L1 passes through IRQs and all MSRs to L2? 

...

> - vmcs02 can't have APICv enabled, because passthrough of interrupts thankfully
>   conflicts with APICv (virtual interrupt delivery depends on intercepting interrupts)
>   and even if that was false, it would have contained L2's APICv settings which should
>   continue to work as usual.

Ah, this was the critical piece I was forgetting.  I'll tweak the changelog and
post a new version.

Thanks!

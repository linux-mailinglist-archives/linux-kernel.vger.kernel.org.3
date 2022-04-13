Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F604FF932
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiDMOpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbiDMOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:45:00 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2561A62BEE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:42:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bd13so1499657pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/JYEDIWYyCmXfCvpDqWCkJLdtO8UQhf0VFm9gLSvtws=;
        b=pceu2zUDQVxybZHIpx8ZRmoZzDQIwrGKZgmWOMMzB7VAntXi50Pl0f8pqyxIEWPI+5
         pL8meqwPaGS963019NumUkybXx5CAsYMfc9veKm5KQ+oJV7CHLpP0E2YE2ceNlg24Awv
         Xiemy6d/d+QzFJP4AyTUBvn9E10N6yw7xHZAlMF5b+RdO7301qDFVWFwUPYHcOEZEQst
         hdyDSfjQBEYHj3aM7s6VfQjTsXUs7pBHuWqIWAdpu45F1CvjpGaMW4cUXBfpwME0fQNW
         ATa+Av8J7FZi20cBDzMQDd2QAB2m/kLbg2cdN+dvirzLbuU7eYsx1Ld8zBtlLaLNLR02
         zZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/JYEDIWYyCmXfCvpDqWCkJLdtO8UQhf0VFm9gLSvtws=;
        b=yUw1bEESkJdEK+SxP+cNkmPjEdE0Kbnt5TY/pkJIsEZbR/HK3UKEXcBinf80zmoHIl
         fURJIy+54GMpWIrmtgS4dHmRljcPFkICz0vQc3rpbA0p8MDah9V9eHbOvHUITC4RimuN
         15j/Ey/P1WjicOxNAm9J6g2X3ChlMnHtU1/LmVX4YB1n2gYGmBh3sEsCBnJenirTp5Jy
         G7OXWZARSAPP8ol9owxlkKUCBLDByrLApK5G7NL3PZiNfVUb84lpjv8sFOQrA5KFZZMa
         DCR6fsTkVNFh8Pwln63PzniHpGOMUOiBfVDuU5V9ppcwSiQAbimchnwgLjYmpzAPf0yT
         TOpQ==
X-Gm-Message-State: AOAM5326IvNZYvYv2SqH2Gc1j/4ohaOCrLJffU/y0zoXW926CtLNNpmo
        Kgz5lyYI6T1HWO7r7f9/WzsJ8w==
X-Google-Smtp-Source: ABdhPJyND0vLloxs8A3tKDdJhHhujGT9+mvw3w0rxORb0WCXA5Nj8ZZclC8so/j+m0ds/Ow5E6mDWg==
X-Received: by 2002:a63:1024:0:b0:39d:1172:b8e0 with SMTP id f36-20020a631024000000b0039d1172b8e0mr20123646pgl.423.1649860954468;
        Wed, 13 Apr 2022 07:42:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090a058f00b001cd50a6ec5csm2934080pji.16.2022.04.13.07.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 07:42:33 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:42:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH V3 2/4] KVM: X86: Introduce role.glevel for level
 expanded pagetable
Message-ID: <YlbhVov4cvM26FnC@google.com>
References: <20220330132152.4568-1-jiangshanlai@gmail.com>
 <20220330132152.4568-3-jiangshanlai@gmail.com>
 <YlXvtMqWpyM9Bjox@google.com>
 <caffa434-5644-ee73-1636-45a87517bae2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caffa434-5644-ee73-1636-45a87517bae2@redhat.com>
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

On Wed, Apr 13, 2022, Paolo Bonzini wrote:
> On 4/12/22 23:31, Sean Christopherson wrote:
> > > +		unsigned glevel:4;
> > We don't need 4 bits for this.  Crossing our fingers that we never had to shadow
> > a 2-level guest with a 6-level host, we can do:
> > 
> > 		unsigned passthrough_delta:2;
> > 
> > Where the field is ignored if direct=1, '0' for non-passthrough, and 1-3 to handle
> > shadow_root_level - guest_root_level.  Basically the same idea as Paolo's smushing
> > of direct+passthrough into mapping_level, just dressed up differently.
> 
> Basically, your passthrough_delta is level - glevel in Jiangshan's patches.
> You'll need 3 bits anyway when we remove direct later (that would be
> passthrough_delta == level).

Are we planning on removing direct?

> Regarding the naming:
> 
> * If we keep Jiangshan's logic, I don't like the glevel name very much, any
> of mapping_level, target_level or direct_level would be clearer?

I don't love any of these names, especially glevel, because the field doesn't
strictly track the guest/mapping/target/direct level.  That could obviously be
remedied by making it valid at all times, but then the role would truly need 3
bits (on top of direct) to track 5-level guest paging.

> * If we go with yours, I would call the field "passthrough_levels".

Hmm, it's not a raw level though.

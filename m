Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F50D56A946
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbiGGRUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGGRUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:20:02 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6148D140ED
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:20:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j3so8063670pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wHDkdTAfWsoyslrvAYsfjRDZIjkF9cFNI1XJMwcL7ik=;
        b=N/22i/c+x0sT6c/G5v+eK+P3M95kFG2bYI613m+5/VgRJn53KVP5angDyfnc+P+xIu
         6qa4TQf0TBpr7qRgXqnFdmboeahHnnfvhQ5FhKcbd7ovQ/y7waxFzejBsWnkoyvjyV7z
         9PNRiNLLuhbuMt4EzpiVv9ktacEvhCpm3uv2hXeAk72+NFooipgrlG6qQ0arAOP9ENmv
         nGCipLBMyBZQL8/letrIRr4U+U7u3roGM2GbUri+EyUqgP1QgfTFCmza59jU2WVfypjC
         mtMnFoT1Y3ruPypNvfjflegcEqfWu+N18rEtXXuRoA1qTDrJ67Hy/BjHdU9yShcywh7u
         +/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHDkdTAfWsoyslrvAYsfjRDZIjkF9cFNI1XJMwcL7ik=;
        b=MtEoe68grV2YBv81rvDnTxH4tcEEFh5T+PQKn7XnqrrBsap/AkBwwJGovtzqAhPyF4
         xpJQnLz58uzX0e+mC2Ge+q8AuD34cvPiNJKnZbWFQe7DGktNfMShncffZ5xId/WYhoTI
         df1Kc6BH3+2GEQ+rVy3o+JBqh/zuxELWci2KM576KpAIwHNQm1jB5tIZrLXgmpnARQx/
         FRDXvBMka6bDdCYUBsi9V5RD9hPO861Z2zbbKU37ykDwEToKHnAQR2xtfnfa8Z/W6HBB
         UzDNk6zWUyr/cBlO4un7/RIGBGYRyXVmAxH3G2Ajq80NuTvWWT+JXM9ME3vb9h2sKX8A
         ly8Q==
X-Gm-Message-State: AJIora8htM4wy14H5ZfUvmRzCPP5wGOwWxQpnCYG2FAi1PjX5qLc+Kro
        weSMscxkPNpXN36Cfry3fFudYg==
X-Google-Smtp-Source: AGRyM1s8F4+upWWb3wse7GLP7QT3oixsb5B56+9euHVQUuWnG78Hv8TcKOHKdaiNXYJMYl4zGz177w==
X-Received: by 2002:a17:90b:38ce:b0:1ef:c5bd:e2bd with SMTP id nn14-20020a17090b38ce00b001efc5bde2bdmr6602223pjb.149.1657214400825;
        Thu, 07 Jul 2022 10:20:00 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id w63-20020a623042000000b005252ab25363sm1419412pfw.206.2022.07.07.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:20:00 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:19:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Subject: Re: [PATCH v2 06/21] KVM: x86: Treat #DBs from the emulator as
 fault-like (code and DR7.GD=1)
Message-ID: <YscVvFgC/CWU0bbN@google.com>
References: <20220614204730.3359543-1-seanjc@google.com>
 <20220614204730.3359543-7-seanjc@google.com>
 <CALMp9eS+54W=w=0UXRvB95OprNbpte=_TDu=c9qzcY0kyRqbuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eS+54W=w=0UXRvB95OprNbpte=_TDu=c9qzcY0kyRqbuQ@mail.gmail.com>
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

On Wed, Jul 06, 2022, Jim Mattson wrote:
> On Tue, Jun 14, 2022 at 1:47 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > Add a dedicated "exception type" for #DBs, as #DBs can be fault-like or
> > trap-like depending the sub-type of #DB, and effectively defer the
> > decision of what to do with the #DB to the caller.
> >
> > For the emulator's two calls to exception_type(), treat the #DB as
> > fault-like, as the emulator handles only code breakpoint and general
> > detect #DBs, both of which are fault-like.
> 
> Does this mean that data and I/O breakpoint traps are just dropped?

Yep.

> Are there KVM errata for those misbehaviors?

Nope.

> What about single-stepping? Is that handled outwith the emulator?

Single-step is emulated, and AFAIK there are no _known_ bugs.

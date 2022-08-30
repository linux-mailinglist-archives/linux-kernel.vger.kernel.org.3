Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590615A6E72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 22:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiH3U3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiH3U3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 16:29:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAC80539
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:29:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 73so3316057pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=LsTZEdyrEUnLjdIJUCRd1V1OnFwME0N4kHKfYMrxspg=;
        b=mppiX4I8oYXWSNfxGk9DQ5u317uUZrkn/IxNV6oDmJ77Zakh83Nf57aSo/dktwwqy2
         k3/9Nl9f4+SwronDEFTr5Yhnfm9BhTO2LG+R1r7kFb+5BAH3F/iuMQrwZy1dPmyyZ3+8
         Nn53tQ9osgBp8HQMxIIc+OZ1t8Ovv9i0KdAQ1rHIumk6eqaoJSThmuJ7zVPRfOZhvjfW
         MTkDibT2H0eYJM/A3pdLxfjLRjEudmMnnwLLuy780RAsuBtSogtahteXaqrQ5RRoKXpq
         +guAhA5II9z9GZx3F1hrx+GKf8ym7OqUOP7rIDkrMtYfOgwn3/+Yycm7rwZgQI/+yjR4
         UbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=LsTZEdyrEUnLjdIJUCRd1V1OnFwME0N4kHKfYMrxspg=;
        b=W12oYaLUotOHKI+OqBbTDjRY5ZPSOYy/xrzuOqNOp7s/VeTc5Gj13D9T5L2W93zREj
         ikrKM3zMyyLS0JXMXN5vhSVUd8PNsBY/AI8Ab0CjSBXoaOBAlfcDq8GEmrdsZUB5Tx2h
         tg4hp63TBjDOdeS0Jcbo05LH3ocDCI1rCAft5DEzDj8o7kvnz/9Ldb7mmFy6Wp3lqIAb
         GbUiq3hxjGpXyWTY92wCUu5klr83OnzYPkLIF9y3wI7MJ5Xo36M3EpRAa+q/xjQBMvyr
         OegIeIN+NqbqSVst8e0PR4JVAIK192kvJaaVLhclCsdrOmNdffddtUUR7EYKwqrPKQgS
         87tw==
X-Gm-Message-State: ACgBeo0stXwV0KhihHthGK7K0pyIXzpeVOlXYC7vfW4lz/d/j3J/Jvbw
        3Y6uDNzugrVSF7BPmedAvMWO7N+4carqUQ==
X-Google-Smtp-Source: AA6agR7F7t9q4et9d50QEwfO7t6Q0oDs2UPJeBF4ULYRWTY+Clxnc5a7fooA3FK5+5z/IYMlL1NmtA==
X-Received: by 2002:a63:f44:0:b0:42c:5a16:dfa1 with SMTP id 4-20020a630f44000000b0042c5a16dfa1mr6752126pgp.305.1661891347446;
        Tue, 30 Aug 2022 13:29:07 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709026f0900b00172b616f375sm10031521plk.228.2022.08.30.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:29:07 -0700 (PDT)
Date:   Tue, 30 Aug 2022 20:29:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v4 0/3] Extend KVM trace_kvm_nested_vmrun() to support VMX
Message-ID: <Yw5zD50fDb54zruw@google.com>
References: <20220825225755.907001-1-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825225755.907001-1-mizhang@google.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022, Mingwei Zhang wrote:
> This patch set update trace_kvm_nested_vmrun() to support VMX. In
> addition, add the guest_pgd field to enrich the trace information.
 
...

> David Matlack (1):
>   KVM: nVMX: Add tracepoint for nested vmenter
> 
> Mingwei Zhang (2):
>   KVM: x86: Update trace function for nested VM entry to support VMX
>   KVM: x86: Print guest pgd in kvm_nested_vmenter()
> 
>  arch/x86/kvm/svm/nested.c |  8 ++++++--
>  arch/x86/kvm/trace.h      | 33 +++++++++++++++++++++++----------
>  arch/x86/kvm/vmx/nested.c | 10 ++++++++++
>  arch/x86/kvm/x86.c        |  2 +-
>  4 files changed, 40 insertions(+), 13 deletions(-)

Some nits that I fixed up when applying (will respond to individual patches).


Pushed to branch `for_paolo/6.1` at:

    https://github.com/sean-jc/linux.git

Unless you hear otherwise, it will make its way the official KVM tree "soon".

Note, the commit IDs are not guaranteed to be stable.

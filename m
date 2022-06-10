Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B4D545934
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbiFJAfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbiFJAfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:35:01 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFE415AB1B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:34:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so2347768pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 17:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6aq2IG/dHm8lryaEF9k98rbozj/J94OCKVxcaPUmS2M=;
        b=atQEVgMVPycKO9nPmo7OzmQC1spbcVKip2A2aCNYD0inDH7W93ukHHOXHvdPjkV6NM
         6R4sj7EWjBwM/Keym49eIbj2Rulhk8YM5QrcS9RqEDHwHB9YfeJIssNSXDAF0P8IGolV
         7mLtZOt8DPtuwyVcAMIBqBX/Hoo9M7ln6NMM6A4ok6sCxmZx/HskthMFLt1jESI47LCu
         R6b862i9566AlvkY91K6sHAOKs6ocY5wcIdZkN740X3cHpbZCkporH/NnimSU40ACUxB
         QGDB/ioMRCZoDQ/v+Kq5b8DpUjvDe+RibKWCJPZkjv+ZLts7VEF26nIGj29K4oqQJntn
         WzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6aq2IG/dHm8lryaEF9k98rbozj/J94OCKVxcaPUmS2M=;
        b=sNQmRuTTTles9DEKrutzIu0f7gLXBoPXfi9AYnmooq2yP2iU0muvF+SPX4y97GR/uv
         2NYSp3MtEVcTkysC2mJjd+2JjsDMQzVqFVx8MBzkdW+YThSOJ5Jaig9+3IPyj38EyQId
         73nF5KCNpVYItuhzzK/mEwEnKz4Cd5+BwvsW0jIjNBExy7MVZm8fnU2luVJq7bka6/i+
         RLdu1fRD/lny2KqhpkZgGe4UP7qV7n2w1ClvMqfOv4+PfPmgaHKCeBZkNyemSOg8vOuD
         Mo+2zmlGyojHQ1cStBUV3HHl4qPIgOzrn2mC7rwOpuDXnaPibuoFsrqxh9URFSterNC+
         i6oQ==
X-Gm-Message-State: AOAM530KzY3v48JahgOW4WQ3fVQIfJiv5RkqJAaWWXocyqqPdrnTBT+s
        bKWIjt6USZbWUDHn0YtnXXsJQA==
X-Google-Smtp-Source: ABdhPJzSNFVk6lq6OH/RQy+VY4tKL4BeOGmjqJoy1Ob2zSOc/+4TL2/YkRqKl8Ak4CNnzNyFfKG34A==
X-Received: by 2002:a17:903:22ca:b0:163:e2b6:e10a with SMTP id y10-20020a17090322ca00b00163e2b6e10amr41964333plg.32.1654821297214;
        Thu, 09 Jun 2022 17:34:57 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm297249pjb.31.2022.06.09.17.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 17:34:56 -0700 (PDT)
Date:   Fri, 10 Jun 2022 00:34:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Anup Patel <anup@brainfault.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        KVM General <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <YqKRrK7SwO0lz/6e@google.com>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <CAAhSdy0_50KshS1rAcOjtFBUu=R7a0uXYa76vNibD_n7s=q6XA@mail.gmail.com>
 <CAAhSdy1N9vwX1aXkdVEvO=MLV7TEWKMB2jxpNNfzT2LUQ-Q01A@mail.gmail.com>
 <YqIKYOtQTvrGpmPV@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqIKYOtQTvrGpmPV@google.com>
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

On Thu, Jun 09, 2022, Sean Christopherson wrote:
> On Thu, Jun 09, 2022, Anup Patel wrote:
> > On Wed, Jun 8, 2022 at 9:26 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Tue, Jun 7, 2022 at 8:57 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > >
> > > > Marc, Christian, Anup, can you please give this a go?
> > >
> > > Sure, I will try this series.
> > 
> > I tried to apply this series on top of kvm/next and kvm/queue but
> > I always get conflicts. It seems this series is dependent on other
> > in-flight patches.
> 
> Hrm, that's odd, it's based directly on kvm/queue, commit 55371f1d0c01 ("KVM: ...).

Duh, Paolo updated kvm/queue.  Where's Captain Obvious when you need him...

> > Is there a branch somewhere in a public repo ?
> 
> https://github.com/sean-jc/linux/tree/x86/selftests_overhaul

I pushed a new version that's based on the current kvm/queue, commit 5e9402ac128b.
arm and x86 look good (though I've yet to test on AMD).

Thomas,
If you get a chance, could you rerun the s390 tests?  The recent refactorings to
use TAP generated some fun conflicts.

Speaking of TAP, I added a patch to convert __TEST_REQUIRE to use ksft_exit_skip()
instead of KVM's custom print_skip().  The s390 tests are being converted to use
TAP output, I couldn't see any advantage of KVM's arbitrary "skipping test" over
TAP-friendly output, and converting everything is far easier than special casing s390.

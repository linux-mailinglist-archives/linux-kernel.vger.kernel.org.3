Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863474D5198
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244420AbiCJTad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240436AbiCJTaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:30:30 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C213C3BD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:29:27 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e2ca8d7812so8540567b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCphOwvog5CR9xCI2b5FDRuXSQsxiJyxhbdn/smQ+b4=;
        b=XS4njOn68MemfU9zs/tszcIIbd6//uLsmy3S1DZEFiYtOKHRV2IYeJapWCCA7Pe1hk
         V4wuRcMQg5zOQH9mr3keyF7lOVNz2+b18MfH3UKyaK3UbujqhEft1q7jAKujJ/xCjyc7
         A9SQx155ypdnZM7LsJq6Q25ZAmZ9hqLB+rVFxzkLxTVA8P1r3FB2mIde/CcWmY6Qjgyr
         KXMK8jpJ4wkESb/Ee9kmquwK0qzNYJXOujYwiG9cQZUNfrdm82hEUiPQKM6FMtcc98cd
         tvWApc1rWf0PB4z/lG3mCFC0hVfbMaUXCIwCRkqOGQKNjnuio414n9kOswijILQMpldd
         e07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCphOwvog5CR9xCI2b5FDRuXSQsxiJyxhbdn/smQ+b4=;
        b=39Y1XPTHkj+tZ2+SwtD2meVqyBh2eVF6tB5sJAsSwS8Ar9IPiJbQovIEQfyZyyiAD3
         eEyaZHPWVowUdNq8TxiEWi1HpI6Qz6L3xALEQphEJcr0hH2bhJbqgzBhHgS1CC+GUT3b
         3/zue2s9W1GgRcdvBvAW/9DYOCYw00B/YAwU0Ru4b7dXUlLpZzOlbRRs3sFyetEzp/Up
         GocVZv5cTjD6J/0bmqMWEzy7JulmhUJIs9cmodaFPmo5jdJiVOepjZGFY6B5la+CB5C/
         hMqTr4IEu8n4sypOV8Ksq7AWi/IxzQnxYUpQNF2lunJbA1xUVt43h28y7QsQZsOKmYjU
         aSYw==
X-Gm-Message-State: AOAM532/sZocvLjo1BMAYWLeyGetwu01un2TFg26r00g+fIvkWeLw4dw
        mROT2aV1jNFvd8neBPNAgpLIhJoPCIqJ6jy/m4RflA==
X-Google-Smtp-Source: ABdhPJwzfDlXw81/eBIXOSlMhPCdutKwJXBijhpTgzHMP1CnJwbpPMTeI+5VMc38WWfyFmQP94nX3V9NcNDr0WM9olw=
X-Received: by 2002:a81:91cb:0:b0:2dc:bad:5873 with SMTP id
 i194-20020a8191cb000000b002dc0bad5873mr5335180ywg.156.1646940566374; Thu, 10
 Mar 2022 11:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20220310164532.1821490-1-bgardon@google.com> <Yio8QtuMd6COcnEw@google.com>
In-Reply-To: <Yio8QtuMd6COcnEw@google.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 10 Mar 2022 13:29:15 -0600
Message-ID: <CANgfPd9xr5ev7fEiwBVUi89iHkuywq-Ba9zOeCMSTFmLkO243w@mail.gmail.com>
Subject: Re: [PATCH 00/13] KVM: x86: Add a cap to disable NX hugepages on a VM
To:     Sean Christopherson <seanjc@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Mar 10, 2022 at 11:58 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Mar 10, 2022, Ben Gardon wrote:
> >   selftests: KVM: Wrap memslot IDs in a struct for readability
> >   selftests: KVM: Add memslot parameter to VM vaddr allocation
> >   selftests: KVM: Add memslot parameter to elf_load
>
> I really, really, don't want to go down this path of proliferating memslot crud
> throughout the virtual memory allocators.  I would much rather we solve this by
> teaching the VM creation helpers to (optionally) use hugepages.  The amount of
> churn required just so that one test can back code with hugepages is absurd, and
> there's bound to be tests in the future that want to force hugepages as well.

I agree that proliferating the memslots argument isn't strictly
required for this test, but doing so makes it much easier to make
assertions about hugepage counts and such because you don't have your
stacks and page tables backed with hugepages.

Those patches are a lot of churn, but at least to me, they make the
code much more readable. Currently there are many functions which just
pass along 0 for the memslot, and often have multiple other numerical
arguments, which makes it hard to understand what the function is
doing.

I don't think explicitly specifying memslots really adds that much
overhead to the tests, and I'd rather have control over that than
implicitly cramming everything into memslot 0.

If you have a better way to manage the memslots and create virtual
mappings for / load code into other memslots, I'm open to it, but we
should do something about it.

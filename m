Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B54AC6A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357317AbiBGQ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241321AbiBGQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:52:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B2F0C0401D3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644252742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SjZDex0SCJOjPXrkB4gDwjTI/FsNHK/bFrxgZZPO4U=;
        b=Tazh40FPp6fC8GYdzdgY+xkmZUkve9DTofwT2/F11S8h5StaAnBSfeuV8GuEUAaBjISOee
        8VpgGLgRIKo/AS1F/0NWkrZZx3v5BVMuyJT19Vl9eV5xhc4+mtwH6q+okiXoZhp/Ud6z5R
        nF7OsuwlhdshtLGSZycopMtoSzGGuoc=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663--3h-FvGHOpq94ljM5KcNYg-1; Mon, 07 Feb 2022 11:52:21 -0500
X-MC-Unique: -3h-FvGHOpq94ljM5KcNYg-1
Received: by mail-yb1-f199.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so29483732ybg.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 08:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SjZDex0SCJOjPXrkB4gDwjTI/FsNHK/bFrxgZZPO4U=;
        b=KLMz/86C9ZwkVb8zMWjsI697b8NqPQMX+MRVXe5OPYfZ2XBQctNU5PE6LOuUlDG7VD
         gD70fiBG7tlmlao9JgsRadrmqsB7y7M09wt1ULwg+vLgb3JQRM+/uVy+hp/5xszJ7NFZ
         8qLDAXSNa6WaBZX2O1IlyxQoI3FAxtajsTk+9ilpGSwZembkuWDCS09vwWQlyelUmN6w
         PHaqkEoAeePuJk0SVqI3ofUeYeQg+FWZzsy0miEH9J8n7aI8jC+8JAsFM9fANsXexON5
         J/+rFZpM3TszXCgXg2R0ULirrHB4aXuqKRceUXLK+ooTE9EZXwHGXsxBhhX9bmGdk5oq
         Bv+g==
X-Gm-Message-State: AOAM530xnaGfzCKVtzmLVnM0NlCVtD6zafNRSfbRYsspsAIQLXhRHgM0
        3dEfU2zFm++eTA7QiQqA4wgzDpruR4F+zSNDnbcmr/m5YwQ8geMqF9dLGBenb8enYNk9YA09gp8
        vbpbfaW7lYXSVgzWI5uH+hXEwmI12K0DSWb5vXiOC
X-Received: by 2002:a25:3449:: with SMTP id b70mr593369yba.426.1644252740402;
        Mon, 07 Feb 2022 08:52:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2r2RWJX+7wc5Ij11c6LjwAsF/aHbvsTtSCysjXZN8Zq45/JDt1/CzRafV4o0/Kb/p6Fhtb0hiMbPiW7TCwxk=
X-Received: by 2002:a25:3449:: with SMTP id b70mr593352yba.426.1644252740156;
 Mon, 07 Feb 2022 08:52:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNt0Xp1j7+hTrV9XZ936Yz+H8Le0pqazhLr3drO0tEzB2w@mail.gmail.com>
 <20220207154739.GH23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220207154739.GH23216@worktop.programming.kicks-ass.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 7 Feb 2022 17:52:03 +0100
Message-ID: <CAFqZXNuKgbq4ZKyzWvMS7yL5D4tkZA7xMJx_LTvLUoHDJwHxvw@mail.gmail.com>
Subject: Re: Semantics vs. usage of mutex_is_locked()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 07, 2022 at 04:15:27PM +0100, Ondrej Mosnacek wrote:
> > Also, any opinions on the name of the new helper? Perhaps
> > mutex_is_held()? Or mutex_is_locked_by_current()?
>
> lockdep_assert_held*() and friends work on mutexes just fine.

Hm, good point, although it will only work if CONFIG_LOCKDEP=y, which
is usually not enabled on production kernels... But maybe it doesn't
make sense to do the check on non-debug kernels anyway?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.


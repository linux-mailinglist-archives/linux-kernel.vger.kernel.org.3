Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20E5691FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiGFSih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiGFSig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 05BC114006
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657132714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6bZNuL7RAHnFV67f4D5x/92+2WjgdYrP06Pk08jyQTU=;
        b=AWG85qAw55yNvkV6v6XLNqvXOyYzPKR3XeuoiS5SYka+Sp/u8tMhf00nh1slfbwD4kmtZw
        sa6yHOojJTWCdRL7lM5oQesStzOQq/VkJsmkek9bqRIaZ0Hg3VznAXPPfsZvNd0S2H8mla
        CHZ55eqd4xYICQAJrvtFBfDwSariF0w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-D9WYsb66PiC8Yy2AnjBjRA-1; Wed, 06 Jul 2022 14:38:30 -0400
X-MC-Unique: D9WYsb66PiC8Yy2AnjBjRA-1
Received: by mail-ed1-f72.google.com with SMTP id y5-20020a056402358500b0043592ac3961so11981879edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bZNuL7RAHnFV67f4D5x/92+2WjgdYrP06Pk08jyQTU=;
        b=02tJAU7Q7RTxXbF8OhXDtkjixCRZ7vPghl8Mn6bZV5w3rrdo7W8iXSUWiKRT3CrAa9
         GjLp2rSxg1wDOKdGePR5OteoScZWfhM/n+7RJtRJ1s4i52vJtsFd53J/s8vAmGp1sWvN
         V9ln35KojvDr6s8htUApQp+jkNLoCs3tba4ziNGWswvVWXVYr7yNiFzjv3egyvlYEsEy
         h4SxwR4sJUt9bNFjQWgP6WtwA248wGSlApAcbdOk9F51/vd7ch5F7KtZat40HaXs2tRA
         0tmMam4KqRWfxbV+07+gA7uJCvxi7zuI6WI36iqoNfuugkexo46cy4Mgb+B+MDf+Np63
         4ctA==
X-Gm-Message-State: AJIora/JkMV8HacsQZilcq9bW0qvdUeqgeoZy3OAi2oLWybWnTMDVVxW
        J/Dyoax2Bu6hxsVJxygts949YW+RHwz8De/GysOGyk5k9FoORH+70/aqG85lj90nFMItJFcaflq
        IAbkco9idhT6f61x/gmGsQyPrSsRJ1y1keZD9sc34
X-Received: by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id b20-20020a056402351400b00435f24afbadmr54023789edd.311.1657132709524;
        Wed, 06 Jul 2022 11:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vXkS+TeYM2iH5bLiOApP8aVSIv6LgG4byRceGi0vcWQ4mpyVXCApsVKw0zrZulmdTMksv1p49XD8lx8TzmptI=
X-Received: by 2002:a05:6402:3514:b0:435:f24a:fbad with SMTP id
 b20-20020a056402351400b00435f24afbadmr54023768edd.311.1657132709303; Wed, 06
 Jul 2022 11:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220705185605.3889110-1-jsavitz@redhat.com> <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
In-Reply-To: <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
From:   Nico Pache <npache@redhat.com>
Date:   Wed, 6 Jul 2022 14:38:03 -0400
Message-ID: <CAA1CXcAFyMLBEi87A0+pBbUKtzfEeE-5uyqPugmHLmzgH8=w8w@mail.gmail.com>
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  5 Jul 2022 14:56:05 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
>
> > Add the ability to run one or more groups of vm tests (specified
> > by the environment variable TEST_ITEMS). Preserve existing default
> > behavior of running all tests when TEST_ITEMS is empty or "default".
>
Hi Andrew,

> What is the reason for this?  What's the use case?

The current design of vm selftests is all-or-none. We'd like to be
able to selectively run these tests (We settled for selective groups
of tests rather than individual tests).

The main reason for doing this is our efforts to expand RedHats MM CI
testing. There are two use cases for these changes that relate to our
reasoning:
1) Our current CI has overlapping tests between LTP and vm selftests,
so we'd like a way to prevent running the same test in two places.
2) We'd like the ability to skip a test if it is determined to be
unstable or requires certain hardware requirements.

By adding this functionality we are really expanding what we are able
to do with the stock vm-selftests.

> And why via the environment rather than via commandline args?
Just a design choice I suppose. I'm sure Joel would be willing to
implement it as a cmdline arg if you'd prefer that approach.

Cheers,
-- Nico


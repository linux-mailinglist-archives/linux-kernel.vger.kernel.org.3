Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3967357E575
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiGVRYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbiGVRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:24:01 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEBD691DA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:23:54 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q16so4944628pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nP/kZp+cfU+PzA9FUjazEG7/eYrubq8X263Q4O4hdGA=;
        b=d1uA3R0qq8joJKG5RNV6d/UBGTRfMTvqMP6O7YtvO5p85K2pjIsoI4Zz1VKX4Ak519
         QCGffbe+j3tWqxDWOvpLMu6q3LIkT//K257CkgOccMcDegdi2E2JgmBBLLeybYGxUOd3
         59LGK7aCNaC7hB8xqLJsH6bqn4KBqOQ+N46BE+0VMs5tIk6a3jn8dDwV4w/RWViGhKjc
         1+xVI6W1F8J0r9ipDTvNx/Z0w0jfVhmz2HTltC8T4nG1tr/9diqHK/IbyuF1I1gwZtJv
         T8XC8FvWkYORTqGvmx92kSnLMH2fbZ3BvsynLr5cr4bHmX0Q78OP/aD75I+2QOxYDhMR
         OK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nP/kZp+cfU+PzA9FUjazEG7/eYrubq8X263Q4O4hdGA=;
        b=TCdNQIM52LVgwLpZ9Ji5oaC1sLGcEOXeaHq2AwU7tCQ7xAIjNTs5wrZD8LwDhyqjFG
         FB5Bwc4d4tjkldJ+FBNhs9oA4zmD0lZEkarH2jFP5p2Y4ZvKVeMS4bAqlBnP2LAGCC/s
         kAMhYivv9/iHb9566ZGItI4p/v1MEYFFrM/LWfbxMG3AO1zplc/ot/tfiTBJj6Irk5p7
         WhsURoyy7rEQjeYUax4WXEIIEDILiTha5SBFmKiz8kp0ywXRZyNh9dGAPBjqDWGv37oe
         E9ld9dgxD1CUeJcx6JD9H4Fe5YgHgmFOa5B3znpmnvgyFFKKrJ6Ticml9NpwE/ursosL
         uYpg==
X-Gm-Message-State: AJIora9PqKAbhK96quQXlu2rlo8sy37jGe/lQshHBoR1iUE2hANehThI
        fpnBZONjxBddbosCL14gBTVIXA==
X-Google-Smtp-Source: AGRyM1uj5dABQna8UMODRfNQ6r1Z8LffiMru2fxqxcgGmeM9Ao43oJ9OhYnmZuxsnSMMweKJJVpbAw==
X-Received: by 2002:a63:fc14:0:b0:419:d6c0:c79e with SMTP id j20-20020a63fc14000000b00419d6c0c79emr659961pgi.493.1658510633709;
        Fri, 22 Jul 2022 10:23:53 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id p27-20020a63951b000000b003fbfe88be17sm3770452pgd.24.2022.07.22.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 10:23:53 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:23:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        oliver.upton@linux.dev
Subject: Re: [PATCH] Revert "KVM: nVMX: Do not expose MPX VMX controls when
 guest MPX disabled"
Message-ID: <YtrdJWmk/2RkcQi7@google.com>
References: <20220722104329.3265411-1-pbonzini@redhat.com>
 <YtrB8JEuc1Il1EOO@google.com>
 <0f8dde12-576b-1579-38c9-496306aeeb81@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f8dde12-576b-1579-38c9-496306aeeb81@redhat.com>
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

On Fri, Jul 22, 2022, Paolo Bonzini wrote:
> On 7/22/22 17:27, Sean Christopherson wrote:
> > > So revert it, at the potential cost
> > > of breaking L1s with a 6 year old kernel.
> > I would further qualify this with "breaking L1s with an_unpatched_  6 year old
> > kernel".  That fix was tagged for stable and made it way to at least the 4.9 and
> > 4.4 LTS releases.
> > 
> 
> Well, there _are_ people that use very old kernels and keep them up-to-date
> with fixes for only critical CVEs (for example by, ehm, paying my employer
> to do so).

Heh, I'm sure that's a winning strategy.

> But still it's way way unlikely for them to be used as L1 in a nested setup,
> whether on their own hardware or in the cloud.
>
> I pushed everything to kvm/queue, but depending on what you post it may be
> deferred to 5.21.

Can you drop the PERF_GLOBAL_CTRL revert?  I figured out how to achieve what you
intended, but in a more robust (and IMO more logical) manner.

If you don't drop it before I concoct the series, I'll just include a throwaway
patch to revert it.

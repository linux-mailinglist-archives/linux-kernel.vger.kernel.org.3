Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF73A51077F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346687AbiDZSwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345190AbiDZSv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:51:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8BDADD5B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:48:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so2941409pju.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csE9mFtUCm71GZFouEwtiuE9H6/G3SH0c069TIhopYE=;
        b=Wm9KcyXE74zZf42Hmi+U3H6SkQfu1t1NPggty6gZHiBYnynKhgvIqzF26eaWSJgiGK
         XL26lD8voOGtCY07zSOSJ80jPs4VF0tMr7Gdq3JAfeYJrk/vs6izpo0MhfZmPk3RCMGg
         WYAQ9pVlSWWfCTnHIvAZezbTdAaRmKbrl7vPxmgoL9FhGddM3MZvgYHaGmcoYptinZ9r
         Rf5k2uXCrvWyBenS4/bu9sO4tQXq16J4w7OiJC0BTU1hhpfA6YZB9sBHG1ElxXnDjzAJ
         oKp4k92yncJkIbAQRY5U6MF5KMHliLI5fx87yAPaLe12HQaQscjlnYkkI4Y4yUFk9/PR
         7OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csE9mFtUCm71GZFouEwtiuE9H6/G3SH0c069TIhopYE=;
        b=5DdJRELbkZ9t8idVhYGPSLacS7Pn0G6s/Yvq9GeAgpV4PukjR9LO1eJN6RCU4HfyYA
         AyaVdSZdsLPq1ShFBfg2isJzzkpW0PttKSFZapdxnSFTTxif2cdWOOWTXskqNyzne79k
         R4+I0JaoLr74JwAWpG2OVoIksI813bOCKKo2k5QmI6bH36UT/WuL/iGqZMutt/XWQAyt
         xshNj/pSIYWtzl7jSOZTeMHKT7VjywDAPWtTFKqDh29pmxSfnmW8tuB4+Ekb8aSueHDM
         TJKXSNUWDVGo9gu6xty2Om5hQfRcb37195CG9uAl3h0S/KkhiXjdmdyU5OECFvRA7SbR
         g3BQ==
X-Gm-Message-State: AOAM530piQMmJDl4OiTBZOjVcYPJAoXtKbUViQ3zMgQbKIErSQgBNup2
        Saya4HBI6UAFrFOqCDh1510RPJInnde3Mtv1yHqyIQ==
X-Google-Smtp-Source: ABdhPJz7i6j2J5iNi5BhmOv5MdYzjx5opwBE6nlgWrXGYcnIMrzowwupIzSt6W0P0gT0mJquuylS1I1FgOyVQoBko5Y=
X-Received: by 2002:a17:903:2444:b0:15d:281d:87 with SMTP id
 l4-20020a170903244400b0015d281d0087mr7939024pls.9.1650998927223; Tue, 26 Apr
 2022 11:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220327205803.739336-1-mizhang@google.com> <YkHRYY6x1Ewez/g4@google.com>
 <CAL715WL7ejOBjzXy9vbS_M2LmvXcC-CxmNr+oQtCZW0kciozHA@mail.gmail.com>
 <YkH7KZbamhKpCidK@google.com> <7597fe2c-ce04-0e21-bd6c-4051d7d5101d@redhat.com>
 <Ymg1lzsYAd6v/vGw@google.com>
In-Reply-To: <Ymg1lzsYAd6v/vGw@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Tue, 26 Apr 2022 11:48:36 -0700
Message-ID: <CAL715WK8-cOJWK+iai=ygdOTzPb-QUvEwa607tVEkmGOu3gyQA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/mmu: add lockdep check before lookup_address_in_mm()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
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

> I completely agree that lookup_address() and friends are unnecessarily fragile,
> but I think that attempting to harden them to fix this KVM bug will open a can
> of worms and end up delaying getting KVM fixed.

So basically, we need to:
 - choose perf_get_page_size() instead of using any of the
lookup_address*() in mm.
 - add a wrapper layer to adapt: 1) irq disabling/enabling and 2) size
-> level translation.

Agree?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C514EFBBA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 22:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352104AbiDAUmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 16:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238330AbiDAUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 16:42:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E632E174BB3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 13:40:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bn33so5403899ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XoSP3hMLfu85/1JEUuOtPJh8kpd6w7SHg/LZEyV60Ps=;
        b=BmxvnjiSUtj1QaEfWViPd99IiS4Iovkvs/qZCvlsIYl13dHqNSDTC0hWMuOpMiKHPV
         kI+Bx1QVp/F0NbIypef3IbNmkvMBfPNwHiR6qRlH0sYUIoo7Kt0hvOrkVUDdf0s2snq9
         KBplvRS39sVsg7Ih4Ngj4cTRUzJMAJ4y2iGUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XoSP3hMLfu85/1JEUuOtPJh8kpd6w7SHg/LZEyV60Ps=;
        b=ALP6SVTjf6xyVqvlzcgcQxwQnh4hInyKa/WPT93aGYspHZOR1xEMs118+twSHe9gQC
         l7FCwwJIpdn5i1CtkATzRyWA08AHAvYSWJgc6zo2ReL/Ip+UbuiTXxBoxLqntQ5Hxxlk
         HlCIT1OyzuF8EqTEey+07b9W85jghyEF0iteLZ/vK8BxwCKyU4LPVSWwleFMo9rZAEOm
         JCL+Sfr9Sr3vjNcXT/g5yYK4+kBVIeav4pbgi2njs4nacQSx10uoQeUmlZ1np+ce5U5m
         o8HPrU6mXfw578hVvfqns5kE8zXw5ocRHqtDLO9oSPonpv9FfLV0hT6U1HBP6/ejNocA
         Gr4Q==
X-Gm-Message-State: AOAM530KFT0K20XRJanvuJAN3hBy5qZEOoG2xTWgaBKpwBcN6OwE2/4r
        ZtEzt6maBP6YWoNQ8sA+sZf6IPKpJmdeIZs2J18=
X-Google-Smtp-Source: ABdhPJxHjvPIlrLSBWib3KnLNUaJ1MWxD6W1tCcif8Q3PmUlEzezzBas4Tftol4jwaciMQreJKosAw==
X-Received: by 2002:a2e:9a98:0:b0:247:e29f:fbd7 with SMTP id p24-20020a2e9a98000000b00247e29ffbd7mr14362523lji.509.1648845617894;
        Fri, 01 Apr 2022 13:40:17 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id x20-20020a2e9dd4000000b00249b92a166asm281565ljj.48.2022.04.01.13.40.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 13:40:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id by7so5489498ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 13:40:16 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr14333618ljn.358.1648845616539; Fri, 01
 Apr 2022 13:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220401153256.103938-1-pbonzini@redhat.com>
In-Reply-To: <20220401153256.103938-1-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 13:40:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgSqvsP08ox-KwAU4TztVsjx07cMQni-rFEzxZQw6+iiA@mail.gmail.com>
Message-ID: <CAHk-=wgSqvsP08ox-KwAU4TztVsjx07cMQni-rFEzxZQw6+iiA@mail.gmail.com>
Subject: Re: [GIT PULL] Second batch of KVM changes for Linux 5.18
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 8:33 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The larger change here is support for in-kernel delivery of Xen events
> and timers, but there are also several other smaller features and fixes,
> consisting of 1-2 patches each.

No.

I've had enough with the big random kvm pull requests.

NONE of this has been in linux-next before the merge window. In fact,
None of it was there even the first week of the merge window.

So by all means send me fixes.

But no more of this last-minute development stuff, which clearfly was
not ready to go before the merge window started, and must have been
some wild last-minute merging thing.

kvm needs to make stability as a priority.

              Linus

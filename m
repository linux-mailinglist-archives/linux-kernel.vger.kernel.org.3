Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12243507A27
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355678AbiDSTXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiDSTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 15:23:41 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF410FF8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:20:58 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q22so3521271ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/3mAvdy0ga85ggIH3HoGB0ePtskeVfNvDlSSUq9jS0A=;
        b=QvNx6FxecAp/z7mkZwwjndqXRE72gf91AcAXVa+k62ZgBfXGYm/WwmIqt/J18sYwhc
         i2StNOuJVaOsCjV7cve0T1U3qOs/WN1wFMwJTv6daJNph0klA03P+VQS+HViCxN/bhCX
         eLHeAXjYrEG6AHsQ2gChTGLFMTqfXijO7Vj+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3mAvdy0ga85ggIH3HoGB0ePtskeVfNvDlSSUq9jS0A=;
        b=D5xq3EsONVWzqjZkqlEcz8jg2p9WTkOuiubQ9ZOlI2mjmXyLJk4UOXh0LBjI1vEmPi
         ArQ4NMlx8THGM3p2amz02eTsj6vgmcs6/ZLIcm3kLvZtmQxVcFKS7K1SV4wu3Gl9wa79
         psfZLQYIs63FwUEDynzZj/S7KElp+U1Wlzydrfu8xUhkMj1J+decm1yY9xfAjFiVPAiu
         O2CJPhzRN0S4JBL2Hr2TniqOE4Y2D5J70h2PjljaHbIi3602t0OuqDrKcQySykEfX6Vj
         3JUWY92RBAZ6k0Ddp4yoGjW1oPgRgdR2HTGipjKm/GLsojZMejQWGBzWST0TKh+o9yft
         0OZQ==
X-Gm-Message-State: AOAM533IBYKGXqd+DrMSkBNDTcWD3zDwfPfEKC3lzq8SEz1DHGThh5Mq
        HxB0xx3pX+riP3cIjI1tzSyQcV9zgTG3gC/hipI=
X-Google-Smtp-Source: ABdhPJxWOTz622CxqVrYivwjcjDzl1LliANJmHBEe40Icz/k2YuGlaP3C+eL01lysqM783yHcoon6w==
X-Received: by 2002:a2e:9101:0:b0:24b:554b:1203 with SMTP id m1-20020a2e9101000000b0024b554b1203mr10919894ljg.508.1650396056610;
        Tue, 19 Apr 2022 12:20:56 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n17-20020a19ef11000000b0046ff45dc816sm1246123lfh.129.2022.04.19.12.20.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 12:20:56 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p10so31107873lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:20:56 -0700 (PDT)
X-Received: by 2002:a05:6512:3c93:b0:44b:4ba:c334 with SMTP id
 h19-20020a0565123c9300b0044b04bac334mr12102115lfv.27.1650396055810; Tue, 19
 Apr 2022 12:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220415164413.2727220-1-song@kernel.org> <YlnCBqNWxSm3M3xB@bombadil.infradead.org>
 <YlpPW9SdCbZnLVog@infradead.org> <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
 <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
 <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
 <Yl4F4w5NY3v0icfx@bombadil.infradead.org> <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
 <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
In-Reply-To: <Yl8CicJGHpTrOK8m@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Apr 2022 12:20:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
Message-ID: <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
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

On Tue, Apr 19, 2022 at 11:42 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> I'd say that bpf_prog_pack was a cure for symptoms and this project tries
> to address more general problem.
> But you are right, it'll take some time and won't land in 5.19.

Just to update people: I've just applied Song's [1/4] patch, which
means that the whole current hugepage vmalloc thing is effectively
disabled (because nothing opts in).

And I suspect that will be the status for 5.18, unless somebody comes
up with some very strong arguments for (re-)starting using huge pages.

                      Linus

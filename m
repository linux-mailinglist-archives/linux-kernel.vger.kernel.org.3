Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3D94D0646
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244719AbiCGSVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244717AbiCGSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:20:59 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66248119F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:20:03 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r22so6202059ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vXXyEj8lw1pMoMyulFe4jBxk+hmJv9H/jKDUVlikh88=;
        b=NgKM2T3pYCAEOBcvpoA2GcVi3zuFlQWkJo9upxaHk9VkZCgaf3zZTH5pW6fPVsQciC
         ehawL3bO12iOFOL+7suAw0EPuSn/RUs2eZeA08NVCE3kfPcUGkRM5J2MU6t6Xuw/WY21
         /KV3f+00uCpiwaLOexa/qrFNzwCJYbpnE9fr+x7X1gNB3FC6D591nx/ahODIR+2fD78c
         zwPRzkXq9nxWvK5zVnEfvsVVv0juheCMjMaEY+sNa6iqGzGK9HfCQ5jvHfAg7vLxc3G5
         GrmzUj3gWmjxLRmQppPzeNNVgYpSVPJAwophgLAMLm3oFaMJzXe37TIejawSeV8oX2MZ
         R85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vXXyEj8lw1pMoMyulFe4jBxk+hmJv9H/jKDUVlikh88=;
        b=KrSCDCkCjamVN0KqD3p+yiAajAJuZaVM2ougzF6+CDZ7gYGicnkSUDrbzIctBFFZPz
         eyj0hMMmt3q3eMfXFVuG5p8IGaUTBAUUvXnCJAPPRx4LNS4GPcn3qcReH143HLd93JNE
         MqoNTxmKWSHeBIhbuva3Y2r8666tMPwkpiH6Rxvb5Hv0J4E9WkNPVa9i2pvYzNsG+PzN
         1gSWzOV1h83tiTY6Rti4bYaU8q8tz/o8qN+9pXicGItCef7TipE41mQIpUtSzmxaTCjZ
         iH9bkPWog4j7RSsdtTaci6qTgBlUAXPZwZvie0Q6w05WGAyWJTs8R+H1Og56SAgVOzGK
         QX5w==
X-Gm-Message-State: AOAM532qOkVLQ0Kp4eYpIPMSw2xr/q/U934dLGtBKlr6SndGTyaIVGL0
        04j1HLFOiF+I/haBmaz6WFeMIUZkUniNahKM4HlhzA==
X-Google-Smtp-Source: ABdhPJwNtzMHKLjUUBfk19XpEDcQzbXS8PlQMwrcBud8ETqUZ+UgfngYJFCo4WBY6IrzNAan5WoZ8s80eUxFF63jUWs=
X-Received: by 2002:a2e:bf24:0:b0:246:801e:39d3 with SMTP id
 c36-20020a2ebf24000000b00246801e39d3mr8177705ljr.472.1646677199361; Mon, 07
 Mar 2022 10:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20220303112321.422525803@infradead.org> <20220303112825.190662703@infradead.org>
 <YiXpv0q88paPHPqF@hirez.programming.kicks-ass.net> <9a58477564a1d86e17bdd2ef959e7f3e@overdrivepizza.com>
In-Reply-To: <9a58477564a1d86e17bdd2ef959e7f3e@overdrivepizza.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Mar 2022 10:19:47 -0800
Message-ID: <CAKwvOdkM0F+ajQdLpgUA-WgzhHuV3ydUJskyTeKvY34D62ZRGw@mail.gmail.com>
Subject: Re: [PATCH v3 04/39] x86/ibt: Base IBT bits
To:     Joao Moreira <joao@overdrivepizza.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
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

On Mon, Mar 7, 2022 at 4:25 AM Joao Moreira <joao@overdrivepizza.com> wrote:
>
> >
> > Joao will be submitting GCC and Clang bugreports on this shortly.
> >
> Reported both on GCC and Clang:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104816
> https://github.com/llvm/llvm-project/issues/54247
>
> I'm not sure if something should be reported to ClangBuiltLinux, since
> the kernel will be built with -fno-jump-tables anyways.

As long as a bug gets filed; that's what's more important to me.
Doesn't matter if we track it upstream in LLVM's issue tracker or
downstream.  Having the record of it in either is what's important to
me. Thanks for filing!
-- 
Thanks,
~Nick Desaulniers

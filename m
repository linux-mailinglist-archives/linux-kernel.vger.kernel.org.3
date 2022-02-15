Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD4E4B77C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242245AbiBOTm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:42:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234521AbiBOTm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:42:27 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA20E1B7BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:42:16 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u16so81398ljk.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=scBaLfaGLWYYxtrlYU1JbIy2UJbbECdZygDHVPbgRRk=;
        b=lJP1yVdHufaCOzEkkjwdzlhxcctxP39rYiSDo8a2MXhB+GgPvhgLw6MCHYH5T5t/FQ
         nSpEnu9AuwpaiPiMgurzncCC3pIY50Fi/JoIzF71JmdI/CidTfrdaU+afI49C2/z/4we
         YnGAyB1qCVxghAFklVWc/ZYuUMF2Z3ATE/ENZqt1LKRrVZfmyMQuwGD2MSyFKI6Zo7gm
         Tsk61FxSAYjYAkDX31UTXa4uG+wyyh5QqcCdsgVR3zst/tkoYtVgN+33IDZLfTwBYBFb
         YHXOYNoumFJw50NPD1yysElaq4kVymT98hLvV4fLbfweVhc2S/NE2TER+lDvYSvPeqZo
         mohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=scBaLfaGLWYYxtrlYU1JbIy2UJbbECdZygDHVPbgRRk=;
        b=cMGTH1AYUKnkG2dgEG+PS4aaBK5D3jm+LHffzhvi9xmqbMbdpKWuGNzpmSTCC2Ijt+
         vDQMp9hN6xbSInktDOjCGWMxODLAMbeMSODSdJgcFEXcm1YK91HX4I6XfqL0NYs5yBxM
         yNTFlGGBkJDlQQs+anuIFW4ICVm+qgzBBd2biMeEgDlizPavvc7Lek/4YvnBKNEu51v2
         mMyPHIIMjvY3AFzfJx4uqwdqbuCe2NyUbdKSV2YRh7p4dcCKpVVjiuULFTeNVXz0VwKs
         NdIlLlW8V67DtkuE41ZMcpw1IIiFkrcWDavUvu+fUKj4ilTmHpqQF6wxkZlI5EqH93L3
         oCew==
X-Gm-Message-State: AOAM531NtU+1lO5RKqiOJ1ppH74WExXkvvvU2m0Ik93VSZMzmyZFjWkj
        zIZfCF6nFcF8ZPJreXspIh2Fj+xd9raPwgm3+SO8QQ==
X-Google-Smtp-Source: ABdhPJzfSSA3stmYRDtGVr8aeAPeZeLZIDE3WmXVsx/LCmKZBtGQxbOB8RdUyWAPezYun7pq/C1CNTW4pBuvRhLj2Hg=
X-Received: by 2002:a05:651c:2121:: with SMTP id a33mr426220ljq.220.1644954134959;
 Tue, 15 Feb 2022 11:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20220214175138.2902947-1-trix@redhat.com> <daabe69d3863caa62f7874a472edbf2bc892d99e.camel@codeconstruct.com.au>
 <6590666e-524d-51c3-0859-f8bf0c43c5ca@redhat.com>
In-Reply-To: <6590666e-524d-51c3-0859-f8bf0c43c5ca@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 15 Feb 2022 11:42:03 -0800
Message-ID: <CAKwvOd=ntKk7PwtYKWCV_44nf9ccCVDKiGJk_wB4yqfvPFDUbw@mail.gmail.com>
Subject: Re: [PATCH] mctp: fix use after free
To:     Tom Rix <trix@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>
Cc:     matt@codeconstruct.com.au, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 6:16 PM Tom Rix <trix@redhat.com> wrote:
>
>
> On 2/14/22 4:44 PM, Jeremy Kerr wrote:
> > Hi Tom,
> >
> > Also, can you share how you're doing the clang static analysis there?
> > I'll get that included in my checks too.
>
> build clang, then use it
>
> scan-build \
>      --use-cc=clang \
>      make CC=clang

I'm pretty sure we have a make target in Kbuild, too. It uses
clang-tidy as the driver, as clang-tidy can do BOTH the static
analyses AND clang-tidy checks.

$ make LLVM=1 all clang-analyzer

>
> There are a couple of configs that aren't happy with clang, these you
> can sed away with
>
> sed -e 's/CONFIG_FRAME_WARN=2048/CONFIG_FRAME_WARN=0/;
> s/CONFIG_RETPOLINE=y/CONFIG_RETPOLINE=n/;
> s/CONFIG_READABLE_ASM=y/CONFIG_READABLE_ASM=n/;
> s/CONFIG_FORTIFY_SOURCE=y/CONFIG_FORTIFY_SOURCE=n/'
>
> I am using clang 14

-- 
Thanks,
~Nick Desaulniers

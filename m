Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE3351596D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 02:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381946AbiD3AxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 20:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiD3AxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 20:53:17 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC4B8BF23
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:49:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso101210717b3.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9Y7U0wTKqKyrzCZ5VtAbMiTlejqirW8gTMxmJkTfiA=;
        b=o904YtYKww9l65iOnpFttd2oN+roVVJk4YvsnVIJZjXPGnvk61QhExALxCRC4rOedS
         GZ+fEIz4xNSI4vgwWDhEYwf63lfKesGr31yZNfmw+UXEX9XN/y2wAhsIjWCitplmO4ps
         8JTE/bKIyu2Jm+PEDZiXmNfTMKnVsLhQOq62VLJ4/GgKGeiH6TciRzAU6SsdTfIYcJER
         3BHGtLCXph4PQRO9JLg1+n+i6SRl5zEq6LVsT2vXCl1IbFZA5JBiHGbCTkleXv53Ljbs
         eh5U/POqRL31KOiefyvGXo2puzoXdUfX+v/WX7nlyz/6NPUWqBhPoK3P/gCH2Cg0mxKY
         c5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9Y7U0wTKqKyrzCZ5VtAbMiTlejqirW8gTMxmJkTfiA=;
        b=JFi8HmMbA8I7FuwP/3mToEC6gDW9uDt5iNEDnsmtBVf8Lk2uzigXLjNOCfPY7qGXm1
         DxRahuusDiT9LWaLXtiFrZ9+36AGyYBT5zDJM6v80bu9bJ5QIZqnlntn0qyOKJqgQtfS
         EvW/afcWMtjqsKxFiI4IgrACa5hfzNc+C/8ql5vmGRUHy/1bHsTT8czRhj2IFGULOb2R
         L7GPJVcjjE7xuXe+SQlbaJCMCFkypWZN8L+HnifYFY5ZyU+tpzUYjo81gR9zFIPRn44V
         Ip+WoTq+aI23KlfQk87yBcAa4nimbfPSTv9lKI1RoVwkDvMT7y/3uonP0liIcYUUGaZg
         Nw7g==
X-Gm-Message-State: AOAM533CZendsbepuJbncZnUnNnsxGx4WoacQpD01FY7lC9/PMNmadVn
        J56ZNbNEkS3akhuAAYmUpwDxVecSyf+d0A6ald/J5w==
X-Google-Smtp-Source: ABdhPJwgM0DU8R1vt+rPUv9v3MVwX19+YnYIl4ZgilTxVCVrF9omxoBF3LL/7AkmrlziboUU9RSRxP5sBIMxP78CMas=
X-Received: by 2002:a81:a93:0:b0:2f4:d65a:d44e with SMTP id
 141-20020a810a93000000b002f4d65ad44emr1937122ywk.243.1651279796955; Fri, 29
 Apr 2022 17:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-15-samitolvanen@google.com> <Ymxy/CU+tZhQ9UtN@hirez.programming.kicks-ass.net>
In-Reply-To: <Ymxy/CU+tZhQ9UtN@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 29 Apr 2022 17:49:21 -0700
Message-ID: <CABCJKud8vC6RwQLs2YXnZMZaXGNYBEq+sNmOsgGjjAw4MfuZuw@mail.gmail.com>
Subject: Re: [RFC PATCH 14/21] treewide: static_call: Pass call arguments to
 the macro
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:21 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Can you explain why this is needed? I don't think there are any indirect
> calls to get confused about. That is, if you have STATIC_CALL_INLINE
> then the compiler should be emitting direct calls to the trampoline.

Clang emits an indirect call for ({ &f; })(), which is optimized into
a direct call when possible. Come to think of it, the recent
InstCombine change to the compiler patch should solve this issue. Let
me double check, I'd be more than happy to drop these two patches.

Sami

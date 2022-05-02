Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAFB5172A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385821AbiEBPfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 11:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385801AbiEBPfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 11:35:38 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C076340
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 08:32:08 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id g28so26617761ybj.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=hCGKNipS00tBX8rbB28dkiVg/BvdNz8E722on+AV5GE=;
        b=iJhBELUzXOr15YhTf0wF+a681aftQovvW35I2W0xmmMp8MntU2wDtF3J/uFXVkHeUI
         FFh10K8dP/kcvw5GV42gc2kKRsaEByU7ysTgBlBeGuBG8+jtAY9IAEIfWWsgn4nIJpbw
         bsd6Y41l2YVABLJQ92bJl0KYYuPYfpyYZI9eYjsmq+GzxKmgW0yHxGKt2ihtN9vq3ExH
         dBOuCATwLlUCWDwVviy4J4NRKpwr/ejONaiz5p0ymgLsXU8O6QPNTKF7w7usOFpdARND
         A5001AxyjOwcV5fpVk7WWUtsEuvWLCeK6kDaDgzQI8xbzzBrq2zM5i8zSaUPu8vITIUg
         4CLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=hCGKNipS00tBX8rbB28dkiVg/BvdNz8E722on+AV5GE=;
        b=ESoLaH8f50ho0HJWC4IuTqDgAPb/YlDn4ndY5FUsm/kM5rl+C3g4BMaArcQZBRuNdl
         LSFnkrd8OglgRUwpkGiz2csmmSm9myR8P0kwIoV6YkIbaxbCrzr8ndXN8KuoRnuHPWjB
         jkMq8wCdJs8HU29zrWO8jooNDUR13V/zAB1NoqIoTskabC45WuhVkv0gxZrYCOF/wQaX
         85UsZo3ubIjTJAZl3JVo80Kg8bhT7bxxqxmlebjEnSA45/y86lHV5UHq8ApFYLbh2c0p
         Y61qT2yEJ/vNarrYDX6m7KKJpPVw5Gf7kGxcK/iHgyuU+lGE0n4eKKrW86C+xOnkBqcF
         OQkg==
X-Gm-Message-State: AOAM532/ZBZddYYy5e3OStz9GmONcoFw4pmX6/41MWdeeY9U8yDP5EFF
        Fg/sdOnuPF/28yQBPjdvJVaA8hk4ua3of0q1t5JDgw==
X-Google-Smtp-Source: ABdhPJwj3QrPFfxu2nyuN5kFPO+0frvF6GLCyRxUVFMu80sCrG1GMxBjBR97BxQia0hYHO5LXNrgaz0HEPZ7M14xL8o=
X-Received: by 2002:a5b:2c9:0:b0:644:b7c9:3766 with SMTP id
 h9-20020a5b02c9000000b00644b7c93766mr10147935ybp.428.1651505527625; Mon, 02
 May 2022 08:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com> <20220430160750.ov7ddsq2vzibwrju@bubbles>
In-Reply-To: <20220430160750.ov7ddsq2vzibwrju@bubbles>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 2 May 2022 08:31:35 -0700
Message-ID: <CABCJKufWFy0ShK49YAqk60mVApQ3qrfOj9R1nuLAWXiVtqbPJA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] KCFI support
To:     Sami Tolvanen <samitolvanen@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 9:08 AM Kenton Groombridge <me@concord.sh> wrote:
> Many thanks for continuing to work on this! As a user who has been
> following the evolution of this patch series for a while now, I have a
> couple of burning questions:
>
> 1) The LLVM patch says that kCFI is not compatible with execute-only
> memory. Is there a plan ahead for kCFI if and when execute-only memory
> is implemented?

There's no plan for executable-only memory right now, that would
require type hashes to be moved somewhere else to read-only memory.

> 2) kCFI only checks indirect calls while Clang's traditional CFI has
> more schemes like bad cast checking and so on. Are there any major
> security tradeoffs as a result of this?

No, cfi-icall is only scheme that's relevant for the kernel. The other
schemes implemented in Clang are mostly useful for C++.

Sami

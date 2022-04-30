Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7210A51597B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 03:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiD3BEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 21:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381955AbiD3BEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 21:04:00 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223B865A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:00:40 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id v59so17181504ybi.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+/lXmWN9a4yBqHcUhGldW2cPmJygtUYS178VCmvTIc=;
        b=sae9+FjGo9T5Lw9oasK5TSXV+WiJ9kOd1rZxgJTdRsikk6ZkRbafNdUGY5LNRGAq7z
         KLeLF9me10KOS2tdhq3QqUpedIvCKSr1k5DC/BpSJXrYAbYGX36I/OHi5sPl2+ZQlekd
         66J+Wwfye+d+OmHrkDF8heOen1RhSJWCYyaI2bN5JBrcN16V9XbLRRbXVKl4swa18OO5
         tjzIGXovtKoxHb2BPhqhs7CQ8j16lH/BUJJAJBpzv9rkOq3Qi4oG9OwF3Ppi6ZYwQt7t
         c0tGVoQRbXL9RFIYG+2HjirHMKUjpclTwnxrV6ci7lqAUdDwRL4xfTYawAje7RdrXeb3
         Ouqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+/lXmWN9a4yBqHcUhGldW2cPmJygtUYS178VCmvTIc=;
        b=HHnOUN3Qg9qyk7hE7AJCDN4XG6Krw0YoFkq8A4yADrE+v5rcP0Fn3fpb/Q3VirN5a1
         2QKIE6QdQMUc7a3RcHrIo4gFKidPfbQMWOiXFyhpqA5jGT8l5/Vnzcl+KB+CjZbMRTY5
         1+cMburo2rFXE6mp8LLrCFW8zsPjoRFsoEmECYQ2cf3MoFBkSE5ZjkneQDv4L4PA04je
         RBgqzMyVZIVdaJHstgoushhdbM+pz0xRB7UywaWTSvu7gSDrhCWs9AB81PfYpGNmfNyd
         VRg1ABqwSKbSJ34aE24qQywjNcOeiLE3CzFU/LDGdr9s9efZFW+aHk1vTf+1NUZAw7D6
         KIrg==
X-Gm-Message-State: AOAM532aK/NWE9LsIdQCJMxyJUQk87VXcVy0D6xeSPytrIJfnV5/yLg4
        7qRJD2NFOlYbY4cFCxdw1GNTPgfYnSBEvB11eWmllA==
X-Google-Smtp-Source: ABdhPJyhcCyxowcmxR+EC+1LVLQSQWfwL5P0ozbbvft+6vNS3yhM7DK8vGFq8LI/3sHN0lOaYWVuT+28wwYR2ixEuLk=
X-Received: by 2002:a5b:2c9:0:b0:644:b7c9:3766 with SMTP id
 h9-20020a5b02c9000000b00644b7c93766mr1986227ybp.428.1651280439211; Fri, 29
 Apr 2022 18:00:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220429203644.2868448-1-samitolvanen@google.com>
 <20220429203644.2868448-17-samitolvanen@google.com> <Ymx1JcO36h7YqLa0@hirez.programming.kicks-ass.net>
In-Reply-To: <Ymx1JcO36h7YqLa0@hirez.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 29 Apr 2022 18:00:03 -0700
Message-ID: <CABCJKufNUoJJPcraG-o2AvTBSWmFEQAzg0z-Z=xLohBqsMA3KQ@mail.gmail.com>
Subject: Re: [RFC PATCH 16/21] objtool: Add support for CONFIG_CFI_CLANG
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:30 PM Peter Zijlstra <peterz@infradead.org> wrote:
> Urgh, what does this do for decode speed? This is a hash-lookup for
> every single instruction.

Two actually, since .kcfi_traps only contains compiler-emitted
locations and we also have to check for manual type annotations. I
haven't measured performance yet, but I also didn't notice a
significant impact here.

> Is that kcfi location array sorted by the compiler? Because then you can
> keep a running iterator and replace the whole lookup with a simple
> equality comparison.

The compiler generates a separate .kcfi_types section for each text
section and the entries are emitted in order, so this should be
doable.

Sami

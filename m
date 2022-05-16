Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035B528920
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbiEPPpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiEPPo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:44:58 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2436B27CC2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:44:57 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r1so27700341ybo.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh4thbZicieh5pA9EvCDqIWgLAD7rreDAsKJIQexD5c=;
        b=NAoEVeLyn9HY8sQK4KikjOwjCyegVnBTeL5zoWuK82YfpVeeInRkemfpzAO6Hr7SSx
         rREBMz9IyEZgBDaS/b2j7V35XSafSQUxzdT3PPKnWgbj3uFgbhsyyuSoFDFWDwqcvqua
         nCQLyT0v46hhy1pE4trJySbGaEWVSGPA/k0jpZvgChCHIb6+zlcaQL0dSmM7PaXvlkfz
         TTFRbsF8RVb15dpwhIDsgTD//g1y2accfif7dNoz991SFFzDD4UmDRuoVyUnBQIzDz9e
         dkRhMg5PSDInh8OuDu+jriCSbDtLVRXI8Uxt5OUZqSYXUmofr4ZAtRVMo3AWfs2L+qs6
         SgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh4thbZicieh5pA9EvCDqIWgLAD7rreDAsKJIQexD5c=;
        b=CV4LWiifaPb8qvJyXcan0N56ug6LSJtlDKL5re3rv3oaczAm0NmaAbWxvrzTXXQ9C2
         cYaSAp8NYjHPZcN5GkVUFmTlATYjMMguCnp7CqeIO2dbHxaDOKA1T4kBP46GBkkEbBpz
         3i0G4VC8xh9qQhJCWRt7h8galVyF/6Xv0Fb4sD9kTGiGk44NJYIjCuNv2e6ghOVILDPE
         teFPiAw2hVtNrXYI23fi+gH+H3cDeqFgqVj18748p7Uv8/WzeDY303ggRWNR7Gd1zGiF
         B0nBQb57GHul5cEQVfyMwNsvtOTsPZ8W47IUKAKbpAiA4ILkIiaeSHKbMf/miMw5f/Wz
         uVyA==
X-Gm-Message-State: AOAM530M/wyCSx0y5mXxySs1lqvzKQmLBqtEIkqxgn0A4PibBxtTWCOB
        vH+BebncGjDr0+e2wpXOfcIk2TRmjY3SZwNFWwYRbw==
X-Google-Smtp-Source: ABdhPJw+DA403J2xHjG+VNvIXpIT/pRyykNE9Phm+VFTfI7c4mG4JJRypFFd1P2SboeRIFqLY6YvBU4iZcfiwmbMapg=
X-Received: by 2002:a05:6902:90b:b0:64b:233d:8e03 with SMTP id
 bu11-20020a056902090b00b0064b233d8e03mr17872541ybb.428.1652715896186; Mon, 16
 May 2022 08:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-2-samitolvanen@google.com> <202205141441.C3B7CF6@keescook>
In-Reply-To: <202205141441.C3B7CF6@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 16 May 2022 08:44:20 -0700
Message-ID: <CABCJKud-aV+B9-2T=jTLqSpXgzmFB=4c8_rKtnreZ6Xa3QEh2A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/21] efi/libstub: Filter out CC_FLAGS_CFI
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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

On Sat, May 14, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, May 13, 2022 at 01:21:39PM -0700, Sami Tolvanen wrote:
> > Explicitly filter out CC_FLAGS_CFI in preparation for the flags being
> > removed from CC_FLAGS_LTO.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Is it worth merging all the "existing" CC_FLAGS_LTO/CFI splits into a
> single patch? Either way:

Sure, I can merge them in the next version.

Sami

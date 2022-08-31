Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1365A88BB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbiHaWE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbiHaWEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:04:24 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4A4E8301
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:04:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 202so14655167pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 15:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=eXEYaFnP4mOKjstNFujmxTiRRJjn9XYWqPXOjFo+1fQ=;
        b=S/NcZDY5SZ6CRMmy+D6KjP0bTurAvGghafOwYbc+nw/dwS4ozUP9sQwnkdU2qYD+X1
         8UMSc5iO5Qk+z++YNmfVFYjUcIBjFchohVKc75j5HUMkRFDUetf4U6l4sH4tLuN2RSPS
         ffiBV5V5SggAAOzfGOvkiCIpVaWQVrpea4yF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=eXEYaFnP4mOKjstNFujmxTiRRJjn9XYWqPXOjFo+1fQ=;
        b=1o8hBCn5bgg25gQgsV2Pg33tCB3Iu3I6jxf4hHkvct82fXBE/PCniJHqwOE4HpuKbw
         qOjxi14ISe0ypeg/knYRhSXG9Nwv357FZVpxAy03lg5OLMUi4ZvF9FrhVFmbRlv/yYH9
         sFllRfVd5oRInILdJpM1mwDM4p2FYP3XZBAihNNJoJStM4TPWCXfQeU/iaDbMEj7j7cq
         5Gnn/j8jiVmaLfpm/hAJYxc98YIfFDE+1bQ6q2VQnODy/CrUrf7SAPcypscgXlwU/za6
         U1Hz+L8CjiXZq828Dux6i4fQg2QUnRep5wiiAasb/LkxCuMOd6A9tSwppD68uOZWR5BK
         sqoA==
X-Gm-Message-State: ACgBeo2y0poyFh6FW18/mDoPm/51QmrLL12f0yuZ4uikmkzo/yx3X7TJ
        Qa0tVEKbeko6kZVB7QGLUlbMfQ==
X-Google-Smtp-Source: AA6agR5Zz4u2SM6bdRyYRSBSx8G9I+mIKqnLqni5bLKs1f95ZDZtfZ5SgHlRdwxyL0X1H+0S1pMqCg==
X-Received: by 2002:a63:88c3:0:b0:42b:33f8:6bc2 with SMTP id l186-20020a6388c3000000b0042b33f86bc2mr23258567pgd.495.1661983462486;
        Wed, 31 Aug 2022 15:04:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902710e00b0016d150c6c6dsm11999017pll.45.2022.08.31.15.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 15:04:21 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:04:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
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
Subject: Re: [PATCH v4 00/21] KCFI support
Message-ID: <202208311503.62B2C1BC@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-1-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:08PM -0700, Sami Tolvanen wrote:
> KCFI is a forward-edge control-flow integrity scheme in the upcoming
> Clang 16 release, which is more suitable for kernel use than the
> existing CFI scheme used by CONFIG_CFI_CLANG. KCFI doesn't require
> LTO, doesn't alter function references to point to a jump table, and
> won't break function address equality.
> 
> This series replaces the current arm64 CFI implementation with KCFI
> and adds support for x86_64.
> 
> KCFI requires assembly functions that are indirectly called from C
> code to be annotated with type identifiers. As type information is
> only available in C, the compiler emits expected type identifiers
> into the symbol table, so they can be referenced from assembly
> without having to hardcode type hashes. Patch 6 adds helper macros
> for annotating functions, and patches 9 and 19 add annotations.
> 
> In case of a type mismatch, KCFI always traps. To support error
> handling, the compiler generates a .kcfi_traps section for x86_64,
> which contains the locations of each trap, and for arm64, encodes
> the necessary register information to the ESR. Patches 10 and 21 add
> arch-specific error handlers.
> 
> To test this series, you'll a ToT Clang toolchain. The series is
> also available in GitHub:
> 
>   https://github.com/samitolvanen/linux/commits/kcfi-v4

This happily runs through all my initial testing hoops. :)

Tested-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

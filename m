Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7E5A858C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiHaS1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbiHaS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:26:26 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38352449
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:22:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 73so5843423pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=I/i5jIe0pyAtTiwLTepRVRpt6gmHv8ChBfodrmmozEo=;
        b=eSmUjyzYgre0PZ1K00Cfc8tvsDugBnadfNSIUOuoe+VuxkBIDN4sFvali/8YxpY2Yy
         JIo1eombL289lhqWvm4w90+7iwbQTGS8DQI4bTYvXQ2UGf4oRT2v6ha0ViH5ugWvQM94
         yweXGcDiRcyk17EsCOuWNdrpHURxwoyHfpaC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=I/i5jIe0pyAtTiwLTepRVRpt6gmHv8ChBfodrmmozEo=;
        b=jzqM32fY+FapApn5Xm7+umoIXMRElC4thlcbCLJzSpnxSrMMU4x4U3N5wsBwlUFZcP
         iFd860NPbfF2nrFbLh2b8X1c7pHhRf/BmlSIy+2f3nC0MbQ7UsSHtzzkPq1zIDJkASXS
         vkFqHQMpZuDY4X6KiFj/COOYr6Qi8fkGbV0VKGny9raDTPoj8oJ2YnDByIwc5F1plpeX
         7wEDd/w7W+u2cHxKc8GHuKXHIdLlzraDQR4NeyjBXGZQvn2D/nBBpTeAlzVN94uiqQxN
         NlSoGgXa7Ra1P0AxrLYueaDHnNa5znTgsEvtXqofFIMBze+gCh7lxWPONyopjmXBshVm
         +s3Q==
X-Gm-Message-State: ACgBeo3LeTNG0uKyYL/vLHV2u6vQ94hkEyQ+TvL2s5Er98irQLZBFjO7
        To6y4kSgSXKO5YfUF9HNn3x17g==
X-Google-Smtp-Source: AA6agR4SBpLEuXeN8GNzl9PJ01BUjf3qaampgOd1NHZi1cFWVwtFCQRkYKzxOrJcywDgmWTUMxK8Ag==
X-Received: by 2002:a63:91ca:0:b0:42b:4847:90dd with SMTP id l193-20020a6391ca000000b0042b484790ddmr22369351pge.28.1661970176454;
        Wed, 31 Aug 2022 11:22:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z15-20020aa7990f000000b0052c849d0886sm11627704pff.86.2022.08.31.11.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:22:55 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:22:55 -0700
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
Subject: Re: [PATCH v4 08/21] psci: Fix the function type for psci_initcall_t
Message-ID: <202208311122.FA0ECD5782@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
 <20220830233129.30610-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-9-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:16PM -0700, Sami Tolvanen wrote:
> Functions called through a psci_initcall_t pointer all have
> non-const arguments. Fix the type definition to avoid tripping
> indirect call checks with CFI_CLANG.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

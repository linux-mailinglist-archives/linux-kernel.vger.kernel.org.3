Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC58C52743F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiENVoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbiENVn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:43:58 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D52B1838A
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:43:57 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 202so10653930pgc.9
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LLS7Qs+kiru82aH5PJhByae1JVoVq6KGrh/vD5VnTrg=;
        b=Q+18rDTK1r07EeGDwGKZz+sW2xEsYdgl6mXdAgXXAZp2VV8YQBl2ddvKiNk6+bRJE7
         WhVB9ovIuJZkleoLE8Wg/p6xtgAPHv6rJhSaKFMs7ARU/f/Pk8MJRYbv0uJDzIG9bm2j
         54NS4mNm22dOZTMg3b4zk3DeDlmGowgXLH7Qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LLS7Qs+kiru82aH5PJhByae1JVoVq6KGrh/vD5VnTrg=;
        b=Lr8nDy9EmxPgVbz5Xk18cc82c5MHCuXjs2uaQh0OCwFy76WVOkmL6ga5RTgmRyxpdV
         vrZuNZiWgzDwxGMxg1JPVdQZmBISWudONpHi/knGNKlddmTAr5IC4267RPLsCpK+CF7F
         CiV+I4AtKKEJUpDqBdSvsY51LM7Z5hcxriXBqlY2q62htMxjUD/Ye4ceM4ZIggBUag2b
         k2nvgO89ORIdgNemGytF4JGYcABioYquD0qQa443xzlXNQFL6Z28tOt9mIG/iO5VOyT5
         lNmjPt8LiAyXtMyIMeLINUtGG5a5o+mVnvMOABhkzXug9eSK6KHLq+ltrLjdODcfY/ZA
         yR4Q==
X-Gm-Message-State: AOAM530xPlxHeJ19VqZLJOtOnBbuE3rDSrE/TTsk4c4R5Y8q62FnqCL/
        cvVvjy9jVPjbqsou8CXAKB2AsA==
X-Google-Smtp-Source: ABdhPJy1SUg6blIfFOl9RL/kjBDiBzqJhlhen4sGbyOOl97K62dMbHT/72DOVt9RHA3FaPWdLh+KpA==
X-Received: by 2002:a65:6810:0:b0:3c6:ae78:5fd0 with SMTP id l16-20020a656810000000b003c6ae785fd0mr9467906pgt.495.1652564637046;
        Sat, 14 May 2022 14:43:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902ce0a00b0015e8d4eb297sm4116507plg.225.2022.05.14.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:43:56 -0700 (PDT)
Date:   Sat, 14 May 2022 14:43:56 -0700
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
Subject: Re: [RFC PATCH v2 04/21] cfi: Remove CONFIG_CFI_CLANG_SHADOW
Message-ID: <202205141443.516DD7C93C@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-5-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-5-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:42PM -0700, Sami Tolvanen wrote:
> In preparation to switching to -fsanitize=kcfi, remove support for the
> CFI module shadow that will no longer be needed.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I like that most of this series is dropping code. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

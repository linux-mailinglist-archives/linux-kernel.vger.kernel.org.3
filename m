Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73452743C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiENVnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiENVnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:43:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D418389
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:43:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ev18so377460pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlRFKx1f5LgxGYiRBStshQO2lcl0shwRTsz4d5msIg8=;
        b=eVJvq+ghFVgsLl2S9H413dqQTj8DyyaMX5Lri0ldevwz5nr6Vcgdxe0+ij/LV+qfcg
         ng+ldMyJk1bq4BG01m2rz/bktU34wNy4ejseMuCe/8j4MBVXCDe6GfufyslHYCZreNjs
         zLCBvZKrj9tb+YOYdvXa5qk9tB4rwunj+IEIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlRFKx1f5LgxGYiRBStshQO2lcl0shwRTsz4d5msIg8=;
        b=PapMN1FNc2qEZtgIhp+ufeEdRtlR8Gp6rDgI1d3EEnwUo0izF7jHHHWl6SOKKscvYd
         xAd9Z7VXSi6aMky+yGmzMEB+ge0RZXTRc3riTtscbvN8xqfysSVeupN6U8q/vOVvUz8i
         DJ4Hf3ii2LwL00cjPJjJN0o65LQTITn4gZhbxwIu2gVtgPtG8f8IYCaRt5pXNxA90+H9
         2EkaP+dzb4sFGXXfDANgQe9d9eUlT/jj+L4N/T1CXwUrdXllg4IEM/4IByslWNpiYYJi
         nXLq424RHivqxEupAidH/XsjPpklevsvZskvT6owpcUId4SUp5vRODHd7bIco9i0AEWN
         kXhg==
X-Gm-Message-State: AOAM531eGsBzMz5bwwH5oRUZ75nkQn6+W6+lbn43OEjdnDMo5awMNi1v
        2FerALCkoJy3UwjWrJ/D8GfVuA==
X-Google-Smtp-Source: ABdhPJwjF7T387a9POXFRR70Tq2h4uk//J7YzYRByRcEsqcopbrDpy2LgsoIKFTW6B9DZ116TxnPTQ==
X-Received: by 2002:a17:902:bcc6:b0:15e:e60e:f3e8 with SMTP id o6-20020a170902bcc600b0015ee60ef3e8mr10898049pls.174.1652564584093;
        Sat, 14 May 2022 14:43:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id io17-20020a17090312d100b0015f4b7a012bsm4078815plb.251.2022.05.14.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:43:03 -0700 (PDT)
Date:   Sat, 14 May 2022 14:43:03 -0700
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
Subject: Re: [RFC PATCH v2 03/21] kallsyms: Ignore __kcfi_typeid_
Message-ID: <202205141443.9A3BAEAA5F@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-4-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:41PM -0700, Sami Tolvanen wrote:
> The compiler generates CFI type identifier symbols for annotating
> assembly functions at link time. Ignore them in kallsyms.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

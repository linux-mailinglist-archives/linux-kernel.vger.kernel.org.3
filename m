Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE0C5A8599
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiHaS3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiHaS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:28:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7707DF3B
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:24:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so71443pja.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 11:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=QOzTr0839E3H9tR0wkETuj4b9U9VUvaitz4KI9/r73I=;
        b=EWOrlKJU+LjqRQ/uV9Xua9LvEAnJThp75klKQawBXR3MM0Z+lCfQZzsPiCp50MfMKn
         RrB3LHxP6lWHR8RQlk9SL2/wueb5grQcMqwigHiPfW8os7zYwv5SeTLb6G+whxDTtkF/
         RiTcqxJYXg7XbnnSYwkrDgauuEFFak+11Xl2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=QOzTr0839E3H9tR0wkETuj4b9U9VUvaitz4KI9/r73I=;
        b=yAGogi3lJQ7EnMpSWTLjYAWl2y8TRlz55VB91GTyLyl+GKOnO2amV2tnYQbJIGHTAr
         OyzYq+Y0i4htCcTMJudC/J1rvMczkNu1ndFX3a9UwtTpQTG6XIp7+ioojVmei/i3EgVX
         1L3oPiNFaKqwDlzslmeFKLqN4scAER58elyQNsopfiNGqdnuQpVyQTVWwcXe/fH9WaNi
         w8Qv+RphOYrJ/3ZrprIOb0WaqnMl5jFF1Py3CNOsLcU2fmauMjMt7RW+PUWugxynaBhL
         GZ7SUIneh+0PtszGnGrtgUzRB/GLArIHKQNf/fzs4+OXvKjdfyUGvhNFqHfv+QUT7XEM
         OYrg==
X-Gm-Message-State: ACgBeo2Ik2AsQsVYJL4lGmDg5JnMZluG3cI0RG4r+CsvfLjfC6IQ5AO2
        JQLXQ53OvxydLUZhKOci1+l53Q==
X-Google-Smtp-Source: AA6agR7ryAbaJQVqp1mJEckyrIip9baCtObI7dR5faSXw3AEvsfrQpKGzAcIiDq8Eww2LkxtypaSAQ==
X-Received: by 2002:a17:902:b68d:b0:172:e973:82b9 with SMTP id c13-20020a170902b68d00b00172e97382b9mr27132898pls.120.1661970241179;
        Wed, 31 Aug 2022 11:24:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79f98000000b00537f9e32b00sm9156524pfr.37.2022.08.31.11.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:24:00 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:23:59 -0700
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
Subject: Re: [PATCH v4 17/21] kallsyms: Drop CONFIG_CFI_CLANG workarounds
Message-ID: <202208311123.B3B651E@keescook>
References: <20220830233129.30610-1-samitolvanen@google.com>
 <20220830233129.30610-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830233129.30610-18-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:31:25PM -0700, Sami Tolvanen wrote:
> With -fsanitize=kcfi, the compiler no longer renames static
> functions with CONFIG_CFI_CLANG + ThinLTO. Drop the code that cleans
> up the ThinLTO hash from the function names.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

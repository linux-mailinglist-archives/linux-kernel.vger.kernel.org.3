Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33606527468
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 23:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiENV64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 17:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235601AbiENV6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 17:58:34 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4C40E68
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:58:32 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w17-20020a17090a529100b001db302efed6so10863497pjh.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzfWF5xEUyLdKqhX0/BNfMvKzUJWiSaq1KcpW14iYMw=;
        b=WUlUbVRF6tirwuKwDy2NkFQO/d2QfrAUOspNRkHBFDb8zh5PYzqPFuh8T5V1C13dXL
         LFH13+Od0CwiqKj4zQII9grfBvdPGnYi6BlF50c5YX57xB7aI063mkiBbOk+Ls4I51VW
         Ea82sWo3QQSM5HKAsah/AH9GJKBYLeEbbBlqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzfWF5xEUyLdKqhX0/BNfMvKzUJWiSaq1KcpW14iYMw=;
        b=Fl/ivjkMW8+RT+7AlIDcGc6zKLAPgxEUNvWAWqtfHBXXCSabHOfP5N8++9MJFU4hie
         bcCSjeNhbISo244a4h1knFD/jnMRiQi16glU+18viQ5S1ImrFph58ftYf4HBjDI7Fo1/
         pSH78qIzzbwnT6uPXIY+ZArhGf/4Rr+/KzzsogP/1l6fZHukWvfX4YzdsDNAd/xkYe4I
         HX+n4quRliy51ENQSU6S+dshLTBR0fscZUBnl4uYF+M7Z48AKxNKnkrGxsWgt9cz2vSp
         V5Ui61C8NPhXd9jc/U5H+ZtVctwv5aonKZYc7Lb2DM4rMLQ3D+FIXBEs/CE9PQarqtnH
         aTVg==
X-Gm-Message-State: AOAM531pY3c3nZqQN3UiYgM1KOiJdJvVGB6IuO7x7gwxErIIgs2rvgQu
        b/DBZcAqBIjHOUf/3lNFMlc6hg==
X-Google-Smtp-Source: ABdhPJwpfw7TbvPXHehxghPWQ4Qsa1e3wKrxEzkB//8n2/gpnFICcaugpHJZByhUFKa3kZET1C0iOA==
X-Received: by 2002:a17:90b:4b03:b0:1dc:6554:1bf9 with SMTP id lx3-20020a17090b4b0300b001dc65541bf9mr22748680pjb.246.1652565512306;
        Sat, 14 May 2022 14:58:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902650200b0015e8d4eb264sm4182146plk.174.2022.05.14.14.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 14:58:32 -0700 (PDT)
Date:   Sat, 14 May 2022 14:58:31 -0700
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
Subject: Re: [RFC PATCH v2 19/21] x86/vdso: Disable CFI
Message-ID: <202205141458.54A04805B5@keescook>
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <20220513202159.1550547-20-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513202159.1550547-20-samitolvanen@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:21:57PM -0700, Sami Tolvanen wrote:
> CC_FLAGS_LTO no longer includes CC_FLAGS_CFI, so filter these flags
> out as well.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

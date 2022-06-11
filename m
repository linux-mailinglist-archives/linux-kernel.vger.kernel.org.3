Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27C554724A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 08:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiFKGBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 02:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiFKGBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 02:01:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D2639A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:01:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so4627317pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 23:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3GFcFwqnFGmcRNmokcZ6QcxITcGcLvGSBnxe2xUhRi8=;
        b=IhYK9SJrhXq+qv1WiqB9FLLyFfKRj6/LONo25ON2I+xiq7D8kxxiuRj370SIb/01Km
         4gLaz5vOJBdR/vDD8jKvcf0cfGJsH0IormapMgd6vYFQTTxeSk0C9taU8BoZGD4Jj5fa
         4u6bRx3oHK3wCWS/+jm6BcndC/WKUqku29P2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3GFcFwqnFGmcRNmokcZ6QcxITcGcLvGSBnxe2xUhRi8=;
        b=zHoEEdE4NkwR1LbGk6k2wIzG1TWXh61bd8Qr5JtMgZv0aEiCLrEpHmCJBa6pl93SJw
         fsmGGWcustUnkglp2QpDCMhJqX7Qr5nWZXS0zKrbFWWK1WdpD3Ixuzja6m3CiEVslZfk
         PSlkQc5dSRL+u3mGqlfJahxvhCcW2myiVmMjGFV9X+lsu95OdYUjurPGXwqVGB+Xvrab
         uJ/ZCrVxuEgekNCFbQnrrYMZCupzlYVoMuX3hB88sNczv0/t2vtDxpJi5nVDe5U2Npw/
         E1i0DI2fvVxNvRQyJuM2bbJ+mqog3bIU5awkIpRxQ0k5JGHM/2XdftisxpAorzhcrqxu
         xucQ==
X-Gm-Message-State: AOAM530Lk4I+FxtniXc9jxYRQ5Jkg3fCwk5OcrsEibr/ZxGP0IN7PfPK
        ox63opnh7lyBK4ywRM+s5ZZQdQ==
X-Google-Smtp-Source: ABdhPJzinXa+z54InZrO9Ii73d7aTXsD66k55pj7PtXI/jz+hh/xNWPtX9cuYHlcPAVY6EjcgVgLAw==
X-Received: by 2002:a17:902:7611:b0:168:cb95:fd27 with SMTP id k17-20020a170902761100b00168cb95fd27mr1051867pll.126.1654927261517;
        Fri, 10 Jun 2022 23:01:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b00168b4b550f2sm726508pln.54.2022.06.10.23.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 23:01:00 -0700 (PDT)
Date:   Fri, 10 Jun 2022 23:01:00 -0700
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
Subject: Re: [RFC PATCH v3 07/20] lkdtm: Emit an indirect call for CFI tests
Message-ID: <202206102300.26A43F5D8@keescook>
References: <20220610233513.1798771-1-samitolvanen@google.com>
 <20220610233513.1798771-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610233513.1798771-8-samitolvanen@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 04:35:00PM -0700, Sami Tolvanen wrote:
> Clang can convert the indirect calls in lkdtm_CFI_FORWARD_PROTO into
> direct calls. Move the call into a noinline function that accepts the
> target address as an argument to ensure the compiler actually emits an
> indirect call instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

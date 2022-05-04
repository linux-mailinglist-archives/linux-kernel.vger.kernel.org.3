Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7651AD68
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354684AbiEDTEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbiEDTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:04:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAF02DD66
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:01:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso2017715pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xl/pKIUZuR+JiscXe+pokb1a3QJoLYKiFmIdj/hqZps=;
        b=Fdf3jKj5u00OGGeg7avF7vYubAJKBvoqvMqq/zRNDR9WlcdyLkzOp1nDU9WN6gkgjy
         jIyHnFJ5Kr1NXA89d1Z387Tey1dgGMGaFWw2Fb9X5g1pT7Pry+RHu1JhmTxqyiibm313
         87sB2sajTTycX2U8j10tK5Cu7zgIg5I5SZWKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xl/pKIUZuR+JiscXe+pokb1a3QJoLYKiFmIdj/hqZps=;
        b=T71ozTNqdnnnQ4ZdOhNljv7OIzngLXYrwCApfSGa/x6IaD1L+e+HowPHNBLJ1qbLOt
         q/2c1TbonWAYeYvkykrMSnGDzX/qh/62CY7Yz4KEWNHdo58sKKkDi3vZe/0o7HffTAkI
         Onelz6jut8HBXA5q0r9HBdG5aNUJHRAoi0qM8TcN1q+u9UHnQxoGbPcSCGsvI18srZ7+
         ZhF+XuhE2QxSUpZuolUEX233T1zRLQa4p98ckIpmZMKR63o2Qqy8WM3UWSPjbgaWsJV8
         OKnwJ0w07KG66HRzKon5fUV1X+rdBnWSNS2VwPq/ckvlARh7SvErnRiCOSgzn+/XRzDa
         pDSw==
X-Gm-Message-State: AOAM533u9CUoT0EEgHGRjd1/2LsMxpjNTidg8rKnbHSOhvY9qTVhnIzm
        WU+Z1G/R4hgD5ug/u3no0zvu5g==
X-Google-Smtp-Source: ABdhPJwMMQb1tcWcnJ998q1R95pZavFrOp3PLu2bWGwLmsAgxCFO56S72Ys0qCwwuW+s7pyVZjto5Q==
X-Received: by 2002:a17:903:31d1:b0:159:804:e852 with SMTP id v17-20020a17090331d100b001590804e852mr22992694ple.19.1651690872777;
        Wed, 04 May 2022 12:01:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ij21-20020a17090af81500b001cd4989feecsm3625006pjb.56.2022.05.04.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:01:12 -0700 (PDT)
Date:   Wed, 4 May 2022 12:01:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        alex.popov@linux.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Message-ID: <202205041200.147A737@keescook>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-2-mark.rutland@arm.com>
 <YnKsvNtIlE6cZEOa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnKsvNtIlE6cZEOa@arm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 05:41:32PM +0100, Catalin Marinas wrote:
> On Wed, Apr 27, 2022 at 06:31:16PM +0100, Mark Rutland wrote:
> > [...]
> > Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Popov <alex.popov@linux.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Will Deacon <will@kernel.org>
> 
> I thought this was queued already but I couldn't find it in -next. So:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Should this patch go via the arm64 tree for -rc6, or should I just carry
it as part of the overall stackleak series?

-- 
Kees Cook

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C7051062E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349792AbiDZSEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351468AbiDZSEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:04:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D326927B18
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:01:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y38so2920023pfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XRsu/ussswt/LIrflZJyacP4e2z+gM39yV+1fzyWCuw=;
        b=XLPvEl+krom+vUGXLLaM9U5FMvMXJDtCpmsgMIMmsaMdInWzeTqMzVZIuAysv57Ob+
         4X5WXx9T58lNI5xuusGfrtE38Ta1uE2xmgiTdklo/jLzQ8BLnvsyWxZ3lcudjHrGsSIC
         937A84Dat2VCWHdClpkuzhwjGY51zChKfOIig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XRsu/ussswt/LIrflZJyacP4e2z+gM39yV+1fzyWCuw=;
        b=Re+LC8nQsebzgmSZA70u5aeZr0SrRNdlMYj1LLgs+egSNWME88owEHQdWKwKNEWQ71
         FeF4EcRLw7WGd0GAZnQXBYALJuMoCwiNC1oJ9vVeern862s2B7o/numlRzu/EW3j+/fZ
         F1Hq4eYTULklOLWZ+XztYDdyLZsMhmVvd+ulgolJGcTu7aSvOIgbwcx3nA3YaB+wtn1/
         TNry60jp59gRjPRFteqQDHNRhn/TGWwsgiSwo1WhXzFxjGezHDp6fgnuaEhiHL1Xmf6I
         u6r21NzHypZD3qYDHFvwyycqFiCWg7USFMx6fmb2uxxXnJtmzx7Sxlk97EiJ6/CLRHhw
         5c2g==
X-Gm-Message-State: AOAM533RzWMsZZgJPtXLK6yikQmyO01YCUBrM+NvAHJpXdrqtwQns36L
        XlmNXa0Ozcn/f5xkwOjO4IzXVg==
X-Google-Smtp-Source: ABdhPJx+8k6RshbL4Qs3shYsjvDuW5rotWD+JQBa6tZTy5QcrmBBIBGpOAXKkMDhNkmcjxy8bxm28w==
X-Received: by 2002:a05:6a02:10d:b0:381:f4c8:ad26 with SMTP id bg13-20020a056a02010d00b00381f4c8ad26mr20497541pgb.135.1650996085751;
        Tue, 26 Apr 2022 11:01:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a784200b001cd4989ff42sm3408312pjl.9.2022.04.26.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:01:25 -0700 (PDT)
Date:   Tue, 26 Apr 2022 11:01:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, luto@kernel.org, will@kernel.org
Subject: Re: [PATCH 0/8] stackleak: fixes and rework
Message-ID: <202204261101.D3DC3333@keescook>
References: <20220425115603.781311-1-mark.rutland@arm.com>
 <202204251551.0CFE01DF4@keescook>
 <YmgXVwaYQ1Kn5+b0@lakrids>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmgXVwaYQ1Kn5+b0@lakrids>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 05:01:27PM +0100, Mark Rutland wrote:
> On Mon, Apr 25, 2022 at 03:54:00PM -0700, Kees Cook wrote:
> > On Mon, Apr 25, 2022 at 12:55:55PM +0100, Mark Rutland wrote:
> > > This series reworks the stackleak code. The first patch fixes some
> > > latent issues on arm64, and the subsequent patches improve the code to
> > > improve clarity and permit better code generation.
> > 
> > This looks nice; thanks! I'll put this through build testing and get it
> > applied shortly...
> 
> FWIW, looking at testing I've spotted a fencepost error, so I'll spin a
> v2 with that fixed (and with updates to the LKDTM test).

Ah! Oops, ok, I'll unpush the series, I missed this. :)

-- 
Kees Cook

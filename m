Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BAF4A89CC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiBCRUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352829AbiBCRPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:15:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3FC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:15:53 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d5so3009977pjk.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 09:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eCxgeYKdwlKt0oqnTuPB4zw2ANgtkFxZ4Jnzg7Jm2aQ=;
        b=c7TfdBKWq7b7RwXKegDo7mrxtFQaaMbFoWobJsoFragv/CCi7+NaQgykHUP9fODpAh
         zDUYUZfAmM6XrgVppNUw1Zuu90Gp2iASFyev8WnefWTyjFibflL2S1CNcWlwjQx2YLCW
         rvlQn7kFjydRTsZ1iGN4NjaGbVymOO3oSxaoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eCxgeYKdwlKt0oqnTuPB4zw2ANgtkFxZ4Jnzg7Jm2aQ=;
        b=jazdZBEM0gLKXHmFFn239hXVhSR6jrljEVow06UGV4c3RbGe7EZYuyMJvx9CrzbN3Q
         kEN6jZDRzYFwkXQZBu8Xdu3+jrA9uqlhISCAXFk9DDDVdhks8QGfdORvzStekEtfFS8o
         joutisFfhCNsVG/JuTBM5N3MBbUldl1o6QKLfHWPEwdt06STs8dS/0Ip9cSzxXLRCmw2
         PaojlgllK35Jn1joFNBb9upWeM3vrOkT+b8y74EeUuL9TlL1PDqhee4FizBR5FCSoera
         SRZ8E7gwXjqwq1+sWaWSBU4DfMIx7fInp/dYVrRf6ElCAagqo6JKPbV+IoYqp714okLP
         rIbQ==
X-Gm-Message-State: AOAM530nysi+x4mfDsHZH7RX554JSo83Knb79XWexmQJbYixBuRJ7yux
        kKKBC9IoXRSvD5nS4c69sFnyKQ==
X-Google-Smtp-Source: ABdhPJzJUGd7ygya4e6M/1Gh2HV6OhdW0Ix+MHxpkRCd4Y5gQDZhB7ej+H+RwMQeV6zcPMjLwU3ZZw==
X-Received: by 2002:a17:90b:3a87:: with SMTP id om7mr11784961pjb.196.1643908552517;
        Thu, 03 Feb 2022 09:15:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u18sm29699773pfk.14.2022.02.03.09.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 09:15:52 -0800 (PST)
Date:   Thu, 3 Feb 2022 09:15:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202202030911.4914709E@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net>
 <202202021237.487D3DE73@keescook>
 <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
 <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 09:04:22AM +0100, Geert Uytterhoeven wrote:
> Not if -ffreestanding, which is what several architectures are
> using nowadays, to a.o. prevent gcc from replacing calls to stdlib
> functions to other stdlib functions (e.g. strncat() -> strlen() +
> store, strncmp() -> strcmp()), which breaks linking if the latter is
> only provided inline.

Hah, for i386:

arch/x86/Makefile
	# temporary until string.h is fixed
	KBUILD_CFLAGS += -ffreestanding

This "temporary" is from 2006. ;)

6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")

Removing that appears to solve it, and appears to build correctly. I'll
continue testing.

> It works after dropping -ffreestanding.

I wonder if the other architectures were just copying x86?

-- 
Kees Cook

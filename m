Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2F46DF00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbhLHX0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbhLHX0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:26:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B9C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 15:23:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id t5so13905093edd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=12eYC9cttLky1xiGkzKZrN85X2r4m8IpTalt9bP6nHY=;
        b=QlyaI3Ku1W5hlIPYgHKuslvFHFWzLFTdq423Ieu6TH5hTrBvHrZGQLiAA0Y2A3UqnQ
         TG2uu6OZ6sCgGywg71Nlh1wTAbDV+IsC6OIoD9k0ezM3qWuscU/NNrsWdyyPvA/FdN3v
         hLMfADD24WDkzP3M92kz41O29cuWzDgIwUnAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12eYC9cttLky1xiGkzKZrN85X2r4m8IpTalt9bP6nHY=;
        b=oHmIAYEr1PSrSty/g5RMkP3YRHj39t6Fb11MFm2/TugEqnliLFULfd5y4w3mv9CwtN
         2ldD7RudnePBA5anwMxr8O7QZJFQWzRKEccnoO0L0oyOY2sivRf+QibHCQPmYQ0TYI0h
         ve2If379wFtsgsxLIohQYRDEMLfTvcN9ojyirqHNpW1mxkz0cKvYM2XwSdJoBvZeT0sC
         +aErYvjom9lhGjc1F12sJyxJBPH8RdiHr4lSGzv1LbpZY7ZAmm/t/DdQ1Xx67e+8ZZk0
         XUymS+doifkAkOp6Txq9c9mf5G4NZrbsszjRVFzSgrrt03HEAh7hDgXoRIUvqIQ+O+iq
         C9oQ==
X-Gm-Message-State: AOAM532cGOQay8AOIKyJDFMUrMxjZvev7ypGV8GpE+KP+GGwuC+DWhl3
        AS9YMIXEdFO3MTxaOWUwYy6mnw==
X-Google-Smtp-Source: ABdhPJwMP2aotTKfhTbOOW19RqP4FL6+EYSjrQ6GDEnSdFMsqfAKIE6z7H9WLhPIVqkR19LBd6CRYg==
X-Received: by 2002:a05:6402:d05:: with SMTP id eb5mr22956922edb.345.1639005791724;
        Wed, 08 Dec 2021 15:23:11 -0800 (PST)
Received: from [192.168.1.149] ([80.208.69.72])
        by smtp.gmail.com with ESMTPSA id y15sm2701371edr.35.2021.12.08.15.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Dec 2021 15:23:11 -0800 (PST)
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
To:     Kees Cook <keescook@chromium.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20211203100846.3977195-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <037c44cb-c5bc-9a9a-0c16-219bdf858ea7@rasmusvillemoes.dk>
Date:   Thu, 9 Dec 2021 00:23:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211203100846.3977195-1-keescook@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2021 11.08, Kees Cook wrote:
> It's common practice to cast small variable arguments to the find_*_bit()
> helpers to unsigned long and then use a size argument smaller than
> sizeof(unsigned long):
> 
> 	unsigned int bits;
> 	...
> 	out = find_first_bit((unsigned long *)&bits, 32);

Those call sites need to be fixed, they are broken on BE anyway. And
your __find_bits_deref does nothing to fix (paper over) that if, say,
the caller uses an u32 to store an 8-bit bitmap.

So NAK.

Rasmus

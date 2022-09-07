Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9153A5B0AD2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiIGQ6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 12:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIGQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 12:57:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105CBD1E9
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 09:57:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j6so10929147qkl.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=bzVsEFvOi3nSHTdMpS6nXLuMs4XDbeJqE6fT5/16cdo=;
        b=gAcmwcHdLlvOrAxJw+SJ83nMXkhFfWW3yMW+CEqGVi3z70+YfMOFt+WnV1AqSqCXtQ
         /deTP8FNJVVicypDwG/UhQ+pFp5oGTz/omH9WRSo23wdKx7HU+M1ekMZkj4dME4x4H12
         tWWpzC2OUZDDr6jlAojqZ21XCXjPFAAjotsGqyfNUiLAxGPPGfgLLIRpH8H2h6zcQ2AO
         ANLRY7L5bH5WFOxjxXgcZDJHQYkc7ziXO2Dre0+vfWAENeaRkAek+wuXrcYBfXwqJtqV
         wcz5l79wI5Ki+FOvDXXeX5Qaab9mxVKiIbpIPYUAhacHTZLFuHhifMWpCVEhFIaMRpYO
         Fz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=bzVsEFvOi3nSHTdMpS6nXLuMs4XDbeJqE6fT5/16cdo=;
        b=28z2VlKtZs9XE2nxiN8hiOnG2YLaBK9Ujwoqvn6Zezu5MSIxBpneoAxMNafINnbbpM
         QBwNm1k6fdnEYVdE50Id3xfqdkRFwNyJT5a8ZZZWohs3s1mplhTMqOuC0JJqFPsAWUUJ
         SGj6tAgWyZzqMz/12QQuLQKRykRMO0p1lZ98M8jczLVHwuUNSLsPQ4IO/wmlnWyLVbPN
         QAR6bBvQRiNM3X9iREPA34pEYNFe9qDsvzH8icS1GaKEAd6Wb/oGv7ceVUtA0ZIMzFss
         0+azlwYeahTx5o6hEIKY3H328AiWe65zyvTJfSOWHzH9QAcCMBZZNp3Qant1lC6pmfa6
         zd+g==
X-Gm-Message-State: ACgBeo2oBFH58fxfLdoUeM/U32M4yzogBZD5OfsLcSJWnwc6SzFnuAyx
        +F/gDl5EKVGJxgjxkqO0+Uw=
X-Google-Smtp-Source: AA6agR6DlXpY9cBFKFdzhIxBQYhDGCMuwh8A853HaHyY055SzPMDzOPAwhy21EiP99UbY6Jkc53dKg==
X-Received: by 2002:a05:620a:f13:b0:6bb:ebe9:d787 with SMTP id v19-20020a05620a0f1300b006bbebe9d787mr3284684qkl.663.1662569852024;
        Wed, 07 Sep 2022 09:57:32 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:2bb2:71a4:3b6f:3d50])
        by smtp.gmail.com with ESMTPSA id bs36-20020a05620a472400b006b9c6d590fasm13911534qkb.61.2022.09.07.09.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:57:31 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:57:30 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Whitcroft <apw@canonical.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] lib/find_bit: optimize find_next_bit() functions
Message-ID: <YxjNeqLjGgRPIm+y@yury-laptop>
References: <20220827175807.4017673-1-yury.norov@gmail.com>
 <20220827175807.4017673-4-yury.norov@gmail.com>
 <xhsmhfsh3b15v.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhfsh3b15v.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:27:08PM +0100, Valentin Schneider wrote:
> On 27/08/22 10:58, Yury Norov wrote:
> > +#define FIND_NEXT_BIT(FETCH, MUNGE, size, start)				\
> > +({										\
> > +	unsigned long mask, idx, tmp, sz = (size), __start = (start);		\
> > +										\
> > +	if (unlikely(__start >= sz))						\
> > +		goto out;							\
> > +										\
> > +	mask = MUNGE(BITMAP_FIRST_WORD_MASK(__start));				\
> > +	idx = __start / BITS_PER_LONG;						\
> > +										\
> > +	for (tmp = (FETCH) & mask; !tmp; tmp = (FETCH)) {			\
> > +		if (idx > sz / BITS_PER_LONG)					\
> 
> Does that want to be

Yes, I already fixed this.
 
>                 if (idx + 1 >= sz / BITS_PER_LONG)
> 
> ?
> 
> Consider this as used in _find_next_bit() for an all-zero 128-bit wide
> bitmap (two ULL's), providing the memory contiguous to the bitmap is also
> zero then this will only stop at idx=3, so that's fetching two ULLs too
> far.
> 
> > +			goto out;						\
> > +		idx++;								\
> > +	}									\
> > +										\
> > +	sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(tmp)), sz);			\
> > +out:										\
> > +	sz;									\
> > +})

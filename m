Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11BB597A64
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiHQX4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiHQX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:56:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB9E792D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:56:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo3202881pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=4OrW2+v/meyruGyW+F7E0QxnRsOWY9DMbrVML0RCO4M=;
        b=SW70luAxBAxmWF0xbo0vvoN6D+BfN/5VNbgtgMfh2yWVHK27yb+gRXhrCitMsILst6
         gd/i/FD7DU/GC9P22lC3CrE9jHgYvTSOlzKpjrsH/HNz8kK2s0HOT1TWY2m3B/AFQ5mQ
         ZkPwYxipcmkEq6CmCLwOLx4fAHP1DCRj2y/aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=4OrW2+v/meyruGyW+F7E0QxnRsOWY9DMbrVML0RCO4M=;
        b=JuWfEUhII1deAMHV4RVvZXfXbXVo1n3Q29OLomcY9SwRH2oga/wswYxRtA3oFYM+sa
         /IoiYH6xcYs0s8VYLygKExTJzXNdxOkGrw0RsC0vA0b01bsOwvLr1ySVS8wgJgm0dOrl
         dJjFOZgz2g0p8O1cvso1lzOhz2g+biMS1+26br/001ZbPGjhIEhOioxIjfGBQRIyazTZ
         D5/sO3XP2u4GSbSTz9NSw3LFDoVf52ZUPEE0a2XUNCP4m4u8DvWz+sGMKvUY1EesCGgC
         iG0MJ2GK44Wieu9fK/6i7rE9Oz0DyYg5KBIjlI7gNgayoSfyyqQJxzlFrIogTRtY5Umu
         j9HQ==
X-Gm-Message-State: ACgBeo381ZIY3HgS8HIBeMLt2ty9X21dFYreVZ84Y/8QH2nS9565EyNC
        ZDge5NDT0pOfG5Ln+Jva4A0X2g==
X-Google-Smtp-Source: AA6agR5mOI6zoxv/758RIIcFtuybDEtU4eRZmif+vY/WesxknhjDFh5Um9NhlfbeGGrs65ev9k85OA==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr6148774pjq.238.1660780564166;
        Wed, 17 Aug 2022 16:56:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n1-20020a1709026a8100b0016d33b8a231sm459784plk.270.2022.08.17.16.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 16:56:03 -0700 (PDT)
Date:   Wed, 17 Aug 2022 16:56:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Wei Liu <wei.liu@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 06/27] rust: add C helpers
Message-ID: <202208171653.6BAB91F35@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-7-ojeda@kernel.org>
 <202208171240.8B10053B9D@keescook>
 <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
 <202208171331.FAACB5AD8@keescook>
 <CANiq72=6nzbMR1e=7HUAotPk-L00h0YO3-oYrtKy2BLcHVDTEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=6nzbMR1e=7HUAotPk-L00h0YO3-oYrtKy2BLcHVDTEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:44:53PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 17, 2022 at 10:34 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Gotcha -- it's for the implicit situations (e.g. -C overflow-checks=on),
> 
> Yeah, exactly.
> 
> > nothing is expected to explicitly call the Rust panic handler?
> 
> If by explicitly you mean calling `panic!()`, then in the `kernel`
> crate in the v9 patches there is none.

Perfect. It may be worth stating this explicitly with the helper. i.e.
"This is for handling any panic!() calls in core Rust, but should not
ever be used in the 'kernel' create; failures should be handled."

> Though we may want to call it in the future (we have 4 instances in
> the full code not submitted here, e.g. for mismatching an independent
> lock guard with its owner). They can be avoided depending on how we
> want the design to be and, I guess, what the "Rust panic" policy will
> finally be (i.e. `BUG()` or something softer).
> 
> Outside the `kernel` crate, there are also instances in proc macros
> and Rust hostprogs/scripts (compilation-time in the host), in the
> `alloc` crate (compiled-out) and in the `compiler_builtins` crate (for
> e.g. `u128` support that eventually we would like to not see
> compiled-in).

Sounds good!

-Kees

-- 
Kees Cook

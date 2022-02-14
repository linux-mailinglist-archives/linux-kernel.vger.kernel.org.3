Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD34B415C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiBNF1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:27:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbiBNF1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:27:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A74E3A8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:27:12 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so2044346plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXSM5xdDFyWUNKhUzhGptRGBx5rWOK73GFZx/zWBRc8=;
        b=W+cv+jWGDhLxepKIENZltiKGyObGtaLgzPhCm6O+2RO43+buTJzScUzaDJH3nVBSnm
         CM1lBO75X+dlCU+rhpoWFNg/+/8j8QSwZz5QGKfp6Xp0nmwpwdYVjtfDgkTZyOVS+a26
         AyXMyNUvhOyYYoRMXlAZ7u1U8YMmA31mCS0Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXSM5xdDFyWUNKhUzhGptRGBx5rWOK73GFZx/zWBRc8=;
        b=V2S3dC51NKlyTB9bKZGqNo+e1++nqHf+mzj47Odjss/3NVcSEq9TGsG8T0OPaX3pOG
         M9xI0shRNyfptnONRWuMZ93+NA019MiEinezvG8g1VbRHI0QrDTfr8oXv7v4BfIeMx9I
         lK00kid+vlldykNm599Si0NobDBPNeMqwp3XV3Oc/uldCQ1dcRdy+/j8Sc6xNEV9Wa/M
         aXmx5u46dYRI/DYBeaAza6P0i/0VFGOgtNg6updz4imAF89xXu6SS1Sm0uzswNpXP8Fy
         3d84l+0RvchQacF58KaxPBnpaMqyI778BptkShvxTwiM4mt0I9AXv6jxmOaM0WSXJHtD
         ZPzg==
X-Gm-Message-State: AOAM533vrFQ1tLly2vEOh0t/yIuopZFG/Y/O4G/F26dzZgZxq9AEGS2R
        bmMEzDjFANWR6a3n1UZLT5ZSVg==
X-Google-Smtp-Source: ABdhPJwp381D0OvQj8raFZ4XntFgIip6ImwPAXBmKuFbZmBoIjsED5BQD4MLOiPxHMzrOwJlO9bL3Q==
X-Received: by 2002:a17:902:e74b:: with SMTP id p11mr12810354plf.115.1644816432102;
        Sun, 13 Feb 2022 21:27:12 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b736:df7d:23c5:206e])
        by smtp.gmail.com with ESMTPSA id w12sm18704725pgl.64.2022.02.13.21.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 21:27:11 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:27:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Dan Robertson <daniel.robertson@starlab.io>,
        Viktor Garske <viktor@v-gar.de>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        =?iso-8859-1?B?TOlv?= Lanteri Thauvin 
        <leseulartichaut@gmail.com>, Niklas Mohrin <dev@niklasmohrin.de>,
        Gioh Kim <gurugio@gmail.com>, Daniel Xu <dxu@dxuuu.xyz>,
        Milan Landaverde <milan@mdaverde.com>,
        Morgan Bartlett <mjmouse9999@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 10/20] rust: add `kernel` crate
Message-ID: <YgnoJ97y3I2hE8UJ@google.com>
References: <20220212130410.6901-1-ojeda@kernel.org>
 <20220212130410.6901-11-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212130410.6901-11-ojeda@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/12 14:03), Miguel Ojeda wrote:
[..]
> +unsafe impl GlobalAlloc for KernelAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // `krealloc()` is used instead of `kmalloc()` because the latter is
> +        // an inline function and cannot be bound to as a result.
> +        unsafe { bindings::krealloc(ptr::null(), layout.size(), bindings::GFP_KERNEL) as *mut u8 }

[..]

> +impl<const ORDER: u32> Pages<ORDER> {
> +    /// Allocates a new set of contiguous pages.
> +    pub fn new() -> Result<Self> {
> +        // TODO: Consider whether we want to allow callers to specify flags.
> +        // SAFETY: This only allocates pages. We check that it succeeds in the next statement.
> +        let pages = unsafe {
> +            bindings::alloc_pages(
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,
> +                ORDER,
> +            )
> +        };

[..]

Is this flexible enough? Why not let user pass bindings::GFP_* bitmask,
just like what the underlying kernel API does.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CE95977B4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiHQUME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiHQUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:02 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C2E66A4B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso1670937pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=HfC3dMpEngb7r9gnYszZZUkGHTRJbCSwAF6hsjZawl8=;
        b=VgN2NI+Ezj1YnwZA75qkUzO3odm7nQ/YsFK2soo32JnPYdtR6gEuOdUGqLBg8c5ktf
         fCo70wM3ALHe+y+fUNIROShP5H6+3xzGZPkl98pJmQZYK+HzHeTl7B8BF44BfwOOv+ir
         h+sT7VUYnSBUCMIx81qQvnB+TETrbRV0froDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HfC3dMpEngb7r9gnYszZZUkGHTRJbCSwAF6hsjZawl8=;
        b=t145910lC8qwfM4XaFg7rkdwvfJCt8xUtuHlhxisb46j2nCD8/7gaAMWTi/BjbH+DW
         psYqOP45+dQXE95upwHMP/A93+RVfiCyri8RUJ8Jpzee4j55jfMd/GBoaWjHyk/WzF0+
         87aiRJqcZTGxe7l1C8kggL7s11cIaJuAhxHRNn0z8kQP4vOM7vwcOKzmckchzNt2TczM
         CTEH41PpqdSXsTRKEWLzTN5rxTUBNP84nRTGThWmjh4O45a/lIxvpWaky/hz5abOJe8h
         xQJNJa/NszGCldym+UgkKrMNPXM0eBVJPf2jQmcRDTq2fNera0QCWpcGLfFPi8M9qTea
         51dg==
X-Gm-Message-State: ACgBeo2YmoYDObZNN8nwggCmZtEnh7txlBGNOqDOncWiRMXEuHdCILR4
        9vKE9/H0fk48NBHjw96n2+W1ow==
X-Google-Smtp-Source: AA6agR5O8XGj1uDOVttCpuLlRr7eJO5srWmKa+1LSIBXqFLAGYz3aii6rcP0HxPmAHhk8CX5FB3voQ==
X-Received: by 2002:a17:903:1246:b0:171:5033:85c with SMTP id u6-20020a170903124600b001715033085cmr27932780plh.146.1660767120719;
        Wed, 17 Aug 2022 13:12:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b0015e8d4eb1d7sm346970plh.33.2022.08.17.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:11:59 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:11:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v9 13/27] rust: export generated symbols
Message-ID: <202208171311.73A2CAAA6@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-14-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-14-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:58PM +0200, Miguel Ojeda wrote:
> All symbols are reexported reusing the `EXPORT_SYMBOL_GPL` macro
> from C. The lists of symbols are generated on the fly.
> 
> There are three main sets of symbols to distinguish:
> 
>   - The ones from the `core` and `alloc` crates (from the Rust
>     standard library). The code is licensed as Apache/MIT.
> 
>   - The ones from our abstractions in the `kernel` crate.
> 
>   - The helpers (already exported since they are not generated).
> 
> We export everything as GPL. This ensures we do not mistakenly
> expose GPL kernel symbols/features as non-GPL, even indirectly.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

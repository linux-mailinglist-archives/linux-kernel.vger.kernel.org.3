Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1A1597786
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiHQUJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiHQUIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:08:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3485D119
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:08:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso1612323pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Brs/W4+fSTjZc3XGeUQqrjHBcxapIUBaWsMZSunKKfc=;
        b=YPNhOtLwlDb4HPD9RTZwy4oTOEH6iqB1SNfZ97TmEKQIH5TTutZ/SSFNGRDCBbP5Of
         Bh6ZHZ/KjIPj4nnturarCUbcM5TZ/vLn3xh/zw+KAx+Z3q8pIrH+Ursc7X87Eb0jJkpL
         98eh82JWIMNnm7/j4obeXbcQ3GNu9oC/WfZaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Brs/W4+fSTjZc3XGeUQqrjHBcxapIUBaWsMZSunKKfc=;
        b=h6vLunqCygjeTOSEvEbdXB2EpTHXAln7jaJKvJAZX+H1f0vVIE7IAYTp6Qd73TQjin
         ICSjL0516fCRk4PT88/ptYbJ3eM34B4nCf9fBgIkmho8HsWhjiV78ADrOmBcGsS4aO8H
         0DTWFqtDkMsbLcpryTP5mr3zZLA9e46ABmXEeDqKI+S46wp7nHGeFuBvqSHXGqICpcGv
         3p/WOBXmrMO+oQnZIOCsYjNllzF28OpLO+sYwCoKHUt6aTfl/qPnrsKTE2PskMwq6rbZ
         UTHdW+Mzp/Wym9iz0AKLcw852jWpM9FOO4CKa0a12PAYzH2wXJpX8axKnxIIy6z8ls3v
         8t/A==
X-Gm-Message-State: ACgBeo2n5Y8pvtxgM2AntlSECWBmN+BDd8gt6Z3DVhJ3ZIrARcORNvGK
        /LyV36g6jRvHAZHmQWuiihHJHg==
X-Google-Smtp-Source: AA6agR5SxPib9LetocQRNIM3FEcdqnApbWc6q3KkvlCH2okTt3qzIUM/nSw2U1GR+l5CPPgg4k9fMQ==
X-Received: by 2002:a17:902:f70a:b0:170:c5e7:874c with SMTP id h10-20020a170902f70a00b00170c5e7874cmr27577177plo.109.1660766921931;
        Wed, 17 Aug 2022 13:08:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090a12c700b001fa9f86f20csm1943898pjg.49.2022.08.17.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:08:41 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:08:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 09/27] rust: add `compiler_builtins` crate
Message-ID: <202208171308.B9F3832496@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-10-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-10-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:54PM +0200, Miguel Ojeda wrote:
> Rust provides `compiler_builtins` as a port of LLVM's `compiler-rt`.
> Since we do not need the vast majority of them, we avoid the
> dependency by providing our own crate.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

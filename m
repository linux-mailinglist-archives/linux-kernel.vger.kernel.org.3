Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CB51E602
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384091AbiEGJ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383986AbiEGJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:26:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518CE4F450
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 02:23:09 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so9292361pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ocCDoyGiSy1GdWrHu5CjFRRUzgHkg0CZyH7/vS7PmVg=;
        b=PlI3z0yq2ISTxCAfw67M32w7ZLLVYK6FDfA1HHYzyBFcnRmEtCexMsELLaKsqrARGJ
         BbfNzbcN8Z3tAtL9lDmq7L21CmgLskN47R0GQEW2MlqoHKww78KcdOkwzrngw8d7YJPe
         K6AzBN3lSusWlmnqoTCq/K/l9L93IGgTF2hJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocCDoyGiSy1GdWrHu5CjFRRUzgHkg0CZyH7/vS7PmVg=;
        b=URzVGHKuZDDRJlEGXD8HubmAhEy9gaD/9q+05+WQIVuoW0GKLB/U7onzXe2NE4KGdM
         xgmFZs2YlPw68ABOlfQlgkDW2JCHMO1ioC7POJaDTX2N9SOMRdmdTFNCbMtkVa8tWswj
         +2Hy/kzJMEQ2eXZqxvXMBFCo8cnCYKWfhBaW9A+tW6s0k9Va4c+Yo1SGn0sinaLNBt+M
         SsJ2HXlEqUvXrtZNpFAzL041B99iu5IpUEOMMnSZzgXjgl9HdSrzjcobSGHyAmBaNp6o
         xvzmNgVTUVRpLdlL9CgBds20qpheN1vzHrmE1JJSqd1RMZQKcFP25xzxlBHzxTTiZhXC
         /h5w==
X-Gm-Message-State: AOAM5305yO0o49fp4wmMf0yzjWSDPS5buKQ5FhiWhc4bcgVd2R9xzCZE
        Qg7Zz3XGVDsY7L5Ir+EJ8U57SQ==
X-Google-Smtp-Source: ABdhPJyLHkvHes6TtzlOPrA5G3JwBYupi+1Lwa2I0beUXgtwuv2eqvmXIpSdBbj6R+57Q0uXuwlYNw==
X-Received: by 2002:a17:902:b948:b0:153:9994:b587 with SMTP id h8-20020a170902b94800b001539994b587mr7807093pls.68.1651915388553;
        Sat, 07 May 2022 02:23:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b0050dc76281c6sm4769532pfo.160.2022.05.07.02.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 02:23:08 -0700 (PDT)
Date:   Sat, 7 May 2022 02:23:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v6 07/23] rust: import upstream `alloc` crate
Message-ID: <202205070214.AC7C566@keescook>
References: <20220507052451.12890-1-ojeda@kernel.org>
 <20220507052451.12890-8-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507052451.12890-8-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:24:05AM +0200, Miguel Ojeda wrote:
> This is a subset of the Rust standard library `alloc` crate,
> version 1.60.0, from:
> 
>     https://github.com/rust-lang/rust/tree/1.60.0/library/alloc/src
> 
> The files are copied as-is, with no modifications whatsoever
> (not even adding the SPDX identifiers).

$ cd ~/src/rust
$ git checkout 1.60.0 -b krust
$ git submodule update --init --recursive

$ cd ~/src/linux
$ b4 shazam -P _ 20220507052451.12890-8-ojeda@kernel.org
$ cd rust/alloc
$ find . -type f -name '*.rs' | xargs sha256sum | \
	(cd ~/src/rust/library/alloc/src && \
	 sha256sum -c -)
./raw_vec.rs: OK
./str.rs: OK
./boxed.rs: OK
./alloc.rs: OK
./fmt.rs: OK
./slice.rs: OK
./borrow.rs: OK
./vec/into_iter.rs: OK
./vec/spec_extend.rs: OK
./vec/drain_filter.rs: OK
./vec/mod.rs: OK
./vec/set_len_on_drop.rs: OK
./vec/is_zero.rs: OK
./vec/drain.rs: OK
./vec/partial_eq.rs: OK
./lib.rs: OK
./macros.rs: OK
./collections/mod.rs: OK
./string.rs: OK

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

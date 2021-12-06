Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97846A0D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382090AbhLFQPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345069AbhLFQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:14:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9BC04979D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:59:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso10774207wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qKFLPUKAa7OWKjD98YceVg+3L0lW6XY0YaSbke6RvEA=;
        b=BZmRiBSmEjX1xv6jlNmmKweTonCeu0/GTdnWKR4xPldXRrloeFZZV2AbOUMrK5LNFj
         1ZJ4LC7vE0c1+qTRprn+Wa0CDQmOIKVWEOWJGayNSTEeHAbEmMGToeMrinnZf4AOTPjQ
         /bOKn7R6kHCjttxXgkpCQOkBKrByqhiwH/tsXIuIgC1Nl3a4ZsKW+GaHLgE6YozZEgJm
         8pkOT9wWpu3pt/uVSY5axVfyMn9UQOnkYok1UMnDa9OTzeO48hpUSejPiwbi2cu4Jx3l
         GBvJ8sEYc5IYXaEVE2IUDpo4hplXBA6jdPOUbLjXWv8qjTtOo4n15Cuz4MTsWOQZGpri
         +wdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qKFLPUKAa7OWKjD98YceVg+3L0lW6XY0YaSbke6RvEA=;
        b=fR/guyWvKSUtaepNTInwlzIsjCiVWLyaP7bjn7oqTK25M2Y4OwWCO6Kc6VRHI5xtHm
         4pRHRHStgUPGYrwCTY8eOwaKIzK94zjAXMbv+DpNoJeZiKrobn3Z/eMN8ESqMDWYbYJ3
         HqPs4I1FU+ro+wSzCmLU0DstWZ49mhKzPxwjHGGzmJyKPwGoPf6Ujovr7YkBVmXKC5Ss
         CaWT0QqiTuxO//Qk32snLPLd48/qqWDXXtqMo71KLklF48ISx8f/dWR1AzCnQ1rCIxpG
         ged9ssSzA6qrEliMrOEZO8uKhTi5YHPQK1psypwaEFhefpGxCJgGaeLjPJ0Y5BGueGZc
         Uuww==
X-Gm-Message-State: AOAM5304OBmpIVuTySEx1Zn64MGyJbginH8TS+DGI4zQBxJr960QGq/o
        M+ItVDOWTElabA31tx6OaznG
X-Google-Smtp-Source: ABdhPJwnspMRmoyUi4srXnq8Tw3fHM2QuYOgprN9iorBNAKCjrVCTJvypFqIsV83vgw7o9fkQ8qBBQ==
X-Received: by 2002:a05:600c:2292:: with SMTP id 18mr39943412wmf.6.1638806390069;
        Mon, 06 Dec 2021 07:59:50 -0800 (PST)
Received: from google.com ([2a00:79e0:d:209:5566:e6d4:87df:ddb6])
        by smtp.gmail.com with ESMTPSA id v15sm12195776wro.35.2021.12.06.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:59:49 -0800 (PST)
Date:   Mon, 6 Dec 2021 15:59:46 +0000
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Wayne Campbell <wcampbell1995@gmail.com>
Subject: Re: [RFC PATCH 19/19] drivers: android: Binder IPC in Rust
Message-ID: <Ya4zco0QFG0K5kO+@google.com>
References: <20211206140313.5653-1-ojeda@kernel.org>
 <20211206140313.5653-20-ojeda@kernel.org>
 <Ya4lu3k9HxLRe1Tv@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya4lu3k9HxLRe1Tv@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 04:01:15PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Dec 06, 2021 at 03:03:13PM +0100, Miguel Ojeda wrote:
> > From: Wedson Almeida Filho <wedsonaf@google.com>
> > 
> > A port to Rust of the Android Binder IPC mechanism.
> > 
> > This module is a work in progress and will be sent for review later
> > on, as well as separately from the Rust support.
> > 
> > However, it is included to show how an actual working module
> > written in Rust may look like.
> 
> Have you all tested this against the userspace binder tests?  And is it
> up to date with the features of the in-kernel binder driver?

Very little has changed here since the last submission, namely: using
credentials for security callbacks, and replacing `Arc` with `Ref` (i.e., using
refcount_t to manage ref-counted allocations).

As the message tries to indicate, this is submitted as an example and WIP, it
doesn't have feature parity with the C version yet.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462EE5977C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiHQUTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiHQUTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:19:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814966555F
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:19:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso1638286pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+9Z/XZXm8bWOMYUazydkN2TVLsN2UeYG6ew3OjVi5qI=;
        b=HpHr/iQWB8WX4st3J64DaE0zM5ARTp02+45sJ5vZkelInM1TFQd24iBXDcg2aI6nJP
         FYbx1aNZdvP+HDvfVwboRXgM3PEgO7zeXFhGMwijY9NPzha4Y8KbJzlh7urNTDLZPwqM
         arxCmXCejqu5cxWkFnYtIAhUlMYrjzHqOQ24c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+9Z/XZXm8bWOMYUazydkN2TVLsN2UeYG6ew3OjVi5qI=;
        b=epVgk8KMYJnrRImd6W3SOfS05Jn64JjZ6NiQLgISslCJiHVDx0lOkicf+3N9eKaK/w
         e0wXjHt/vVpxLfcs8NItGC32X67z8H/tEYYEf2gUOnuf/rx9KIEWqMTdx/jllUifzAoY
         xqgcjWTdGVx92k4rh6eh9dXCMISba41MoAuqgGSqhAY6Hzuau+P57V1YFcxVCmThTDOr
         jz3ocrQmtSdTBDeJ/keiRoO/b00wryCplnYfYmLnKHYPQCJzmUcfKyiuA/SQccerpey+
         ajJnNlazmtKo0gCX4Agq6cJrhWuLEgJSsISoKg21gDSY40S1pB7MyeK8UdFBSGvl8F1m
         Njjw==
X-Gm-Message-State: ACgBeo1bj9jh9ihMMBvt9CJ+hSFK7xqclbjm/sRQbBz/8K+3U0WkvqYY
        rgcXQV8D+bjZetOtNy85LMaRqQ==
X-Google-Smtp-Source: AA6agR7QY3W0ZMOeQxTs1Yg2FjXLJvBUDKldZveBa2NF4s7r4sgSa2kskTzcL5qA6NGNdrvGjfHJrg==
X-Received: by 2002:a17:902:8f8a:b0:16f:975e:7c6e with SMTP id z10-20020a1709028f8a00b0016f975e7c6emr28503738plo.136.1660767569016;
        Wed, 17 Aug 2022 13:19:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q200-20020a632ad1000000b0041c30def5e8sm9819384pgq.33.2022.08.17.13.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:19:28 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:19:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 21/27] scripts: add `is_rust_module.sh`
Message-ID: <202208171319.AE20401@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-22-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-22-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:06PM +0200, Miguel Ojeda wrote:
> From: Daniel Xu <dxu@dxuuu.xyz>
> 
> This script is used to detect whether a kernel module is written
> in Rust.
> 
> It will later be used to disable BTF generation on Rust modules as
> BTF does not yet support Rust.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

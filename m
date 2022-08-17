Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA275977E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiHQU1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbiHQU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:27:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA01A926C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:27:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f21so966190pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=e8AurnYaw5w6q42X379tvVxdUwxeEA/mYjtAY47a6po=;
        b=aLY/bwswAmyWGmv+4JEwglL+yZmZSkY5uTI10+jNpMXObxnDHYBy1/NFE6oNgiy8gm
         8M7QxAggsLjoXwN0tKrViIKk34FBRU2jjAG7OmyyvJlon3HbSz6RYHrCeWoKD7s7v+ey
         WBXTu2wjGczVnm7NC9ChqKPe87n8jYbCFqs3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=e8AurnYaw5w6q42X379tvVxdUwxeEA/mYjtAY47a6po=;
        b=bCCdnFm+Pn70ztRi68RdRl+KymQClLHrNDDUBpuOGvm7XnGQZKiQBhUu0BREQih9uc
         3XsnbXV21bZc7aQbLbWPuF1hVp1dIU1NUl/qUdkwifIgXqRG7b2NVazWgR2L1dxHSaMX
         tk/8M7l9NBJHiPpyZYlj/0kQrpLCWvSxtcHkoUJxR6c2kiI/Wa4YU6iVWIf23vFhs46w
         PJzzOH0vybHnUCM0XMiomdd/cfWmP0oTCpbfAwplFQklYajsKJzdWnotC6akXqztmtdq
         9SoZvj29/dEM1QukVvDdYdCSSHkWAXkJKvW+kFSKKbIHuOXsY7u/sP72xnr6Nar9o3/G
         i04Q==
X-Gm-Message-State: ACgBeo2sb7+wu+1JhR6mRqmJLwMvg9ZgChuXazbeEW3+9rPz1myAQaZK
        qWl6Shcwc/Tcm7gzmAFtdUzc7w==
X-Google-Smtp-Source: AA6agR5S9YLS9hTLBjiPpJ4Ms8k04xxDQPAV7b2x3cjD+0b+HLPqSTmwLa6D1Y6x82x152TjEZlwVw==
X-Received: by 2002:a17:902:cccb:b0:172:60b7:4590 with SMTP id z11-20020a170902cccb00b0017260b74590mr20507691ple.152.1660768058582;
        Wed, 17 Aug 2022 13:27:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027e4800b0016efa52d428sm320362pln.218.2022.08.17.13.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:27:37 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:27:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v9 25/27] x86: enable initial Rust support
Message-ID: <202208171327.EFF61F0E@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-26-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-26-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:10PM +0200, Miguel Ojeda wrote:
> Note that only x86_64 is covered and not all features nor mitigations
> are handled, but it is enough as a starting point and showcases
> the basics needed to add Rust support for a new architecture.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

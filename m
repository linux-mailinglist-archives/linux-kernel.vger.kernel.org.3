Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F1951CCE9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386921AbiEEXvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiEEXvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:51:18 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285D9606FA
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:47:37 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so4885805pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WUeD15hPWbE9yoLCSewnQRLeJEfOMbMnHsMRj2V00MI=;
        b=ON7D9twBBGASskVsH0epWyeWeUqtfI88ck8O2HvE/k9j7Qb7o5myuFABitL3ivhnIT
         EoZN9A1DoynAHqRGxK5iGEa+7s677dgUgnLNRpZF5iUJNhtYWiCY4ny0yfTYb1r8v2RC
         NCEPlv2z8Oa5dnRQTMIypfwSzHsTnXsjPOUY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WUeD15hPWbE9yoLCSewnQRLeJEfOMbMnHsMRj2V00MI=;
        b=Ga+4bslu5KM4qsLXDBsfWf8qcan55/Vjps5+WPgPzNXCWFKOG59oNCq2QI+bLjyTDF
         0x081UPbyCm8yG0TuFAASFuFNpjOL3Zjn0NP4GP3q5tKwY+9JqgOOeahJHXEA/26WJBb
         QXCw2NJo8AT4uovOphU9QNAP8oVB9YJ65ZxfvS16G1ukQkP/kKxanywHUzm/npfdPgk9
         4pCrrUAcIuc4oc/PpKPKo4bIYy6GO7KTLWgnUWa25DACT7dLI6w23lEjCRlSM7U3/8kT
         4mQ+jxz8t+xqBjJRlIrqmHlf3L+z+Jtn4kN3yE9BXJXdxpLdTdb0/HHtjJ4s+RDM1YYa
         UiFA==
X-Gm-Message-State: AOAM533kEM3QCBiRQPba7LfOp8MRYVhJ37/hanTGkzTZfoYHb/xYCZCr
        hL94lf0yTOhNm8bHZJqYOrv0Gw==
X-Google-Smtp-Source: ABdhPJxyJ0ZpbkWIDIluufCjLB0tfv4b+F5mOal0GQQ/EJ3ziZkOuCJ8ouhAePZE/2nYXlvy8g/kww==
X-Received: by 2002:a05:6a00:1805:b0:50d:ee59:b579 with SMTP id y5-20020a056a00180500b0050dee59b579mr777129pfa.70.1651794456576;
        Thu, 05 May 2022 16:47:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i27-20020a63131b000000b003c1b2bea056sm1864488pgl.84.2022.05.05.16.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 16:47:36 -0700 (PDT)
Date:   Thu, 5 May 2022 16:47:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, Song Liu <song@kernel.org>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Vernet <void@manifault.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v1 2/3] kallsyms: support "big" kernel symbols
Message-ID: <202205051647.B5839507@keescook>
References: <20220505191704.22812-1-ojeda@kernel.org>
 <20220505191704.22812-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505191704.22812-3-ojeda@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 09:16:44PM +0200, Miguel Ojeda wrote:
> Rust symbols can become quite long due to namespacing introduced
> by modules, types, traits, generics, etc.
> 
> Increasing to 255 is not enough in some cases, and therefore
> we need to introduce longer lengths to the symbol table.
> 
> In order to avoid increasing all lengths to 2 bytes (since most
> of them are small, including many Rust ones), we use ULEB128 to
> keep smaller symbols in 1 byte, with the rest in 2 bytes.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

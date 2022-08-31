Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC64F5A84B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiHaRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiHaRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:49:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B27D0756
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:49:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 145so14797139pfw.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VFkJurdbJUTCWb5htdv9XL8GXl+ooHeGwTuU6qvLebw=;
        b=VostS88Kk2T9x6tzKXLo0TDqNIb1gPQ3/yzR073wKLNexwMTG22DFuQ+O6EvlCnOd/
         OgcP5p9wktNxFostue0wrRjsLrG7khl70oMXkKD0a01OaDu6xqWF9GcUVBxHL22V6uPZ
         SzGoOnicvDtJasw1c4prIQQ8Lu5uYdlCrU2WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VFkJurdbJUTCWb5htdv9XL8GXl+ooHeGwTuU6qvLebw=;
        b=M6tFHDVe0g3mIafoQrPZfHn5iX5qHeF3kRG7xE3sFp0G33OlsUQlpx2FEP6lleavnP
         nwIdDFPtJvPc9P5i9u6xg++cKV9utUKJt5lhNNw6SWnX9XRnbripSssgHJk0Mp9qNYxr
         vR/IkNQAeWNQrD/3Zu2ahxybN1qiWrbx8A1rZx09YpceIDi6MMpVMZZ3rbZX3TBZRm0S
         C3Plef/MTJ4Zb4kL0wWDEufEp9k1+c/VTXe444V4GZWb+FwqXj1+GkQDcTfFPN99Rvj8
         QyYbTcSNR9i1RBW9clLoytlOOAkQlYqRQpra7DDSvf9GwZZqCmzuRab8K+C1Q4FseVmd
         3T9w==
X-Gm-Message-State: ACgBeo0hLSpBop5nOW6vumDJ+1TXciQ0BmcEaGGMBXDpmGhaiuaGb4AD
        pv3hgP/eIwjpkOHpGC1gbWju/A==
X-Google-Smtp-Source: AA6agR6daGH4O55c1EA2PgDANyYrLnYplMbFqZwe+Sa2xZJSfsxf22bpjN5zJ9lCWZGLXIpgNqWdKw==
X-Received: by 2002:a63:f011:0:b0:42c:7687:7322 with SMTP id k17-20020a63f011000000b0042c76877322mr9329970pgh.126.1661968148965;
        Wed, 31 Aug 2022 10:49:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b0016d3935eff0sm10016902plh.176.2022.08.31.10.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:49:08 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] overflow: Allow mixed type arguments
Message-ID: <202208311040.C6CA8253@keescook>
References: <20220830192147.47069-1-keescook@chromium.org>
 <787894a0-b1b7-43c2-c509-f246f94f58f7@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787894a0-b1b7-43c2-c509-f246f94f58f7@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:52:32PM +0200, Rasmus Villemoes wrote:
> On 30/08/2022 21.21, Kees Cook wrote:
> > [...]
> > + * *@d holds the results of the attempted addition, but is not considered
> > + * "safe for use" on a non-zero return value, which indicates that the
> > + * sum has overflowed or been truncated.
> 
> I don't like that wording. It makes it sound like there's some ambiguity
> or (implementation|un)-definedness involved in what the destination
> holds on overflow. The gcc documentation is perfectly clear that the
> result is the infinite-precision result truncated to N bits, with N
> being the bitwidth of d.

Hm, well, I think use of *d should be strongly discouraged on overflow.
How about just adding the specifics to the end?

 * *@d holds the result of the attempted addition, but is not considered
 * "safe for use" on a non-zero return value, which indicates that the
 * sum has overflowed or been truncated. (*@d will contain the
 * infinite-precision result truncated to the bitwidth of *@d.)

-- 
Kees Cook

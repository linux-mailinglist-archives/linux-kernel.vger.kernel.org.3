Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCDF4A8F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiBCVEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiBCVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:04:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D616C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:04:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o64so3564942pjo.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AXCyJIfbpLGxYBIbWAc7Goy/U+/enGtkfIUDufgG5no=;
        b=RN+nNTd2KY08ojmx+rurrM8Bco9OeNs0WRScp2CK+r9LCNzp64NTOEMjXnQVm24qyo
         wO7H8nt7ZgWhWAxYuOVShnWUfDiM9/1AiVV6vNCyTVEdoHah5R8ZjkopBY+8uUL+h7Eo
         pOaE/TaH1Ss7lgkxTUQQORRBFTEXe9mi1T54M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXCyJIfbpLGxYBIbWAc7Goy/U+/enGtkfIUDufgG5no=;
        b=WFIKxB8DTRM2T4YkOoWtF2f9kHaWW8/9Vu89PfsqRaPM5V2GLA0rvMBEDAuE4iJXNR
         tQJkU6w764VIPHwWGiWOE8Q3KwQHQFsGAcDYr/j9pIglkGDr03ESscD+G5AQ1KYkO3oj
         6toGqslJ+F28dtoaPGHFGMpELgvuYVBqqVWJEo/yuVEolkgcKGRlCd+TNqIFzby1MWAd
         FAeq9YSZcj9uutGBZ0438TkuxzJP17oFGs26J6gCDYZC0c18bal0jdcSvKjdFMlzHqXY
         ybg6etbwyJwFb7k1ar1DJzS5rxbvDDPm3r1wmqmQU6WAu1ztRCWQszxWstS++FcN4bgp
         BTSw==
X-Gm-Message-State: AOAM531X8Rhh1WiYPW6I331/fytWK4BI+8SeYxLGLdDpbwVBqZTz8T2X
        JeHOH6uBYkt0t8yLT8TwCdzY98IB1fcZ7Q==
X-Google-Smtp-Source: ABdhPJzHdXzL/QHbPAYTIAbR5kUmDhbNvKJm0lPvrYqdexCUwxFUHuGjIxkP9nZ73WuTSjfPXxN9BQ==
X-Received: by 2002:a17:90b:1d0a:: with SMTP id on10mr15687871pjb.167.1643922253959;
        Thu, 03 Feb 2022 13:04:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm18049411pfw.86.2022.02.03.13.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:04:13 -0800 (PST)
Date:   Thu, 3 Feb 2022 13:04:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        George Burgess IV <gbiv@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6 2/4] Compiler Attributes: Add __overloadable for Clang
Message-ID: <202202031301.437D8FD3@keescook>
References: <20220203173307.1033257-1-keescook@chromium.org>
 <20220203173307.1033257-3-keescook@chromium.org>
 <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkU=5q-7Sb4BKYkRsigy_qYjo_7J+A73ZYKn+xArxUwXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2022 at 12:26:15PM -0800, Nick Desaulniers wrote:
> On Thu, Feb 3, 2022 at 9:33 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > In order for FORTIFY_SOURCE to use __pass_object_size on an "inline
> > extern" function, as all the fortified string functions are, the functions
> 
> s/inline extern/extern inline/

I will update that. :)

> 
> Yes, they're the same thing, but it sounds backwards when I read it.
> 
> > must be marked as being overloadable (i.e. different prototypes).
> > This allows the __pass_object_size versions to take precedence.
> 
> Is this because of the `const` additions to the function signatures?

That might be an issue, but the *real* issue is the implicit mutation of
the function into an inline with _additional_ arguments. i.e.

char *strcpy(char * POS p, const char * POS q)

is really

char *strcpy(char * const p, const char * const q, size_t __size_of_p, size_t __size_of_q)

(i.e. what I was doing with macros, but all internally and still an
extern inline)

-- 
Kees Cook

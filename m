Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940E949FFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbiA1R6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244505AbiA1R6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:58:18 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B739EC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:58:18 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z5so6760371plg.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 09:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qMBeUtTGoBAaUmn8ulylEeU3TILxfDlpE26BBKiNnGY=;
        b=J7fuSAhEvpVepqu4bHtpGok7OuYMF9RjkZNrGHmNgrE3z94rFzSezvXY1VOwIJRPne
         HDraILoeB+OqGPXAMfYrq42DJ1VEKRhNZ5KbKSdVW71X/qYEYlKw9piEK2FL2LkgD438
         fhLhq8AjSchO7gxQu78V/tqZ3W0KAYttERvW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMBeUtTGoBAaUmn8ulylEeU3TILxfDlpE26BBKiNnGY=;
        b=5hBw/wRYJ6c5m596LSecKORH65VD7Me7FvI9yZJY8V3Ws15+pNU7yZalqf3DuIzHBr
         i7zHIu3cDWatvmqVNskeSxH99BeubNSd5Af4QgsU6Gu/TTNeMXZj3bEMAZQwwbY8Jo68
         9mUVX63yL/tcp+151YefUczeLO923I/yT5Ut65Y+cs5q/sAYnVUgA5cfELvYNEGQy1Kz
         lUz+NJblff0ayl9w/EZ2Kvp/VtsbPLOqvKjsj/o3X3czNRUgWKTmzB3r/8E6s9JqXuAd
         TAHva8vzHePFgKLtqE3sRjs2yXQMS2ge1YrOoTe/1d3HIGFzOwTqt26qq4TFtNLAm2A1
         ixbw==
X-Gm-Message-State: AOAM533DVkAaCcbF9cxIuixExOAvx04cmomaRcLtvV1FJv6PAMJzngoW
        RchwzYyF8Tp54xIbNQnftm/Mvg==
X-Google-Smtp-Source: ABdhPJx5tvndvTY7lS7GUegKk//TLoB/LnrEz7voqsYYRocSw26tJo+R5gzx4F/9MEcP+wqMwA5t9w==
X-Received: by 2002:a17:902:bf0a:: with SMTP id bi10mr9948941plb.164.1643392698276;
        Fri, 28 Jan 2022 09:58:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm5893755pfo.11.2022.01.28.09.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:58:18 -0800 (PST)
Date:   Fri, 28 Jan 2022 09:58:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-mm@kvack.org,
        Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] Revert "ubsan, kcsan: Don't combine sanitizer with kcov
 on clang"
Message-ID: <202201280957.562D6AC@keescook>
References: <20220128105631.509772-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128105631.509772-1-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:56:31AM +0100, Marco Elver wrote:
> This reverts commit ea91a1d45d19469001a4955583187b0d75915759.
> 
> Since df05c0e9496c ("Documentation: Raise the minimum supported version
> of LLVM to 11.0.0") the minimum Clang version is now 11.0, which fixed
> the UBSAN/KCSAN vs. KCOV incompatibilities.
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=45831
> Link: https://lkml.kernel.org/r/YaodyZzu0MTCJcvO@elver.google.com
> Signed-off-by: Marco Elver <elver@google.com>

Yup, good to get rid of it.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

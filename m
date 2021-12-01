Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514254656FF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 21:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhLAUWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 15:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239682AbhLAUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:22:34 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F6FC061748;
        Wed,  1 Dec 2021 12:19:13 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id l190so24784676pge.7;
        Wed, 01 Dec 2021 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WdZzR4ZwLQ/TO4QlfXg+7Dzk3T+tkZakBeW+NfWpvrg=;
        b=kmU2JDT4I5HdgFl5D2Knq8PJ5nq2rZKjMD4a9/AZpYBX1/qTcPLS2jTNPyn2yufs1R
         ry7z8eCGJcgUQ32pNhik2Usvhr+vjzI90aINnmMjV1qSe29yKEjZRR2U0WXK7VG4V/ik
         SIR25EqMO9JBGmamZGRHrw00rP9hRBpcyuM8yh+5ksAgPtlMtYOAEfPsydFOkBZq5s53
         jQMcsKE/JpMUa16hk65zpkF3TBuO5E+5JtKEBTVjH9ux4Eij/4LJu+8jHHh8sMqntEBw
         0csBv+6E1bfMoSrQ5bwsEXhEwp+pxP1QWRDnk3oho8PIRu18Hw5q2Kulg33F8CQynrm3
         jOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WdZzR4ZwLQ/TO4QlfXg+7Dzk3T+tkZakBeW+NfWpvrg=;
        b=63uETetYACGRmJBWXaa8zbBtb4zYNZf0kJSakcGLOFW+ixdlwjbGZiQRiTMt8QFYN9
         xnS9tEzKpJ0xKCk9vFgltdkNO/rqABSR/jKAXfao6qqpkAYXkAGmJ2XgvL7qCvDscC4C
         +DjNuAjV2S6FNwvkNzcVzKPTi+lS01V+6hg7F/jOn/GzkS2bQg1rQUB86HlfcKxWS7RF
         nqA+F64RHsao7GlNoNT5mbQ6Yr+hAAlhFMMU+JXhaIs9e9TsFtSROZ++af4jkVIkyer1
         lhSqQLoHhGjjXGZmDj/Y9Ybn4R1QWI6ApjU4iXGRWX+nRIHnZFIAjYlZC5jG16HHSndn
         UKGQ==
X-Gm-Message-State: AOAM530I+jS6bLLzIYNwroHEgKl8pIxxKqNPapfQzwqj7KmPP5EvrSzV
        TzCUaNrXck0T+x++j4aTRalJ8lTdjz4=
X-Google-Smtp-Source: ABdhPJx77VGIJjFiA7bC6VJsxHbkIrCTYHxRGgN6jfIIoleNM0B9IgbTLgPaZ6VXHgQripk91K3i4g==
X-Received: by 2002:a63:470c:: with SMTP id u12mr6347917pga.133.1638389952277;
        Wed, 01 Dec 2021 12:19:12 -0800 (PST)
Received: from google.com ([2620:15c:202:201:d65e:d674:a6f6:68e0])
        by smtp.gmail.com with ESMTPSA id g7sm671982pfv.159.2021.12.01.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:19:11 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:19:08 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: add in-kernel support for decompressing
Message-ID: <YafYvA5JWMgb6PVy@google.com>
References: <YaMYJv539OEBz5B/@google.com>
 <202112011112.83416FCA2C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112011112.83416FCA2C@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:24:35AM -0800, Kees Cook wrote:
> On Sat, Nov 27, 2021 at 09:48:22PM -0800, Dmitry Torokhov wrote:
> >  /* Flags for sys_finit_module: */
> >  #define MODULE_INIT_IGNORE_MODVERSIONS	1
> >  #define MODULE_INIT_IGNORE_VERMAGIC	2
> > +#define MODULE_INIT_COMPRESSED_DATA	4
> 
> bikeshedding: adding "_DATA" seems redundant/misleading? The entire
> module is compressed, so maybe call it just MODULE_INIT_COMPRESSED ?

OK, or maybe MODULE_INIT_COMPRESSED_FILE since we are indeed dealing
with a file?

Thanks.

-- 
Dmitry

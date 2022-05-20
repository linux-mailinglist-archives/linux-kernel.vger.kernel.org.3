Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D286052EE9D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350550AbiETPBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiETPBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:01:32 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC828E17;
        Fri, 20 May 2022 08:01:29 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dm17so6844032qvb.2;
        Fri, 20 May 2022 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vGSFw4jrCGm9RPAsfuC4fmNcgR0RxqeW32e009JQSB4=;
        b=TlUcoGdfUbihXYBfXozqertJmke3JAAv6o2KAwELU1DMexACOHHGkM0bx3xSY8QEYN
         LHwg0ffGKqXSVnsDS+0W9PInvxdvSr4bCTjzDu19nb+T8ydYDHgksYmLddf0z1+g1Ydr
         pFbaVayMj3muDpnzdQjMuYl+qPRCTYTd51SAcq4bUPpqEliBAhaWFVDlqusa02PrXnXI
         NrcyDJsgbIELDI7Ri2sww+H76I1nqyKko1xeK6qD+R/2Fk8bJs5SyqFDmQT9AlKdzbCQ
         7jpJJFlMIZ9kGu9LvEIsSQrP9Zw9i5Sg8no8yb+qLqSSeVRihBmVAjHOHR0VMdrjG7lT
         gfjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vGSFw4jrCGm9RPAsfuC4fmNcgR0RxqeW32e009JQSB4=;
        b=i4ubnDp/0Y36NhAM+GzQgdRAwek64i66WoaBcxZ7Z+v5dHnbPODzrWHms824nKgdYR
         v20jWFG9kFMKqpqJ8Y0onYzQRBJzjkKoDRD2+qpsHB/4DKGCnJ6dQVLA/3g8xRqkFPGh
         RNHmU2vDVYSiT7BvFps4jjsYCN3Lfr3YyumeQLISXWafPG6Vza4WCbOO8pLM0OeZ0Qh2
         87E246m9MJ9R9rQ3gdMR6xjbYVd5biZ+eoa4eWbYGH2iy/uR8E4KhFa5lIc3Hw4vatKL
         O4h6e35JfUQMTy6aziLtrrFrF6Bn43azRwG9SwnN3h4XjIkDfB5WDFsBnwY2Qq2dTh7F
         Wjtw==
X-Gm-Message-State: AOAM531/fdTQJgfmtACigj1rXl/CPmweMd/lROjoDzVViJP9nQs9dtoL
        2S1c6JNGHOEQcVo8DVanCQ==
X-Google-Smtp-Source: ABdhPJyxN4KuUJsUGimL1+Ickp88wrj/zC3iokXa/Ln/Qnovw7q4wBdE56YjJ+JrXRvCH6tLtJMwbg==
X-Received: by 2002:a05:6214:27e4:b0:45a:a04d:d835 with SMTP id jt4-20020a05621427e400b0045aa04dd835mr8555828qvb.82.1653058888515;
        Fri, 20 May 2022 08:01:28 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id k67-20020a37ba46000000b0069fc13ce1e9sm3178827qkf.26.2022.05.20.08.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:01:27 -0700 (PDT)
Date:   Fri, 20 May 2022 11:01:25 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <20220520150125.ezprkcimxaokeeg5@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <YodF6C9ib2/kh5px@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YodF6C9ib2/kh5px@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 09:40:24AM +0200, Michal Hocko wrote:
> On Thu 19-05-22 13:23:56, Kent Overstreet wrote:
> [...]
> > The goal is to replace most of our %p format extensions with this
> > interface, and to move pretty-printers out of the core vsprintf.c code -
> > this will get us better organization and better discoverability (you'll
> > be able to cscope to pretty printer calls!), as well as eliminate a lot
> > of dispatch code in vsprintf.c.
> 
> Is this really something that we want? While I do see arguments about
> our existing %p$FOO mess there is at least one good argument to have all
> those "pretty printers" at a single location. That approach allows to do
> a proper review whether those printers are safe from the printk point of
> view. If we allow any random callback to be called from the printk
> context we just give a free ticket to anybody to do whatever from there
> without understanding of all potential consequences. 
> 
> Maybe that is less of a concern these days when printk locking has been
> reworked a lot but I still do remember how frustrating it is to debug
> issues related to printk getting stuck...

Thanks for raising this, but I see this as an argument for documenting and
perhaps improving printk locking rules. Curiously, there was no such
documentation in vsprintf.c, nor anywhere else I've looked yet.

We may want to consider double buffering - it would get rid of any locking
concerns if we wrote to a separate buffer while building up the printk message.
However, this would require allocating memory, so it'd require MM folks to get
over their fear of allocating memory... :)

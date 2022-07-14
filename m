Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59F257577B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241048AbiGNWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbiGNWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:15:23 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E524B0C1;
        Thu, 14 Jul 2022 15:15:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10c8e8d973eso4197684fac.5;
        Thu, 14 Jul 2022 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ng3/X4PelThqjSHpCTGPAN/BVGWWlZ6hoIZsJJT4v7Y=;
        b=F58ZWzw58v3u/Ep11tkIsNCLmim7u4IKUrhmGA4BSfnvT85un5c2mitiW4qVkQ5mXb
         wwOafM1aLO3EfDaRiLDDeUUEoHdetODhpnK9ui4uHAvjC/QxEH2WkMSdFW2NykuDtP7i
         YAOhLfXAsAacUoVrhR/XlZU//q/V4qja3+w+1Y8eLQYvJXG+z7VKwV3j8KKgevogjGwG
         pyIzA2YqaL8jVUPQRLGfUqaDQLzW98UGjAzY6iqFjJb4tCoXTRITsEBJkM+o+cPIaT3m
         hQdn11+HugzDnU3pmHrQQBMoeYkQjlTV/EA522n6EjPlIKx72kcDOuPWfYvQKkz75LP1
         9QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ng3/X4PelThqjSHpCTGPAN/BVGWWlZ6hoIZsJJT4v7Y=;
        b=ZkNUUarAlMvppbPzILrZkD5+Xtf2dZUa5OelN44j1tSitOTl5FfktPMKrL1bS8sNfH
         ViA0QXLoet+h2LlHSa5Tp9geMmqXvYvAK0ntM5BevjtDfosfuZU6IfzZGKDnF+jBCnrq
         dBn6JFmhf/R6qugJdVtqORu81kD5S9ZxN+bVWeAXrboa7TIyfoNV0ZNQ7pFLS3oov/q2
         9rVJAfbJKx9JHtL47uA/xepZZVhUFFOphovWBkc4BDVv9qS7mTXKS/C9567s2ZTwrOtg
         fB6ovd6Qo6H5kl+UGIWfvXbwEjgUikhHFYZQ6lluoRQTKl3AWxl1DUNa+Zi4xvavD/x+
         qZSg==
X-Gm-Message-State: AJIora/21HmqtiFGaOa2u2MSyYzLHn4pE3Cbjc40WM6TXaQWWfsfNGup
        0DRzCURSejFcwyv0xZPlRConCtDpyVHo6w==
X-Google-Smtp-Source: AGRyM1vVXmOV/Fn33yqyYL2kv3owKqaXip641o/zmVhcrSArz5/BWplK7y5pW+xjNvqdrJrqqnZyOg==
X-Received: by 2002:a05:6870:c353:b0:101:e7e4:9388 with SMTP id e19-20020a056870c35300b00101e7e49388mr5579381oak.45.1657836922071;
        Thu, 14 Jul 2022 15:15:22 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id w21-20020a9d5a95000000b0061c68a35fdfsm1192880oth.9.2022.07.14.15.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 15:15:21 -0700 (PDT)
Date:   Thu, 14 Jul 2022 15:15:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 00/10] lib: cleanup bitmap-related headers
Message-ID: <YtCVeOGLiQ4gNPSf@yury-laptop>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
 <CAAH8bW-OcdzetthsBanbkObVQxF1J6CiyBBnab=VXd2wcj517Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW-OcdzetthsBanbkObVQxF1J6CiyBBnab=VXd2wcj517Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 09:28:21AM -0700, Yury Norov wrote:
> On Wed, Jul 6, 2022 at 10:42 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > This series unifies declarations of bitmap-related functions and aligns
> > return types with values that actually returned. Also, it moves one-liner
> > wrappers around cpumask functions into headers, so that compiler has a
> > chance to optimize better.
> >
> > With this series, GCC 11.2 for ARM64 with kernel v5.19-rc4:
> > add/remove: 15/7 grow/shrink: 461/164 up/down: 14844/-4580 (10264)
> >
> > This +10K didn't surprise me because  modern compilers are more aggressive
> > in inlining, loop unrolling, and other techniques that increase size of
> > the image.
> >
> > v1: https://lore.kernel.org/linux-mm/YsAzU3g2QpgmIGre@smile.fi.intel.com/T/
> > v2: - Align whitespaces in headers;
> >     - Make bitmap_weight() unsigned long consistently;
> >     - Pick 2 patches from Ingo's sched/headers series [1] that split
> >       linux/gfp.h, and drop my similar patch for it.
> 
> Ping?

OK, I realize that it's not the very entertaining thing to review a
headers cleanup.

Adding this into -next because there's no negative feedback (he-he).

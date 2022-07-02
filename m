Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C273056430D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 00:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiGBWGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 18:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBWGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 18:06:42 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A794CE16;
        Sat,  2 Jul 2022 15:06:41 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id ay10so4726319qtb.1;
        Sat, 02 Jul 2022 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qWVzoWJiukz0uMc/6nDJZct0as3OEPBskJtVTg6SlEg=;
        b=mc7H5jasd4LfEtY2rm4wZRl7UnEzyYM03PXLNK4gNksqdVesPr/gZzzyu0Eg4uuWwM
         23RnsOURvmBEhBp+0Q7LrhTZ4r8nyDPhPdeY+L3pkBN/Iw1dppG6+XsdHfUIKruiE0Ki
         hJpTCrhsfM6iy7xy39Hk2yLXH+ciWFngkjpmtDsH7zvypETVllyKmY23delveTOU42df
         R/6o5f0lMwH7BeA/A8gm1WLvuL65sydYfRLFEBsMsR4FPfvl7ZY5oNrsUZiY4UsfzjKQ
         Em0qEFm7hrLooqSR1TbDgD+cFzHDaTwYTSHjOrKVDY2ilfC5delAoiUzsJo4OalIBoEW
         gXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qWVzoWJiukz0uMc/6nDJZct0as3OEPBskJtVTg6SlEg=;
        b=t2TBlZS4v9HgIgjz02CfhI1MAOIzM7J7KioR/qxNlu12pW7eXD9PelYBlECIkiyOsA
         ks0z8SIw5fKIgr3J6LgWXNbBi1V9ju+hMRxW6UWmeV06G9PM6iwir/kCS2kxsCk/L+OL
         8DyUQeFQetJybD3ldjHxQbF+MesxLp0iI2TKtlTqCCrCQoqEP9rNFfF5Tt6ULn0fGsy6
         /IuLtpUXdR+E0p6k77T3CDWjRhyaI4dDb3hJVybzIcjgRYBmQJwBr0dTujh4LYzh6Ivp
         WeCdQ4JmMnJPaE/lYoLpSBrm4tCIbROykevW1P789GixTXhknoVcFtcKAB0I9IKrDFcI
         Qv5A==
X-Gm-Message-State: AJIora9Dt7v/5C4x7fBXLQLHtd01vGMwTtZersLz5+uXznfilMDquCwl
        9iUdKfs5W5RyaA5tlJof/Ec=
X-Google-Smtp-Source: AGRyM1vq6UAVmcmt5d/O2DY7q4ksXfPBKaksojESvKdwWStGnRsTeqbeOkgRt3edMzGa3psAP0PpzA==
X-Received: by 2002:ac8:5b0e:0:b0:31d:3b3d:37cd with SMTP id m14-20020ac85b0e000000b0031d3b3d37cdmr7456251qtw.657.1656799600667;
        Sat, 02 Jul 2022 15:06:40 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:e838:b1c2:b125:986a])
        by smtp.gmail.com with ESMTPSA id cb24-20020a05622a1f9800b003187c484027sm12140303qtb.73.2022.07.02.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 15:06:40 -0700 (PDT)
Date:   Sat, 2 Jul 2022 15:06:39 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
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
Subject: Re: [PATCH 7/8] mm: split include/linux/gfp.h
Message-ID: <YsDBb15JeN2v/NBK@yury-laptop>
References: <20220701125430.2907638-1-yury.norov@gmail.com>
 <20220701125430.2907638-8-yury.norov@gmail.com>
 <YsA0k5G1B1kiQdXY@smile.fi.intel.com>
 <YsA1hHc3GgTIsglN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsA1hHc3GgTIsglN@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 02, 2022 at 03:09:40PM +0300, Andy Shevchenko wrote:
> On Sat, Jul 02, 2022 at 03:05:39PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 01, 2022 at 05:54:29AM -0700, Yury Norov wrote:
> > > gfp.h belongs to many include paths, and it causes circular dependencies
> > > when, for example, trying to keep cpumask one-line wrappers in headers.
> > > 
> > > In many cases, sources need only gfp flags. This patch splits gfp.h by
> > > moving flags to include/linux/gfp_flags.h. It helps to move trivial 
> > > wrappers from c-file to header in the following patch for cpumask.
> > 
> > Wondering if you checked Ingo's gigantic series [1] for something similar.
> > Maybe you may utilize his work if there is anything like this.

No, I didn't. 

> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/log/?h=sched/headers
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?h=sched/headers&id=56a20d45417dc517d91626e5ef9f5492a5e901aa
> and a few more patches on top

OK, I'll try to use his patches. If they don't work - I'll take mine.

> -- 
> With Best Regards,
> Andy Shevchenko
> 

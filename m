Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1C52E3FD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbiETEoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345390AbiETEoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:44:12 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE65E14ACAA;
        Thu, 19 May 2022 21:44:07 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p3so6006809qvi.7;
        Thu, 19 May 2022 21:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HCloP/BdwQKf94dgUQ7fIsRcmJ+458am9RBh2zWQYLA=;
        b=lXfzvugyW0tXVca4mORS+9CgubQ6m+HRpxyqhKJCYWXwbNW0F8YgJ72Pwmn7WK9FXN
         WVy08B2JQvzNrfdqm2D7XOI6x3DNhNFavHWBwtJHmaIjSagug6TN7ewoK9LiT8ouNvlb
         DxYvET4AooXw0WPIXTK4CxNUd5XjUg4ZKkMzpNgw56FKUkD9lKXm/GipLsPSWhd2ZlIY
         k6X163v8VK9ZN3V3kz31ji3U4mI46E3rLLhHK0Jcig9g9bm4qs8sFC2T4g5yV7xVx2Xe
         tarLbqfwJ+RRC2giiuozfwP1BmUuE7Xb8h/JV/2fMco3eNfY9vEz9Uf6L7de9ZByaDLJ
         UC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HCloP/BdwQKf94dgUQ7fIsRcmJ+458am9RBh2zWQYLA=;
        b=qsymhkcI2TlOjZJbSiv3iOlgHbvMvulWb99BesoSNJbUdaykY0He64W7L+k61D91Pw
         ivikGQO4W2/cpa0xMsQEWaNrD2VlbybvEhekKhABnz9puxTG6I2YgrxSKjEcQ9Y3RF3r
         WMsCvR5uRhBV3ZDnf/A/RsLN7MdwzCgVYpEIt5mvlGMxFW9pntpCwfqypizozHawhTjR
         xYKZH63++KRrV1RXwj5nN7hZNff2kgaMlhwOoBkX0kiFT9vMCcAqk67Rh8+wgG/9nEFT
         dkerGF0GXGYNcx0PAgEfo/1QfFQxLQKdco2pMi2XdBjMtX/mt8orhtZbNlVi03wDAtoV
         ZNYw==
X-Gm-Message-State: AOAM532R50+CgGDxg/h2SrxME6jQ6wEhztDc6JHNXQZJNVGCFe8gEy71
        ok1G/4LnIV7SH0dznuAxeg==
X-Google-Smtp-Source: ABdhPJwLICvkW0v/UPh6JqOT21/vBBfTtqW8W83d55h0C+u2gCS/3qtw4zVaG3/N3D6QCIb1Pf3xKg==
X-Received: by 2002:ad4:4e31:0:b0:461:c420:fed0 with SMTP id dm17-20020ad44e31000000b00461c420fed0mr6489588qvb.14.1653021846898;
        Thu, 19 May 2022 21:44:06 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id cm27-20020a05622a251b00b002f39b99f69dsm2471779qtb.55.2022.05.19.21.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:44:06 -0700 (PDT)
Date:   Fri, 20 May 2022 00:44:04 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <20220520044404.tdjnuenbunymuzrs@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-2-kent.overstreet@gmail.com>
 <YoaKjCoVot4JV46s@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoaKjCoVot4JV46s@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 07:21:00PM +0100, Matthew Wilcox wrote:
> On Thu, May 19, 2022 at 01:23:54PM -0400, Kent Overstreet wrote:
> > This adds printbufs: a printbuf points to a char * buffer and knows the
> > size of the output buffer as well as the current output position.
> > 
> > Future patches will be adding more features to printbuf, but initially
> > printbufs are targeted at refactoring and improving our existing code in
> > lib/vsprintf.c - so this initial printbuf patch has the features
> > required for that.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> My only complaint ...
> 
> > +#define PRINTBUF ((struct printbuf) { .si_units = PRINTBUF_UNITS_10 })
> 
> si_units doesn't exist yet :-)

Thanks, also fixed :)

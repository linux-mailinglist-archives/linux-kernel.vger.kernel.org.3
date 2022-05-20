Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DAE52E3FA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiETEng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbiETEn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:43:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2F114AC95;
        Thu, 19 May 2022 21:43:21 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id dm17so6017472qvb.2;
        Thu, 19 May 2022 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lx7VC/jrYLPDvaYWvElCUwpwQ14yXPIJEZL+IdY7kNk=;
        b=oTIqZpVz8XCqCUXx1uoFc04RuWVXjZBsox4Q8gTfnvF2NIGG7QUyZDInEuidSY0qmh
         4+7H6BjpAPVmIEVU5s7S30bsvlQNmcBIw7gEjp43XWOIfJki6xuvN0hl9FT0sS1S8zqB
         4/4emmRPCxVfWHOmb0R9wUuE0DrkJiKK9SRoE4wUKb7ACzI1P8SYjhKmS5C39G6bDc1l
         OGuC0wrRA2Z/yAQu2F3rRf49UIC5XE+NvO0GMYbSMLb2mgObzaXEw13fQjAWSvsF1BBQ
         lGD/6fJ6fYL/fkGTKXmYKUy1i+IPqAlC9DSBaxm4rXfovIRPQkW4gZY1NWf6Bj/NAFia
         +5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lx7VC/jrYLPDvaYWvElCUwpwQ14yXPIJEZL+IdY7kNk=;
        b=aOspaFvWSM0kb9PbxyQZ5UMY7ZAOguhCaYODb/imzFh2dMh6L1WzlgG7m+evtf0QU9
         LUP0cxeYFk15zLLsOnMQpXT8q+8E9wL/R02k7RrzWSxusRHgoZx+Bjquallx8wAKW5bO
         uNVyYMwbVzhWpWeZTbONBQ5jwP6e4VdKxveoW7LQxW4TG1LJvcpKcLWKh8xJYSS4Werm
         vz21xBBtLlFjjFDALR3LYAw+qqUGo+t+n3HwXOz8Eg5GCGKlsiqZA+hv7QVzV1KGlGt6
         b59qgSNL6kf1YOlzci79hNepM+EAz3Yoi7eednSjENUDeONOiSnzVrGMTZyI8pTUJy/+
         5VYQ==
X-Gm-Message-State: AOAM533cT7OVa9kG3acCOrjkJPF2AcpHVK6cfHxGH8GGITBZU/WlE932
        KoAuBurttdF6tKEN/SM08Q==
X-Google-Smtp-Source: ABdhPJxDbFun3YFua92Io0Jyi4jrXNXPGlENcMgxAYBUpqVztN0ItXTzHJ5oGy4QeEYz8E6CFCyUDw==
X-Received: by 2002:ad4:5e89:0:b0:45a:d9c8:e04b with SMTP id jl9-20020ad45e89000000b0045ad9c8e04bmr6552568qvb.112.1653021800792;
        Thu, 19 May 2022 21:43:20 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 128-20020a370c86000000b0069fc13ce205sm2387681qkm.54.2022.05.19.21.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:43:19 -0700 (PDT)
Date:   Fri, 20 May 2022 00:43:17 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2 03/28] vsprintf: %pf(%p)
Message-ID: <20220520044317.5ypfqjjgnlmt62tp@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-4-kent.overstreet@gmail.com>
 <YoaNfEwEWGhrJuSd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoaNfEwEWGhrJuSd@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 07:33:32PM +0100, Matthew Wilcox wrote:
> On Thu, May 19, 2022 at 01:23:56PM -0400, Kent Overstreet wrote:
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -625,6 +625,25 @@ Examples::
> >  	%p4cc	Y10  little-endian (0x20303159)
> >  	%p4cc	NV12 big-endian (0xb231564e)
> >  
> > +Calling a pretty printer function
> > +---------------------------------
> > +
> > +::
> > +
> > +        %p(%p)     pretty printer function taking one argument
> > +        %p(%p,%p)  pretty printer function taking two arguments
> 
> Needs to be updated to the %pf change.
> 
> > +        printf("%p(%p)", foo_to_text, foo);
> 
> Likewise
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks - fixed.

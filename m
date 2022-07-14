Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7165754B7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240545AbiGNSMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240539AbiGNSMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:12:23 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EDC6872E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:12:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w29so1363937qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pHDX+ueiTJVI3deKG6Hv7RJHDyQ/mE9meqfCKJ1qXHw=;
        b=QuB7HSlZJ0ej/IHezAJ2sA282MkWQ5QaNeXagaJTwQ6i0bymRwqHTTbaWWEw+Hmhvu
         BWnwYdw2+jZ0O4dFkskLtXSv2h2uFy9pudKdcfw2Bq3vhLbqLgK+WjD8XABKvjGZ6LqK
         E6r20idKcW0VSHqnCNzzPk3X288fhrhxnadACRX15OmEtB+/ZYmYyzvqEEypcrAQ9KTj
         6AS7Wz8QGAbnQ4toW9yWi29oJUueEg4nbxLxvs3uQiDxGoV7yBNp0KLWtQefmxk4cc5j
         g7bZ4Hqb8uo2PBGWw1dTMB/e+s3iPTgU0uBPKOtWDxdElFQcm8tNGmW0Uh7su6mDLLoa
         JPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pHDX+ueiTJVI3deKG6Hv7RJHDyQ/mE9meqfCKJ1qXHw=;
        b=cDGEgaB18aIR3u9E6KLnI9Gm0hTgWrHN5hEvsRefp4W0012xJLjF5ypYq7tVmDqI2+
         7JYaT94fA6vKwsBIkvY79yv/6iVJdHkCUYCs8DO1weoii3N9uJlIOZYapFtuppySW/K8
         weMrBSkDI0bgVgownI1NG35ADx9XYkE16xS6USUwNJOqGGo7kDJ8AEgQzrRREBzt4FdG
         km5WtZJWo3D40clUNJmKjUFjgD3sEXWAJ/q8kS9/lcUJkIxW+bkE8hcSEPy+1uYoKpFh
         4t9vAARBJHh2ZueMovK2LBnKxEWrNmN8yD0G+gcfwXkg3jKcbz7dHCPSaUFsQtxh4T32
         HeDA==
X-Gm-Message-State: AJIora+q7U1lFLtEhO0eWKs8rJdyJr69Eawn05oYnYRAlKTM/05rHY3M
        aUkl9y6FGcmpGP7jPSFs+5a2JEVf9ZE=
X-Google-Smtp-Source: AGRyM1vAIqiVasN+BPwGXAoTChMCpMSsajgBneBOok04gPchxgKO2SGyxwc+WW4IeI/gnGyVFhH9hA==
X-Received: by 2002:ac8:7f45:0:b0:31e:bebe:18e5 with SMTP id g5-20020ac87f45000000b0031ebebe18e5mr9442092qtk.382.1657822341926;
        Thu, 14 Jul 2022 11:12:21 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id bp9-20020a05620a458900b006a793bde241sm1956834qkb.63.2022.07.14.11.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:12:21 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:12:21 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/bitmap: Make count and length parameters unsigned
Message-ID: <YtBchVNwjWk5OySA@yury-laptop>
References: <20220714164207.52410-1-pmenzel@molgen.mpg.de>
 <YtBIo8XnDqchGhyk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtBIo8XnDqchGhyk@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 07:47:31PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 06:42:07PM +0200, Paul Menzel wrote:
> > Counts and the length are non-negative, so make them unsigned, and adapt the
> > while condition in `__bitmap_set()` and `__bitmap_clear()` accordingly.
> > 
> > For `__bitmap_set()` six less intstructions are used as a result:
> 
> You may check this by doing
> 
> 	make allyesconfig
> 	make
> 	cp vmlinux.o old
> 	# apply your patch
> 	make
> 	cp vmlinux.o new
> 	scripts/bloat-o-meter old new

For me it's:

add/remove: 0/0 grow/shrink: 19/17 up/down: 178/-404 (-226)

I'll append it to bitmap-for-next after some testing.

Thanks,
Yury

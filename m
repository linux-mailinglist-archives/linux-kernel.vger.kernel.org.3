Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7352E3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbiETEhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiETEhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:37:05 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05D66690;
        Thu, 19 May 2022 21:37:01 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id eq14so6019539qvb.4;
        Thu, 19 May 2022 21:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UDEaMebepw9nHCvdgrfj83Hon0Tr8egcC3hMlrRwrjg=;
        b=BaPTntNRgBbMv9UFWD3S5046pFYBLCEg/1qdCVn/y44FD8PpjLe4NqR/KuzME621QO
         8gg/fw7EXhhsGVgCjBCCAfKzZWc7REGevBWPrbGqtwS7SJhFzOo4PDPJPcmieoXWtKUt
         YzmalL0zRl13CjlFsMTbLnklEloUp8F3TGzAfLZs0OQutq1CBd2FLuiIJdpPERoaGzQf
         YgLNnlTdysPntlWtNJKNx4WyH7w73v0cpmBDQKpphRv2deZHZI4Xh/W1oxiyVNVXu5GL
         Cl6PUKjPLxZNusD/EYleKfVuwR+OoTe0DNdRu9cQlNuYNA7tTPBOodQm3kuTGxltihbS
         WSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDEaMebepw9nHCvdgrfj83Hon0Tr8egcC3hMlrRwrjg=;
        b=E/L88vdv+dvUbhA8AgmT7dwBG8JcR7qkDc3jUj9T7aHZMKB6L3AtNMQ3DimTzudYpi
         E9093ennk8XF/+R27a2/G5xHrkEuRp/ZijSNaldRpNaTas9F/Nz6QHM/mSu+zfEq+mL/
         bzbklwFgdzMnIhqtNsFnn0OP0xDGYb5f1ZVzf/N2kSQl85CarJ6/H0eK2WYD7qVfXj5c
         kLHle4Sk9G2RASdmm9tg695B6KEMWamvulAH4WbwYqZjDh9yGUIsSJrDxivv8XbVmNzh
         vjKDlHGs3kIpyrXJyOxMGmXyt5KKlvUHa159HBuLhvIgBM1U7NrqLVtDrURMQEnqh0OL
         60tw==
X-Gm-Message-State: AOAM533CUQ+3PvbqYxrgXutIHSLpZsOwY3H9UgdPvlu1M60FQtbcs7Jw
        7ZviZx37Bgb4xPvg4KdcKkczyR56haah
X-Google-Smtp-Source: ABdhPJxc7FslFygv7tKxu0i24w6afFY4PgZHCeUJYc8L4uF6bOXoOaY0uDKAR/dx1rCnYzDS10E3gQ==
X-Received: by 2002:a05:6214:1cc6:b0:45d:a313:d2d with SMTP id g6-20020a0562141cc600b0045da3130d2dmr6417961qvd.127.1653021420486;
        Thu, 19 May 2022 21:37:00 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 7-20020ac85907000000b002f39b99f69esm2625297qty.56.2022.05.19.21.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:36:59 -0700 (PDT)
Date:   Fri, 20 May 2022 00:36:57 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        willy@infradead.org
Subject: Re: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Message-ID: <20220520043657.mq2c4veaxawyhayq@moria.home.lan>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-8-kent.overstreet@gmail.com>
 <Yoam1bW/vni3srLc@smile.fi.intel.com>
 <20220519202626.3x3kyqs3jttel7u4@moria.home.lan>
 <YoazuWvIU63zNGJr@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoazuWvIU63zNGJr@smile.fi.intel.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:16:41AM +0300, Andy Shevchenko wrote:
> On Thu, May 19, 2022 at 04:26:26PM -0400, Kent Overstreet wrote:
> > On Thu, May 19, 2022 at 11:21:41PM +0300, Andy Shevchenko wrote:
> > > On Thu, May 19, 2022 at 01:24:00PM -0400, Kent Overstreet wrote:
> 
> ...
> 
> > > > +	if (v < 0)
> > > > +		pr_char(buf, '-');
> > > > +	pr_human_readable_u64(buf, abs(v));
> > > 
> > > Wouldn't -v work?
> > 
> > This is a bit terser
> 
> Have you checked assembly? Basically the question here is does the compiler see
> the same conditional and avoid duplicating it?

No. I check the assembly for code where it matters - for this, I'm going to
write it the way I find it most readable.

> I run `make W=1`, but I think the kernel doc validator is run anyway.

Got it, and fixed the doc warnings.

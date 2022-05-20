Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C752F0E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351765AbiETQlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351811AbiETQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:41:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B7549F81
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:41:19 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g207so4475955qke.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkubbAhF29FhvKmmevQzXLxG5QZHESokBvz4K1V6cEo=;
        b=DQTmBnn0ZDX0GRgKWYzWkYo55TP/cdT3Sakix+Rs2cFKA2gFDqImO7h9wrnhOZV02G
         HjwIZDaCTk2oQZlglY7Eu/yq4krTe7vortY0GAcNE1AJ0cnnDbZH5RgZaZrrNNYkbrrB
         OsdPP061S/hu1m4i8ty43+sZub9IaT8rYLedBoJ+LvBtXR+I1wWIUz27DliaHSnagx59
         bHfNnizJLpublgU/8uUd8Pfc3v/FDLLkQ/NUDjv8Mgh8lpi+dayq2RQR+DUuXNw9lRc0
         EkJFI9hKdXptcdBvacJQMrGVg/i+nIshFIzqSiUBe/oiIrt2LguoZ6fQTl//9Cf+UloH
         exHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkubbAhF29FhvKmmevQzXLxG5QZHESokBvz4K1V6cEo=;
        b=fuC19heNaNuvIO1eNR85ziRTRE2ejdpOHjQcLbDsNBNR7RARF9TzWGYrF/tcoYNe9b
         YkzMgiG0nMSBp5Oa3MMdStZgYb87tYB3K9Jg+xlx9av8ROI5bDI3VZhfPcWrhZUexo7f
         31VOkd4vUOkDIYMVssDZavMN+C1r2WIMZ6BD39VAIxK7aYDiT1Iy6WvFPh+UZcW+HaV8
         4cE/+LbdgfpZnnrrgwgKY6zkAsb2PM56usa9dCCRaSctP26d0MMUY4rcbuhu6rff3lG8
         8QDo3e5Qrn1gZsEHTHN0kLApux9qBi0on7ZMb+Tq5Ikge7joNhI3axeuflsFJpKzml4D
         JoHQ==
X-Gm-Message-State: AOAM530IeBKmv7tS5a6K5cu/Cy2Nffzl7VGz2eXWOlZg5TF5l5LvOnot
        +7qR/M6CL1MVKCduX7/dNZNF6M2qnSfn
X-Google-Smtp-Source: ABdhPJwuB47wcY/9uJ/K+woiLyVarnXc36VZPpIKVTTXBtOZwt6WKU6VZYuiZ2eEIheGUN2zsVMoRg==
X-Received: by 2002:a37:6189:0:b0:6a3:3622:794c with SMTP id v131-20020a376189000000b006a33622794cmr5147483qkb.210.1653064878240;
        Fri, 20 May 2022 09:41:18 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id w1-20020ac87e81000000b002f3b561957asm3745541qtj.13.2022.05.20.09.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:41:17 -0700 (PDT)
Date:   Fri, 20 May 2022 12:41:15 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <20220520164115.oectf3x5hkwesioi@moria.home.lan>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-4-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509183820.573666-4-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 11:38:17AM -0700, Roman Gushchin wrote:
> diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> index ad9f16689419..c1f734ab86b3 100644
> --- a/drivers/md/bcache/btree.c
> +++ b/drivers/md/bcache/btree.c
> @@ -812,7 +812,7 @@ int bch_btree_cache_alloc(struct cache_set *c)
>  	c->shrink.seeks = 4;
>  	c->shrink.batch = c->btree_pages * 2;
>  
> -	if (register_shrinker(&c->shrink))
> +	if (register_shrinker(&c->shrink, "btree"))
>  		pr_warn("bcache: %s: could not register shrinker\n",
>  				__func__);

These drivers need better names for their shrinkers - there will often be
multiple instances in use on a system and we need to distinguish.

Also, "btree" isn't a good name for the bcache shrinker - "bcache-%pU",
c->set_uuid would be a good name for bcache's shrinker, it'll match up with the
cache set directory in /sys/fs/bcache/.

For others (device mapper, md, etc.) there should be a minor device number you
can reference.

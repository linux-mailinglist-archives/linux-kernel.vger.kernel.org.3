Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB958BA84
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 12:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiHGKCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiHGKCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 06:02:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672A3DFD1
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 03:02:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b16so8222230edd.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 03:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cOMKjLtoyfKfKLxS4Utjtr9dyLLaLulKlhk3hE0DmS0=;
        b=SvHZelym3M8h5d4I8LnI9IigeiJ5fxXK0h4MSizcvxM1ST7hESwq9X/OQPUu2qkP4H
         vgjQn3elUiZHrOZX1TFTmGh2OduAPtzz4NauDn0Odh5mqSIX9yDiGpKvqgPihtbyr0Gz
         GLPjhsY9NMHd7+DF7uXgX2TZ7Dh3qKyLhHbvioLHl9yl4K7jLKp0qfOnvc1V06eYhF4J
         HyOfta1XjxAnFFPXHtaOcYf+bT9+by60O2bcu6N5BEoEBnmeA33C5uOcJS+XNoJVcGDi
         DvNTI7A7TyXErT1CSmfSXgto0IULwxCXUBYLIzmxiF4KClcl2syTo1yv6Q4P7s3bAYsO
         Bmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cOMKjLtoyfKfKLxS4Utjtr9dyLLaLulKlhk3hE0DmS0=;
        b=Fh1iHuGoQv9dgnjMTvH/WZOktKw4mWSyWdFm6sqnzpqBMGGMvtIAV6iyLxKKh7hodc
         /g/pi8UT4cUCkfbk4ZW0mSto70L2Z72l+Fy6P3Sy4+cz2ryVJouRtdy6yd9YCbbZa9u7
         SsNW3pQwL+FXtTs2cTTZJca60xv2YaJFxoQJH4lJaYqOvQrxSudXzjpKmAcv41KstrIm
         zoSOd2H/iN75icfqjGV7axdwtmFvh8cNvKzEIKCXJXvGhc3MwL4j4wORQWYMA9nHsUyx
         aCuleVdO5X9X/YD92Ox30ZVauqf7+5hs7dwroIBI4xqGE39vKX8+LEoaynOMtTaeeeuo
         bRdA==
X-Gm-Message-State: ACgBeo1hGB4nCRob5z0XbX+yHhSHpiOpAilMGY6YEz483NXvzjik/Foq
        ilNeHcCJcC6qLkEjeSmgEJsjE8Jggyo=
X-Google-Smtp-Source: AA6agR6v0Dg8Br3XJc/D+EFjZEJ4rlNWWS9b2emJaNfilzI17ugo0Ajj2vD6bQo4T/WxoCN/g9I2cA==
X-Received: by 2002:a05:6402:278d:b0:43d:cf90:c91a with SMTP id b13-20020a056402278d00b0043dcf90c91amr14049571ede.186.1659866564016;
        Sun, 07 Aug 2022 03:02:44 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id os8-20020a170906af6800b0073092b543c3sm3696561ejb.141.2022.08.07.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 03:02:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 7 Aug 2022 12:02:41 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, ira.weiny@intel.com,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <Yu+Nwbn4CZUmyD14@gmail.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yu4wON0MRGH7h5Jv@zn.tnic>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Aug 06, 2022 at 11:01:06AM +0200, Ingo Molnar wrote:
> > It's still 2 instructions more than what we had before, while the 
> > fault-time CPU number is only needed infrequently AFAICS.
> 
> With the amount of logical cores ever increasing and how CPU packages
> (nodes, L3 sharing, you name it) get more and more complex topology,
> I'd say the 2 insns to show the CPU number in every exception is a good
> thing to do.

We can show it - I'm arguing against extracting it too early, which costs 
us 2 instructions in the exception fast path - while in 99.999999999% of 
the cases we don't use that field at all ...

> Arguably, we probably should've even done it already...

Yeah, so I'm not against Rik's patch that prints the CPU number - that's 
indeed useful and I'd like to see it merged.

I'm arguing against extracting the CPU so early as to impact the exception 
fast path.

Thanks,

	Ingo

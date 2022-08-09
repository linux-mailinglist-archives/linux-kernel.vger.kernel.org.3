Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696AE58E390
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiHIXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiHIXGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:06:14 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C26D9FB
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:06:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso381140pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0dif6Jvy3tqvIXoBURzewg07wJiLTaWlzuiD5tnehZE=;
        b=jz+mkg4M3KX4TsHlSIFsNKZmwOPj2rmlji2B1M6p3UD/Pk0q2u/6+iy7IF7h04ED9Z
         ooqEoj9iQZ6vEmtdTYX2RfWKfqUR8vqp/7Hws2yv1o+Su2MDPo4vAmU6/qV3i/1s/JgI
         JQl2P9f8nFQ1AUjrL9O1hCsDgK5ybki/OmESI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0dif6Jvy3tqvIXoBURzewg07wJiLTaWlzuiD5tnehZE=;
        b=ys0UcS31aoWVKQ/OsrW2Wj5pCZibuDdHij+TJl9AdNJDxZLRge7bccRDhC2T8yQ0W6
         Wb+vcmK7D/ZFDtVW4HtcaTWZVruG8YDWcQsjcgEajBJf9ZPZp6BG7X7wR5yp9RZ2jtzD
         nyvZq8/FvbXJVuGHwj9I2AYTgaK8fnA/JXvLxNFOYcWyIwO5UeG0zHbQZxzRut+U76Oe
         i7ZtpaSPDtu5VtiDI/vjLq7wv+a8ctL+YTU4e/FCLefzjmvWRIKZ+RaLVlJlyCrDCaNy
         ZBguIxi3Z/t7zgQNb5g7bfdoRpc61D+WlBBoCh0XNg+EqVra0aFmwfTn05wbQPnUAFax
         rQrA==
X-Gm-Message-State: ACgBeo24jaIPM5DhKdcEWUqNOjSPkapNtHm63dW5f6OEg4pA/q4SmpfC
        csDf7M1/rGvpDCnDzcgjg2O6nOaIcJtuSw==
X-Google-Smtp-Source: AA6agR442dUhw5QL7LXbxeGzFGScs5Lz5Gi5+YphEzab6rEbuhYoI/m/XB94JOt77c/QK12r6H2xuQ==
X-Received: by 2002:a17:903:1110:b0:16b:6968:1d08 with SMTP id n16-20020a170903111000b0016b69681d08mr25432123plh.3.1660086370284;
        Tue, 09 Aug 2022 16:06:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a64ce00b001f2e20edd14sm118690pjm.45.2022.08.09.16.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:06:09 -0700 (PDT)
Date:   Tue, 9 Aug 2022 16:06:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: Invalid pstore_blk use?
Message-ID: <202208091600.D19DFF9C7D@keescook>
References: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
 <c5edaa34-6f85-c6a8-84f5-75413dc864ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5edaa34-6f85-c6a8-84f5-75413dc864ea@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 11:35:08AM -0700, Florian Fainelli wrote:
> Hi Kees, WeiXiong,
> 
> On 7/14/22 20:49, Florian Fainelli wrote:
> > Hi Kees, WeiXiong,
> > 
> > I am trying to make use of pstore_blk which is BTW exactly what I had
> > been looking for to store panic/console logs onto an eMMC partition.
> > 
> > Using the 5.10 kernel plus:
> > 
> > 7e2e92e9861b Revert "mark pstore-blk as broken"
> > 01c28bc8f389 pstore/blk: Use the normal block device I/O path
> > 2a7507999638 pstore/blk: remove {un,}register_pstore_blk
> > fef0b337cd25 pstore/zone: cap the maximum device size
> > 
> > or the android13-5.15 (at Merge 5.15.40 into android13-5.15) kernel with
> > no changes and using:
> > 
> > mount -t pstore pstore /sys/fs/pstore
> > modprobe pstore_blk blkdev=/dev/mmcblk1p9 best_effort=yes
> > 
> > upon triggering a crash with:
> > 
> > echo c > /proc/sysrq-trigger
> > 
> > and rebooting and remounting the pstore filesystem and loading
> > pstore_blk, I only have:
> > 
> > # ls /sys/fs/pstore/
> > console-pstore_blk-0
> > 
> > which contains the entire console log up to, but excluding the crash.
> > The kernel does show that pstore_blk was used for all 3 types of kmsg,
> > pmsg and console:
> > 
> > [   28.649514] pstore_zone: capping size to 128MiB
> > [   28.712894] pstore_zone: registered pstore_blk as backend for
> > kmsg(Oops) pmsg console
> > [   28.721145] pstore: Using crash dump compression: deflate
> > [   28.906253] printk: console [pstore_blk-1] enabled
> > [   28.911229] pstore: Registered pstore_blk as persistent store backend
> > [   28.917735] pstore_blk: attached pstore_blk:/dev/mmcblk1p9
> > (134217728) (no dedicated panic_write!)
> > 
> > there is no automatic reboot upon panic, so I just tend to reboot after
> > 2-3 seconds manually. The kernel is configured with the default
> > CONFIG_PSTORE_* options.
> > 
> > Is the observed behavior a limitation of the best_effort mode? If so, do
> > we have any plans to implementing a non-best effort mode for eMMC
> > devices?
> 
> Any feedback on my email? I did try to get kernel panics to be dumped out to

Hi! Sorry I lost this email originally. :)

> a dedicated /dev/mtdblock* partition for which there ought to be support for
> mtd->panic_write, but it still did not work any better. Is there something

With the mtdblock driver, do you still see:

    pstore_blk: attached pstore_blk:/dev/... (no dedicated panic_write!)
                                              ^^^^^^^^^^^^^^^^^^^^^^^^^

> obvious that I am missing which prevents kernel panics from being logged?

Unfortunately it really depends on how the drivers are built. If the
block layer is shut down during a panic, pstore_blk won't catch the
panic. :(

-- 
Kees Cook

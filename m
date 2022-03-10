Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443214D4493
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiCJK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiCJK26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:28:58 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5AB139106
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:27:57 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id 195so5960871iou.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/TvTwTRE5ZLnuOuX6FmvE7twzPbdAnz0gt379FQSjM=;
        b=ZG7BKAH0cDR9Ezst+s2IovF6T9rCTxg1K2QOd7Y/2G+6aKtgE+wU3rDnk26DUQJVp+
         NlRnipPaxVJj74a1wOcxmGerVkypJtH/RxTcouma0ZFoD0nFDLuMkHyE/W4e9acshD2q
         5loYWVXWygw+qwAdMm5j5sBMgQUAVw3RHsLW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/TvTwTRE5ZLnuOuX6FmvE7twzPbdAnz0gt379FQSjM=;
        b=iu5HDlVr2QIzT4s3MREf5U+IFOgZFy/eLWikHP3yISBs1hR06NBZdPgJCKgeS/Oj6y
         5qaJZsCYT1Xjv/YkF8oirioKb7RYQyGMnglHgDpeBXL/JWmCO3+5BeOnChC2jmf9CbXs
         qb6W2lag+dKjWJeUnmbA5dXpaXp+t9o5o1OcoPgUmbTcwAy2nv7ConnHKVFJm9ngJ+xC
         sgHndU7XUVp0GtFYZM4L6yOypnZrjQk+x1VKqhzcdr+Gi6nMA/X53z8ZKiL6Mr+s1H/k
         t7w1YQMOjhWhDJuq/XV+WSJ5UIpgh4syde+D+JDpHCoSOOEEkHTBG5vmq4OxOHEeSAuk
         7wFA==
X-Gm-Message-State: AOAM5318CxgYH4sYnxk9bMp49/koFdZTqypHPNO3XvRXdO1vs//yR/5u
        gxQSlGHGCo+iGYsZaUA9JU8p8kLhIOSQ1uffbgym2A==
X-Google-Smtp-Source: ABdhPJzdE1Ar/Z1/NhsDqf43Wfdc5EFZaml3NQ53CEZWS74q/uC2laNDDFLN7yij2ZB0BGN9GQP/B5b/7wX00uSrkvs=
X-Received: by 2002:a05:6638:3049:b0:317:9a63:ec26 with SMTP id
 u9-20020a056638304900b003179a63ec26mr3378628jak.273.1646908077073; Thu, 10
 Mar 2022 02:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20220302171816.1170782-1-kvigor@gmail.com> <20220302171816.1170782-2-kvigor@gmail.com>
In-Reply-To: <20220302171816.1170782-2-kvigor@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 10 Mar 2022 11:27:45 +0100
Message-ID: <CAJfpegvpKKO-dFg7P8fERq5-BcQSC7uh2cYzz-Ufo7wHvnvv9g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] FUSE: Add FUSE_TRUST_MAX_RA flag enabling
 readahead settings >128KB.
To:     Kevin Vigor <kvigor@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 at 18:18, Kevin Vigor <kvigor@gmail.com> wrote:
>
> The existing process_init_reply() in fs/fuse/inode.c sets the ra_pages
> value to the minimum of the max_readahead value provided by the user
> and the pre-existing ra_pages value, which is initialized to
> VM_READAHEAD_PAGES. This makes it impossible to increase the readahead
> value to larger values.
>
> Add a new flag which causes us to blindly accept the user-provided
> value. Note that the existing read_ahead_kb sysfs entry for normal
> block devices does the same (simply accepts user-provided values
> directly with no checks).

read_ahead_kb only allows root to open for write.  Allowing non-root
arbitrary read ahead window size is not a good idea, IMO.

Thanks,
Miklos

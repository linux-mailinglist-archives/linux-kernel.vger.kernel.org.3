Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270A583F92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiG1NGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238705AbiG1NGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:06:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D8E27B11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:06:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w5so2068271edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zda77mg1ZZpOWsNvo8VG8yNV1v0c9vJN28zhGs4j7Co=;
        b=LiZHYy+VWInwHyqug4oZSVH4NIe032Ss239NP3GsmxgHC7dqSIjbPTuWe3EImLsHid
         HyfTrV+f+pSzH4+VxlB2HytHnDf7MEQd9Xftns9QUsAjd7ylxMx0HnI2/DsShcMG905K
         fuamrsR6PoaheVVy7tfC6cjcuwCLoRKUApQhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zda77mg1ZZpOWsNvo8VG8yNV1v0c9vJN28zhGs4j7Co=;
        b=u+i7gT4+Q3Mls9GfNAmmO8LrW4b3lZT2H7UmaCNAEjzrLY33BGYlC0faoFsAO0lNOI
         JJPHheh+zUSbuW5i10w+4+4+3F8Nl6bQlwFYJGgLY323XoLCdqgadcRy2a4GU+wFb/6Z
         f3++n9eBB1GscvB6lb6w+qXs05Q96OnXf/bWeKTWs4NHw3oWxehl+TDoV+rBZKYqPXxx
         eSqncDZptdRgHPKSP9wEKlmtN4RwHmub89X5sP1N4sp12R6doqgXdyhMk+UyUkXRFRhL
         zcoOb+dpI1EY70CR7blutQJx9cM2hJ9yqB8SyM0Xzpn+JpthCB3w23hL3sJ5h0pZJ4MR
         r4rw==
X-Gm-Message-State: AJIora8NJmib7W6poQC0R+mgDPgC+MbzA3xy+UvoORzY/mbc1tUMyiMm
        SD+JGDHjs0EL4HJteQSnCmiEIXetvQjsPc0VaiaMOw==
X-Google-Smtp-Source: AGRyM1tOXQ83oiijld594L1K/qs5gc3SWYDeihnffqaM2IEgRBgLJ6intgsdVQkHW12Iqu0p07tPfY25Yv9nGgVh1EM=
X-Received: by 2002:a05:6402:5201:b0:43b:f621:3ce0 with SMTP id
 s1-20020a056402520100b0043bf6213ce0mr20847294edd.22.1659013561468; Thu, 28
 Jul 2022 06:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220728114915.91021-1-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20220728114915.91021-1-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Jul 2022 15:05:50 +0200
Message-ID: <CAJfpegtxUrytqTFjVG0J03ZmEzzpFr8Ra1KP8HiZNPzTtgY3kw@mail.gmail.com>
Subject: Re: [PATCH v2] ovl: drop WARN_ON() dentry is NULL in ovl_encode_fh()
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Hongbo Yin <yinhongbo@bytedance.com>,
        Tianci Zhang <zhangtianci.1997@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 at 13:49, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> Some code paths cannot guarantee the inode have any dentry alias. So
> WARN_ON() all !dentry may flood the kernel logs.
>
> For example, when an overlayfs inode is watched by inotifywait (1), and
> someone is trying to read the /proc/$(pidof inotifywait)/fdinfo/INOTIFY_FD,
> at that time if the dentry has been reclaimed by kernel (such as
> echo 2 > /proc/sys/vm/drop_caches), there will be a WARN_ON(). The
> printed call stack would be like:
>
>     ? show_mark_fhandle+0xf0/0xf0
>     show_mark_fhandle+0x4a/0xf0
>     ? show_mark_fhandle+0xf0/0xf0
>     ? seq_vprintf+0x30/0x50
>     ? seq_printf+0x53/0x70
>     ? show_mark_fhandle+0xf0/0xf0
>     inotify_fdinfo+0x70/0x90
>     show_fdinfo.isra.4+0x53/0x70
>     seq_show+0x130/0x170
>     seq_read+0x153/0x440
>     vfs_read+0x94/0x150
>     ksys_read+0x5f/0xe0
>     do_syscall_64+0x59/0x1e0
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> So let's drop WARN_ON() to avoid kernel log flooding.


Applied, thanks.

Miklos

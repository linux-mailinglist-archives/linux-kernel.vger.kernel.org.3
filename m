Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C520D49F14F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbiA1Cx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbiA1Cx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:53:26 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBB8C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:53:26 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c6so14530803ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZSEsahTaMIlSofqaMZHvrGxDpUIJ7LxbR4idGwpdew=;
        b=GjOTsPDJ93PhRReYYYL5QaX/G6LbckIbbxfENXB+nMNkcnTfI82ElvaQVQwxLvvZ8o
         YawOPfZq8G5hKWVpPaGU9INFBQKv69tO4uEZKc2RlHGxPpli1b7YP8NAN0hvCcbEgitg
         SJltmsme+M2ycoqwgoTxSLyVDnWgBClMZkltzZlLLD5UlIdwAVQickOtQUyWfN5Q6C5p
         jw4cGjqzevSZDW3T/vwInaescNrnv8quUqOTBuD9rAGYqe9gjedAYmKuK6TONv/CCDXL
         E4e8nqyX7E9moZPTFBM+IAEcyHTm52WokhjjCJAQ7kmj8JXCfqbQUKG3ONH4hDp70gRl
         fEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZSEsahTaMIlSofqaMZHvrGxDpUIJ7LxbR4idGwpdew=;
        b=xKLbXWA+pLj1sHwsmE1hJq3HNWQmZR6OAM9cNrvyBn6Ke1aSh1bJwZHmgnkRkq/ROj
         8h9xpVOCxfsulxBUW2a8uNTNraM+onoOMdzjL6xez/P45qtp/+1mhfDnVtzugu3HMiv8
         lispQGwGlqJNwHUmn3HWQM6HBYRG63BX1Xm7SmxSx34nTv0f+WI4ZbbdUbUyi6+FA/wa
         ngRxsfUj3wNk75fRfPX7RTuGHILzo2qwChK99qOj1Kd2ucnTuhL5uFycwrUQmSmaM7p3
         fqSHel4ZfmSvMlLNUWErHsGCjI1MFK1myNxXdLJQ1Sae9L9gZlOLBrs8ZgnxbSLEQBz4
         Q+jA==
X-Gm-Message-State: AOAM532sWdYuYLZIn12N+SKQ4yP8/eef/130e2SXhE2jsVzPEUR5feLL
        KEkNdSKTN77ks7nmtQ5qSMR9hHCwBRDTn0VNlvcwXv371tQ8fw==
X-Google-Smtp-Source: ABdhPJzf7c9PkzJz25VZAlwf3/CGlrXvPil3n5mlFwSgExkN4czsiChb2H83zO+Cy9bJb04apCSkp5l8W+EjiV959uQ=
X-Received: by 2002:a25:d80f:: with SMTP id p15mr10191044ybg.753.1643338405485;
 Thu, 27 Jan 2022 18:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20220128014303.2334568-1-jannh@google.com> <CANn89iKWaERfs1iW8jVyRZT8K1LwWM9efiRsx8E1U3CDT39dyw@mail.gmail.com>
 <CAG48ez0sXEjePefCthFdhDskCFhgcnrecEn2jFfteaqa2qwDnQ@mail.gmail.com>
 <CANn89iKmCYq+WBu_S4OvKOXqRSagTg=t8xKq0WC_Rrw+TpKsbw@mail.gmail.com> <CAG48ez2wyQwc5XMKKw8835-4t6+x=X3kPY_CPUqZeh=xQ2krqQ@mail.gmail.com>
In-Reply-To: <CAG48ez2wyQwc5XMKKw8835-4t6+x=X3kPY_CPUqZeh=xQ2krqQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 27 Jan 2022 18:53:14 -0800
Message-ID: <CANn89iKVQBDoAwx+yuJ0P0OAV59bav_abh87BA6n7JuzMKMtCQ@mail.gmail.com>
Subject: Re: [PATCH net] net: dev: Detect dev_hold() after netdev_wait_allrefs()
To:     Jann Horn <jannh@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:48 PM Jann Horn <jannh@google.com> wrote:

> When someone is using NET_DEV_REFCNT_TRACKER for slow debugging, they
> should also be able to take the performance hit of
> CONFIG_PCPU_DEV_REFCNT and rely on the normal increment-from-zero
> detection of the generic refcount code, right? (Maybe
> NET_DEV_REFCNT_TRACKER should depend on !CONFIG_PCPU_DEV_REFCNT?)

NET_DEV_REFCNT_TRACKER is not slow, I think it has neglectable cost really.
(I could not see any difference in my tests)

Also getting a trap at the exact moment of the buggy dev_hold_track()
is somewhat better than after-fact checking.

In your case, linkwatch_add_event() already uses dev_hold_track() so
my proposal would detect the issue right away.

>
> My intent with the extra check in free_netdev() was to get some
> limited detection for production systems that don't use
> NET_DEV_REFCNT_TRACKER.

Understood

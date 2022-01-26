Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91E249CFED
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243260AbiAZQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236669AbiAZQoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:44:22 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708FCC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:44:22 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so419585ybd.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 08:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn+3XwLtFaaXewwNrqnpZ08MIqd56MgA4Nzvpzw2Rck=;
        b=loX2o69cxQhfTbzaEheoHgyXMWaVN9Fl0oxkMMeaymKtyfb/tRiCv15dLMUFO5R39a
         dNhnFqAWDCbIX+sE7BR0FjCwkUB30+XKHMpTd9eZC30WYqQMKlheE+d7ofFQVLQUPMTR
         s6KPtRFoUFG+FMLGvY6pIGHj8wQHUQ+2MprOCGocfP+vWo1X5i/plCUlJPz6IhQCidis
         8/IlzQItYwp2BZ4jhbVFSHGQCijxmFl5PtNn8evTImkHAcsgwUernq90pBSLiHh/cx4C
         Rjx3BaQ8VtJbDcDvlfRJU/HiHoLFMoBbQJP473y8eCIoYbSjQYYWu2iTcxf2nkv8Phx6
         Ajgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hn+3XwLtFaaXewwNrqnpZ08MIqd56MgA4Nzvpzw2Rck=;
        b=crzoEwrKWcI0mAMqxZ0jfrP8cYR2LHxk8na7ZWtPcTJOCfRNmW9qcG0ay1nhJ4/FaV
         8KR/trjfZnJp4lBwwTVfxvbqiREaEdl8v52R/Iu9KbcojrA5VMm3dWzXu9BhFtAAOlHB
         BIiDGPu3l81I8JDEjLChh89nN8aIe0phYEQ9PACmbh/WM0UYz3oiX+uGRtQt94HfuY9N
         cm6bZm5Ccqc3gWVEZNotxphXVdjcdXuTlNLmjgJgQ3ZwRWEG6nhvfo6Ink6xcwtAGoPu
         Yrn5EuAvaRvBnSLPnvub73WdrPmQMqpuTTYQyOlkdYnYC3GliE1M/dRlKolL21JjCF+Q
         qdRg==
X-Gm-Message-State: AOAM532O4lXI2CoogQwEKKWFMp7fmbFjj2Leh2FVZc7YkCYUfkJRswSL
        1zJxvlTDQUVn/zC45bRVew9vFVhGrqD8ZRRYrIg9ag==
X-Google-Smtp-Source: ABdhPJw2JTKWqJxocNIGE7jMUaTewzym6lIQKL0wJPFFdukwj6rNoiUYD9bjMcCFI3+js7uX8oXUgDWYPJ/ajAl0bdM=
X-Received: by 2002:a25:d7cf:: with SMTP id o198mr36466764ybg.602.1643215461475;
 Wed, 26 Jan 2022 08:44:21 -0800 (PST)
MIME-Version: 1.0
References: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com> <YfAL55Xydar/jKrl@cmpxchg.org>
In-Reply-To: <YfAL55Xydar/jKrl@cmpxchg.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 26 Jan 2022 08:44:10 -0800
Message-ID: <CAJuCfpEGUH0SDwP9EJ-uA52R7j3pcVXa+gJX3=QtEhJQ5ig6KA@mail.gmail.com>
Subject: Re: [PATCHv4] psi: fix possible trigger missing in the window
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huangzhaoyang <huangzhaoyang@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 6:40 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Jan 25, 2022 at 02:56:58PM +0800, Huangzhaoyang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > When a new threshold breaching stall happens after a psi event was
> > generated and within the window duration, the new event is not
> > generated because the events are rate-limited to one per window. If
> > after that no new stall is recorded then the event will not be
> > generated even after rate-limiting duration has passed. This is
> > happening because with no new stall, window_update will not be called
> > even though threshold was previously breached. To fix this, record
> > threshold breaching occurrence and generate the event once window
> > duration is passed.
> >
> > Suggested-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looks good. Thanks!

Acked-by: Suren Baghdasaryan <surenb@google.com>

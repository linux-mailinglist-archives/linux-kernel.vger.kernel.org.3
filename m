Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492D950E224
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiDYNpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiDYNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:45:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2F149698
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y21so11557154edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sr6NHdWKU3G7E0q97WawXDyYijNKn/3Z9o8oYg5lN24=;
        b=fL8CwR2tPXkWXaAQUuSJKgbPIwbYhIxgddaWq/Kmn1MpbmxF8jXZwaZSVPOmueO1Hg
         +EjW6bFvMcc3wQd+SeKDvuaCSRLj8RjOLxXUT0jiN5Jw+ce4tN1swlKdjpRLiycy/X+B
         cOPgpIj104tgqAi1o39gLM1emMbRExpAK9Txg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr6NHdWKU3G7E0q97WawXDyYijNKn/3Z9o8oYg5lN24=;
        b=Pw6XkiAAGlaF7Igz/p7plKwM2xv3c6xGNSS1DFaNRyIhcruIJ6O/ZJhCGO9hOvjsyl
         PvyWo95M0Qf9Zrks/v+a8EugKITndLGejt6SOOGOHnDgYkv0tyeQcxod18uKuo/cGjED
         F3kLMz0O9+hmTPTHCrAGiESgDVr0+UGzs8Gq1r5Aerw/N9qoiHBb5wmtfd/qXgr954Xk
         llyGlZsNyVUKaMbsPLU7gSCH14cXSNmhCyluCCRRPrSV7dgYAWTsJo9Rv+Qv1PzD/tym
         k7KvS+htLlPMOn5Wr31B/Tq1g/5/GNr6nfvIPLgERTM4dCNUYHQGgLcR176HOnDBPhPj
         YvFw==
X-Gm-Message-State: AOAM531LuvYvyBRyV8QIZ94lVp7UjGBrp4wuNwspSTkSH5xELSabIwtQ
        WS2F0CHc2IBed46HtnXsJgWyZ9OsWg33Gqw61txYRg==
X-Google-Smtp-Source: ABdhPJyX+EHJxdRI3uyGY/iGAMM47DqAOjilYLyRNrx72zYkSB/r0Gc06ojy5VbdvQ13OFRRaKr6oelSCSlx+b/T5G0=
X-Received: by 2002:a05:6402:50cb:b0:423:d7a8:719e with SMTP id
 h11-20020a05640250cb00b00423d7a8719emr18800324edb.37.1650894120851; Mon, 25
 Apr 2022 06:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220325132126.61949-1-zhangjiachen.jaycee@bytedance.com>
 <CAJfpeguESQm1KsQLyoMRTevLttV8N8NTGsb2tRbNS1AQ_pNAww@mail.gmail.com> <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
In-Reply-To: <CAFQAk7ibzCn8OD84-nfg6_AePsKFTu9m7pXuQwcQP5OBp7ZCag@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 15:41:49 +0200
Message-ID: <CAJfpegsbaz+RRcukJEOw+H=G3ft43vjDMnJ8A24JiuZFQ24eHA@mail.gmail.com>
Subject: Re: Re: [RFC PATCH] fuse: support cache revalidation in
 writeback_cache mode
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xie Yongji <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 at 15:33, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> On Mon, Apr 25, 2022 at 8:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Fri, 25 Mar 2022 at 14:23, Jiachen Zhang
> > <zhangjiachen.jaycee@bytedance.com> wrote:
> > >
> > > Hi all,
> > >
> > > This RFC patch implements attr cache and data cache revalidation for
> > > fuse writeback_cache mode in kernel. Looking forward to any suggestions
> > > or comments on this feature.
> >
> > Quick question before going into the details:  could the cache
> > revalidation be done in the userspace filesystem instead, which would
> > set/clear FOPEN_KEEP_CACHE based on the result of the revalidation?
> >
> > Thanks,
> > Miklos
>
> Hi, Miklos,
>
> Thanks for replying. Yes, I believe we can also perform the
> revalidation in userspace, and we can invalidate the data cache with
> FOPEN_KEEP_CACHE cleared. But for now, there is no way we can
> invalidate attr cache (c/mtime and size)  in writeback mode.

Can you please describe the use case for invalidating the attr cache?

Thanks,
Miklos

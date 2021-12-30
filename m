Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7150481F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbhL3TG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbhL3TG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:06:28 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A374C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:06:27 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id h21so30093881ljh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2njUeTmOSXQ9oVKtPT8JUEx/StHcUEgojYN5cLkfSjY=;
        b=ZM8WvwPrv4jn2BKTcGXKjPqPB+DwjejlfUGS3gZPS0W045tepA4ylYeFNNBI6V11UJ
         6EktwV7UeyEAGvNGtCRPMr2pPJ/yvgsH1xe3LQotuffsxB4VUEQk5Ei3UdXJVOYrduA+
         FmMTkFTDkD9ywNpH7F9FOKxsKNpll/9EzdIJ5nnHsWxUSaJ8nrMNaGne8jLR2LzJg633
         3vLlrPfI09PKm0sM16Iddw3gYA2hw8qnO9KI7KrumUEnIS1WWem9n5x5yq5e3PkL09iz
         zdx6PIAKhBhQIWo7meuPwLi//37SGfjzGIvxEeJ/zFuogwzztB0tQNlaK0OgN6CIwvW0
         ZPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2njUeTmOSXQ9oVKtPT8JUEx/StHcUEgojYN5cLkfSjY=;
        b=rmaXX71wyL2lBs0NPZdJn/33hJQ/TNbBKqbHvHZFYl9Xxb1Ki+HZ/EMesfg33iBVlH
         IlUoBnXSy/lIazyjU1YtUAilVxxTl91TIZLJEaljE/AckRRpA0NlCZ/j7+/0+fCZ3YVx
         7WxmIuyUxGGFgFPHZqpXRe7yRQR2iOkCaRvYIj6Uyge3tZHnvvmjfJKq/9Gf74DBqy3K
         JkpXjBYyrMwE4pdM1Ijn3EZJ0+n1UcHi8KrrslJ4C1FEfYOYMrkba3K0t2fEkVPmKHgo
         aeS08Nrgi6K3OGAQUwCjZscRGUWYx698aN9Kf5GFZlTz+RX4stDrv1b+yVO9XI83ruFt
         wYow==
X-Gm-Message-State: AOAM530YYmA97G52Fe1lcRj3QI3VkM7BCiq7MvstC2mT19RE0m4VSlrN
        BOW9fH9K6gc5Uq8SKIoZMcSbbmSK3Zfjp5+TQb6nYtoywTs=
X-Google-Smtp-Source: ABdhPJyRHsAS7y1biDeCD6kEm0K80HkFw5MoFDckjlmT1t4EDPGqsr5bzllsf+UL1XEhQQFGG61Zd1FJTe4e27CO1js=
X-Received: by 2002:a05:651c:1790:: with SMTP id bn16mr27944310ljb.475.1640891185477;
 Thu, 30 Dec 2021 11:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20211222052457.1960701-1-shakeelb@google.com> <YcmaA9BS/DSB/iER@dhcp22.suse.cz>
In-Reply-To: <YcmaA9BS/DSB/iER@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 30 Dec 2021 11:06:14 -0800
Message-ID: <CALvZod5ORV1y02TcATpRAQVObEPYNv0y0t49bS0f0NTvT6WRSQ@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add per-memcg vmalloc stat
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Mon, Dec 27, 2021 at 2:48 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> >       atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> > +     mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC, area->nr_pages);
> >
> >       /*
> >        * If not enough pages were obtained to accomplish an
>
> Is it safe to assume that the whole area is always charged to the same
> memcg? I am not really deeply familiar with vmalloc internals but is it
> possible that an area could get resized/partially reused with a
> different charging context?

From what I understand, vmalloc areas are not resized or partially
reused at the moment. There is some ongoing discussion on caching it
but caching would also require updating the accounting part as well.

Regarding the whole area charged to the same memcg, the only way it
may get charged to different memcgs is if the process in which the
allocations are happening is migrated to a different memcg. We can
resolve this by traversing the pages in area->pages array (and use
lruvec based stats instead).

I did contemplate on making this a lruvec stat but decided to start
simple and if we ever need per-node stat then we can easily move to
lruvec based stats. Let me know what you think.

thanks,
Shakeel

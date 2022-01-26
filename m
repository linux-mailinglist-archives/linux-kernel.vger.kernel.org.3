Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104549C154
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiAZC3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiAZC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:29:16 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF48C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:29:16 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z131so8860783pgz.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 18:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gBphoDTJ7iVLPaQDaQVzV9+VxlZPl1QowAhFpiBy2s=;
        b=pyBX2sD1RygC8EvnNC6YTU3JUpsdIpob4MgzNSVdbgTORCnmCVVR8meepuClkkK/0P
         QtaT1+t0rXPaah324RrCgXm0ZsiUNkzG6ESeoshTpW8TEKOeiGNvJuU5+U1avMPXhnCO
         ZN8LYftYsOsST8NDk0E02B3ZsRn3XXdxptJ37lWAepXuaQ59a58rqC7ZzJXtd7SAGY11
         HcERwPmxxiuRsmy7TT9BzcVxW5I1IsBHkKfxuIpDAavQDLI1tm1VLt8JVM4lTVFlUZu8
         QIv8h7b8F2jRONxAP2Ti+YvDZ02SMlQirU1cOGRvvDJceUFAdRnSqlHr0kKGelDgAs8P
         FzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gBphoDTJ7iVLPaQDaQVzV9+VxlZPl1QowAhFpiBy2s=;
        b=pLIhXKQRNqJ0yRZTwtm83qn/ioikvKbsItgoFfZGa+ES7qWaucOeBaLnsadWX7GNfK
         NsvfHPIe14bU9VE0dGaduz2cHhnui2s3gJWPrTJM58uq8o++1Rtp3f31MZDEtLEK/4EO
         O2P55Svuv5kQxl46UrUUfXJ3e6JMBV3pqaQyKWzInFFiaIDNx9SZLfrde3UmVwvS48o+
         cK9WqStDsJLrn5H3LzMe52ssj9paIeN3Smqk60If5RvybDu0eYeMNgRRicF4W6V5k7DH
         LkbRAtVgx5FEI9EApaxtErmvfxSfpLxjvaRG956ymsDIs9tEugKc3aL5aTGDsF0/S38s
         WcbA==
X-Gm-Message-State: AOAM53257qnBkkjIaKSRjN8euC9kHu6dnvf9rcBHqboaeQYeb+qRNpYJ
        LB/505MH19PmII7i2aFmLTrzINCTaXmlEPR0xes=
X-Google-Smtp-Source: ABdhPJwG/ZIu+1/wlNxAA9pZHwzt7g6rFWUHuneUvYdotEqJASJ3HaLwkDQ7pKqViOY2jAWr7QfC0akH8vsvfYj4+hg=
X-Received: by 2002:a05:6a00:70d:b0:4c0:1cbf:2394 with SMTP id
 13-20020a056a00070d00b004c01cbf2394mr20816535pfl.69.1643164155681; Tue, 25
 Jan 2022 18:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20220119012109.551931-1-yury.norov@gmail.com> <20220125182550.7c693c76fe6520047c2e4f26@linux-foundation.org>
In-Reply-To: <20220125182550.7c693c76fe6520047c2e4f26@linux-foundation.org>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 25 Jan 2022 18:29:04 -0800
Message-ID: <CAAH8bW9s9ENa7QOExV3rOqn-LAEu1RrQd+ijor9o=jhGxm=6ew@mail.gmail.com>
Subject: Re: [PATCH v2] vmap(): don't allow invalid pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 6:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 18 Jan 2022 17:21:09 -0800 Yury Norov <yury.norov@gmail.com> wrote:
>
> > vmap() takes struct page *pages as one of arguments, and user may provide
> > an invalid pointer which would lead to data abort at address translation
> > later.
>
> Does "user" mean userspace code?
>
> If so, please tell us much more about the means by which userspace can
> trigger this problem.

User means user of vmap() API. The discussion is here:

https://lore.kernel.org/linux-mm/20220118235244.540103-1-yury.norov@gmail.com/

I'll send v3 soon with more details in the patch description.

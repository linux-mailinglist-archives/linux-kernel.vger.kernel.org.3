Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E647E3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243859AbhLWMlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhLWMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:41:50 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38E3C061401;
        Thu, 23 Dec 2021 04:41:49 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e136so16058778ybc.4;
        Thu, 23 Dec 2021 04:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMFcygJOqx2hcVsxt5vWXtekAovZBeJCWpY0ATwarLo=;
        b=HI98DRduBhuffS4+1P9Y1dm7p8F5NgMLd3EpBfgpVldac6dM/pfJarkGyCySSc3ig3
         IT3JMr2miSBSH60WGbvGwWwjr3hAUWTdREHK7DnJXhQALkBka5Sn7u3sz+3n0S/d4nAd
         95HIdBf7rxbiBC13koFgFHej7upm3L6oB4Ls8Dh+WMRFi+yHSeI+RyKZps+CgedDvEfc
         IZsaR6Xvs3TXElxeUxWELcsn4JBvfQ1HNSdNi9DQtdS7lvio3sKrQuRVipzXgmfTsOmG
         w+Swm8NRqJJwBgJkyvGTpjnvIVyOg0TlGQc4/AvGBspyC84IjHQ4xCifQEBW3JPQWNa6
         nN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMFcygJOqx2hcVsxt5vWXtekAovZBeJCWpY0ATwarLo=;
        b=eECjukm3hvq/0Wtib4E1A0F37EJumZQ+kBBC5eAR4wcWewqwVUZOxsBU4rRFiGO7Gh
         vNEmpb4xTkoABdfFFmtQxfqXvQ56xH7jpSSl61ZWy/fQsbcA5/NAxBi5u+xMtn+dG91Y
         Qv6Sn4RHwATa4GKWyysPk9baQW8TbC4h2jqK3Th6fhHLKudFDjte2/FlMAyhOjQhHhrD
         3x7PvKmQiKYWQp2EDnJEKgRQxUT6kJCwtv8NXah0VNObvK1o35xAhrcHfZhP/M51tILy
         0nxo3EllxZyWjjvZYQk5+CLAHkpVjCyG8sQ1fNmSqxEEQEqtWiRa2neC1gfuQ1gH4Ot9
         UNJA==
X-Gm-Message-State: AOAM532Da3qmhzVBl1xXP99zZ/KUXhXfxOAws/vPToFXszciyG6ZbniD
        llP+NfhaBn2UpalKPoSyYOQlz3J2z6gghE+v4/yPEQzi
X-Google-Smtp-Source: ABdhPJxepOFwSslsh7zK8xgJih6RR3ovUUWt+TYOCT4MJuC+MZVGjLUAvm3k2lglBNCkM7IYXlpEhJ135XhLHlh03fQ=
X-Received: by 2002:a25:dfd1:: with SMTP id w200mr2924404ybg.359.1640263309089;
 Thu, 23 Dec 2021 04:41:49 -0800 (PST)
MIME-Version: 1.0
References: <20211223123003.6947-1-lukas.bulwahn@gmail.com> <20211223123724.GA23339@lst.de>
In-Reply-To: <20211223123724.GA23339@lst.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 23 Dec 2021 13:41:38 +0100
Message-ID: <CAKXUXMxGcJDiw9ZckCEuv-qiYvTZFh7d6PH5oXG-oS1KknDOew@mail.gmail.com>
Subject: Re: [PATCH] block: drop needless assignment in set_task_ioprio()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 1:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> >               if (task->io_context) {
> >                       kmem_cache_free(iocontext_cachep, ioc);
> > -                     ioc = task->io_context;
> >               } else {
> >                       task->io_context = ioc;
> >               }
>
> Please also drop the now superflous braces.

Will do. Patch v2 will be there in a second... Lukas

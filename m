Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C32460FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbhK2IZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:25:30 -0500
Received: from mail-vk1-f182.google.com ([209.85.221.182]:39544 "EHLO
        mail-vk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhK2IX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:23:29 -0500
Received: by mail-vk1-f182.google.com with SMTP id 84so10468378vkc.6;
        Mon, 29 Nov 2021 00:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5BQgcOrUvLNDtZYraiJLQUtUu4O8GrQnMfpQiDVOOQ=;
        b=OVIhiSeEp5/0XXHciF122MwFAVzglvH5+fyoxGBujlhI4gM4OucOMmBK7UMnEzbWj3
         fN+e14VcDxxx5FSmupcC+xKqEYOIYTl7WAtuhznbs/RSwC68Gpx/irQheEvpTKRqIjIc
         RcSGBRoI9D3QY3sFV9nnegM3bFg8X9nAC6SLzqMcWa8Mwgb7P7BX5wKb6zB3IClybi07
         DN4gbVyLnP0+d/y9j9TzU3OP8QU4FKJDYiSNZxr2nX2zN6rFaAPpZytgJ4/4YgK8jWPy
         cA6kL0liOLaDq4JDJtKAe3fTQxDuJTEJrwx973u1qCNWYcLBoi5N029s8QTNapOSFsfH
         Eedw==
X-Gm-Message-State: AOAM530JHoGdGpofk3eWRAclF3nlNSVdRC4l4urjq89+rEaspZpTJhFA
        OyRMOPnnJHW0n+BmmH1ZagGeQnnJiO6HcA==
X-Google-Smtp-Source: ABdhPJx/yTvEs8Ih38aVkSFDynfmn/vcbOzAg2DZO7LC23jYtIykLa85akYupXSHeqz6SS1OO/yxPQ==
X-Received: by 2002:a05:6122:16a3:: with SMTP id 35mr33716342vkl.11.1638174011769;
        Mon, 29 Nov 2021 00:20:11 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id d16sm7518424vko.29.2021.11.29.00.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 00:20:11 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id r15so32322764uao.3;
        Mon, 29 Nov 2021 00:20:11 -0800 (PST)
X-Received: by 2002:a05:6102:e10:: with SMTP id o16mr30473209vst.5.1638174011305;
 Mon, 29 Nov 2021 00:20:11 -0800 (PST)
MIME-Version: 1.0
References: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
In-Reply-To: <8f6a78cf7b60160ef3d22445ee1b8f2c0678f74b.1637879659.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Nov 2021 09:20:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUcFYTLQDdpCh-pcv9nWeKp39wR4iGzbbSPjyNq_xRBGg@mail.gmail.com>
Message-ID: <CAMuHMdUcFYTLQDdpCh-pcv9nWeKp39wR4iGzbbSPjyNq_xRBGg@mail.gmail.com>
Subject: Re: [PATCH v2] pata_falcon: Avoid type warnings from sparse
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 11:36 PM Finn Thain <fthain@linux-m68k.org> wrote:
> The zero day bot reported some sparse complaints in pata_falcon.c. E.g.
>
> drivers/ata/pata_falcon.c:58:41: warning: cast removes address space '__iomem' of expression
> drivers/ata/pata_falcon.c:58:41: warning: incorrect type in argument 1 (different address spaces)
> drivers/ata/pata_falcon.c:58:41:    expected unsigned short volatile [noderef] [usertype] __iomem *port
> drivers/ata/pata_falcon.c:58:41:    got unsigned short [usertype] *
>
> The same thing shows up in 8 places, all told. Avoid this by removing
> unnecessary type casts.
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Michael Schmitz <schmitzmic@gmail.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

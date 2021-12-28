Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C836F480796
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhL1JJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 04:09:42 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:44798 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhL1JJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 04:09:41 -0500
Received: by mail-vk1-f180.google.com with SMTP id b77so9958983vka.11;
        Tue, 28 Dec 2021 01:09:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2L/mIkOhGH5Un7mufox+a5rve6lVrG/dmfdaGHBhKs=;
        b=lZKHxm4nCkl2WI6gLo/tHnd9f4Ii1n71q9nPHgwttdi+5kMSPoaLIxW6nNi6zdyZri
         uzNZliqh7l1pSTM8mcMplxxyNvbYVnpVitCLt/1+rrvXcuX0dBeJNiGBZcc8ypJC0hGk
         yw8oX7l5KqoMSgL8jF1HerYQll5aZA5i4qWooZC0hBX73sOnbL3HuIAjMpHrrATfr8MZ
         d6P68KVdxUYPgbEAqk2fLdM7lr3pWb5UqNQ21QjddBxpH5Rxq3xeWqwTe5GMOA5a905u
         0fQKruFakAk0kR9RUKSZ/ivtQVybHlqEddxzP4fDLJZu7D7LUawsWG6euMcsSE404rLS
         AAMQ==
X-Gm-Message-State: AOAM530qh4gxgbmhzmdVpnOyxxpYFngRzwmYnBuuxq6Bf/M6DE2XJ48p
        PypCHABs8SduNbj0LulhuZ1BvxX1JQxxdw==
X-Google-Smtp-Source: ABdhPJwl5xABcsAZHJLdoiOpNYFGptDSMwBnxedcJ0OF3HGydxFU3rK+sF6Orat0Rnk5zAvn7xb0/g==
X-Received: by 2002:a05:6122:16a7:: with SMTP id 39mr6236243vkl.13.1640682580467;
        Tue, 28 Dec 2021 01:09:40 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id o19sm3356463vsl.12.2021.12.28.01.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Dec 2021 01:09:40 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id o63so31013772uao.5;
        Tue, 28 Dec 2021 01:09:40 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr5620772vsg.68.1640682579829;
 Tue, 28 Dec 2021 01:09:39 -0800 (PST)
MIME-Version: 1.0
References: <20211214172437.1552740-1-broonie@kernel.org>
In-Reply-To: <20211214172437.1552740-1-broonie@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Dec 2021 10:09:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
Message-ID: <CAMuHMdUQjKOp6B7_-pG8t8OzrH=H+dYjn65YMHHy7CLaw6OU1g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the dmaengine tree with the
 dmaengine-fixes tree
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 10:53 AM <broonie@kernel.org> wrote:
> Today's linux-next merge of the dmaengine tree got a conflict in:
>
>   drivers/dma/idxd/submit.c
>
> between commit:
>
>   8affd8a4b5ce3 ("dmaengine: idxd: fix missed completion on abort path")
>
> from the dmaengine-fixes tree and commit:
>
>   5d78abb6fbc97 ("dmaengine: idxd: rework descriptor free path on failure")
>
> from the dmaengine tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> diff --cc drivers/dma/idxd/submit.c
> index 83452fbbb168b,569815a84e95b..0000000000000
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@@ -134,20 -120,32 +125,43 @@@ static void llist_abort_desc(struct idx
>         spin_unlock(&ie->list_lock);
>
>         if (found)
> -               complete_desc(found, IDXD_COMPLETE_ABORT);
> +               idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
>  +
>  +      /*
> -        * complete_desc() will return desc to allocator and the desc can be
> -        * acquired by a different process and the desc->list can be modified.
> -        * Delete desc from list so the list trasversing does not get corrupted
> -        * by the other process.
> ++       * completing the descriptor will return desc to allocator and
> ++       * the desc can be acquired by a different process and the
> ++       * desc->list can be modified.  Delete desc from list so the
> ++       * list trasversing does not get corrupted by the other process.

traversing

>  +       */
>  +      list_for_each_entry_safe(d, t, &flist, list) {
>  +              list_del_init(&d->list);
> -               complete_desc(d, IDXD_COMPLETE_NORMAL);
> ++              idxd_dma_complete_txd(d, IDXD_COMPLETE_NORMAL, false);

Is "false" correct here?

>  +      }
>   }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

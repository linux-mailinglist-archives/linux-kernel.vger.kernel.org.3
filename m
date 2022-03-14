Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55C4D8828
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbiCNPfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiCNPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:34:55 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E54CE0BA;
        Mon, 14 Mar 2022 08:33:45 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2e51609648cso76081017b3.10;
        Mon, 14 Mar 2022 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Uf1X6BAagoyzcf9c5dvcehL531aJr8OKOHip8qjCDs=;
        b=RfIFHwmN6k+Gp0IVda/zINTwdNi/MZEye6oR71nG0/6PU2BUectEz7CkifHFsFHauO
         eTq1Cf5ayYujzyMNhBpGmwcEAcUl1P2J2WKLu50a3wXXl0sYa+R5vUCjG28N/Aoun3tO
         dGErBDZBJBD1JcAXVG+YEHfg+WhZ3RZEdhyTQ3mGnKar1LTAF+5KKbVYYfmATywMo/YH
         PXidlyp4lAN+021MkXbSFJil4QtYgR5EJ/bCtQ2YrU3MueYhf/fvW0/d2IYiLwiM7r4q
         zVjAGZlMGcxL7aW5JRYFz7zndLhVRX5BGG7xeSB7afCrmn25trSkGKuDd1JtsZUCzQ4b
         6J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Uf1X6BAagoyzcf9c5dvcehL531aJr8OKOHip8qjCDs=;
        b=cxKH3y9dPa8Urkc/S6ccf+lm8048fMq+PmmV4UAMWGDqKy4WrdaWav98/jubujsYqu
         m+E0dVOkdZSEMtmj6873gnmHe547D3BCmwd8DU8X/6WmTdwGzXH8zs+LfrcpijjR620m
         yJ8hmqsdvXgO3WiB6E8tRZez32WgKZkw7g0Ajk6hEvuhCP4pTheLPyIobSv4rvxE4mcu
         Roix33+tSnugxpCthx8f7azAPc/AqkVk66+SqhoDEl/ExOlXzhhG66QQg2tZTOA5XdeO
         wopC/u96J9/qQx8L247LCqFr2cDKPaX8S/xRGh5UHHxC7J7EndjBQ51mj93KY2JFfgMn
         NybA==
X-Gm-Message-State: AOAM532Os1/7dmJaVNHRmt8bUS4GBoZf1aSgaVlmHx6blNT/4b38oGay
        6w9T5JaUD0cppHdHpnPM16juyZBCrGPdnKgILGY=
X-Google-Smtp-Source: ABdhPJzAEkW3U8RcBIrN2CYdtTeG5V354VjfFYOWSsw+ja/YXGMk8Kvulorztry28q/9rxOJ2iPDAsNNkGpvuBU8vrw=
X-Received: by 2002:a81:fc06:0:b0:2d6:4a8d:943f with SMTP id
 g6-20020a81fc06000000b002d64a8d943fmr20275962ywi.464.1647272024282; Mon, 14
 Mar 2022 08:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220314150321.17720-1-lukas.bulwahn@gmail.com> <0d79b44c-d51e-282c-99a0-78ae6c9f6f01@kernel.dk>
In-Reply-To: <0d79b44c-d51e-282c-99a0-78ae6c9f6f01@kernel.dk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Mon, 14 Mar 2022 16:33:33 +0100
Message-ID: <CAKXUXMz4XkWTizAjD9nB3x47Fu4+1=pQgWRQNnFzxqCPr8cFSg@mail.gmail.com>
Subject: Re: [PATCH] sr: simplify the local variable initialization in sr_block_open()
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 4:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/14/22 9:03 AM, Lukas Bulwahn wrote:
> > Commit 01d0c698536f ("sr: implement ->free_disk to simplify refcounting")
> > refactored sr_block_open(), initialized one variable with a duplicate
> > assignment (probably an unintended copy & paste duplication) and turned one
> > error case into an early return, which makes the initialization of the
> > return variable needless.
> >
> > So, simplify the local variable initialization in sr_block_open() to make
> > the code a bit more clear.
> >
> > No functional change. No change in resulting object code.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Christoph, please ack.
> >
> > Jens, please pick this minor clean-up on your -next branch on top of the
> > commit above.
>
> Should it have a Fixes line?
>

As it is really just syntactic clean-up, it does not deserve the
attention for any kind of severity assessment or potential
backporting, which usually comes with a Fixes: tag.

So, I personally do not consider a Fixes: tag needed. The code works
well before this patch, and well after this patch; it is just a bit
more clear now.

Lukas

> --
> Jens Axboe
>

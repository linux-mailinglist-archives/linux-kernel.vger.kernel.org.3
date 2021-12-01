Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E168A4644B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 03:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbhLACIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 21:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbhLACId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 21:08:33 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:05:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id e3so94920192edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 18:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=42m790/IGCobksWss1SnqgLm+pgiOFsHShM/cPNqVew=;
        b=p9fqmzZg9PnnKxpdk0nUus8Val7ofxjRnlBL6LmhrlLq9sG2JksQ6WRwVK7OnSAo4U
         v4UaEeEGAiDbX/IbGk+0wB8MNsMxPIx3tDCWDv5lJRot8LbbvhV4XK1Lavo7GIGDMdTW
         ew4Sm+rRUKMsUfsN4BReHOO9wH6FkewypwsRzO4Isseb64JR0Kyvh0D1qoEpv9833Lo2
         KQ/gP6dA5KoeyuFfVhQpQ8LUZ0KA2RDyrZH884OwH79WLn0avJpNz/Ig2lUdQRAyWJFa
         vElftcF1oHLggR2MXv+LminZcUK9t1McDeSM5amDHRaum9YD41//D3gGSrn7hTUpphsF
         Jhrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42m790/IGCobksWss1SnqgLm+pgiOFsHShM/cPNqVew=;
        b=sw36lPjmATsy3jFnUNsUriJDRDqkwWqcIY4kI8K7bMMThzTLieND+D9l/s5fGgtlEu
         bW5YhAVgB77QMBY02AC5+usZNR7oCC4Xzr3djU1C4QsH4CMFwjG+1rkwqRQCWMmMW0pu
         TNqccIGZE7x1dvbez8t0fRXOBzPr9tTJzgzbPxaSQem5hxKA6ljhY1CknM34rkcUYIfv
         MYN6am+qUr23c7huaISqQfpIGq1jSqGOCFLaN/zl1rMFFmZ2fRGYwPC5pNoIbIVn4Y7E
         OZ2Z8/+waYePyOPQPFH2nE/trQO5Ox88XUHjMqvltm//XsSn8QmhX3xRuPXcMATyKHnz
         sf2A==
X-Gm-Message-State: AOAM530Kp0jVfQdbgpDaRqhLybOaqDFnBRr7bqggZ7q6KZZZhL5El4bB
        c1K8zT558Jm20P2R/ugBqa+K0wElxp5z71aEPksdzNnpaYQ=
X-Google-Smtp-Source: ABdhPJzA7jfhRFpemSo5Uszm7kBcaFbtdUFFGtyZcN7KnARwI28LZLMZVWhkafHSKbJrfcD3JF5S6BYNiw+cthcJmAo=
X-Received: by 2002:a17:907:3d94:: with SMTP id he20mr3598141ejc.75.1638324311884;
 Tue, 30 Nov 2021 18:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20211130135015.1818325-1-mudongliangabcd@gmail.com> <20211130154754.GA3627665@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211130154754.GA3627665@dhcp-10-100-145-180.wdc.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Wed, 1 Dec 2021 10:04:46 +0800
Message-ID: <CAD-N9QV2NjeM_Rb0MuotXLefooX3CwXySmyjNXQhfyVVPPADEg@mail.gmail.com>
Subject: Re: [PATCH] driver: nvme: fix missing error code
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:48 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Nov 30, 2021 at 09:50:14PM +0800, Dongliang Mu wrote:
> > Smatch reports:
> >
> > drivers/nvme/host/multipath.c:865
> > nvme_mpath_init_identify() warn: missing error code 'error'
> >
> > In one error handling path of nvme_mpath_init_identify(Line 865), error
> > is not initialized as an errno.
> >
> > Fix this by assigning error to -EINVAL.
>
> Nak, the code is correct as-is. Returning a negetive error will abort
> the initialization process. We don't need ANA support in order to manage
> this controller, so failing a controller for an optional condition
> isn't helpful.
>

OK, I see. Let's ignore this patch.

> The other parts of this function returning negetive errors should be
> fixed to return 0, though.

Do I need to modify the error value to zero and submit another patch?
Or you will take care of it?

>
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/nvme/host/multipath.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> > index 7f2071f2460c..2cbeb6d6b064 100644
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -862,6 +862,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> >                       "ANA log page size (%zd) larger than MDTS (%zd).\n",
> >                       ana_log_size, max_transfer_size);
> >               dev_err(ctrl->device, "disabling ANA support.\n");
> > +             error = -EINVAL;
> >               goto out_uninit;
> >       }
> >       if (ana_log_size > ctrl->ana_log_size) {
> > --
> > 2.25.1
> >

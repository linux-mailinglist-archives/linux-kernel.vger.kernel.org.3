Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C455489543
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242976AbiAJJcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbiAJJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:31:35 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3260C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:31:34 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id d14so10821838ila.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpHgw6UpVVG5H52/tvDsDE4I8M6x/y865h/7HwVLG7U=;
        b=JfDVm3uBcevT4eiLNGWsg9uSDxPmCKimiFap3zfcV3/T9N49KhP2MALeypetQXArbW
         0Vi9mlmqTS4f1svjgFH2eGMfRuZWav4m3iw+4y2l2z6lrIkVIuHrMw9A0QA+tRWNsgjI
         eGK3EMqvkBrFWzU2qfRW89LEROefsrlSiZx+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpHgw6UpVVG5H52/tvDsDE4I8M6x/y865h/7HwVLG7U=;
        b=miG6TQhIw/jPu2hcEg+TKJNRJoTVHztrWOJR5ML6SCqmwUoSsgOOz36ag2zDj5RrlJ
         gfAE4NpmnCbuN/o5G3uwj2DNN6wcGAZ3/eu6mxA6TjYrAeC+A5VxsWcqCXZJXSxnPNKR
         V/wCUdoU2gxb69An44ZXxXPbigcoP/auKJyhm7KPn/Kj23mvvD/xRkrax87R44ovIenk
         qE1HHLobOp4Njm8zxNctk7RPbp+Q61x1cxSTHxUMR+oZs7cAQFsfpqNETSqiEMz3YUQX
         oa5Kuq/gGZk8r17fAmR+BhQ2iy4vBYd4aObou434UTXjT4db6Ssjkve+8ZPAWa0L9z+j
         7WNA==
X-Gm-Message-State: AOAM533daQt3VkAAGfzQKQFQCoYDifMCVQj8xH0vAbNofMClvvK9YKtW
        JPfCUB/VOyIWqJvBNh7zSuO0P1bohh06CyNgvEuTqQ==
X-Google-Smtp-Source: ABdhPJzgHOZExtCPA3Jb6BdJBdMMzFv4mrZHCv73Xpy8ayJyi9Rweur1v7bUrxh6WNniiAAD0yhQksZuIuk8J3Sd0bU=
X-Received: by 2002:a92:6f09:: with SMTP id k9mr8744870ilc.61.1641807094384;
 Mon, 10 Jan 2022 01:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20220105220653.122451-1-gwendal@chromium.org> <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
 <CAPUE2uu3FPvxHHGYGbckxR=QmWt3=KwFk3DYoqBSmaQd+AO0QA@mail.gmail.com> <20220106110558.49dd6f26@coco.lan>
In-Reply-To: <20220106110558.49dd6f26@coco.lan>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 10 Jan 2022 01:31:23 -0800
Message-ID: <CAPUE2usF1m8rmE1_Nrdv_B5SfXExzKzGnhcZrmcSHFSMQzyjiw@mail.gmail.com>
Subject: Re: [PATCH 00/17] Add export symbol namespace PL_CHROMEOS
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        hverkuil-cisco@xs4all.nl, lee.jones@linaro.org,
        pmalani@chromium.org, sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 2:06 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> Em Wed, 5 Jan 2022 20:26:36 -0800
> Gwendal Grignou <gwendal@chromium.org> escreveu:
>
> > On Wed, Jan 5, 2022 at 2:58 PM Dmitry Torokhov <dtor@chromium.org> wrote:
> > >
> > > Hi Gwendal,
> > >
> > > On Wed, Jan 5, 2022 at 2:07 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> > > >
> > > > Add a symbol namespace for functions exported by the plaform chromeos
> > > > subsystem.
> > >
> > > It would be great to explain why this is needed/desirable. What are
> > > the benefits of introducing this namespace? What problem are you
> > > trying to solve?
> > The issue came when reviewing an iio sensor
> > (https://www.spinics.net/lists/linux-iio/msg66280.html). I wanted to
> > be ahead of the curve (for once).
>
> Patch 01 should clearly document the reason why this is needed.
> Yet, see below.
>
> While I see value on using namespaces, we should have extra care when
> this is used for kAPIs designed for a product/system. I mean, what
> prevents that the affected drivers won't support some day different
> non-ChromeOS products? We have a media driver originally written to
> work with the One Laptop Per Children hardware, that used some
> product-specific kAPIs, that were extended a couple years later to
> cover different types of hardware.
>
> What happens if some day, a driver introduced to be used on a ChromeOS
> hardware would also be used by a non-ChromeOS hardware? This could
> become messy as times goes by.
>
> Instead, IMO, it would make sense to have per-subsystem namespaces.
> So, for instance, placing iio under an IIO-specific namespace
> (and the same for other subsystems) makes more sense on my
> eyes, as the namespace boundary will be clearer, and an IIO driver
> will always be IIO, no matter on what hardware such driver would
> be used.
I based this patchset on the current/future use in the IIO subsystem,
where the namespaces are used for small subsystem like HID,
IIO_HID_ATTRIBUTES, or code shared among sensors drivers of the same
vendor (LTC2497, more to come).
Since the usage of namespace in the kernel is not clearly defined yet,
I wait for the dust to settle and more usage to emerge before tuning
this patchset.

Thanks,
Gwendal.
>
> Thanks,
> Mauro

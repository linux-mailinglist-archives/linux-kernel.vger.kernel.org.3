Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9347404E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbhLNKVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 05:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbhLNKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:21:07 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869E2C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:21:07 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id s17so12171152vka.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 02:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8Fa8Kszo3XIjbu8l4Yejv1uFgZJe7E3nSQeyvq6bbo=;
        b=py1sUqVwM/zL1uOqW3ziX5MlFaF3wX/LlJtZAsVED87EbZZyaR64ZcwuZYOtL9AtFl
         FD4BwC5lejvgg1ipZnhfWvxVDudxpjvVo8DrUoWoRAC0hXMbnHW64awwlGact2kBJsaQ
         Ox8c3ZjNnXRiFEJiTaywNqyUo1i76zEcIRn+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8Fa8Kszo3XIjbu8l4Yejv1uFgZJe7E3nSQeyvq6bbo=;
        b=Zqo3qZOzPX/rvrA12pN2hmxsjPyi8GL9SDoiERf91G0u3hR5zMJsFsR5yXPbs7zJE+
         YympqrM+eWLGC3s2WNe/rU3nhO47ueHpIx72DU2DDRZqHzgVOKSCTwUz7AqPwuqxuXXt
         dtKAH42gkP5b1YM9ndZnjz9B9m5GvhomqB/i9Khpe3rFuuiLQWvBM6XLPtdzcwSbFPA4
         VJ4yqLOuBBBbopZn/gZ9XXhzCft05Uei2j/RV8msaSp2QGBKJLA8A2v4SaLeVJUdKx3Q
         Apg3V+gSHn5QEbTKyg1g07O9gl+KnuBioU3L/yw3b8jDTaDoWg7AQQSU5tO6/F/uuH33
         2tdg==
X-Gm-Message-State: AOAM532VlDBsQ8pB15Q/K0Ha3PCbICG7QsaElmsB99B3eccJkyPJxstd
        pw9sJaQ5ZRMyFWiBXo/JelPo/NmtN2E53dAYGEUENw==
X-Google-Smtp-Source: ABdhPJztx268YvgATu/AlJUf2NurU4d2rYV2fPqGq1H/pVe9eAFZMQbAxLg7sQXz7OUEhJJKrHMM/DGcQx5SZvP0444=
X-Received: by 2002:a1f:5f94:: with SMTP id t142mr4620765vkb.34.1639477266564;
 Tue, 14 Dec 2021 02:21:06 -0800 (PST)
MIME-Version: 1.0
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
 <20211201175613.13710-2-dafna.hirschfeld@collabora.com> <CAFr9PX=6Pd1Rg=wJvpuX6WX63L=iAnwPA24e59An3Kac5f_vzA@mail.gmail.com>
 <cdd9b485-364f-c6bd-776f-a0ca2d260762@collabora.com> <e9905774-a994-6311-7b53-b40588d4f6ec@collabora.com>
In-Reply-To: <e9905774-a994-6311-7b53-b40588d4f6ec@collabora.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 14 Dec 2021 19:20:55 +0900
Message-ID: <CAFr9PXnnGc1TUQBeW8JW9qGewhU99gmRbvzZEsZaDmr12jMg0A@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] staging: media: wave5: Add vpuapi layer
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

On Tue, 14 Dec 2021 at 16:48, Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
> >>> +static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
> >>> +{
> >>> +       u32 gdi_status_check_value = 0x3f;
> >>> +       u32 data;
> >>> +
> >>> +       if (vpu_dev->product_code == WAVE521C_CODE ||
> >>> +           vpu_dev->product_code == WAVE521_CODE ||
> >>> +        vpu_dev->product_code == WAVE521E1_CODE)
> >>> +               gdi_status_check_value = 0x00ff1f3f;
> >>> +
> >>> +       return read_poll_timeout(wave5_vdi_read_register, data, data == gdi_status_check_value,
> >>> +                                0, timeout * 1000, false, vpu_dev, addr);
> >>> +}
> >>> +
> >>
> >> This looks like it should be s/wave5_vdi_read_register/wave5_read_register/.
> >> For wave511 addr passed in here is 0x8e14 so well outside of what is
> >> directly accessible.
> >
> > Hi, I didn't understand this explanation. I see that
> > wave5_read_register eventually calls 'wave5_vdi_read_register'.
> > Could you please explain in more detail why you think
> > calling wave5_vdi_read_register is wrong?

Mainly because the address accessed 0x8e14 but on my machine the
directly accessible registers end at 0x800.

> hi, I see know that those backbone address are indeed not read and written directly but
> the address should be first written to a regsiter W5_VPU_FIO_CTRL_ADDR,
> and then the content is returned from W5_VPU_FIO_DATA.

I think so. But as I can't get this driver to fully work yet I can
only say I think so.

Cheers,

Daniel

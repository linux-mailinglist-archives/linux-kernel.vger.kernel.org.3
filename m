Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B00D4690BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238437AbhLFH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbhLFH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 02:27:07 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F87C0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:23:39 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id o1so17736693uap.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVXIT3QBReTAXMWK2JBRHaKSQvnCkPugoBOMsNBKysg=;
        b=maqLUi5cEmc99xwy3nFbbYAYdHLt75CoLJ0K9WVYMH3Zv6pm7qtoNUklMqOQdvlUbg
         KFavq8DcElKOxy3YRuj+2DUuBN8X7Zj6XwDTHUph2GVpZAvRrxFhD+j8SttjdkpQ+kMy
         BJpE+4wFU/RAIXFGz7Ne4gWhtocENWmibWVHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVXIT3QBReTAXMWK2JBRHaKSQvnCkPugoBOMsNBKysg=;
        b=5iHdUqxJbEGor+8Z/6UKtoc6GSDW8sXcfycDxvPtwoLLP0BbyQ53Z5QZFS5BgmLCra
         XrRRjt3rre4L9e9gh8AvHNWVe6FW9fipYvrtKtLUjV5/o/as/aQCq9UwgN59iojNg227
         hmB6oGCYrCUjB4uhBuJktFekQyXZcLGtDALfnLsRiWnK17XOlkH3OCacXvpq8ZWta+Qn
         SO25UtYd+6eTVgN0ZrduD/uNodHDy3PdqS6oafNMnM6OV5S8dVeRcom3+vi7HJLA32xQ
         75sXcuhs7nzr9T4nLHQuGm20sMagvE3vRNDq9Hgtil0PZtOdLevsFqE/KEXFofbj/b9+
         oQvg==
X-Gm-Message-State: AOAM531du6/5gFf4vVTvtFdcXQDDsbl44j/W1gHKKJ5RgHLHtJzkm4bc
        qVDRceW0cK9FZ910mNMRMjfbhatI570T9Q==
X-Google-Smtp-Source: ABdhPJxpyLkwiow7O1Fa6LPxXbVfm9VX0w7ybvexO1e4KZlCE32FxFuSCu+GfwlgOo7lILn8mPr2Jw==
X-Received: by 2002:a67:c79a:: with SMTP id t26mr34223085vsk.37.1638775418234;
        Sun, 05 Dec 2021 23:23:38 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id b13sm3733342vkn.38.2021.12.05.23.23.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Dec 2021 23:23:37 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id l24so17804525uak.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:23:37 -0800 (PST)
X-Received: by 2002:a67:ef4b:: with SMTP id k11mr34003840vsr.74.1638775416913;
 Sun, 05 Dec 2021 23:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20210920170408.1561-1-dafna.hirschfeld@collabora.com>
 <c59b7f40-d99e-370a-b797-5dc72979df46@xs4all.nl> <CAPBb6MW_i1_Lh2ZaF8jGjcV-4XBhjswtyKkZCk3HxKO7LX79Og@mail.gmail.com>
 <1d509eea-37ef-bfd1-cfe7-0a204d8c4bd4@collabora.com>
In-Reply-To: <1d509eea-37ef-bfd1-cfe7-0a204d8c4bd4@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 6 Dec 2021 16:23:25 +0900
X-Gmail-Original-Message-ID: <CAPBb6MU6KvhwXa=dx+8P1a5gYt4P6W3A2EbfC+6dYfDNSKvATQ@mail.gmail.com>
Message-ID: <CAPBb6MU6KvhwXa=dx+8P1a5gYt4P6W3A2EbfC+6dYfDNSKvATQ@mail.gmail.com>
Subject: Re: [PATCH v4] media: mtk-vpu: Ensure alignment of 8 for DTCM buffer
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        minghsiu.tsai@mediatek.com, houlong.wei@mediatek.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:39 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
>
>
> On 18.10.21 04:16, Alexandre Courbot wrote:
> > Hi Hans!
> >
> > On Mon, Oct 4, 2021 at 6:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>
> >> On 20/09/2021 19:04, Dafna Hirschfeld wrote:
> >>> From: Alexandre Courbot <acourbot@chromium.org>
> >>>
> >>> When running memcpy_toio:
> >>> memcpy_toio(send_obj->share_buf, buf, len);
> >>> it was found that errors appear if len is not a multiple of 8:
> >>>
> >>> [58.350841] mtk-mdp 14001000.rdma: processing failed: -22
> >>
> >> Why do errors appear? Is that due to a HW bug? Some other reason?
> >
> > MTK folks would be the best placed to answer this, but since the
> > failure is reported by the firmware I'd suspect either a firmware or
> > hardware limitation.
> >
> >>
> >>>
> >>> This patch ensures the copy of a multiple of 8 size by calling
> >>> round_up(len, 8) when copying
> >>>
> >>> Fixes: e6599adfad30 ("media: mtk-vpu: avoid unaligned access to DTCM buffer.")
> >>> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> >>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> >>> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> >>> ---
> >>> changes since v3:
> >>> 1. multile -> multiple
> >>> 2. add inline doc
> >>>
> >>> changes since v2:
> >>> 1. do the extra copy only if len is not multiple of 8
> >>>
> >>> changes since v1:
> >>> 1. change sign-off-by tags
> >>> 2. change values to memset
> >>>
> >>>   drivers/media/platform/mtk-vpu/mtk_vpu.c | 15 ++++++++++++++-
> >>>   1 file changed, 14 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
> >>> index ec290dde59cf..1df031716c8f 100644
> >>> --- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
> >>> +++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
> >>> @@ -349,7 +349,20 @@ int vpu_ipi_send(struct platform_device *pdev,
> >>>                }
> >>>        } while (vpu_cfg_readl(vpu, HOST_TO_VPU));
> >>>
> >>> -     memcpy_toio(send_obj->share_buf, buf, len);
> >>> +     /*
> >>> +      * when copying data to the vpu hardware, the memcpy_toio operation must copy
> >>> +      * a multiple of 8. Otherwise the processing fails
> >>
> >> Same here: it needs to explain why the processing fails.
> >>
> >>> +      */
> >>> +     if (len % 8 != 0) {
> >>> +             unsigned char data[SHARE_BUF_SIZE];
> >>
> >> Wouldn't it be more robust if you say:
> >>
> >>                  unsigned char data[sizeof(send_obj->share_buf)];
> >
> > Definitely yes.
>
> won't it actually be better to implement it like this:
> (assuming len is always multiply of 4 - which I think it must be since access must be 4 aligned)
>
>         void __iomem *to = obj->share_buf;
>
>          if (len % 8 != 0) {
>                  memcpy_toio(to, buf, len - 4);
>                  to += len - 4;
>                  buf += len - 4;
>                  writel_relaxed(*(u32 *)buf, to);
>          } else {
>                  memcpy_toio(obj->share_buf, buf, len);
>          }

Not sure if avoiding that stack allocation is worth the extra
complexity and requirement for len being a multiple of 4. Also I'd
like to test it on real hardware to confirm it is indeed ok.

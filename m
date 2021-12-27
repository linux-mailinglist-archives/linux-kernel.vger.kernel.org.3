Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A496047FAAF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhL0HGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhL0HGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:06:23 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E529C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:06:23 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id az37so4606008uab.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TGt9h2A85gxYft0rVPguvrwyauB5J7ujBUnVmtY0QIE=;
        b=UuGM08JNoPIZGbdzJTwhkqWus0Mk3UZF1YuJDDNqK7d7b23yzMmxkLcwqVZXdOyILw
         CrjCTshqvCB0YGZhAGrU7b8HOQdNB8O7LZTFwiwyTPBTu4ZaUKtm6DEUbPRcuzc41YB9
         ANpYlwsZO6IQtKii+/rd5T1GdsBy0+cUSSvlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TGt9h2A85gxYft0rVPguvrwyauB5J7ujBUnVmtY0QIE=;
        b=QWYEsWRiWdDmusT4E0KhHI5FRqo8Hlty4OEIBjTFurPPBHKwazqe8amnVtRfP6UWB5
         iq2c6RaqOJhAlEIzsSy+jt5vjW6u3zaTg8xuUO1u96tKuoOXBmOIs30QFhQyN06COERP
         s6tVMGRYjQnBMtYHg6OSx2qTSKiTJLqqxNSj8RqxW2kG/CXaAUuMhRlsXgEUliVrIqSt
         gHKHb6fFJI98lIio1GumiPLsK78SDHxp25pHNYbz0y6nVzJG07jej8MbA4i68AhRjBc8
         /mCkMH/9uh53n+std691W30PVr6RH3hfX2P4ECM+zry+wj/+QYF3qJjdWCr2WKV9m1B/
         fYGA==
X-Gm-Message-State: AOAM530dr/ZUNmwRw6rmgTwr0JtYs0zcuoqZB35eux1omCNrLUlXqQVy
        4cZGixoWcxWoofbhjtk1dOD8/QOmUbyEjA==
X-Google-Smtp-Source: ABdhPJzBqvshUL41Fmz8pCBW81A9vaOAhKhF6t9BmIaLSg9K2l7cISIN1UBNmQjYj2i6AcSQUdSl8w==
X-Received: by 2002:ab0:3e8:: with SMTP id 95mr4162283uau.26.1640588781864;
        Sun, 26 Dec 2021 23:06:21 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id m62sm62292uam.0.2021.12.26.23.06.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Dec 2021 23:06:21 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id o1so25554674uap.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:06:21 -0800 (PST)
X-Received: by 2002:a05:6102:85:: with SMTP id t5mr3972571vsp.25.1640588780620;
 Sun, 26 Dec 2021 23:06:20 -0800 (PST)
MIME-Version: 1.0
References: <20211117130635.11633-1-dafna.hirschfeld@collabora.com> <20211117130635.11633-3-dafna.hirschfeld@collabora.com>
In-Reply-To: <20211117130635.11633-3-dafna.hirschfeld@collabora.com>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 27 Dec 2021 16:06:09 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVeohz94O5bXrBLmQkPddMTD9sj0ZMsOjG652_r7OyHSg@mail.gmail.com>
Message-ID: <CAPBb6MVeohz94O5bXrBLmQkPddMTD9sj0ZMsOjG652_r7OyHSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] media: mtk-vcodec: call v4l2_m2m_ctx_release first
 when file is released
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        courbot@chromium.org, Dafna Hirschfeld <dafna3@gmail.com>,
        eizan@chromium.org, houlong.wei@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Irui Wang <irui.wang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        minghsiu.tsai@mediatek.com, Tomasz Figa <tfiga@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 10:06 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> The func v4l2_m2m_ctx_release waits for currently running jobs
> to finish and then stop streaming both queues and frees the buffers.
> All this should be done before the call to mtk_vcodec_enc_release
> which frees the encoder handler. This fixes null-pointer dereference bug:
>
> [gst-master] root@debian:~/gst-build# [  638.019193] Unable to handle ker=
nel NULL pointer dereference at virtual address 00000000000001a0
> [  638.028076] Mem abort info:
> [  638.030932]   ESR =3D 0x96000004
> [  638.033978]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [  638.039293]   SET =3D 0, FnV =3D 0
> [  638.042338]   EA =3D 0, S1PTW =3D 0
> [  638.045474]   FSC =3D 0x04: level 0 translation fault
> [  638.050349] Data abort info:
> [  638.053224]   ISV =3D 0, ISS =3D 0x00000004
> [  638.057055]   CM =3D 0, WnR =3D 0
> [  638.060018] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000012b6db00=
0
> [  638.066485] [00000000000001a0] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [  638.073277] Internal error: Oops: 96000004 [#1] SMP
> [  638.078145] Modules linked in: rfkill mtk_vcodec_dec mtk_vcodec_enc uv=
cvideo mtk_mdp mtk_vcodec_common videobuf2_dma_contig v4l2_h264 cdc_ether v=
4l2_mem2mem videobuf2_vmalloc usbnet videobuf2_memops videobuf2_v4l2 r8152 =
videobuf2_common videodev cros_ec_sensors cros_ec_sensors_core industrialio=
_triggered_buffer kfifo_buf elan_i2c elants_i2c sbs_battery mc cros_usbpd_c=
harger cros_ec_chardev cros_usbpd_logger crct10dif_ce mtk_vpu fuse ip_table=
s x_tables ipv6
> [  638.118583] CPU: 0 PID: 212 Comm: kworker/u8:5 Not tainted 5.15.0-0642=
7-g58a1d4dcfc74-dirty #109
> [  638.127357] Hardware name: Google Elm (DT)
> [  638.131444] Workqueue: mtk-vcodec-enc mtk_venc_worker [mtk_vcodec_enc]
> [  638.137974] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [  638.144925] pc : vp8_enc_encode+0x34/0x2b0 [mtk_vcodec_enc]
> [  638.150493] lr : venc_if_encode+0xac/0x1b0 [mtk_vcodec_enc]
> [  638.156060] sp : ffff8000124d3c40
> [  638.159364] x29: ffff8000124d3c40 x28: 0000000000000000 x27: 000000000=
0000000
> [  638.166493] x26: 0000000000000000 x25: ffff0000e7f252d0 x24: ffff80001=
24d3d58
> [  638.173621] x23: ffff8000124d3d58 x22: ffff8000124d3d60 x21: 000000000=
0000001
> [  638.180750] x20: ffff80001137e000 x19: 0000000000000000 x18: 000000000=
0000001
> [  638.187878] x17: 000000040044ffff x16: 00400032b5503510 x15: 000000000=
0000000
> [  638.195006] x14: ffff8000118536c0 x13: ffff8000ee1da000 x12: 000000003=
0d4d91d
> [  638.202134] x11: 0000000000000000 x10: 0000000000000980 x9 : ffff80001=
24d3b20
> [  638.209262] x8 : ffff0000c18d4ea0 x7 : ffff0000c18d44c0 x6 : ffff0000c=
18d44c0
> [  638.216391] x5 : ffff80000904a3b0 x4 : ffff8000124d3d58 x3 : ffff80001=
24d3d60
> [  638.223519] x2 : ffff8000124d3d78 x1 : 0000000000000001 x0 : ffff80001=
137efb8
> [  638.230648] Call trace:
> [  638.233084]  vp8_enc_encode+0x34/0x2b0 [mtk_vcodec_enc]
> [  638.238304]  venc_if_encode+0xac/0x1b0 [mtk_vcodec_enc]
> [  638.243525]  mtk_venc_worker+0x110/0x250 [mtk_vcodec_enc]
> [  638.248918]  process_one_work+0x1f8/0x498
> [  638.252923]  worker_thread+0x140/0x538
> [  638.256664]  kthread+0x148/0x158
> [  638.259884]  ret_from_fork+0x10/0x20
> [  638.263455] Code: f90023f9 2a0103f5 aa0303f6 aa0403f8 (f940d277)
> [  638.269538] ---[ end trace e374fc10f8e181f5 ]---
>
> Fixes: 4e855a6efa547 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video =
Encoder Driver")
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

The order looks indeed safer this way.

Reviewed-by: Alexandre Courbot <acourbot@chromium.org>


> ---
>  drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/dri=
vers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> index eed67394cf46..f898226fc53e 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
> @@ -214,11 +214,11 @@ static int fops_vcodec_release(struct file *file)
>         mtk_v4l2_debug(1, "[%d] encoder", ctx->id);
>         mutex_lock(&dev->dev_mutex);
>
> +       v4l2_m2m_ctx_release(ctx->m2m_ctx);
>         mtk_vcodec_enc_release(ctx);
>         v4l2_fh_del(&ctx->fh);
>         v4l2_fh_exit(&ctx->fh);
>         v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> -       v4l2_m2m_ctx_release(ctx->m2m_ctx);
>
>         list_del_init(&ctx->list);
>         kfree(ctx);
> --
> 2.17.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF34B18F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbiBJXCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:02:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345039AbiBJXCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:02:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0B121B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:02:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A79E161D4C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18380C36AE2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644534161;
        bh=dWlM6GzodJ6qB1EODWTpq+ewUBIgSf03yMrzLU0NHO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R4M3aM2dbBiCBVRD9SOPozc/V4OMcqIhnAKKSnSRve3J2dFrqxI5l0sj8LlB32DK1
         /e6iIKXE6/IG2p4Su/Od36qjzmpJA5SYpwfysVYa7gR3d8L15MH6CKyLYX9l47EW5Z
         dONy7oE4u4OBzkPH6o7ZV1r0SJoKUSqCSWQHwXe+ib0eVkq9SI5PF19U3l918OOA/m
         88H8jhZkAX9rjjrRGN9geqpzcuCmOKATJ9jR9hwjktaJo1AYeel6jsTuFzSx/hnKLQ
         rmKEsY6fZTyHKfbMJdVL5IWtQrvEfpvJDzOxE9oLAJTFROsWR8bFOd1lZeRGsskvt0
         2cSzyvrvcO+aQ==
Received: by mail-ej1-f54.google.com with SMTP id y3so18944845ejf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:02:41 -0800 (PST)
X-Gm-Message-State: AOAM531HKwR5/CfiVkIhgXUh2tHeNqK1uXsetLcHszoZeJuTAXU7OQv1
        8FaSagx4wbJJOgCKsvyB19l+/3SFOyQi85hb+w==
X-Google-Smtp-Source: ABdhPJz2bSTC3EJpr7pbff7mvYDGZyI2Hfx9d+xyM27F2vwC06Lxziyew4yTIc/KsKfPOLtMgnGB5JXbzuRSDEEER68=
X-Received: by 2002:a17:906:c10f:: with SMTP id do15mr8161642ejc.638.1644534159327;
 Thu, 10 Feb 2022 15:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20210915232722.10031-1-chunkuang.hu@kernel.org>
 <CAAOTY_8BZ9BgWeQVsD_01ioP8H16c1_QUb_+yniU_4Wp91Nc7A@mail.gmail.com> <b233115c-704a-df4c-9d75-70cebb80a53c@gmail.com>
In-Reply-To: <b233115c-704a-df4c-9d75-70cebb80a53c@gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 11 Feb 2022 07:02:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9zMfd1inE_4Lo=p3tM7Wq3NerOaDnpksdU811mfm=_4w@mail.gmail.com>
Message-ID: <CAAOTY_9zMfd1inE_4Lo=p3tM7Wq3NerOaDnpksdU811mfm=_4w@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: cmdq: Use mailbox rx_callback instead of cmdq_task_cb
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Matthias Brugger <matthias.bgg@gmail.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=
=888=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:30=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Chun-Kuang,
>
> On 08/10/2021 16:15, Chun-Kuang Hu wrote:
> > Hi, Matthias:
> >
> > Please ignore this patch because this patch depend on [1] which would
> > cause numerous warning message. So I would revert that patch in [2].
> >
>
> Thanks for the head-ups. I'll ignore this patch.

This patch depend on [3] which has been merged into mainline, so you
could  start to review this parch.

[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/gpu/drm/mediatek?h=3Dv5.17-rc3&id=3D1ee07a683b7e4e6ad9ad4f77fce4=
751741bc8ceb

Regards,
Chun-Kuang.

>
> Regards,
> Matthias
>
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/drivers/gpu/drm/mediatek?h=3Dv5.15-rc4&id=3Dc1ec54b7b5af25c779192253=
f5a9f05e95cb43d7
> > [2] https://patchwork.kernel.org/project/linux-mediatek/patch/202110072=
35310.14626-6-chunkuang.hu@kernel.org/
> >
> > Regards,
> > Chun-Kuang.
> >
> > Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2021=E5=B9=B49=E6=9C=
=8816=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=887:27=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >> rx_callback is a standard mailbox callback mechanism and could cover t=
he
> >> function of proprietary cmdq_task_cb, so use the standard one instead =
of
> >> the proprietary one. Client has changed to use the standard callback
> >> machanism and sync dma buffer in client driver, so remove the propriet=
ary
> >> callback in cmdq helper.
> >>
> >> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> >> ---
> >>   drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +-----------------------=
-
> >>   include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
> >>   2 files changed, 2 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/medi=
atek/mtk-cmdq-helper.c
> >> index 3c8e4212d941..c1837a468267 100644
> >> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> >> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> >> @@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> >>   }
> >>   EXPORT_SYMBOL(cmdq_pkt_finalize);
> >>
> >> -static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> >> -{
> >> -       struct cmdq_pkt *pkt =3D (struct cmdq_pkt *)data.data;
> >> -       struct cmdq_task_cb *cb =3D &pkt->cb;
> >> -       struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >> -
> >> -       dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> >> -                               pkt->cmd_buf_size, DMA_TO_DEVICE);
> >> -       if (cb->cb) {
> >> -               data.data =3D cb->data;
> >> -               cb->cb(data);
> >> -       }
> >> -}
> >> -
> >> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb=
,
> >> -                        void *data)
> >> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
> >>   {
> >>          int err;
> >>          struct cmdq_client *client =3D (struct cmdq_client *)pkt->cl;
> >>
> >> -       pkt->cb.cb =3D cb;
> >> -       pkt->cb.data =3D data;
> >> -       pkt->async_cb.cb =3D cmdq_pkt_flush_async_cb;
> >> -       pkt->async_cb.data =3D pkt;
> >> -
> >> -       dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_ba=
se,
> >> -                                  pkt->cmd_buf_size, DMA_TO_DEVICE);
> >> -
> >>          err =3D mbox_send_message(client->chan, pkt);
> >>          if (err < 0)
> >>                  return err;
> >> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc=
/mediatek/mtk-cmdq.h
> >> index ac6b5f3cba95..2b498f4f3946 100644
> >> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> >> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> >> @@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
> >>    * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute t=
he CMDQ
> >>    *                          packet and call back at the end of done =
packet
> >>    * @pkt:       the CMDQ packet
> >> - * @cb:                called at the end of done packet
> >> - * @data:      this data will pass back to cb
> >>    *
> >>    * Return: 0 for success; else the error code is returned
> >>    *
> >> @@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
> >>    * at the end of done packet. Note that this is an ASYNC function. W=
hen the
> >>    * function returned, it may or may not be finished.
> >>    */
> >> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb=
,
> >> -                        void *data);
> >> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
> >>
> >>   #endif /* __MTK_CMDQ_H__ */
> >> --
> >> 2.25.1
> >>

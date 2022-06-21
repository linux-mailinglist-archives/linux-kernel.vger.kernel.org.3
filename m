Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028C55346A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351366AbiFUOWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351268AbiFUOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:22:37 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C7E2314C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:22:36 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id n15so16534261qvh.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Us5unMMOUBPzuFEiHM0v1mwK/JxXZgMtN7G9faNpjJY=;
        b=fpezBkIMLFOFzWxjpswbf4s/HCObOkBJEpbZsvdUKYst5H6NWHqDs8wBlp+Kfb3t1J
         WCDbDD+W/UILz5SULbQBeGw3zI42w/R4iGfGDceX2IxLMvHjycu9J3rzltECOtAqK5zd
         S1VwMo1hmgkAV9BgjIH2JNXUnwPJ0g9l9A0OUp5EUD74cvr9H2fAOYpCBaLrEqsMq2aG
         BjAyJBstblU/2hrODyjaqJ1T88aTeVDZu/kgxbdpXnGnuUvJ8CuKi3RbMVG/rZ4CJD5N
         vFRg0q+IwMcigLgjeZJ3cSC4SO0B9gHReKtaB326ru1FkYNJe+F2WeYBPM6Zrclav4oK
         FvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Us5unMMOUBPzuFEiHM0v1mwK/JxXZgMtN7G9faNpjJY=;
        b=utKZffMKveUQpcP2GFytt0EWS016ck0rF2+mTPM4dsbAR/J/iapkxAeXjM5BH/KNjK
         BdzrgV6VRSUF1S/nRaJB1t17defA0kXd051E54MHTLSmrFkxhLOWJXdrJezBPoX4o9qf
         iFQM6AsmyCDYOQgwIv8yBzb4O5Gx3fBqH6exDkPUEDZxSfcDYkO7kg7g5QB4MtLrELMW
         9j3lq0KZX+4WJBfmfu14zKhE2iGFBsU2/zopxXv/Tv8Q4+4zygX/nGjmkIY7PzTGxfMT
         RxKFiaP0AP8im9Y7m+Z/zSjXw4iKcxfmkh9iL4FC5cSdsQcsCqeAcc6LJrJ7+MV8aBcE
         jfuw==
X-Gm-Message-State: AJIora8l7IPZS9eJM+d63VkjC0Toli/AfaQdb/Mr0pSP0O5cPwSIDOAw
        ua3o2njQoY/NkHOCaga0rtMCKA==
X-Google-Smtp-Source: AGRyM1vWXzMwB6hYFPiRehDN/2RBDuFRyqd4NGtand04O8n4nIKe/fYzERyGTr9do0RK2hCoRoE2Rw==
X-Received: by 2002:a05:622a:412:b0:306:74e9:869c with SMTP id n18-20020a05622a041200b0030674e9869cmr24545108qtx.230.1655821356013;
        Tue, 21 Jun 2022 07:22:36 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006a91da2fc8dsm13809503qkj.0.2022.06.21.07.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:22:35 -0700 (PDT)
Message-ID: <9f37792d9de58cf88c3b21d6d96fc83ff30768da.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: Skip SOURCE_CHANGE & EOS
 events for stateless
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Date:   Tue, 21 Jun 2022 10:22:34 -0400
In-Reply-To: <20220620063349.2754116-1-wenst@chromium.org>
References: <20220620063349.2754116-1-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 20 juin 2022 =C3=A0 14:33 +0800, Chen-Yu Tsai a =C3=A9crit=C2=A0:
> The stateless decoder API does not specify the usage of SOURCE_CHANGE
> and EOF events. These events are used by stateful decoders to signal
> changes in the bitstream. They do not make sense for stateless decoders.
>=20
> Do not handle subscription for these two types of events for stateless
> decoder instances. This fixes the last v4l2-compliance error:
>=20
> Control ioctls:
> 		fail: v4l2-test-controls.cpp(946): have_source_change || have_eos
> 	test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: FAIL
>=20
> Fixes: 8cdc3794b2e3 ("media: mtk-vcodec: vdec: support stateless API")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>=20
> This should apply cleanly on next-20220617. The other media patches I
> have on my branch:
>=20
> media: mediatek: vcodec: Initialize decoder parameters after getting dec_=
capability
> media: mediatek: vcodec: Fix non subdev architecture open power fail
>=20
> should not interfere, though the second is required for proper operation
> of the decoder on MT8183.
>=20
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> index 62f29b6fa104..a5fbc0a1c6bc 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> @@ -234,6 +234,11 @@ static int vidioc_vdec_querycap(struct file *file, v=
oid *priv,
>  static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
>  				     const struct v4l2_event_subscription *sub)
>  {
> +	struct mtk_vcodec_ctx *ctx =3D fh_to_ctx(fh);
> +
> +	if (ctx->dev->vdec_pdata->uses_stateless_api)
> +		return v4l2_ctrl_subscribe_event(fh, sub);
> +
>  	switch (sub->type) {
>  	case V4L2_EVENT_EOS:
>  		return v4l2_event_subscribe(fh, sub, 2, NULL);


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE66A52DC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiESSMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238253AbiESSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:12:38 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9ABDFF6A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:12:36 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b20so5341905qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=tFMT9p04p6pk/FKwjzStiTXullLYyMSDGXNZ801VM7I=;
        b=PKzhaZDk22Absyi8wUzUhO9PROJMmVrgiRPx6JTGSX5wmUL8OQwkaDQ8q7WkjL6OSg
         Xs94//6ghOeHhoSezi2NwSuhRMsscnXDr1rojLHvdjn2pBZrfHahNTG/6XF/M6O8uY2p
         ISHC/VruKGCxndr4zCwY1c8LnJYXfqbxJMvNvK1UlOWSscQxZ0jLZXlPt0ujt17JE0P3
         UOFpFmKAYLVC9Om9065rThCn9wW0raOYzT875jDrAn1atddWU/3aKF0xBKQPSXxJ5nd8
         +rCs2HpM1ECq/KKzjs8s7mclwZQ0uLvL9a7mLS5lE22IUexJYcAxsVC4+S+RD/TZBJcJ
         xW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=tFMT9p04p6pk/FKwjzStiTXullLYyMSDGXNZ801VM7I=;
        b=yLaJFAZIdFd+pyyE/G2ixaimD7XTpfGxK6mGu5Ua05TTsCLVws1AIfOqLYwm1O+MjC
         +8JGV5rLurQa6uGRIL96PKSV+Y3wqwADMOLVJ9/aI0NBtoArrSlgDosuTQfVPmbkebM6
         o/LDPbkShW1q2u1calyLdyPS316afSZU06tuxcEDuel8d0J9+xQhHVcgZj4C6RxNVfUI
         SLQhqsCHbE2/Hx72XN+oWbR9N4J8Hkjzopl1rA3BXuucz2xjv4KUOhR2HWGM5nHCQrXH
         miQ3OfLrvkk/FFTC5xLGsQ6gack7LjmC7sqpG/GNsIfSDF4XYeAdMZcy005AkGPrvkLm
         t1fg==
X-Gm-Message-State: AOAM530UPNj8tlNbST0AW+URAjGcl69GZ5aam9kq1d6JB0LJsL3teV2K
        bH+mC2gkFzIVvDpwWMJBudzcmw==
X-Google-Smtp-Source: ABdhPJzsB2nDyOXcFejRQHNq4crFJljOGlEqKg76glbiH6W1DlRpf6oFnQGg081iBFZbdlCcYWkJRA==
X-Received: by 2002:a05:620a:24d3:b0:6a0:4c98:344c with SMTP id m19-20020a05620a24d300b006a04c98344cmr3834508qkn.267.1652983955958;
        Thu, 19 May 2022 11:12:35 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id d19-20020ac85453000000b002f39b99f6c2sm1608497qtq.92.2022.05.19.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:12:35 -0700 (PDT)
Message-ID: <e03669333c20c07d40d0b1ce05eb771f5dbd4139.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: return error if format is unsupported
 by vpu
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 May 2022 14:12:34 -0400
In-Reply-To: <20220519072844.31792-1-ming.qian@nxp.com>
References: <20220519072844.31792-1-ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming Qian,

Le jeudi 19 mai 2022 =C3=A0 15:28 +0800, Ming Qian a =C3=A9crit=C2=A0:
> return error if format is unsupported by vpu,
> otherwise the vpu will be stalled at decoding

I have a reasonable doubt about this patch. I don't think such a case shoul=
d be
reachable by users. Normally, calls to S_FMT should ensure the driver forma=
t
state is valid on both ends but modifying the relevant structures. As an
example, for decoders, setting the CODEC (OUTPUT queue) format, may change =
the
raw format (CAPTURE queue) implicitly to prevent this situation. Are we cer=
tain
this change isn't papering around some missing format propagation ?

regards,
Nicolas

>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vpu_malone.c | 2 ++
>  drivers/media/platform/amphion/vpu_v4l2.c   | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/=
platform/amphion/vpu_malone.c
> index f29c223eefce..0930b6ba8c42 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -610,6 +610,8 @@ static int vpu_malone_set_params(struct vpu_shared_ad=
dr *shared,
>  	enum vpu_malone_format malone_format;
> =20
>  	malone_format =3D vpu_malone_format_remap(params->codec_format);
> +	if (malone_format =3D=3D MALONE_FMT_NULL)
> +		return -EINVAL;
>  	iface->udata_buffer[instance].base =3D params->udata.base;
>  	iface->udata_buffer[instance].slot_size =3D params->udata.size;
> =20
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/pl=
atform/amphion/vpu_v4l2.c
> index 446f07d09d0b..89b88e063e45 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -500,10 +500,10 @@ static int vpu_vb2_start_streaming(struct vb2_queue=
 *q, unsigned int count)
>  		  fmt->sizeimage[1], fmt->bytesperline[1],
>  		  fmt->sizeimage[2], fmt->bytesperline[2],
>  		  q->num_buffers);
> -	call_void_vop(inst, start, q->type);
> +	ret =3D call_vop(inst, start, q->type);
>  	vb2_clear_last_buffer_dequeued(q);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  static void vpu_vb2_stop_streaming(struct vb2_queue *q)


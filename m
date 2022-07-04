Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760BF565A99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiGDQFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbiGDQFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:05:38 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA50FE09C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:05:37 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b133so7047278qkc.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=ILiPYCnR1Ay3FEgk2Uo0AF/TasoSIbuVs6Xs1VhuKcA=;
        b=2Or7ArxHC2w727HWd3eTwhy2H5YmDdrCibjJHyZq2QqcCBI1GkUGipq3hCFJNGs3rO
         FRW7x3m79IDg517c4XgguQOqueRUShKlbMpZU2qzaZCttLICcEltt5Dr3Sy/BIUGbw8q
         QtKwHjLm65PEXKrzQuI4Zhs4Ru9ccoq/ipRKtD2PI/XTWHZ2lB1c1cJFj9eiQJBzRoCy
         o+pSIG0w9OykEj5oexwxKgaM4uPbm6AD8SIJ1+8w/auiKjrldBdezAOHeTjf+Ukgzosn
         djnJ6FOSqwWjbLlTn9qBa9Zing5CHrgRvmYPLApi3v0+EzSxA5AkBvIG+SSFA/wecQjj
         mW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=ILiPYCnR1Ay3FEgk2Uo0AF/TasoSIbuVs6Xs1VhuKcA=;
        b=347xdYCxrCp+LVBH+JJ1rc8rcjcxK94FKSILcY6JFE5KAllnUrgx/x/R3Bu7FxS3Cw
         S6BZcyNuqHCS2OTidpEwVNwVktHcXG2ixv5JipjtmvHshluwitlBZZKGM+YNGIdG5FzX
         nFIUMMDIafbAmAa4U5ZulSfO3BFpIXJ1cV7Oj3lUJPo1st34KwXksUyiD2yv8rYlPs3W
         qt1kQWxz8R4tzyYv/DT0D4QLWiuNmc62s6kCeZx5hoduqMIQt4NXRUJustcnunNafye/
         6lj+Q0oMc5lywUSlLtmweNOz+Zy1cfkXytRLsQoq73NgUy1sHvEGubJFIsJ4all6C1C2
         MV0A==
X-Gm-Message-State: AJIora8OSe1diOp1wYG2kDXtfoAVAzTrxbuwKNzDXHiJ66F+6Z7OVStS
        pRbMXYmI+I6YZlrX/Nj51TtZWqwhRRjIBKn7
X-Google-Smtp-Source: AGRyM1uuDHPTXWLItXdsm6fmkRBRA8X4Ap9qJyVgaT677qZsCuxPXg74slHMJUXSYen9IhIpbY8KVw==
X-Received: by 2002:a05:620a:24d0:b0:6af:bc2:5217 with SMTP id m16-20020a05620a24d000b006af0bc25217mr20049113qkn.666.1656950737005;
        Mon, 04 Jul 2022 09:05:37 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (mtl.collabora.ca. [66.171.169.34])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm21505731qkp.130.2022.07.04.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:05:36 -0700 (PDT)
Message-ID: <6e54af5243d324c5df1c9ec18d4b091fbd52150f.camel@ndufresne.ca>
Subject: Re: [PATCH] media: amphion: only insert the first sequence
 startcode for vc1l format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 04 Jul 2022 12:05:35 -0400
In-Reply-To: <20220628052017.26979-1-ming.qian@nxp.com>
References: <20220628052017.26979-1-ming.qian@nxp.com>
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

Hi Ming,

Le mardi 28 juin 2022 =C3=A0 13:20 +0800, Ming Qian a =C3=A9crit=C2=A0:
> For some formats, the amphion vpu requires startcode
> before sequence and frame, such as vc1, vp8.

I'm not sure why VP8 is being mentioned here. There is no specified sartcod=
e for
VP8, and no split of headers either.

>=20
> But for V4L2_PIX_FMT_VC1_ANNEX_L, only the first sequence startcode
> is needed, the extra startcode will cause decoding error.
> So after seek, we don't need to insert the sequence startcode.
>=20
> In other words, for V4L2_PIX_FMT_VC1_ANNEX_L,
> the vpu doesn't support dynamic resolution change.
>=20
> Fixes: 145e936380edb ("media: amphion: implement malone decoder rpc inter=
face")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vdec.c       | 1 +
>  drivers/media/platform/amphion/vpu.h        | 1 +
>  drivers/media/platform/amphion/vpu_malone.c | 2 ++
>  drivers/media/platform/amphion/vpu_rpc.h    | 7 ++++++-
>  4 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platfo=
rm/amphion/vdec.c
> index 09d4f27970ec..51218a41a5ac 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -731,6 +731,7 @@ static void vdec_stop_done(struct vpu_inst *inst)
>  	vdec->eos_received =3D 0;
>  	vdec->is_source_changed =3D false;
>  	vdec->source_change =3D 0;
> +	inst->total_input_count =3D 0;
>  	vpu_inst_unlock(inst);
>  }
> =20
> diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platfor=
m/amphion/vpu.h
> index e56b96a7e5d3..f914de6ed81e 100644
> --- a/drivers/media/platform/amphion/vpu.h
> +++ b/drivers/media/platform/amphion/vpu.h
> @@ -258,6 +258,7 @@ struct vpu_inst {
>  	struct vpu_format cap_format;
>  	u32 min_buffer_cap;
>  	u32 min_buffer_out;
> +	u32 total_input_count;
> =20
>  	struct v4l2_rect crop;
>  	u32 colorspace;
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/=
platform/amphion/vpu_malone.c
> index c62b49e85060..f4a488bf9880 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -1314,6 +1314,8 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct=
 malone_scode_t *scode)
>  	int size =3D 0;
>  	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
> =20
> +	if (scode->inst->total_input_count)
> +		return 0;
>  	scode->need_data =3D 0;
> =20
>  	ret =3D vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE, =
sizeof(rcv_seqhdr));
> diff --git a/drivers/media/platform/amphion/vpu_rpc.h b/drivers/media/pla=
tform/amphion/vpu_rpc.h
> index 25119e5e807e..7eb6f01e6ab5 100644
> --- a/drivers/media/platform/amphion/vpu_rpc.h
> +++ b/drivers/media/platform/amphion/vpu_rpc.h
> @@ -312,11 +312,16 @@ static inline int vpu_iface_input_frame(struct vpu_=
inst *inst,
>  					struct vb2_buffer *vb)
>  {
>  	struct vpu_iface_ops *ops =3D vpu_core_get_iface(inst->core);
> +	int ret;
> =20
>  	if (!ops || !ops->input_frame)
>  		return -EINVAL;
> =20
> -	return ops->input_frame(inst->core->iface, inst, vb);
> +	ret =3D ops->input_frame(inst->core->iface, inst, vb);
> +	if (ret < 0)
> +		return ret;
> +	inst->total_input_count++;
> +	return ret;
>  }
> =20
>  static inline int vpu_iface_config_memory_resource(struct vpu_inst *inst=
,


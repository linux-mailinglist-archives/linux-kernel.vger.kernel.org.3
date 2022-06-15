Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9579254CAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356068AbiFOODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355945AbiFOOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:02:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA045101D;
        Wed, 15 Jun 2022 07:02:38 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF66B6601701;
        Wed, 15 Jun 2022 15:02:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655301738;
        bh=A/jvOxm1ICij5K0mIG7oqF5iy6HOnMoo/iFg2qWHY+o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xp91NeW7/5pDED1maKh/hv/BrO3shNGUFb2jaEdMzphcwtcjlNybZ+ct8f3IwhDac
         ZI/OWfjBpJZKrBoklAeASR8Tu7mCBjc99sYoSIPJ0Urj/ds4at6R0RGAq8X/YdOc9q
         l8yW8bym5tB5LXyiaqIv4I/Cs1Ws8rhasaPXmj4yTo0/cc2I73wnpxAeUhobtyvtLD
         jbRIWok6C3Y3BMSDsNsenU06cBgVOzTqVuBEsv0HUmYc2S++fOMctZZZKa+JFWCIpr
         6zUxp6Q2kTv52QxFTODST5w3r1d0nHz3uRuPUXCICLdGey89ewVi2W6DwOfbxVW3VS
         no6sEAK760B8w==
Message-ID: <a64aa50e843967d691300af3cda27b85b8353f96.camel@collabora.com>
Subject: Re: [V9,4/7] mtk-jpegenc: add jpegenc timeout func interface
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, kyrie wu <kyrie.wu@mediatek.com>,
        srv_heupstream@mediatek.com
Date:   Wed, 15 Jun 2022 10:02:07 -0400
In-Reply-To: <20220613032306.23237-5-irui.wang@mediatek.com>
References: <20220613032306.23237-1-irui.wang@mediatek.com>
         <20220613032306.23237-5-irui.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 13 juin 2022 =C3=A0 11:23 +0800, Irui Wang a =C3=A9crit=C2=A0:
> From: kyrie wu <kyrie.wu@mediatek.com>
>=20
> Generalizes jpegenc timeout func interfaces to handle HW timeout.
>=20
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  8 ++++++
>  .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 25 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index f6e980fde4ef..0683d80fcea5 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -76,6 +76,12 @@ struct mtk_jpeg_variant {
>  	u32 cap_q_default_fourcc;
>  };
> =20
> +struct mtk_jpeg_hw_param {
> +	struct vb2_v4l2_buffer *src_buffer;
> +	struct vb2_v4l2_buffer *dst_buffer;
> +	struct mtk_jpeg_ctx *curr_ctx;
> +};
> +
>  enum mtk_jpegenc_hw_id {
>  	MTK_JPEGENC_HW0,
>  	MTK_JPEGENC_HW1,
> @@ -107,6 +113,8 @@ struct mtk_jpegenc_comp_dev {
>  	struct mtk_jpegenc_clk venc_clk;
>  	int jpegenc_irq;
>  	int hw_id;
> +	struct delayed_work job_timeout_work;
> +	struct mtk_jpeg_hw_param hw_param;
>  };
> =20
>  /**
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> index 8ac6b031dcd4..99f3db2a393a 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> @@ -185,6 +185,26 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ct=
x,  void __iomem *base)
>  }
>  EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_params);
> =20
> +static void mtk_jpegenc_timeout_work(struct work_struct *work)
> +{
> +	struct delayed_work *dly_work =3D to_delayed_work(work);
> +	struct mtk_jpegenc_comp_dev *cjpeg =3D
> +		container_of(dly_work,
> +			     struct mtk_jpegenc_comp_dev,
> +			     job_timeout_work);
> +	enum vb2_buffer_state buf_state =3D VB2_BUF_STATE_ERROR;
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +
> +	src_buf =3D cjpeg->hw_param.src_buffer;
> +	dst_buf =3D cjpeg->hw_param.dst_buffer;
> +	dst_buf->vb2_buf.timestamp =3D src_buf->vb2_buf.timestamp;

Another case for v4l2_m2m_buf_copy_metadata? As you know early the dst_buf,=
 you
could do that once before you start the encoding, this could possibly remov=
e the
duplication.

> +
> +	mtk_jpeg_enc_reset(cjpeg->reg_base);
> +	clk_disable_unprepare(cjpeg->venc_clk.clks->clk);
> +	pm_runtime_put(cjpeg->dev);
> +	v4l2_m2m_buf_done(src_buf, buf_state);
> +}
> +
>  static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
>  {
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> @@ -196,6 +216,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq=
, void *priv)
>  	struct mtk_jpegenc_comp_dev *jpeg =3D priv;
>  	struct mtk_jpeg_dev *master_jpeg =3D jpeg->master_dev;
> =20
> +	cancel_delayed_work(&jpeg->job_timeout_work);
> +
>  	irq_status =3D readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
>  		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
>  	if (irq_status)
> @@ -272,6 +294,9 @@ static int mtk_jpegenc_hw_probe(struct platform_devic=
e *pdev)
>  	dev->plat_dev =3D pdev;
>  	dev->dev =3D &pdev->dev;
> =20
> +	INIT_DELAYED_WORK(&dev->job_timeout_work,
> +			  mtk_jpegenc_timeout_work);
> +
>  	jpegenc_clk =3D &dev->venc_clk;
> =20
>  	jpegenc_clk->clk_num =3D devm_clk_bulk_get_all(&pdev->dev,


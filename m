Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1961C54CBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348569AbiFOOpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349437AbiFOOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:45:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0213EBA5;
        Wed, 15 Jun 2022 07:45:23 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 067A46601707;
        Wed, 15 Jun 2022 15:45:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655304322;
        bh=B5ZJF2aBx5ss4ohJzqiscPZXnsAb9fMttJ93kueV2pw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g9ABufRk84jpvagLpaqe/NEmV0fXAi7UeFmB3M2ezk+EvigPi4QGfef/mwBk13akZ
         m2C4bBilQTaEXsD9xZ/V925fg5Mt3K+YQHov6F6BuocS3V/xYCF3AVF0Uh0qvIvxIw
         0pzxh6UKvcMNZA+IAneHaCzxf/JuVbMV8LNT+NLM1ARf1Zj7KTFIscgKnczEjpNIcC
         L9JkgblamTX61jkeGXE0JvBb+aC5iSq4CoK7UhZdEBRfXET8Ya+o8dLbtX0gpJ83Pi
         Rc0K0JcDW/sdDg14ibGZ1BRuNSwDLCV1ldgr7KWG0jPEDu88yjihOirNoGxcMs0Cv5
         gg/BcGgH5pH4A==
Message-ID: <46b517debe88cd7617be473fe9effd0de3e16e56.camel@collabora.com>
Subject: Re: [V9,5/7] mtk-jpegenc: add jpeg encode worker interface
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
Date:   Wed, 15 Jun 2022 10:45:10 -0400
In-Reply-To: <20220613032306.23237-6-irui.wang@mediatek.com>
References: <20220613032306.23237-1-irui.wang@mediatek.com>
         <20220613032306.23237-6-irui.wang@mediatek.com>
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
> Add jpeg encoding worker to ensure that two HWs
> run in parallel in MT8195.
>=20
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> ---
>  .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 216 ++++++++++++++++--
>  .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  30 ++-
>  .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  |  38 ++-
>  3 files changed, 248 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index f7a5b971e628..f35ca23d3139 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -105,10 +105,18 @@ static struct mtk_jpeg_fmt mtk_jpeg_dec_formats[] =
=3D {
>  #define MTK_JPEG_ENC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_enc_formats)
>  #define MTK_JPEG_DEC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_dec_formats)
> =20
> +enum {
> +	MTK_JPEG_BUF_FLAGS_INIT			=3D 0,
> +	MTK_JPEG_BUF_FLAGS_LAST_FRAME		=3D 1,
> +};
> +
>  struct mtk_jpeg_src_buf {
> +	u32 frame_num;
>  	struct vb2_v4l2_buffer b;
>  	struct list_head list;
>  	struct mtk_jpeg_dec_param dec_param;
> +
> +	struct mtk_jpeg_ctx *curr_ctx;
>  };
> =20
>  static int debug;
> @@ -907,38 +915,138 @@ static int mtk_jpeg_set_dec_dst(struct mtk_jpeg_ct=
x *ctx,
>  	return 0;
>  }
> =20
> -static void mtk_jpeg_enc_device_run(void *priv)
> +static int mtk_jpegenc_select_hw(struct mtk_jpeg_ctx *ctx)
>  {
> -	struct mtk_jpeg_ctx *ctx =3D priv;
> +	struct mtk_jpegenc_comp_dev *comp_jpeg;
>  	struct mtk_jpeg_dev *jpeg =3D ctx->jpeg;
> -	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	unsigned long flags;
> +	int hw_id =3D -1;
> +	int i;
> +
> +	spin_lock_irqsave(&jpeg->hw_lock, flags);
> +	for (i =3D 0; i < MTK_JPEGENC_HW_MAX; i++) {
> +		comp_jpeg =3D jpeg->enc_hw_dev[i];
> +		if (comp_jpeg->hw_state =3D=3D MTK_JPEG_HW_IDLE) {
> +			hw_id =3D i;
> +			comp_jpeg->hw_state =3D MTK_JPEG_HW_BUSY;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +
> +	return hw_id;
> +}
> +
> +static int mtk_jpegenc_set_hw_param(struct mtk_jpeg_ctx *ctx,
> +				    int hw_id,
> +				    struct vb2_v4l2_buffer *src_buf,
> +				    struct vb2_v4l2_buffer *dst_buf)
> +{
> +	struct mtk_jpegenc_comp_dev *jpeg =3D ctx->jpeg->enc_hw_dev[hw_id];
> +
> +	jpeg->hw_param.curr_ctx =3D ctx;
> +	jpeg->hw_param.src_buffer =3D src_buf;
> +	jpeg->hw_param.dst_buffer =3D dst_buf;
> +
> +	return 0;
> +}
> +
> +static int mtk_jpegenc_deselect_hw(struct mtk_jpeg_dev *jpeg, int hw_id)

Just a thought, perhaps some old timer may help here, but select/deselect i=
s
indeed used, but get/put() also came to my mind. There is no issue otherwis=
e, I
would just want to know what would be the most consistent naming here.

> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&jpeg->hw_lock, flags);
> +	jpeg->enc_hw_dev[hw_id]->hw_state =3D MTK_JPEG_HW_IDLE;
> +	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +
> +	return 0;
> +}
> +
> +static void mtk_jpegenc_worker(struct work_struct *work)
> +{
> +	struct mtk_jpegenc_comp_dev *comp_jpeg[MTK_JPEGENC_HW_MAX];
>  	enum vb2_buffer_state buf_state =3D VB2_BUF_STATE_ERROR;
> +	struct mtk_jpeg_src_buf *jpeg_dst_buf;
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	atomic_t *hw_rdy[MTK_JPEGENC_HW_MAX];
> +	int ret, i, hw_id =3D 0;
>  	unsigned long flags;
> -	int ret;
> =20
> +	struct mtk_jpeg_ctx *ctx =3D container_of(work,
> +		struct mtk_jpeg_ctx,
> +		jpeg_work);
> +	struct mtk_jpeg_dev *jpeg =3D ctx->jpeg;
> +
> +	for (i =3D 0; i < MTK_JPEGENC_HW_MAX; i++) {
> +		comp_jpeg[i] =3D jpeg->enc_hw_dev[i];
> +		hw_rdy[i] =3D &comp_jpeg[i]->hw_rdy;
> +	}
> +
> +retry_select:
> +	hw_id =3D mtk_jpegenc_select_hw(ctx);
> +	if (hw_id < 0) {
> +		ret =3D wait_event_interruptible(jpeg->enc_hw_wq,
> +					       (atomic_read(hw_rdy[0]) ||
> +						atomic_read(hw_rdy[1])) > 0);

I see two issues here. The first one is that all the code that was assuming=
 we
could possibly support more then 2 cores in the future falls here. The seco=
nd is
a bit bigger, doing 2 atomic_read() one after the other isn't atomic.

I don't know the usual mechanism in the Linux kernel, and I'd appreciate if
there is more "kernel style" suggestion here. Normally I would in solve thi=
s
with an atomic counter. Whenever you reserve (select) a core, you decrease =
the
usage counter. When you release a core, you increase the counter (and signa=
l).
You then have 1 atomic_read() to check, atomic_read(num_idle_hr) > 0.

> +		if (ret !=3D 0) {
> +			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
> +				__func__, __LINE__);
> +			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +			return;
> +		}
> +
> +		goto retry_select;
> +	}
> +
> +	atomic_dec(&comp_jpeg[hw_id]->hw_rdy);
>  	src_buf =3D v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +	if (!src_buf)
> +		goto getbuf_fail;
> +
>  	dst_buf =3D v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> +	if (!dst_buf)
> +		goto getbuf_fail;
> =20
> -	ret =3D pm_runtime_resume_and_get(jpeg->dev);
> -	if (ret < 0)
> +	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +
> +	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
> +
> +	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
> +	ret =3D pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
> +	if (ret < 0) {
> +		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
> +			__func__, __LINE__);
>  		goto enc_end;
> +	}
> =20
> -	schedule_delayed_work(&jpeg->job_timeout_work,
> -			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> +	ret =3D clk_prepare_enable(comp_jpeg[hw_id]->venc_clk.clks->clk);
> +	if (ret) {
> +		dev_err(jpeg->dev, "%s : %d, jpegenc clk_prepare_enable fail\n",
> +			__func__, __LINE__);
> +		goto enc_end;
> +	}
> =20
> -	spin_lock_irqsave(&jpeg->hw_lock, flags);
> +	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> +			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> =20
> -	/*
> -	 * Resetting the hardware every frame is to ensure that all the
> -	 * registers are cleared. This is a hardware requirement.
> -	 */
> -	mtk_jpeg_enc_reset(jpeg->reg_base);
> +	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
> +	jpeg_dst_buf =3D mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
> +	jpeg_dst_buf->curr_ctx =3D ctx;
> +	jpeg_dst_buf->frame_num =3D ctx->total_frame_num;
> +	ctx->total_frame_num++;
> +	mtk_jpeg_enc_reset(comp_jpeg[hw_id]->reg_base);
> +	mtk_jpeg_set_enc_dst(ctx,
> +			     comp_jpeg[hw_id]->reg_base,
> +			     &dst_buf->vb2_buf);
> +	mtk_jpeg_set_enc_src(ctx,
> +			     comp_jpeg[hw_id]->reg_base,
> +			     &src_buf->vb2_buf);
> +	mtk_jpeg_set_enc_params(ctx, comp_jpeg[hw_id]->reg_base);
> +	mtk_jpeg_enc_start(comp_jpeg[hw_id]->reg_base);
> +	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
> =20
> -	mtk_jpeg_set_enc_src(ctx, jpeg->reg_base, &src_buf->vb2_buf);
> -	mtk_jpeg_set_enc_dst(ctx, jpeg->reg_base, &dst_buf->vb2_buf);
> -	mtk_jpeg_set_enc_params(ctx, jpeg->reg_base);
> -	mtk_jpeg_enc_start(jpeg->reg_base);
> -	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
>  	return;
> =20
>  enc_end:
> @@ -946,9 +1054,58 @@ static void mtk_jpeg_enc_device_run(void *priv)
>  	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
>  	v4l2_m2m_buf_done(src_buf, buf_state);
>  	v4l2_m2m_buf_done(dst_buf, buf_state);
> +getbuf_fail:
> +	atomic_inc(&comp_jpeg[hw_id]->hw_rdy);
> +	mtk_jpegenc_deselect_hw(jpeg, hw_id);
>  	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
>  }
> =20
> +static void mtk_jpeg_enc_device_run(void *priv)
> +{
> +	struct mtk_jpeg_ctx *ctx =3D priv;
> +	struct mtk_jpeg_dev *jpeg =3D ctx->jpeg;
> +	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> +	enum vb2_buffer_state buf_state =3D VB2_BUF_STATE_ERROR;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!jpeg->variant->is_multihw) {
> +		src_buf =3D v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
> +		dst_buf =3D v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
> +
> +		ret =3D pm_runtime_resume_and_get(jpeg->dev);
> +		if (ret < 0)
> +			goto enc_end;
> +
> +		schedule_delayed_work(&jpeg->job_timeout_work,
> +				      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> +
> +		spin_lock_irqsave(&jpeg->hw_lock, flags);
> +
> +		/*
> +		 * Resetting the hardware every frame is to ensure that all the
> +		 * registers are cleared. This is a hardware requirement.
> +		 */
> +		mtk_jpeg_enc_reset(jpeg->reg_base);
> +
> +		mtk_jpeg_set_enc_src(ctx, jpeg->reg_base, &src_buf->vb2_buf);
> +		mtk_jpeg_set_enc_dst(ctx, jpeg->reg_base, &dst_buf->vb2_buf);
> +		mtk_jpeg_set_enc_params(ctx, jpeg->reg_base);
> +		mtk_jpeg_enc_start(jpeg->reg_base);
> +		spin_unlock_irqrestore(&jpeg->hw_lock, flags);
> +		return;
> +
> +enc_end:
> +		v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> +		v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> +		v4l2_m2m_buf_done(src_buf, buf_state);
> +		v4l2_m2m_buf_done(dst_buf, buf_state);
> +		v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> +	} else {
> +		queue_work(jpeg->workqueue, &ctx->jpeg_work);
> +	}
> +}
> +
>  static void mtk_jpeg_dec_device_run(void *priv)
>  {
>  	struct mtk_jpeg_ctx *ctx =3D priv;
> @@ -1211,6 +1368,13 @@ static int mtk_jpeg_open(struct file *file)
>  		goto free;
>  	}
> =20
> +	if (jpeg->variant->is_multihw) {
> +		if (of_property_read_bool(jpeg->dev->of_node,
> +					  "mediatek,jpegenc-multi-core")) {
> +			INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
> +		}
> +	}
> +
>  	v4l2_fh_init(&ctx->fh, vfd);
>  	file->private_data =3D &ctx->fh;
>  	v4l2_fh_add(&ctx->fh);
> @@ -1345,6 +1509,18 @@ static int mtk_jpeg_probe(struct platform_device *=
pdev)
>  			dev_err(&pdev->dev, "Failed to init clk\n");
>  			goto err_clk_init;
>  		}
> +	} else {
> +		if (of_property_read_bool(pdev->dev.of_node,
> +					  "mediatek,jpegenc-multi-core")) {
> +			init_waitqueue_head(&jpeg->enc_hw_wq);
> +			jpeg->workqueue =3D alloc_ordered_workqueue(MTK_JPEG_NAME,
> +								  WQ_MEM_RECLAIM
> +								  | WQ_FREEZABLE);
> +			if (!jpeg->workqueue) {
> +				ret =3D -EINVAL;
> +				goto err_alloc_workqueue;
> +			}
> +		}
>  	}
> =20
>  	ret =3D v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
> @@ -1421,6 +1597,8 @@ static int mtk_jpeg_probe(struct platform_device *p=
dev)
> =20
>  err_clk_init:
> =20
> +err_alloc_workqueue:
> +
>  err_req_irq:
> =20
>  	return ret;
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> index 0683d80fcea5..d233a49bf952 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
> @@ -76,6 +76,11 @@ struct mtk_jpeg_variant {
>  	u32 cap_q_default_fourcc;
>  };
> =20
> +enum mtk_jpeg_hw_state {
> +	MTK_JPEG_HW_IDLE =3D 0,
> +	MTK_JPEG_HW_BUSY =3D 1,
> +};
> +
>  struct mtk_jpeg_hw_param {
>  	struct vb2_v4l2_buffer *src_buffer;
>  	struct vb2_v4l2_buffer *dst_buffer;
> @@ -98,12 +103,17 @@ struct mtk_jpegenc_clk {
> =20
>  /**
>   * struct mtk_jpegenc_comp_dev - JPEG COREX abstraction
> - * @dev:		        JPEG device
> - * @plat_dev:		    platform device data
> - * @reg_base:		    JPEG registers mapping
> - * @master_dev:		    mtk_jpeg_dev device
> - * @pm:	                mtk_jpegenc_pm
> - * @jpegenc_irq:	    jpeg encode irq num
> + * @dev:		JPEG device
> + * @plat_dev:		platform device data
> + * @reg_base:		JPEG registers mapping
> + * @master_dev:		mtk_jpeg_dev device
> + * @venc_clk:	        mtk_jpegenc_clk
> + * @jpegenc_irq:	jpeg encode irq num
> + * @job_timeout_work:	handle jpeg encode work
> + * @hw_param:		record hw param
> + * @hw_rdy:		record hw ready
> + * @hw_state:		record hw state
> + * @hw_lock:		spinlock protecting the hw device resource
>   */
>  struct mtk_jpegenc_comp_dev {
>  	struct device *dev;
> @@ -115,6 +125,10 @@ struct mtk_jpegenc_comp_dev {
>  	int hw_id;
>  	struct delayed_work job_timeout_work;
>  	struct mtk_jpeg_hw_param hw_param;
> +	atomic_t hw_rdy;
> +	enum mtk_jpeg_hw_state hw_state;
> +	//spinlock protecting the hw device resource
> +	spinlock_t hw_lock;
>  };
> =20
>  /**
> @@ -146,6 +160,7 @@ struct mtk_jpeg_dev {
> =20
>  	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
>  	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
> +	wait_queue_head_t enc_hw_wq;
>  };
> =20
>  /**
> @@ -204,6 +219,9 @@ struct mtk_jpeg_ctx {
>  	u8 enc_quality;
>  	u8 restart_interval;
>  	struct v4l2_ctrl_handler ctrl_hdl;
> +
> +	struct work_struct jpeg_work;
> +	u32 total_frame_num;
>  };
> =20
>  #endif /* _MTK_JPEG_CORE_H */
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> index 99f3db2a393a..316dd3818187 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
> @@ -192,6 +192,7 @@ static void mtk_jpegenc_timeout_work(struct work_stru=
ct *work)
>  		container_of(dly_work,
>  			     struct mtk_jpegenc_comp_dev,
>  			     job_timeout_work);
> +	struct mtk_jpeg_dev *master_jpeg =3D cjpeg->master_dev;
>  	enum vb2_buffer_state buf_state =3D VB2_BUF_STATE_ERROR;
>  	struct vb2_v4l2_buffer *src_buf, *dst_buf;
> =20
> @@ -202,6 +203,9 @@ static void mtk_jpegenc_timeout_work(struct work_stru=
ct *work)
>  	mtk_jpeg_enc_reset(cjpeg->reg_base);
>  	clk_disable_unprepare(cjpeg->venc_clk.clks->clk);
>  	pm_runtime_put(cjpeg->dev);
> +	cjpeg->hw_state =3D MTK_JPEG_HW_IDLE;
> +	atomic_inc(&cjpeg->hw_rdy);
> +	wake_up(&master_jpeg->enc_hw_wq);
>  	v4l2_m2m_buf_done(src_buf, buf_state);
>  }
> =20
> @@ -218,30 +222,38 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int i=
rq, void *priv)
> =20
>  	cancel_delayed_work(&jpeg->job_timeout_work);
> =20
> +	ctx =3D jpeg->hw_param.curr_ctx;
> +	src_buf =3D jpeg->hw_param.src_buffer;
> +	dst_buf =3D jpeg->hw_param.dst_buffer;
> +	dst_buf->vb2_buf.timestamp =3D src_buf->vb2_buf.timestamp;
> +
>  	irq_status =3D readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
>  		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
>  	if (irq_status)
>  		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
> -	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
> -		return IRQ_NONE;
> =20
> -	ctx =3D v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
> -	if (!ctx) {
> -		v4l2_err(&master_jpeg->v4l2_dev, "Context is NULL\n");
> -		return IRQ_HANDLED;
> +	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE)) {
> +		dev_err(jpeg->dev, " Not JPEG_ENC_INT_STATUS_DONE\n");
> +		goto irq_handled;
>  	}
> =20
> -	src_buf =3D v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
> -	dst_buf =3D v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
> -	dst_buf->vb2_buf.timestamp =3D src_buf->vb2_buf.timestamp;
> -
>  	result_size =3D mtk_jpeg_enc_get_file_size(jpeg->reg_base);
>  	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
> +
> +irq_handled:
>  	buf_state =3D VB2_BUF_STATE_DONE;
>  	v4l2_m2m_buf_done(src_buf, buf_state);
>  	v4l2_m2m_buf_done(dst_buf, buf_state);
> -	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
>  	pm_runtime_put(ctx->jpeg->dev);
> +	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
> +	if (!list_empty(&ctx->fh.m2m_ctx->out_q_ctx.rdy_queue) ||
> +	    !list_empty(&ctx->fh.m2m_ctx->cap_q_ctx.rdy_queue)) {
> +		queue_work(master_jpeg->workqueue, &ctx->jpeg_work);
> +	}
> +
> +	jpeg->hw_state =3D MTK_JPEG_HW_IDLE;
> +	wake_up(&master_jpeg->enc_hw_wq);
> +	atomic_inc(&jpeg->hw_rdy);
> =20
>  	return IRQ_HANDLED;
>  }
> @@ -294,6 +306,10 @@ static int mtk_jpegenc_hw_probe(struct platform_devi=
ce *pdev)
>  	dev->plat_dev =3D pdev;
>  	dev->dev =3D &pdev->dev;
> =20
> +	atomic_set(&dev->hw_rdy, 1U);
> +	spin_lock_init(&dev->hw_lock);
> +	dev->hw_state =3D MTK_JPEG_HW_IDLE;
> +
>  	INIT_DELAYED_WORK(&dev->job_timeout_work,
>  			  mtk_jpegenc_timeout_work);
> =20


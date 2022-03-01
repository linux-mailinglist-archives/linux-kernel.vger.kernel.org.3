Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213364C8E15
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiCAOp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbiCAOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:45:25 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A62A709
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:44:43 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b13so13010691qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 06:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=WkCA9qH6vVLYzu+u6wTBqAFPzNBD5R0NvjAHwZ5DKRI=;
        b=fyMPLIzcyTCrvlvg32Ua6gbBG1tr6+BgnGVlDkID26/vuabOCWwZnoRbc7pTR0trKs
         /dNgVEU+mhxuWzWmNxQbkx1TLul4ohVBQT4Z1QTQRD1re477HEf7s8SLUz3EkCl58vVI
         TR0IDLhlxkE2C+4GV4jazycemFham7O4IvJ7pLZpzHlOm2WLDOObZMRNYcUSZTRXEt94
         pV2kmOnVl0vU+uLpZT0e/Z0W14sVdOSiDpcQoaePMtWQUxXXdwZr2482jC2ehsaSuEEB
         r1nIBhJE/vJlJCbCJEha+OJc0HH5RLigTIc3JHcGNRYJeLu2ANyu4k1xBE6Ag68T89Qf
         QAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WkCA9qH6vVLYzu+u6wTBqAFPzNBD5R0NvjAHwZ5DKRI=;
        b=qYGvi4dDYSwwJRP6hh4rI/M5SOfzxj5zdkHz5KcmHDgspqGM/SezGj7ui0DU/+skMT
         vb4mCTDqzYeDbygbTw5wCB1g0Hb/1yadZvve8Gvvht0+joQRNWAkos1aY16ujEB41YQu
         NZ6crLZr39+2zuTMMTN4s64uPyYJKL4LiJwEMypkzOaurpgoJSQv/7wsZFPaM85WOFd9
         er9TB7MPHHSXX+HHppOKjIGxhkk58VtNzOsrEH7OYimSX5585koIcpu1rlLcdQfrg/oJ
         Jb0TMS99UK+81vJ10I2abOOSsi3NayDC42D2k9Tp0K35H8hlaYZNqVfqUhKHRLqZajMx
         DsHA==
X-Gm-Message-State: AOAM530O3tQS4VBd7n4v6tKTk5KGKmBq3aN1gJ3VJRTO/qPgt2m9Ym48
        Pk1WhmyaTA76glQzU6WRS+OzTzKpsfwO6mkq
X-Google-Smtp-Source: ABdhPJxE/e0D/N3u+MX4lGWSKp8+eZy0EEciVed9iWZbwDOIGQKyDwek+X7MKvGZ8yKTtOEaARFqbA==
X-Received: by 2002:a37:b842:0:b0:479:2ecc:e51e with SMTP id i63-20020a37b842000000b004792ecce51emr13881457qkf.206.1646145882950;
        Tue, 01 Mar 2022 06:44:42 -0800 (PST)
Received: from nicolas-tpx395.localdomain (173-246-12-168.qc.cable.ebox.net. [173.246.12.168])
        by smtp.gmail.com with ESMTPSA id u26-20020ae9c01a000000b0062ce6955181sm6609852qkk.31.2022.03.01.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 06:44:42 -0800 (PST)
Message-ID: <0af43e6de8bb963eecb856e88b00d649c5720c3d.camel@ndufresne.ca>
Subject: Re: [PATCH v7, 03/15] media: mtk-vcodec: get capture queue buffer
 size from scp
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 01 Mar 2022 09:44:40 -0500
In-Reply-To: <20220223034008.15781-4-yunfei.dong@mediatek.com>
References: <20220223034008.15781-1-yunfei.dong@mediatek.com>
         <20220223034008.15781-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your patch, though perhaps it could be improved, see comment below.

Le mercredi 23 février 2022 à 11:39 +0800, Yunfei Dong a écrit :
> Different capture buffer format has different buffer size, need to get
> real buffer size according to buffer type from scp.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../media/platform/mtk-vcodec/vdec_ipi_msg.h  | 36 ++++++++++++++
>  .../media/platform/mtk-vcodec/vdec_vpu_if.c   | 49 +++++++++++++++++++
>  .../media/platform/mtk-vcodec/vdec_vpu_if.h   | 15 ++++++
>  3 files changed, 100 insertions(+)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h b/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
> index bf54d6d9a857..47070be2a991 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
> +++ b/drivers/media/platform/mtk-vcodec/vdec_ipi_msg.h
> @@ -20,6 +20,7 @@ enum vdec_ipi_msgid {
>  	AP_IPIMSG_DEC_RESET = 0xA004,
>  	AP_IPIMSG_DEC_CORE = 0xA005,
>  	AP_IPIMSG_DEC_CORE_END = 0xA006,
> +	AP_IPIMSG_DEC_GET_PARAM = 0xA007,
>  
>  	VPU_IPIMSG_DEC_INIT_ACK = 0xB000,
>  	VPU_IPIMSG_DEC_START_ACK = 0xB001,
> @@ -28,6 +29,7 @@ enum vdec_ipi_msgid {
>  	VPU_IPIMSG_DEC_RESET_ACK = 0xB004,
>  	VPU_IPIMSG_DEC_CORE_ACK = 0xB005,
>  	VPU_IPIMSG_DEC_CORE_END_ACK = 0xB006,
> +	VPU_IPIMSG_DEC_GET_PARAM_ACK = 0xB007,
>  };
>  
>  /**
> @@ -114,4 +116,38 @@ struct vdec_vpu_ipi_init_ack {
>  	uint32_t inst_id;
>  };
>  
> +/**
> + * struct vdec_ap_ipi_get_param - for AP_IPIMSG_DEC_GET_PARAM
> + * @msg_id	: AP_IPIMSG_DEC_GET_PARAM
> + * @inst_id     : instance ID. Used if the ABI version >= 2.
> + * @data	: picture information
> + * @param_type	: get param type
> + * @codec_type	: Codec fourcc
> + */
> +struct vdec_ap_ipi_get_param {
> +	u32 msg_id;
> +	u32 inst_id;
> +	u32 data[4];
> +	u32 param_type;
> +	u32 codec_type;
> +};
> +
> +/**
> + * struct vdec_vpu_ipi_get_param_ack - for VPU_IPIMSG_DEC_GET_PARAM_ACK
> + * @msg_id	: VPU_IPIMSG_DEC_GET_PARAM_ACK
> + * @status	: VPU execution result
> + * @ap_inst_addr	: AP vcodec_vpu_inst instance address
> + * @data     : picture information from SCP.
> + * @param_type	: get param type
> + * @reserved : reserved param
> + */
> +struct vdec_vpu_ipi_get_param_ack {
> +	u32 msg_id;
> +	s32 status;
> +	u64 ap_inst_addr;
> +	u32 data[4];
> +	u32 param_type;
> +	u32 reserved;
> +};
> +
>  #endif
> diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
> index 7210061c772f..35f4d5583084 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
> @@ -6,6 +6,7 @@
>  
>  #include "mtk_vcodec_drv.h"
>  #include "mtk_vcodec_util.h"
> +#include "vdec_drv_if.h"
>  #include "vdec_ipi_msg.h"
>  #include "vdec_vpu_if.h"
>  #include "mtk_vcodec_fw.h"
> @@ -54,6 +55,26 @@ static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
>  	}
>  }
>  
> +static void handle_get_param_msg_ack(const struct vdec_vpu_ipi_get_param_ack *msg)
> +{
> +	struct vdec_vpu_inst *vpu = (struct vdec_vpu_inst *)
> +					(unsigned long)msg->ap_inst_addr;
> +
> +	mtk_vcodec_debug(vpu, "+ ap_inst_addr = 0x%llx", msg->ap_inst_addr);
> +
> +	/* param_type is enum vdec_get_param_type */
> +	switch (msg->param_type) {
> +	case GET_PARAM_PIC_INFO:
> +		vpu->fb_sz[0] = msg->data[0];
> +		vpu->fb_sz[1] = msg->data[1];
> +		break;
> +	default:
> +		mtk_vcodec_err(vpu, "invalid get param type=%d", msg->param_type);
> +		vpu->failure = 1;
> +		break;
> +	}
> +}
> +
>  /*
>   * vpu_dec_ipi_handler - Handler for VPU ipi message.
>   *
> @@ -89,6 +110,9 @@ static void vpu_dec_ipi_handler(void *data, unsigned int len, void *priv)
>  		case VPU_IPIMSG_DEC_CORE_END_ACK:
>  			break;
>  
> +		case VPU_IPIMSG_DEC_GET_PARAM_ACK:
> +			handle_get_param_msg_ack(data);
> +			break;
>  		default:
>  			mtk_vcodec_err(vpu, "invalid msg=%X", msg->msg_id);
>  			break;
> @@ -217,6 +241,31 @@ int vpu_dec_start(struct vdec_vpu_inst *vpu, uint32_t *data, unsigned int len)
>  	return err;
>  }
>  
> +int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint32_t *data,
> +		      unsigned int len, unsigned int param_type)
> +{
> +	struct vdec_ap_ipi_get_param msg;
> +	int err;
> +
> +	mtk_vcodec_debug_enter(vpu);
> +
> +	if (len > ARRAY_SIZE(msg.data)) {
> +		mtk_vcodec_err(vpu, "invalid len = %d\n", len);
> +		return -EINVAL;
> +	}
> +
> +	memset(&msg, 0, sizeof(msg));
> +	msg.msg_id = AP_IPIMSG_DEC_GET_PARAM;
> +	msg.inst_id = vpu->inst_id;
> +	memcpy(msg.data, data, sizeof(unsigned int) * len);
> +	msg.param_type = param_type;
> +	msg.codec_type = vpu->codec_type;
> +
> +	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
> +	mtk_vcodec_debug(vpu, "- ret=%d", err);
> +	return err;
> +}
> +
>  int vpu_dec_core(struct vdec_vpu_inst *vpu)
>  {
>  	return vcodec_send_ap_ipi(vpu, AP_IPIMSG_DEC_CORE);
> diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> index 4cb3c7f5a3ad..d1feba41dd39 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> +++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.h
> @@ -28,6 +28,8 @@ struct mtk_vcodec_ctx;
>   * @wq          : wait queue to wait VPU message ack
>   * @handler     : ipi handler for each decoder
>   * @codec_type     : use codec type to separate different codecs
> + * @capture_type    : used capture type to separate different capture format
> + * @fb_sz  : frame buffer size of each plane
>   */
>  struct vdec_vpu_inst {
>  	int id;
> @@ -42,6 +44,8 @@ struct vdec_vpu_inst {
>  	wait_queue_head_t wq;
>  	mtk_vcodec_ipi_handler handler;
>  	unsigned int codec_type;
> +	unsigned int capture_type;

This structure member is added in this patch, but never set or used.

> +	unsigned int fb_sz[2];
>  };
>  
>  /**
> @@ -104,4 +108,15 @@ int vpu_dec_core(struct vdec_vpu_inst *vpu);
>   */
>  int vpu_dec_core_end(struct vdec_vpu_inst *vpu);
>  
> +/**
> + * vpu_dec_get_param - get param from scp
> + *
> + * @vpu : instance for vdec_vpu_inst
> + * @data: meta data to pass bitstream info to VPU decoder
> + * @len : meta data length
> + * @param_type : get param type
> + */
> +int vpu_dec_get_param(struct vdec_vpu_inst *vpu, uint32_t *data,
> +		      unsigned int len, unsigned int param_type);
> +
>  #endif


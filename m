Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048DC54B864
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbiFNSQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiFNSQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:16:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A912A271
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:16:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d128so7017395qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=IUZbp7PiXUU7CAVpO1jooUP9RPiupsus4DCsHt1x4pQ=;
        b=GVcOu+R24+27b2NOvitiVm0BFB8m/d5jTlFrMXfoUi7v9rt8nF0E2q0h9wUTAiiNqL
         0dOB9sUXKyM0KWkVvc1bLRbT+961TQS0GbEGUMR0YGhhtAnUHWh7SgKaU8H5D/WOw8Ik
         kQVot4N1MIEvbRmr+TER8hR+dyhNLMzo/wAy4KqSibgLRZ12kyTdDUvVynQ+q9Et3sXJ
         KYwRZ3CWARS/lM6FUYw1ZReTAYgotqGiLV5I9b1DU9WZmol83vnmF7+66YxUiG3p7AJh
         UyIActoNb1Aa6Nk+ElpIqwIJ+vtaj0p4ApTGcXhfvGgGcu7l/oIrN6JB9zdXPQFK0N2E
         AtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=IUZbp7PiXUU7CAVpO1jooUP9RPiupsus4DCsHt1x4pQ=;
        b=qbI29G3MDde2l1VKSfBkip/5Kfb7WdJCeMlZt/NfXslwvqaxOn28PYfLnki5bByRIT
         vBfMzshXeO7kKHiCpNAvGlohx0f6jOyIx7SMb3hOFwXy3uCBFbSY5ZNTPsOtVfI3C1F8
         iS40qknqZfUYXJ7cJoyWubCU6CyIuSSSG/niHbQPAFIx5z+MXWfCpnmnDw9U2xBqSa+J
         sty8Oyxo5fAJlqDnabDyrX4KkDwRJh4yE2h5CKuYE8K+bIgj29HSZPnZyY7oZMHsETbR
         fIrxBPYilue0n8z4PNNrH/r0+2FplW2cRlYPRVT44d3tay0BUe18GQicg/BPj+2PlaxS
         T2Tw==
X-Gm-Message-State: AOAM531SMSjo/kmSpd+JXOXXeq/4iyRnZL+AcVzEA2EfjnZlPrmRmoUN
        0iLj9TW2zJE1XXpAY1XwlueAOA==
X-Google-Smtp-Source: ABdhPJyspk1OooBvKaZDZNbDRmfj2xD5SU/mh9sKS0Jw8BTrNURhDW6qUdVc4ix3LNjCyOrp5xwfbA==
X-Received: by 2002:a05:620a:28d6:b0:6a7:7a8d:4840 with SMTP id l22-20020a05620a28d600b006a77a8d4840mr4912308qkp.500.1655230563578;
        Tue, 14 Jun 2022 11:16:03 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id r11-20020a37a80b000000b006a6ab259261sm9371251qke.29.2022.06.14.11.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:16:03 -0700 (PDT)
Message-ID: <9fef91917df081bd94e4b8e7e76b441264ad073c.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: fix minmax.cocci warning
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Guo Zhengkui <guozhengkui@vivo.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Haowen Bai <baihaowen@meizu.com>,
        George Sun <george.sun@mediatek.com>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     zhengkui_guo@outlook.com
Date:   Tue, 14 Jun 2022 14:16:01 -0400
In-Reply-To: <20220614072618.26925-1-guozhengkui@vivo.com>
References: <20220614072618.26925-1-guozhengkui@vivo.com>
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

Le mardi 14 juin 2022 =C3=A0 15:25 +0800, Guo Zhengkui a =C3=A9crit=C2=A0:
> Fix the following coccicheck warning:
>=20
> drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c:
> 694:15-16: WARNING opportunity for min().
>=20
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat=
_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> index f464af190d8c..81de876d5126 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
> @@ -691,7 +691,7 @@ static int vdec_vp9_slice_tile_offset(int idx, int mi=
_num, int tile_log2)
>  	int sbs =3D (mi_num + 7) >> 3;
>  	int offset =3D ((idx * sbs) >> tile_log2) << 3;
> =20
> -	return offset < mi_num ? offset : mi_num;
> +	return min(offset, mi_num);
>  }
> =20
>  static

regards,
Nicolas


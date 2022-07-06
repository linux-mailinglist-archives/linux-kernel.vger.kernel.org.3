Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE13A567CFA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiGFEFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiGFEFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:05:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40B42958E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657080305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k07HRFbOFiUBUdfl6xSh6EEBnHPKszbgl4EpE1PM/GE=;
        b=Jx09jCyj3Y40r9T0hS1CtLa3i/5TEZ2WjGAEhPNYf1jN+wc2fp2zMT6m18t2+7n8puWUgN
        kiwa+FE6lu8fsGem3aA0yngiCvZYzit9NLcqk/eb+5yXgl6yt2kbclb7W2VoleWVrxQsOf
        oWQ+Epe3JRhwOy1f0QFPh9pJmBNmVX8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-bUAb_cn-M96RXvIJX-egKQ-1; Wed, 06 Jul 2022 00:04:56 -0400
X-MC-Unique: bUAb_cn-M96RXvIJX-egKQ-1
Received: by mail-lj1-f197.google.com with SMTP id y8-20020a2eb008000000b0025bf6ec0c6cso4173466ljk.20
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 21:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k07HRFbOFiUBUdfl6xSh6EEBnHPKszbgl4EpE1PM/GE=;
        b=BZQRWJ4QK0Ql0uWZ7yLoLXUGCuv/USbRRIUPerlNIqvn6f2BfDFUlEmCEBjp2FhZTG
         1z7tfAdXv4PdY5ERchVC9B5w+b8Fcb0y26i4NpBkNKCUX7Xr4aPfyC6SsG/s5rBeDaUD
         BuuLFWUlWXdLamnbXp8CcBB0mZtaRkGE+fnU1nnyuaTHuCgB1ujzn43RdFdwrbjs/Jkv
         qeml0HxCd/93fwEcC1i3aW19X8c/Ks+fyDIkRQCXwKuWdkI1ajuzAmh2QIt00Oj1As97
         8HuzjymSIjdQams9uCQ1yMyDF3iggiv39oEsHCJEXiiDZJVU1kBsvWbGaoZIufvVrsT9
         txlQ==
X-Gm-Message-State: AJIora8FJ6BeYT3AcZCEj0MCQfwY36WrS6+r2TkljyJqAxvC0TsZk67t
        TwmQbOu1sqJGEE7t8ks90oYcdlS0G1G8VadhByalnADvNNG5ETTKAanSfzNGOaU1XyrmumHQyat
        rx+eiqY8+2HnrTIvNzqr6m3/9jRup8s27Qcgb8ja2
X-Received: by 2002:a2e:9043:0:b0:25d:1ba8:5b59 with SMTP id n3-20020a2e9043000000b0025d1ba85b59mr9509164ljg.496.1657080294313;
        Tue, 05 Jul 2022 21:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vIYFZhrA46WES5xcvLJavARz+fvVIjuPHJ6w8X3S/rWD6vBSkXFusl9QD1gav74vumzK33/Sw+eUpd8qdpHeI=
X-Received: by 2002:a2e:9043:0:b0:25d:1ba8:5b59 with SMTP id
 n3-20020a2e9043000000b0025d1ba85b59mr9509155ljg.496.1657080294118; Tue, 05
 Jul 2022 21:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220704024104.15535-1-jiaming@nfschina.com>
In-Reply-To: <20220704024104.15535-1-jiaming@nfschina.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 6 Jul 2022 12:04:43 +0800
Message-ID: <CACGkMEvGQ6v6-Td+cK0ew2znqrEcUK6RtT9GUg2S7_-r=HY1Gg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: ifcvf: Fix spelling mistake in comments
To:     Zhang Jiaming <jiaming@nfschina.com>
Cc:     mst <mst@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Eli Cohen <elic@nvidia.com>,
        Yongji Xie <xieyongji@bytedance.com>,
        Gautam Dawar <gautam.dawar@xilinx.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        liqiong@nfschina.com, renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 10:41 AM Zhang Jiaming <jiaming@nfschina.com> wrote:
>
> There is a typo(does't) in comments.
> It maybe 'doesn't' instead of 'does't'.
>
> Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 0a5670729412..e2e201885713 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -685,7 +685,7 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
>  }
>
>  /*
> - * IFCVF currently does't have on-chip IOMMU, so not
> + * IFCVF currently doesn't have on-chip IOMMU, so not
>   * implemented set_map()/dma_map()/dma_unmap()
>   */
>  static const struct vdpa_config_ops ifc_vdpa_ops = {
> --
> 2.34.1
>


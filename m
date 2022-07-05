Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B665661B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 05:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiGEDPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 23:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGEDPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 23:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E88CEE04
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 20:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656990912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MPiLYuaQHJ/dNIyImBUJeFklEe+TyW/wfcZITbRD1eI=;
        b=YI2rSS0aZkJKff79sKa8cJsbhM9xSs5ZFvATUpJh9Y43HKEL7Xr2bw4kk0QNw8RfJ1b61i
        5SouEEYvZDnacIOGuaeyhmUhu+oQoNugMNB3FDYFoH0hTlhjpSUpCrVB096fSexxyUeXT4
        Z7Okt2y8wgOSyr7aHc2hKdVY7S+/lvk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-_jyVbulNMj-hoSMU2Z5UXw-1; Mon, 04 Jul 2022 23:15:10 -0400
X-MC-Unique: _jyVbulNMj-hoSMU2Z5UXw-1
Received: by mail-lf1-f71.google.com with SMTP id o22-20020a05651205d600b004810c974c17so3508103lfo.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 20:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPiLYuaQHJ/dNIyImBUJeFklEe+TyW/wfcZITbRD1eI=;
        b=pG948Nj+lPfcjQP6iOX/qrKJDYoYsowrmc1W5QYIFh3UO07Q/ZbBfD8ou/FF1W+oiL
         svdnWnPdi0V4P68Dpi5rBi1xRa1hnsBCP2uczkUOYBREnZUzeZA0ESgm/VJ5vGqV6/RG
         WRrUCsTqOMFxw8dlQeEG8UqvR9Q/3LxtrzG8kBE8a5Ssk9xtWhgeuDmQitwvMN7J8ntU
         0pcevOKeT528P95a9ZtrCDsF3zz81/ZT1HHqrMEquJb45FE7M2jzvEVHwRVZkdRt3EX3
         ewvRMXili19Jd19XM6OSty9JPfpNoiZ5nc6viEA3nmem3Ah+fc/bkJ+JFMpcCazECwOY
         fIcA==
X-Gm-Message-State: AJIora/wGOivPBMJCmFjpuUO3YzLxpZlkltD2MWrsYeBJjv8/4rZ7npS
        JjcqAY/gBekBPAue9DahkxbfOh3Y4rq++LkZIvnWyJadJrA0YoM17XQXzg2FvYOF+ZOfQD8Yk54
        AZmw6+0sl2h7MBFH2TJUvm9Xj1u/8JuriUo5wbp7V
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id y15-20020a0565123f0f00b0047f6f890326mr19728905lfa.124.1656990909242;
        Mon, 04 Jul 2022 20:15:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tza1pmpMAWjNhoieZO4QqKWL1/YPqUOvpoVjPyKy0BY4OsaLw+4a3jzDRxrl7JkPP/xB1zCm2drjENV6/171U=
X-Received: by 2002:a05:6512:3f0f:b0:47f:6f89:326 with SMTP id
 y15-20020a0565123f0f00b0047f6f890326mr19728895lfa.124.1656990909097; Mon, 04
 Jul 2022 20:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220704190456.593464-1-colin.i.king@gmail.com>
In-Reply-To: <20220704190456.593464-1-colin.i.king@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 5 Jul 2022 11:14:58 +0800
Message-ID: <CACGkMEsEZjmG8JV6hz4=a=hWLFxeGom6sGs7LSYzTZnoC-M7jQ@mail.gmail.com>
Subject: Re: [PATCH] vDPA/ifcvf: remove duplicated assignment to pointer cfg
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 3:05 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> The assignment to pointer cfg is duplicated, the second assignment
> is redundant and can be removed.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/ifcvf/ifcvf_base.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
> index 48c4dadb0c7c..47b94091733c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
> @@ -29,7 +29,6 @@ u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector)
>  {
>         struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
>
> -       cfg = hw->common_cfg;
>         vp_iowrite16(vector,  &cfg->msix_config);
>
>         return vp_ioread16(&cfg->msix_config);
> --
> 2.35.3
>


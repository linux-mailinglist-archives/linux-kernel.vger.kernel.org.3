Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE353240F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbiEXH1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiEXH1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:27:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC2C980BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r71so15676474pgr.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsv75/jMSG9IE7z+FFdGkSFpTdlyLS1N1PmQi6VFqBI=;
        b=wvLcdRoTzjduYLMmkssoeHZpDzj+D6Li3c0sGg6dhznKpbBFocVHCep91+LKPeyu6A
         adf8V3sSKAOctotcch5S4mjMvRTbGhUus5+QA9diimFJsnt8A7i6RD2y60WXwsSGiVdh
         bgwJnqToDTyrZHPGBmo0VfUmcmMllbbq6FQB+bPb997SkUODY+yapFzKf5qaekHLwqXu
         +UX9XXuscTRgo2MU9b9/+1PWDINJRaRuHj42B7O7KiR1jhJSTJoTBSaL8gJ2Gt9CqoYy
         eR7pDrcyhkAJYgcV8Nobpd9IwwO8hEcjkrUHmcHmfpQH8XlOqP3WIr1mmEMAnLuWDQDE
         MRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsv75/jMSG9IE7z+FFdGkSFpTdlyLS1N1PmQi6VFqBI=;
        b=LZM3hIBtG7BLiEkA1q53NccFfCcmYMtdXSdBKAUtZpBgpZPDXmcUGmRwn7zkmdlqsv
         xifol6JkJ40i9zhbjvni0es3CnciFjvcx39QLFia3NHAXCx0WyVD12ftta/0/ufJnW4H
         zJ7KKPca0HFB+7ZBF/URJbOrELM7xdMcTEZqtF4T8uG72KgR4z8n1lhGGv36sBVCmooQ
         be9nc/ewA83ETL/r8V0jx7IqMKfqr8stjUxeQHi6P8+ktwS2W4ng5Ea1Nzd5o0EiszMz
         vANM+0NvPZlRoh1UrHs9X4uZOZogwPtrAk6Wd6+O4/NYiNvO2902fGXy4+nLEiZPzHWi
         G2WA==
X-Gm-Message-State: AOAM5326A/gK4MO9okA5zouBxEj9Zg34ur33cjOujYPpFnBlBiVOmsFl
        Qz8XcMHHqcTrfa6kkWzj+E/bYNamuiFWslGhAM++Vw==
X-Google-Smtp-Source: ABdhPJw3ORe/h7f5dIvOTqYeutYcfp1EKqFSPpJWeNvmseS55Kkvyhwnm9kIFnPx97OSfYOHlmOBlicekC0ETSFOvdM=
X-Received: by 2002:a05:6a00:228c:b0:518:9533:4a1e with SMTP id
 f12-20020a056a00228c00b0051895334a1emr11198767pfe.79.1653377262793; Tue, 24
 May 2022 00:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 24 May 2022 09:27:06 +0200
Message-ID: <CAMZdPi8c1HqxgGW2woTF=0wUv_gV+pn5q088fYZ=KV0p=avJfA@mail.gmail.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
To:     Yonglin Tan <yonglin.tan@outlook.com>
Cc:     mani@kernel.org, gregkh@linuxfoundation.org,
        quic_hemantk@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 at 08:38, Yonglin Tan <yonglin.tan@outlook.com> wrote:
>
> The product's enumeration align with previous
> Quectel EM120R-GL, so the EM120 FCCL would use
> the same config as Quectel EM120R-GL.
>
> Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>

> ---
>
> V2:
> Fixed the format errors in the patch description.
>
>  drivers/bus/mhi/host/pci_generic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 8416267..0a6469c 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>                 .driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>         { PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
>                 .driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> +       { PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> +               .driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>         /* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>         { PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
>                 .driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> --
> 2.7.4
>

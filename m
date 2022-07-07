Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD856A0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 13:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiGGLAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 07:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiGGLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 07:00:27 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECE57248;
        Thu,  7 Jul 2022 04:00:22 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id z13so22103160qts.12;
        Thu, 07 Jul 2022 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23PHPhj0/eKznTyCRyOWvJNJPLtb5rkGTi+i3ffjDQg=;
        b=R38cThAMSULlEeQBN5Nkvs0zkLWIe/XgyrTdEyatK+/kULG1Rr1iSdTohMX/Cj+V4Z
         QohIxVtXWyAsojJ+NI2tu+LUefD7culAywaEBiGB7F7hrLovL4hJeD0HJKLWkanuFhqU
         8euQFjQGrzqprpdmaxm0SX2IukIIh2Ho15zIIexwme+bUJVRmanszdGXrn7DnVihyyBx
         ODgYJ+MNANEsmKOiqSx4njUFUVhcmTFotX1IhA72npaIdGu+QLzqp6JF3P8jtFGfGN3l
         xkshljPIVAwSolcwea+Td5ZcY05Qca5m7RCxxhVlMyj6csG4SfxUVQITECH75xnH3aFL
         bNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23PHPhj0/eKznTyCRyOWvJNJPLtb5rkGTi+i3ffjDQg=;
        b=PVzNPtfrZBXDz0t+l4CEYnysPRgBdVotbCQIRxZhlz6knE8Yb1HnaIPi7wzJB3OWWB
         JWCBLxxU7qssWd9lJcEbfcWrcoMqDVFp0htP/YEkZiL+0jzfry8NQlWoqY78Qo62i7vy
         E6izVVU074kq4PPYNpZNZOxCBacCGOxFpcWFBB8U2oSiA6QhdMVqCo83JK1tMuybr0Ag
         IPJuRyAUXDgBiVjBB1l8R1Z0WxUxGew5Keag+Gkb82Wx7FjKGE1i2y9QSw/r9Yp/qu8J
         X/I90rUaLY+y9Kqjh/FTVMw/xT6O79SoRYZLwNFfA8b1O9loIG7Qn1eP9NQ8kigFbKF7
         LYpQ==
X-Gm-Message-State: AJIora/ThEBcnDClj8YY1eKskmt1D9nyUZBNRFb8lerFqyQH4uQoaqtT
        FdTYP2dA9lPzKzGpkwg/vy9P885/Z00IFFL0IXI=
X-Google-Smtp-Source: AGRyM1u8k/iin/OaNtZEhyGsTxZtJfs/5NKuYhAAZXEhoFAnwJUczcq/MA3Tn93WeumlczS5+dC5MmEpq1GYX3z/otY=
X-Received: by 2002:a05:6214:5014:b0:473:3720:d422 with SMTP id
 jo20-20020a056214501400b004733720d422mr418092qvb.117.1657191621359; Thu, 07
 Jul 2022 04:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220707013017.26654-1-ansuelsmth@gmail.com>
In-Reply-To: <20220707013017.26654-1-ansuelsmth@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 7 Jul 2022 19:00:15 +0800
Message-ID: <CADBw62o8HfH_MfbLP-=5qra9yjO34bUC__mZU1NDxqFALQZOmw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwspinlock: qcom: Add support for mmio usage to sfpb-mutex
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 9:30 AM Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Allow sfpb-mutex to use mmio in addition to syscon.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/hwspinlock/qcom_hwspinlock.c | 32 ++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
> index 364710966665..23c913095bd0 100644
> --- a/drivers/hwspinlock/qcom_hwspinlock.c
> +++ b/drivers/hwspinlock/qcom_hwspinlock.c
> @@ -19,6 +19,11 @@
>  #define QCOM_MUTEX_APPS_PROC_ID        1
>  #define QCOM_MUTEX_NUM_LOCKS   32
>
> +struct qcom_hwspinlock_of_data {
> +       u32 offset;
> +       u32 stride;
> +};
> +
>  static int qcom_hwspinlock_trylock(struct hwspinlock *lock)
>  {
>         struct regmap_field *field = lock->priv;
> @@ -63,9 +68,20 @@ static const struct hwspinlock_ops qcom_hwspinlock_ops = {
>         .unlock         = qcom_hwspinlock_unlock,
>  };
>
> +static const struct qcom_hwspinlock_of_data of_sfpb_mutex = {
> +       .offset = 0x4,
> +       .stride = 0x4,
> +};
> +
> +/* All modern platform has offset 0 and stride of 4k */
> +static const struct qcom_hwspinlock_of_data of_tcsr_mutex = {
> +       .offset = 0,
> +       .stride = 0x1000,
> +};
> +
>  static const struct of_device_id qcom_hwspinlock_of_match[] = {
> -       { .compatible = "qcom,sfpb-mutex" },
> -       { .compatible = "qcom,tcsr-mutex" },
> +       { .compatible = "qcom,sfpb-mutex", .data = &of_sfpb_mutex },
> +       { .compatible = "qcom,tcsr-mutex", .data = &of_tcsr_mutex },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
> @@ -101,7 +117,7 @@ static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
>         return regmap;
>  }
>
> -static const struct regmap_config tcsr_mutex_config = {
> +static const struct regmap_config qcom_hwspinlock_mmio_config = {
>         .reg_bits               = 32,
>         .reg_stride             = 4,
>         .val_bits               = 32,
> @@ -112,18 +128,20 @@ static const struct regmap_config tcsr_mutex_config = {
>  static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
>                                                  u32 *offset, u32 *stride)
>  {
> +       const struct qcom_hwspinlock_of_data *data;
>         struct device *dev = &pdev->dev;
>         void __iomem *base;
>
> -       /* All modern platform has offset 0 and stride of 4k */
> -       *offset = 0;
> -       *stride = 0x1000;
> +       data = of_device_get_match_data(dev);

Nit: better to validate the return value though this is a rare case.

if (!data)
         return -ENODEV;

Otherwise LGTM.

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

-- 
Baolin Wang

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B875230B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiEKKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiEKKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:32:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309C68335
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:32:33 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so3126019ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diBqFc+BoWzAr/VmLH7dKrLdPRQvzkNUrCN5zzOorr4=;
        b=j7v8dV+of4JcYw6oQpjfYDg+/AhDGlh8rWDyVb4dNZFpWwCXA/ba7PSzuOc073fq5C
         CkbxcaE8TIYaP/pepZuL48hr/m1y4+28nijoEjmbwdqh6cKWZ9DJnWqZNJdkIV7JUYyK
         K+adh0jDs6KRrHOvq2jskXIux2qU/jq084T6hmNIBFHJD1Kdjv3EQgIogmZypxSboneH
         u24R/YdKD1LA+I5Zm3gwoh4EXivmzYiVlM1C6kwKzu3sEDV7G/8qbNQlrgM+GuoAmdEE
         TrmZCR0vnIxqBgF7fdIt1N9tzj894I735RdxUya0xlE6QJTIBqjtLCBvRhw/nG5KNTUv
         2ZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diBqFc+BoWzAr/VmLH7dKrLdPRQvzkNUrCN5zzOorr4=;
        b=yZavLABkBdn9iodIwjOm6Uzpr2g9tIM7DdkiyzEVdVEUh8tJ+ToAeWi1UVW4XT15lj
         bhDPlmhFwdK+q9yS5Th28atk+pP+wE+XEbxmcXlo6Q6li5/+NiRN0XDw75W2f15tZ+f2
         8OdkUKo5dpKoc9e3wc0a32glrPYDtW4qdDm3nMrYwottY5RrXhTxBvDQZ+RPtwzVeSos
         LC8FPH89PIlau7JOgClCMAjBXSfrEzeLc+o9faP052YH+HtzxtPoWmfAiFSdzW5Twe30
         MX7ZOm+DURpZxvxPSUVczD/WpVpETyd9TFdzsdLvvtu3I/Zst+TsXux5rpWeEoVM8ctD
         QsiA==
X-Gm-Message-State: AOAM532XWovvHmNteHSxShRt5stK0K4J/xYcfu9J2/tGDy9Tth455zIx
        ziynDhBz4HItOywKVzIU8O41HyuvmOajFIZnzlI=
X-Google-Smtp-Source: ABdhPJw6yj7TxbR0Hf9m7Lwxgm0Ky888mXXjlZZAf43y7eUMo7ah+68FM66Xr2uyLeand054/IqjszNELkdzUOz42E0=
X-Received: by 2002:a17:906:c14b:b0:6f8:e6bb:f8d5 with SMTP id
 dp11-20020a170906c14b00b006f8e6bbf8d5mr16921243ejc.4.1652265151596; Wed, 11
 May 2022 03:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220511065803.3957-1-linmq006@gmail.com>
In-Reply-To: <20220511065803.3957-1-linmq006@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 11 May 2022 07:32:19 -0300
Message-ID: <CAOMZO5AqKNg36_OBntqzpF6sYFitCMMJZP-KwFpYftJ76fdDsA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: Fix refcount leak in imx_sgtl5000_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Richard Zhao <richard.zhao@linaro.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 3:58 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_i2c_device_by_node() takes a reference,
> In error paths, we should call put_device() to drop
> the reference to aviod refount leak.

s/aviod refount/avoid refcount

> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

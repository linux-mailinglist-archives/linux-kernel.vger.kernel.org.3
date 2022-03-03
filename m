Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6E74CBBBB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbiCCKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 05:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiCCKxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 05:53:07 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481A117B8AA;
        Thu,  3 Mar 2022 02:52:21 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id y44so2007628uac.11;
        Thu, 03 Mar 2022 02:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jy/eLWfmHZk4p4Njv6BVmkKZB0XpsQJckLrKwVAajxo=;
        b=55T5txiZ/UyE7az+tHRha/fNAkATpyoxBdJmMK0VsYa3yUTafkQ5G3adhCybqyX6Ic
         laVc9k2PL82enFRU8RB8g2mtUHnJWNJJMUK6mFl883wpXT4mroYcnXEJZOk/t3ovMmjp
         0vuxbyXDIKfc2bOZZ66huee1kwG26LVWj9A27InqOVGtGC2gDoQ9uCXaPFLQByVP3ETw
         0eXGCuPQ1H/YmlTLHZ7HRAZA/HQ6J2yHS5iBtQkq6SFrYa+ESOyievlssaUPmGhjjxEY
         6BlZgjoy1QvOb/zred8jZf4/U5DTAXMLDpUuTiIvjYtxY5wUsIGDB0vul1GTZtBd/Bkn
         M9RA==
X-Gm-Message-State: AOAM533XoLj9NNYTFX5yfOv4s4pIEht5R6vRnM8r3E/5txih3m9S+9fs
        nsAq+0zocEaKvPEBXjcZIZkDCVniyKTX1g==
X-Google-Smtp-Source: ABdhPJyzSUsCIT4ySRKwEi5H8KMecSV7EdJspiJYoctwCtJkubJAYMsYIAMkDVLonfGlVF0f5QtxgQ==
X-Received: by 2002:a9f:24d6:0:b0:348:d872:5917 with SMTP id 80-20020a9f24d6000000b00348d8725917mr4847247uar.118.1646304740321;
        Thu, 03 Mar 2022 02:52:20 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id d13-20020ab0378d000000b00342bf7d383dsm290250uav.11.2022.03.03.02.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 02:52:20 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id q9so5053751vsg.2;
        Thu, 03 Mar 2022 02:52:19 -0800 (PST)
X-Received: by 2002:a67:c499:0:b0:320:2cd8:9e1a with SMTP id
 d25-20020a67c499000000b003202cd89e1amr2476378vsk.38.1646304739297; Thu, 03
 Mar 2022 02:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20220228172528.3489-1-srinivas.kandagatla@linaro.org> <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20220228172528.3489-2-srinivas.kandagatla@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Mar 2022 11:52:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUYWs=PYLJhg54wDEcTzxMtkPn2dvL7_AdqxRVJn_JUGA@mail.gmail.com>
Message-ID: <CAMuHMdUYWs=PYLJhg54wDEcTzxMtkPn2dvL7_AdqxRVJn_JUGA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] soundwire: qcom: add runtime pm support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Vinod <vkoul@kernel.org>,
        yung-chuan.liao@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        quic_srivasam@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, Feb 28, 2022 at 7:13 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> Add support to runtime PM using SoundWire clock stop Mode0 on supported
> controller instances and soft reset on instances that do not support
> clock stop.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for your patch, which is now commit 74e79da9fd46a597
("soundwire: qcom: add runtime pm support") in next-20220303.

> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c

> @@ -1345,6 +1399,105 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *swrm)
> +{

[...]

> +}
> +
> +static int __maybe_unused swrm_runtime_suspend(struct device *dev)

This is causing build failures if CONFIG_PM=n:

drivers/soundwire/qcom.c:1460:12: error: 'swrm_runtime_resume' defined
but not used [-Werror=unused-function]

http://kisskb.ellerman.id.au/kisskb/buildresult/14704362/

> +{

[...]

> +}
> +
> +static const struct dev_pm_ops swrm_dev_pm_ops = {
> +       SET_RUNTIME_PM_OPS(swrm_runtime_suspend, swrm_runtime_resume, NULL)
> +};
> +
>  static const struct of_device_id qcom_swrm_of_match[] = {
>         { .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>         { .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4534754F7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 14:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382420AbiFQM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382459AbiFQM6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 08:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9272B1B5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD18F61FD0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B42BC341C5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 12:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655470714;
        bh=aJe/IuNfbjZ9EniMI2KMI/OYNV3Ky7QaQrPqbpHqWEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YceFDQKz6Qp3semAVSe6go/03+fq5w2gdDcUhzRXBfGfw6Ck0mm2h1bKcOkDCqSE1
         LXx0To+qfIBp/c1sr/dS4FDhi/Bc2BNaQZ8kgH/SmwPzsepWIwsuWH3z2AYqlVIi5W
         /wrAEbkctqOvhA3FUpQ8+2dC1DpLULN/r+3b+uSJXvJXAkyQI2j5SRwyqlg6iDW6VV
         wBzGl0XmWM4AWBd0zSb68+xsRmah96Oh0e79gl+48h6rG3GWm3OxeqoLmYNboook0C
         g4eFIahW5BQQoVgtZtpKZW2dk0p7iAlXYmmbDrGZ8gT0D64qumRJZlBahLyw/m7zjR
         n3v6InWaJwKug==
Received: by mail-lj1-f172.google.com with SMTP id s10so4632445ljh.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 05:58:34 -0700 (PDT)
X-Gm-Message-State: AJIora8+Kxr24g8jWwl7pQCfg/bbY/zsXCpfNcdxFLqxB6wk8hHqOm3E
        aOaycM8JILULhDVxT3vLg44fUTM7+6nouTyQ1+Q9JQ==
X-Google-Smtp-Source: AGRyM1uqosFaBOhZZC5A81VpQaFlEvVkSB4BPtOu6MTbFLXMRKLMCZXs1CEtapjf6SQr5wJTaVMHzlCzz1PP2y5pmko=
X-Received: by 2002:a2e:8609:0:b0:255:6eb1:46a0 with SMTP id
 a9-20020a2e8609000000b002556eb146a0mr4963421lji.336.1655470712245; Fri, 17
 Jun 2022 05:58:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220616202537.303655-1-daniel.lezcano@linaro.org>
In-Reply-To: <20220616202537.303655-1-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Fri, 17 Jun 2022 18:28:21 +0530
X-Gmail-Original-Message-ID: <CAHLCerNcat-uvXYA4jHK9_wQR1HFYXisXD2Pj+TuGWcgM0u=-g@mail.gmail.com>
Message-ID: <CAHLCerNcat-uvXYA4jHK9_wQR1HFYXisXD2Pj+TuGWcgM0u=-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] thermal/drivers/qcom: Remove get_trend function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:QUALCOMM TSENS THERMAL DRIVER" 
        <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 1:56 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> There is a get_trend function which is a wrapper to call a private
> get_trend function. However, this private get_trend function is not
> assigned anywhere.
>
> Remove this dead code.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/qcom/tsens.c | 12 ------------
>  drivers/thermal/qcom/tsens.h |  2 --
>  2 files changed, 14 deletions(-)
>
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index 7963ee33bf75..e49f58e83513 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -933,17 +933,6 @@ static int tsens_get_temp(void *data, int *temp)
>         return priv->ops->get_temp(s, temp);
>  }
>
> -static int tsens_get_trend(void *data, int trip, enum thermal_trend *trend)
> -{
> -       struct tsens_sensor *s = data;
> -       struct tsens_priv *priv = s->priv;
> -
> -       if (priv->ops->get_trend)
> -               return priv->ops->get_trend(s, trend);
> -
> -       return -ENOTSUPP;
> -}
> -
>  static int  __maybe_unused tsens_suspend(struct device *dev)
>  {
>         struct tsens_priv *priv = dev_get_drvdata(dev);
> @@ -1004,7 +993,6 @@ MODULE_DEVICE_TABLE(of, tsens_table);
>
>  static const struct thermal_zone_of_device_ops tsens_of_ops = {
>         .get_temp = tsens_get_temp,
> -       .get_trend = tsens_get_trend,
>         .set_trips = tsens_set_trips,
>  };
>
> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> index 1471a2c00f15..ba05c8233356 100644
> --- a/drivers/thermal/qcom/tsens.h
> +++ b/drivers/thermal/qcom/tsens.h
> @@ -65,7 +65,6 @@ struct tsens_sensor {
>   * @disable: Function to disable the tsens device
>   * @suspend: Function to suspend the tsens device
>   * @resume: Function to resume the tsens device
> - * @get_trend: Function to get the thermal/temp trend
>   */
>  struct tsens_ops {
>         /* mandatory callbacks */
> @@ -77,7 +76,6 @@ struct tsens_ops {
>         void (*disable)(struct tsens_priv *priv);
>         int (*suspend)(struct tsens_priv *priv);
>         int (*resume)(struct tsens_priv *priv);
> -       int (*get_trend)(struct tsens_sensor *s, enum thermal_trend *trend);
>  };
>
>  #define REG_FIELD_FOR_EACH_SENSOR11(_name, _offset, _startbit, _stopbit) \
> --
> 2.25.1
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC995B27BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiIHUct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 16:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiIHUcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 16:32:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C1F02AD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 13:32:45 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t14so20869277wrx.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vaR+PRR/c8VGDxG3pWSaeOmzf/CHklELeimE/+fWPMY=;
        b=lCAHHHtGrq9cNEZkhFfMbtPxHscDK7s0S4yHqSiFF3nde/Kclq1HENHQQhVHeUt9Yj
         D/9+fdKfsyfKL3ZSZntsRfDnls3ySehyrEFIyUYVB5xt7JACTP/dkpVza+mmKUvv2FKq
         oPDBxtsu1GQFlk0Rt+PqICrAQ1shTZq0nXN24wPlw6Aum6LGRiGShk3pLvhytTx2Y1fz
         UXLNaDng7ZEiYEUBVwbARxTMEvShiKmkHJ0DjHqynta2OncqVGAGUomZZYvL2B4KxOS0
         5JC1hJkVwLq/cwbHpzgru3X55StUYRb9OEezfeaoevF5Ba8NAaF7CiEn9cppS4+T/Na/
         KuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vaR+PRR/c8VGDxG3pWSaeOmzf/CHklELeimE/+fWPMY=;
        b=63ZSCyRSHxx1h6dPXHjWeRmLShGjYNAzFwxRIcPhe8n7FBSecq/3Ddlz1OXrRgD7iG
         8mdwqoEUuTtjDqCIdoLI5niS8D3/u7raLWGsF8VcFFi38GwDf6oWBIuv4kO80HgWjEKy
         Qiz4To6CuvZX4XOZoEMk7tHkpk6PiVg1yvR4PDLCfee/Z28mmxs6KQNUIzGzmLpFswGM
         0XrpiwTjuOZzPNslceCVmXl3MJdm25FmdSTEHcoFkejbI1vPxQQPLgl/7uebc1n9GxwW
         WesUn8vLjrmoXeZusKSLIVZdNfH6rl8USgLVdsYYA+eNYGmn2zYL0PTBB9kYCw+HQObO
         UZOg==
X-Gm-Message-State: ACgBeo1ypZhU4sktJ98fM+dEWp8ZusiLbcow9x5Su9R/CAWkWtJMwwSl
        TC8XShaE2gGZ2kL4JQQ+Ot2cb5P44m39fE3DowTi3e5Ccrs=
X-Google-Smtp-Source: AA6agR7lafh5iFDYSngDCJLO1yWQBBaEIcCgTmgJJZt1Q4q1I7mTv9rD219dWAKV0aSj6u6/8XmjvrSPmjTKI+DJsZU=
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id
 y14-20020a056000168e00b0022087dac3e4mr6000203wrd.559.1662669163591; Thu, 08
 Sep 2022 13:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <1662519715-21891-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1662519715-21891-1-git-send-email-shengjiu.wang@nxp.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Thu, 8 Sep 2022 13:32:32 -0700
Message-ID: <CAGoOwPSCQF9WC=jhV79wnqDQ-puL+=yuF1u1oEpomZU9FRzBbA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_asrc: Add initialization finishing check in
 runtime resume
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 8:20 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> If the initialization is not finished, then filling input data to
> the FIFO may fail. So it is better to add initialization finishing
> check in the runtime resume for suspend & resume case.
>
> And consider the case of three instances working in parallel,
> increase the retry times to 50 for more initialization time.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Some nitpicks inline.

Otherwise,
Reviewed-by: Nicolin Chen <nicolinc@gmail.com>

> @@ -20,6 +20,7 @@
>
>  #define IDEAL_RATIO_DECIMAL_DEPTH 26
>  #define DIVIDER_NUM  64
> +#define INIT_TRY_NUM 50

s/TRY/RETRY

> @@ -592,6 +593,10 @@ static void fsl_asrc_start_pair(struct fsl_asrc_pair *pair)
>                 reg &= ASRCFG_INIRQi_MASK(index);
>         } while (!reg && --retry);
>
> +       /* NOTE: Doesn't treat initialization timeout as error */

s/as error/as an error

> +       if (!retry)
> +               dev_warn(&asrc->pdev->dev, "initialization isn't finished\n");

Could print which pair; or perhaps pair_warn?

> @@ -1295,6 +1301,20 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>         regmap_update_bits(asrc->regmap, REG_ASRCTR,
>                            ASRCTR_ASRCEi_ALL_MASK, asrctr);
>
> +       /* Wait for status of initialization for every enabled pairs */

s/every/all

> +       do {
> +               udelay(5);
> +               regmap_read(asrc->regmap, REG_ASRCFG, &reg);
> +               reg = (reg >> ASRCFG_INIRQi_SHIFT(0)) & 0x7;
> +       } while ((reg != ((asrctr >> ASRCTR_ASRCEi_SHIFT(0)) & 0x7)) && --retry);
> +
> +       /*
> +        * NOTE: Doesn't treat initialization timeout as error

s/as error/as an error/

> +        * Some of pair maybe success, then still can continue.

+        * Some of the pairs may succeed, then still can continue.

> +        */
> +       if (!retry)
> +               dev_warn(dev, "initialization isn't finished\n");

Could print which pair.

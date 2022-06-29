Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF755609BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiF2SuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiF2SuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:50:07 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B201A812;
        Wed, 29 Jun 2022 11:50:05 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-3137316bb69so156965347b3.10;
        Wed, 29 Jun 2022 11:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VRwlWNsQktWMF2euNfXj/Eod6yNt2K46g0nDE9s0cO4=;
        b=F0FHECUSidSLS7vkHSbqvQjatFtFvo5g3dnD7dt/5rCTuhMn3wwhrQmB3AhY1xzV/Q
         N7CFCqNng3BEH42OGj8iUITuPd10V7Pimvn3aHHDPg8dPVweYGjaraa60c/B+CKjN4QP
         ClIODpX7RtWA8DGTqUPYcF2tsNM4RRBIf6Drwl6fZPkSAeLLlBHK12GHnpojbxz1ZSQi
         YKvQsQKoWw7J/k/Q8GNNOPEvgCyqM8kABwPbVZ1mged/NGx+HQeP0FJ28jvNeHd+wjvY
         IK/4udVIhJSr6hbuVqHUuPF/kOIj1H5sh59H5OdmmJ8vhgsAEg2zvR5ydYZTQs3t5LP9
         LzJA==
X-Gm-Message-State: AJIora887a0am4kZSTKWEhYUhnhfX0tcnrvxS7AV3gDeW4WollhBJwlF
        hiF7v3UlHyT/81gGz13rtYCbbJz1f/CLHD4HURa1sJF1VNc=
X-Google-Smtp-Source: AGRyM1vSND3nNpOCua9TxqWuka1+y023DNDu4pE9BPRV4wqxRK++krN2w1YqvdMGs4vdlNHUTDIm+wBvCFiFzI7pxlU=
X-Received: by 2002:a81:24c7:0:b0:314:1e60:a885 with SMTP id
 k190-20020a8124c7000000b003141e60a885mr5681810ywk.301.1656528604330; Wed, 29
 Jun 2022 11:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220628104411.984551-1-sbinding@opensource.cirrus.com> <20220628104411.984551-3-sbinding@opensource.cirrus.com>
In-Reply-To: <20220628104411.984551-3-sbinding@opensource.cirrus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Jun 2022 20:49:53 +0200
Message-ID: <CAJZ5v0g8S3D6sc0tF2vTO6unLE_Qf1bgjLyk9Fkk0fP4h6ZcNw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: cs35l41: Read System Name from ACPI _SUB to
 identify firmware
To:     Stefan Binding <sbinding@opensource.cirrus.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:44 PM Stefan Binding
<sbinding@opensource.cirrus.com> wrote:
>
> When loading firmware, wm_adsp uses a number of parameters to
> determine the path of the firmware and tuning files to load.
> One of these parameters is system_name.
> Add support in cs35l41 to read this system name from the ACPI
> _SUB ID in order to uniquely identify the firmware and tuning
> mapped to a particular system.
>
> Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> ---
>  sound/soc/codecs/cs35l41.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
> index 8766e19d85f1..9ab016094b32 100644
> --- a/sound/soc/codecs/cs35l41.c
> +++ b/sound/soc/codecs/cs35l41.c
> @@ -6,6 +6,7 @@
>  //
>  // Author: David Rhodes <david.rhodes@cirrus.com>
>
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -1142,6 +1143,24 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
>         return ret;
>  }
>
> +static int cs35l41_probe_acpi(struct cs35l41_private *cs35l41)

I'd call this cs35l41_acpi_get_name(), because that's what it does.

> +{
> +       acpi_handle handle = ACPI_HANDLE(cs35l41->dev);
> +       const char *sub;
> +
> +       /* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
> +       if (!handle)
> +               return 0;
> +
> +       sub = acpi_get_subsystem_id(handle);
> +       if (IS_ERR(sub))
> +               return PTR_ERR(sub);
> +
> +       cs35l41->dsp.system_name = sub;
> +       dev_dbg(cs35l41->dev, "Susystem ID: %s\n", cs35l41->dsp.system_name);
> +       return 0;
> +}
> +
>  int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *hw_cfg)
>  {
>         u32 regid, reg_revid, i, mtl_revid, int_status, chipid_match;
> @@ -1270,6 +1289,10 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
>                 goto err;
>         }
>
> +       ret = cs35l41_probe_acpi(cs35l41);
> +       if (ret < 0)
> +               goto err;
> +
>         ret = cs35l41_dsp_init(cs35l41);
>         if (ret < 0)
>                 goto err;
> @@ -1316,6 +1339,7 @@ void cs35l41_remove(struct cs35l41_private *cs35l41)
>         pm_runtime_disable(cs35l41->dev);
>
>         regmap_write(cs35l41->regmap, CS35L41_IRQ1_MASK1, 0xFFFFFFFF);
> +       kfree(cs35l41->dsp.system_name);
>         wm_adsp2_remove(&cs35l41->dsp);
>         cs35l41_safe_reset(cs35l41->regmap, cs35l41->hw_cfg.bst_type);
>
> --

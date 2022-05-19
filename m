Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE552D3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbiESNXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiESNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:23:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFC7A835
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:23:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ch13so9870247ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0w8abIetG2abMfdqOSd7Y82vyjnsYTVbT2dM/SJUnQ=;
        b=kqyqe4kqxe8fIM4wT/Lk+TKu3gZPfVVJL7C4awAbF1WarDBgMnhX/jTNZMl/vxTt85
         O+Z6wBabc4+ZNCx8n0IHE9REoVXdCMvPJlFCnZZYhFj1hzZxP+8mcqFOUhlVZbDAzPre
         Kc/q7pYmg1xfxtbb3BFBaHJS52S/wJHPIZsXAseZ8vOuQdzGf7Q8TolTfts249OnHSX2
         Zvvj5lEJ4vqVz5G0WslC0SbW4MlQrCVSSX7e6+KrAampo/iIcwlgZWo1YulA6XmleJ2q
         lrwd2wIj2hyi5kx1AWJ3qxAkGhNfEyLpl2qlX5PGPoPvv92sBJrzSyZNuz9JxC/w48oG
         d3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0w8abIetG2abMfdqOSd7Y82vyjnsYTVbT2dM/SJUnQ=;
        b=G1c5LmAYiF3DmPFr4IPPlsEwucUrwb6WX4iCrIvjrN1kBdl6oZZiogjvhcffwnl6jR
         8cHrLo0v5CJxjZ3Vm9phn0nVZ+ql36awu5/ebnwPS2DdjS5SA8k1U5QgL9Ry+rCgM0kY
         /WpJwhSXPAbV+lRVEVMBOMgqUa5Gh58vSabM/wzvSvNcHq1ebk1zfsZj2N93v2scMgsk
         5zr5y3BpaQu+M3GxR9LcmAlhBsN/gfFJ/cuBgIKkUvMn7sVBKfzWB6qcNMaK/mUZi2I4
         G4AOFwpKUdnLdEaGpwffTzjFOEZI9j1oAxceSeXDLPtzUcw4fzTNYxO9/0nkn0ceJAtU
         +gjA==
X-Gm-Message-State: AOAM533xAd1hukFErm0gv/B3wMf1qAaySDkJfa0bpxCrjNgAzw6kGAOu
        Rn6Y8y8tqt/h+ONfUYoQJMZQf3ahS17w8HIjIw4=
X-Google-Smtp-Source: ABdhPJxNRiGcRFJtK3UBMZH041EXrP1arR0vXHoGPqJhbNCeJrxP1aggikIpmh71PFSM0Xke5vQam54J3vaSYyrXjBg=
X-Received: by 2002:a17:907:7b9f:b0:6f4:d8c5:392c with SMTP id
 ne31-20020a1709077b9f00b006f4d8c5392cmr4265502ejc.652.1652966594102; Thu, 19
 May 2022 06:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1652963808-14515-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 May 2022 10:23:06 -0300
Message-ID: <CAOMZO5DtpoH0dLDX3=Sv4UUpX_=66VEZPsJUWQNnYviApfMLKQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable MCTL_MCLK_EN bit for master mode
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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

Hi Shengjiu,

On Thu, May 19, 2022 at 9:49 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index fa950dde5310..dae16a14f177 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -437,6 +437,12 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
>                                    FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
>                                    savediv / 2 - 1);
>
> +       if (sai->soc_data->max_register >= FSL_SAI_MCTL) {

Isn't it a bit fragile to take this decision based on the number of
SAI registers in the SoC?

What about adding a specific field in soc_data for such a purpose?

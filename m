Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0282F4D401B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbiCJEEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCJEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:04:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12FD710F6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 20:03:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b24so5361232edu.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 20:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GrKdFSYsZlVt8uhCN2U6sNHmV3u4KOt5mcwLajvsZOw=;
        b=ONrKwNauEyspuXAuyaYf+2s7frYnXQgKz3I3C/XTvDB8gnwd6/YlZl1iyEk5kZ2T9s
         CflKU1uQ3xl/8qFQRFY21+vq6dhEYhcFsbFQSMmoStDu0ZoDIcmz4pWksO1uCcP5vX2b
         UlrJuWB0okTvlUvCk92Sb8C9A4PlLlPLdBTVRDRdynYexSvalJOaM+uiDgfbbfn9mGph
         UkcupGs9lFCOqR+O5d7tp2IeOcyUUwZRS4C98tiYq3YE9X4Lgervcc4mnfH+/FM/xFnU
         IxfufytJXbxJI+AxXNgaE37NoMNafJs1zKfW9mF15vroPEb2zGDpC8giAcxDjTKstxsn
         HEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GrKdFSYsZlVt8uhCN2U6sNHmV3u4KOt5mcwLajvsZOw=;
        b=T64ac2HFtDaXKeTQz8IVmV/ENQ2816nAnOOdthIxFuFBZSTiRbPWkykMfHBqfqa/O9
         g9jueQQp1ZDnZk1Dt/BPNFFBSQMOJGc6NKiO6d1R1DdF328FkGMm5jie64qwVtqjIir2
         RhN8fK8gphcpDliufZM2jddr0W4xTQRSsUHVea7gX6lq7CnNfWJJyg7ukrNd0lxQi1fk
         ZunIxY4PS9KAzroWfMkK2RPrVdQcv4uSaKAmua4l6OpIPd4E/taWqFf6t5ZYYR7gCFGs
         NiFjuYQeIyYJhKhHKRyDOhuf34vxE7Acaxdcf2PpKLaSF1uHxK2Dp2mHqIyIu1Kei699
         /ifg==
X-Gm-Message-State: AOAM533faput2FvuXi2YavBQhsvNcGsU0ryUwDPSQM5v4H5CUTzXlqVB
        JrC6ZvOpj/feNEHKXhtn99k56fgESxnA5YahN1g=
X-Google-Smtp-Source: ABdhPJwkgjgmWZTe/uzCw13LmTJ+AMMbnaHvJVc7YxhfBh+pWiN0kj2TdHmcSbojsH78j+QzOvhAaEGenMZA45d4jKA=
X-Received: by 2002:a50:9d0f:0:b0:416:95a3:1611 with SMTP id
 v15-20020a509d0f000000b0041695a31611mr2430187ede.77.1646884986448; Wed, 09
 Mar 2022 20:03:06 -0800 (PST)
MIME-Version: 1.0
References: <1646879863-27711-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1646879863-27711-1-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 10 Mar 2022 01:02:54 -0300
Message-ID: <CAOMZO5DCm8TzajeLCECxpdsoKBMOzr2MgmoYbUSN7SDYRhPL4A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Disable TX clock when stop
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

On Wed, Mar 9, 2022 at 11:46 PM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The TX clock source may be changed in next case, need to
> disable it when stop, otherwise the TX may not work after
> changing the clock source, error log is:
>
> aplay: pcm_write:2058: write error: Input/output error
>
> Fixes: a2388a498ad2 ("ASoC: fsl: Add S/PDIF CPU DAI driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

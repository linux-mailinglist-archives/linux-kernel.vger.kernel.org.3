Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07076586FBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbiHARro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiHARrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:47:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7BF2A435
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 10:47:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so5936064wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8Jns36cM/Xdll3zQTDOynsDPWveorbrG1VHyx9CdQR0=;
        b=G4tRILzARpm1bpxvqlIvwyPp6Q3sPOp30LU8KfkTmEbQvU/HzJTfAutPmk7ojeUJl+
         IxmsFl1cOf3f9TEB0LvOEu2hnx1emE0t0Ty2+rUvwm4Stt0nmWIq/agtWwIuzyuRiZYs
         1Zy+AoDvCDe04ITvIkdsGsfBs4PQD7vQ8KRQ4vRbB1I1orGiMsmjn+OnOPlN9DXTGYDA
         TpgEPTvOgtWzpQNn8tqYXJ/pgyB0fg8VejaGxPE6PavIgCU6YQyVBnqEita9wAmkwKFJ
         hVkeHxggcnWcygVPyUBVq4QG88GP9BZGQFukG4EEtA15a9wFdZ1XZ/H9ejkRUXCDgFuJ
         5Yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8Jns36cM/Xdll3zQTDOynsDPWveorbrG1VHyx9CdQR0=;
        b=b5jaAzFjSWalGL+p2/SHeigypzj9pbnhkIQpp1VFkZHf9ers+LZdlBdIATfJDRQpDa
         2ckgNQKq1odmuA2M3hmrGRcii9VJF2BURueps/qv1AhamcNJIhSglo7O9q+H5h/oakCj
         jm4V72Lns8sYmHqi/1JYXYqbC3V746J4mtH4M4ozChSxYqHMMM/k0q36wUEu7e50o1f2
         gBkVG5Imbuloav4v/QvWCWcwHs7B19J60+Ypj87pv3vT0d+cfOW0JgOxjdK0hEKOEjBj
         IIcqQrxwg7r5WjWFwTd44gDenxQCEI7TxgKDyaps/g8AWrByNlwUvHhKNTwMzcc1gmec
         xe+w==
X-Gm-Message-State: AJIora//GxGjE+vDfC+7w3arUfshhN9lnWGe6gnae1ufL42OtpKhv3dx
        IlK1F03QHaSAonZHv4n1WHwizPjmqAfVyHfOmeA=
X-Google-Smtp-Source: AGRyM1vXZlt10Nll2wkPPyLa+hlsyZx/+f3pCIFG+RLb7StXHim8J1UtQjk4yZr5Nc72B/VPuT0OJCtzNR7gmh4BNG0=
X-Received: by 2002:a05:600c:4f06:b0:3a3:2158:c5ed with SMTP id
 l6-20020a05600c4f0600b003a32158c5edmr11852463wmq.103.1659376059939; Mon, 01
 Aug 2022 10:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <1659356773-8315-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1659356773-8315-1-git-send-email-shengjiu.wang@nxp.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Mon, 1 Aug 2022 10:47:28 -0700
Message-ID: <CAGoOwPSy77PuBvA0BghsFrNgpXfO+JuFgTW5VTNOfMEQdnbrVA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: imx-rpmsg: Support configure sysclk for codec dai
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 5:42 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

>  struct imx_rpmsg {
>         struct snd_soc_dai_link dai;
>         struct snd_soc_card card;
> +       unsigned int sysclk;

unsigned long?

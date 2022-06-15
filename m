Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24AE54CB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiFOOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiFOOWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:22:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C7A19032;
        Wed, 15 Jun 2022 07:22:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v1so23505165ejg.13;
        Wed, 15 Jun 2022 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cDSM19XhnVItQmXe2GXVbX8IiIZwrvghbIjLeWagA4=;
        b=T/uAnd4NRj5HaHVJL/NGW4xzIHjJ88SjHm1ylY4aca+8D6wfooiNh1pXFcmjxgVI5z
         oxoPES4Ga1RtHrg8cGHFuHkSH2f+OhwSwGTCIdhsCCYLUsxNmdilDkXJBny9cRAXwPZM
         bj8r9HZgGjAb5+5ooOWAC5V7AY+rgW6aZYN3JDn47Ts9R2AcZjZ3lDBwe9qmz0FuX73b
         Jfcp3Lz9OOReArTRl64Lor4pK9Gl2b8EG10faardk619owy9Pnf2EMV3tb3R3xjJeKiM
         R/q+Fh8c24KmtesrDZVl0JNopM0eMSrF15SULsMSyCvI4x6xfOthaOBHNdHq8n4QMJq9
         RjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cDSM19XhnVItQmXe2GXVbX8IiIZwrvghbIjLeWagA4=;
        b=iR9HA6qDl5ORUUI5komj3rPxPDhC2uDdggll+bqqT3fIJ//PwTVqG9L4w785s86W62
         GvWoBG4Ut8pfatPbVkwx0oXNSTgcMuM/WC8mnXXekoq1D2nQACHbQgnpNpy8xRTf0DvS
         B7KSjrNRRLRD2mPd6LL3gjqo+DBpfwwnPyiYR6KAuDmbyyZysnOHWywP4S0l3LmKu7M0
         tMPrixn/0Bpy989+s8WBiyr1H3ip/phKqx17DkkPt8ZiLU1Oz9jBVdeKcC7WTIZmt1Mz
         IGmU6V7Ag1P94L8DO9FEM37Nt1ofeLINWyTvF/FYw/iTnfJ0Y1gaZXY0f2pRjCkjdr8M
         eqvQ==
X-Gm-Message-State: AJIora+vjnWdyEw2stzALAror+DUUFiV6Y6HqSGWOCjFAHeN8NrPZQwc
        W/bHwPmKYkdH5wy8qoSbIDdAbkK9FOO60dU+kCA=
X-Google-Smtp-Source: AGRyM1tK+gakBdNkEl/BCl5Wp6p+/qyTwlR5zO3bm+xtxartwOdF0AEvujrW1NR3rivDizKoWarT6AlmcqwpahefijQ=
X-Received: by 2002:a17:907:2d8d:b0:711:d1bd:d738 with SMTP id
 gt13-20020a1709072d8d00b00711d1bdd738mr70128ejc.658.1655302966907; Wed, 15
 Jun 2022 07:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com> <1655179884-12278-6-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1655179884-12278-6-git-send-email-shengjiu.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 15 Jun 2022 11:22:38 -0300
Message-ID: <CAOMZO5BRVBawK2PRvTazkQf-wExOuni9qD76Ha3FYmZZQyPRsg@mail.gmail.com>
Subject: Re: [PATCH 5/7] ASoC: fsl_sai: Move res variable to be global
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
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

On Tue, Jun 14, 2022 at 1:25 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> The resource info need to be accessed by hw_params()
> function for multi fifo case, the start address may
> be not the FIFO0. So move it to be global first.

Actually, it is not global. It is being added as a member of struct fsl_sai.

Please rephrase the Subject to:

ASoC: fsl_sai: Make res a member of struct fsl_sai

and then in the commit log:

"So move it to be a member of struct fsl_sai."

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388554D9B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 13:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348159AbiCOMYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 08:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240193AbiCOMYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:24:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7224763A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g17so32661126lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sb104aj3tjLKyTTZ17U/Klg2aBSSJ2T/5c6D895wNBw=;
        b=EKPJ4DTBgq1DS2BRevHWl8q2iA30+g+EpaPb32GmUpkfz6F9SIgFvoxLwtDVSmVnc9
         o4QCgNSFdCUehk+XZ06HqikO+9nVCx2GZ0p5otm+Zz/Jn1JCrgp9c4Oj8pASpU4tszeq
         U6bgOy/C/rTInOq21QMcQzfEkFSDw0PCOMXqmV1oNJEl2DNtoC9oVyIKO+mjsQBBcEbV
         mroOVOpOGvmGmenjIO233FBscoMB8PD9OTym9PsGjI3oGy7JrzoaEK6U3+bCt59XbHiv
         +QWeP8yTegN+YXO+E0WXIVXCXySLaiURu2jpPLeTmAAOXrHveXhYA1nYE9wDqcDypBRO
         rhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sb104aj3tjLKyTTZ17U/Klg2aBSSJ2T/5c6D895wNBw=;
        b=vZnx401SdIodvnYuemDdW7NAWzEbn4MfJg0iX7sJwz0vQ2QIYhIUC877JOCREbslp3
         PLDsanwSbHmTh1hthjdlzndEKQd83TAabyiYS/ndikz6WK/97nDi5kSiQxOGfy9sj9Xl
         hcfEn9OGYJZERibQB3NJth7aQ29mjWkJpwsYDT6kX9n+gqBDXE1LWbwSd2YatMJoKE7J
         QlQNMBG5rTjXnfREo8KEgqj95LzG19APXJ/HAQAzXwdD2w3idisZRs0Fp9r6Ac8GAUI7
         mzreC7x71RbjwCjeJciJF8m55gGzgnCimPwhyDC4WPBBP2ozrdrgZNGEokjfqHlon6bS
         lifg==
X-Gm-Message-State: AOAM532x+4ZsQS/TEbXqrJxcQRxAPDyItBKfFXVq17V5VyDd250BDcBc
        hKOrfEr9QECcWCLRxT6FhhHgzvvIPPfAoaJsOYE0GA==
X-Google-Smtp-Source: ABdhPJwSjQ5oQZjfEtoR4Ve6sp8VlABql5PGdoO9Q/flDYRac285+1HDvAlszXmV6KA6EFPeME165019ThdE01YY4Ts=
X-Received: by 2002:a05:6512:3b07:b0:448:27ab:4a0f with SMTP id
 f7-20020a0565123b0700b0044827ab4a0fmr16658811lfv.373.1647346998734; Tue, 15
 Mar 2022 05:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220303164522.129583-1-ulf.hansson@linaro.org>
 <CAPDyKFod3LdfRRgVfdASqgSBAXqJnGkdKMM9qKnAYcfUQptF_g@mail.gmail.com> <ece53010-b7ed-6b12-1baa-08505537854d@gmail.com>
In-Reply-To: <ece53010-b7ed-6b12-1baa-08505537854d@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:42 +0100
Message-ID: <CAPDyKFosSVMOXtin149h=YaLeMEUq3Q0-xwYcg0ZgcfWRbawvA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Improve fallback to speed modes if eMMC HS200 fails
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 at 23:02, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 14.03.2022 11:54, Ulf Hansson wrote:
> > On Thu, 3 Mar 2022 at 17:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> In the error path of mmc_select_hs200() we are trying our best to restore
> >> the card/host into a valid state. This makes sense, especially if we
> >> encounter a simple switch error (-EBADMSG). However, rather than then
> >> continue with using the legacy speed mode, let's try the other better speed
> >> modes first. Additionally, let's update the card->mmc_avail_type to avoid
> >> us from trying a broken HS200 mode again.
> >>
> >> In an Amlogic S905W based TV box where the switch to HS200 mode fails for
> >> the eMMC, this allows us to use the eMMC in DDR mode in favor of the legacy
> >> mode, which greatly improves the performance.
> >>
> >> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Heiner, does this solve your problems? Can you perhaps run some tests
> > at your side to see how it works for you?
> >
>
> Tested-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks! Patch applied for next.

[...]

Kind regards
Uffe

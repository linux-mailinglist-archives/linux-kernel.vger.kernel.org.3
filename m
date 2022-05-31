Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C09539375
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiEaO7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiEaO7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:59:47 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF714163D
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:59:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r65so12651547oia.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZN3XYzcycmCsCacW8bmcW60HDp42L0uYVb/ImOyReg=;
        b=U9o+bkG40WUIYZVcc3zU5Nu4eZQvbsOJRf+82NIcI2eurDzXRrKyuzSHPWFSE4Mr36
         WCvUfuhvTUqLPsCltkReJ669CNI1o1QfvwYmBEMV3V5gyK1Gdvxsx0St+2aoUo74OTjI
         hnFdNuKAQkLMWxSOhs8RhZzJ/WOrVKrlAg6KUO9aPU4qz0+TyP30q67InhxFfXM+Qd4P
         ogaubtZ2Z5LTeoHxfPD9MZTY0qb+tpIznbF05H98I9vbY7pkvjV/BQix6LGB7HCSA5Tn
         ZESAfrT5A9rXh7F3qGizPFwe1y3JwWdc6M84EW//F36gvi4DKFKBksfHaCX/bEl027Rp
         nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZN3XYzcycmCsCacW8bmcW60HDp42L0uYVb/ImOyReg=;
        b=oIS05/d5f4a8TzbDhqZ/cbQDMvWJ1dzuX7XIWBsqPbVtydlBs5mfCfZxJlwj5SjHql
         u3JcRoPqTJo2m9/pw3sLPfZhpmuMuwNWKLYjdsJX3QFUdWM4e4hDbTTzWhFRGuby8HQt
         pkFkmIzxLF5NOJ/C8WO8j8VsGMtAsr+/68+RFwTuLY66wFecTtDm/3sPsJwpxWipzsZY
         FhNTdM9ypSP5UbjqpYHNWtphiHi2diRZC1DezfwCKexzcKapqS2mIVQ5aFGGYAMNKBuD
         XvNc1uOcB8hnmNYELcKIZ94rp9sakYmbd2Lkg3fdCHVkyUjoR/5n3RyDK+rktzp3TVhR
         ZIPw==
X-Gm-Message-State: AOAM530Ix29WpLoBrSByeci9p0JaDFnZu6D6cyNalDTr8tSxrRzwWkHO
        LRhivRYQHWykc/Ubaulof1hNRoaVgz9yWi0wV2O1lA==
X-Google-Smtp-Source: ABdhPJzxx64dmxnPfDeB3C1YUs+FTmy6inRBZeTpYnAKLKlv7YEbKfRvQ/MzYXNnOIYO+2qGuLYtDHsJ83R+DJYC4MA=
X-Received: by 2002:a05:6808:124a:b0:32c:45f0:5011 with SMTP id
 o10-20020a056808124a00b0032c45f05011mr2700034oiv.217.1654009185566; Tue, 31
 May 2022 07:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220523171559.472112-1-cristian.marussi@arm.com>
In-Reply-To: <20220523171559.472112-1-cristian.marussi@arm.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Tue, 31 May 2022 16:59:35 +0200
Message-ID: <CAN5uoS8XA9y_ieGYk_QjRkOLKHOSNxOjxeHv_kT1yC_Jak=qSg@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on
 protocol list
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>
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

Hello Cristian,

On Mon, 23 May 2022 at 19:17, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> Even though malformed replies from firmware must be treated carefully to
> avoid memory corruption Kernel side, some out-of-spec SCMI replies can
> be tolerated to avoid breaking existing deployed system, as long as they
> won't cause memory issues.
>
> Reported-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Acked-by: Etienne Carriere <etienne.carriere@linaro.org>

Best regards,
etienne

> ---
>  drivers/firmware/arm_scmi/base.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
> index 20fba7370f4e..d0ac96da1ddf 100644
> --- a/drivers/firmware/arm_scmi/base.c
> +++ b/drivers/firmware/arm_scmi/base.c
> @@ -221,11 +221,17 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
>                 calc_list_sz = (1 + (loop_num_ret - 1) / sizeof(u32)) *
>                                 sizeof(u32);
>                 if (calc_list_sz != real_list_sz) {
> -                       dev_err(dev,
> -                               "Malformed reply - real_sz:%zd  calc_sz:%u\n",
> -                               real_list_sz, calc_list_sz);
> -                       ret = -EPROTO;
> -                       break;
> +                       dev_warn(dev,
> +                                "Malformed reply - real_sz:%zd  calc_sz:%u  (loop_num_ret:%d)\n",
> +                                real_list_sz, calc_list_sz, loop_num_ret);
> +                       /*
> +                        * Bail out if the expected list size is bigger than the
> +                        * total payload size of the received reply.
> +                        */
> +                       if (calc_list_sz > real_list_sz) {
> +                               ret = -EPROTO;
> +                               break;
> +                       }
>                 }
>
>                 for (loop = 0; loop < loop_num_ret; loop++)
> --
> 2.36.1
>

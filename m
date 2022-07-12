Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF0572901
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 00:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiGLWIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 18:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGLWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:08:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61107BEB41
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:08:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dn9so16723109ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e6Mh3C+uukR/DWRHXYHxlUK8ZlybYZpRoKWBJ/X1AF4=;
        b=aU+dJonux1J27uENvyLoPGXSYNfkO6wrAHdlorO59BdNhVvVFTDO8JNMtb7rQTmsrH
         wkdd8LR2o+pA6+wIp34HmTQHfdOHKkvNk09aempDqPp5U9mIdnanPiy1huOLbovsJiUs
         gqaW40ygQNPXHFq4tg6Kj0QL+siUkH4D1XsfsAr5koMlq3sbuLWNkXmUK4gsWt7yw2Vm
         zHcbF+y0IR8unFA0W4amDtmlmKhWxehj6gQM1pSJU+aq2RUBCFMzwgFRR/EeaiumenDb
         jcP/xEqI3UzjuH1ZPfZPJunbfsSh779A1Z9TdpM+bVOipCWyNFpPLDyvvL5ibtxJctn3
         4+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e6Mh3C+uukR/DWRHXYHxlUK8ZlybYZpRoKWBJ/X1AF4=;
        b=udBuW/NtzPW2g2LKPKa8yJEkzAWX0pW9x2O9nCP7QdS9FIl0OWrovYkAECXlF1ToI7
         jQfNa5+SGoNH5Q27b64ZfBYIgTXl/RjAMR2FJF1+7sRhIZc9Qgr+sF4Psu6JupVJbzmb
         t3wFoZXJwHXrOL1JdrRLg0/VLTuD0RAei+lkpoVM7swYXxH1+MNhm2Ye9xC36ijOB0Xe
         M36oRrI24loPcd+APpbccQXWPQTOuyzMK6oo9wuI0FHmhlQLmjR2GMfIJFXHz1W8IuWe
         Q1ceCCasCQh3CTrvMroe28/eySX7NHAzpsOYUxGg8HQkE4dS4/3sWaOKS5dpVY5UM+AN
         iI1A==
X-Gm-Message-State: AJIora+aPdEqyfCzod+Zouz86xvjp4x6HpfJoofw1WWxJ8L/pQIH0xeq
        kJOcDVhmHF+PyJSkDmv44GDz/gnjUjVK962W6ZFSnw==
X-Google-Smtp-Source: AGRyM1sbMjtnE3khqOzWbs6jH+h1l6uJCY8+VMLsW0fheWtLu5UbaHn/tRGVkDQ7Jqqj79gC4r2wmAh96zyfSzDYhuk=
X-Received: by 2002:a17:907:2c77:b0:72b:1154:33da with SMTP id
 ib23-20020a1709072c7700b0072b115433damr265458ejc.27.1657663690831; Tue, 12
 Jul 2022 15:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220712214554.545035-1-nfraprado@collabora.com>
In-Reply-To: <20220712214554.545035-1-nfraprado@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 12 Jul 2022 15:07:59 -0700
Message-ID: <CABXOdTe_Q5fcM_Ffa72V=X5NWv8jZvK_exZ2i3tfCJ_SW3N-XA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Use dev_err_probe on port
 register fail
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:CHROME HARDWARE PLATFORM SUPPORT" 
        <chrome-platform@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 2:46 PM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> The typec_register_port() can fail with EPROBE_DEFER if the endpoint
> node hasn't probed yet. In order to avoid spamming the log with errors
> in that case, log using dev_err_probe().
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
>
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/c=
hrome/cros_ec_typec.c
> index d6088ba447af..8c0ca3c128ee 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -352,8 +352,8 @@ static int cros_typec_init_ports(struct cros_typec_da=
ta *typec)
>
>                 cros_port->port =3D typec_register_port(dev, cap);
>                 if (IS_ERR(cros_port->port)) {
> -                       dev_err(dev, "Failed to register port %d\n", port=
_num);
>                         ret =3D PTR_ERR(cros_port->port);
> +                       dev_err_probe(dev, ret, "Failed to register port =
%d\n", port_num);
>                         goto unregister_ports;
>                 }
>
> --
> 2.37.0
>

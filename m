Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403224E3026
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiCUSkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352262AbiCUSkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:40:46 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D18A145B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:39:20 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a20so6112145uaq.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBJRgrM679+/JjxLGR3nmTFCym20HMB6VhWhqGNgFiM=;
        b=PG4fWDOFfqEb1cwl16UhzR8soGx/W8RjDVStZmUeC4FwIcYryWXGxnsdv1Ow9axY81
         bxpnYdM6gvQoBzNfVHavE9RJ1rhzFY2bgdrKXZM67pk8Cm6GWQge196yxugatGSxluhc
         ITwHb1hO57OAmG/YExVgnAIJ21FiLIY86ZccvhKPOzXF+jsPz7MsvfQxX3bdZJp4ddMG
         ykDG5QDX759NXwK48Xbtaq2qGrKySqxWtnm7zSrLhHI0FqtSw7u+ErnKRKfX5Bn+DFmO
         LpZCrNKSHBbnxgRXX+X6N9B5G+Ssyt+hkwScD970Y/M0mvpS2g0X2FGTaJaCAzcU4xPe
         5b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBJRgrM679+/JjxLGR3nmTFCym20HMB6VhWhqGNgFiM=;
        b=0lEzB1R8moZTL6ntm9wUr9uQ+MjNtPaJ9lmb0+3SMzsmzstgi0LNm/t3c+EuoIUdxE
         yTUWGcLW7BFbYT34uTx2WTmC6nfnFyWIEJxNyz/d4Zxe6tyBkkXbo9HPZksFbDnaZ9UJ
         qemp5v4w/sT/7hQEPfh/XAK0c/kg8kTG1IuyzvJ6cp2pYXoftdrRpX0ZpbIhzGU9dlJ/
         xpAUYm354Esw2vo9y702t4sb+falEtoA62zGeTPivRBNlQJ1AqT6DZFKztfPPaT4+Xyx
         sG9B4HQpCtfmf5rQ7BCkbArt7Hyk4EgsJ9oUT9k8eB+nwA8OzfB9N2RDQ/MxS77EflsX
         tKFQ==
X-Gm-Message-State: AOAM532Kud2sl/h3FOQJNrXsyxga/K1YOgXkftcVsmyggezFFLqDGHgB
        bRjFJ1Hi7o7NGTEcGm+YVxqpa+1Crf3L1pGKSlU=
X-Google-Smtp-Source: ABdhPJy3o0R7d0CgN7xEA+Au05PBORG0Q+g3G0JhxDNMmfabfHU01leM4tN2PHTNKvCLRr+FX9ndznByCnN+fisaK6A=
X-Received: by 2002:ab0:20d6:0:b0:356:9691:c3a4 with SMTP id
 z22-20020ab020d6000000b003569691c3a4mr2966622ual.116.1647887959449; Mon, 21
 Mar 2022 11:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220321123626.3068639-1-jakobkoschel@gmail.com>
In-Reply-To: <20220321123626.3068639-1-jakobkoschel@gmail.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Tue, 22 Mar 2022 00:08:43 +0530
Message-ID: <CAAs364-0t4rF4QPywshd2-CnkRmOpP3xZ_K7zZay8UqNOCo1vg@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: codecs: fix type confusion of list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        linux-staging@lists.linux.dev, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Mon, Mar 21, 2022 at 6:07 PM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> If the list does not exit early then data == NULL and 'module' does not
> point to a valid list element.
> Using 'module' in such a case is not valid and was therefore removed.
>
> Fixes: 6dd67645f22c ("greybus: audio: Use single codec driver registration")
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/staging/greybus/audio_codec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index b589cf6b1d03..e19b91e7a72e 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -599,8 +599,8 @@ static int gbcodec_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
>                         break;
>         }
>         if (!data) {
> -               dev_err(dai->dev, "%s:%s DATA connection missing\n",
> -                       dai->name, module->name);
> +               dev_err(dai->dev, "%s DATA connection missing\n",
> +                       dai->name);
>                 mutex_unlock(&codec->lock);
>                 return -ENODEV;
>         }
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613

Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>


> --
> 2.25.1

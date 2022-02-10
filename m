Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588594B0CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiBJLnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 06:43:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiBJLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 06:43:51 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4681113A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:43:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so14538845eje.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:content-transfer-encoding:date:message-id:cc:subject
         :from:to:references:in-reply-to;
        bh=QCeTPktxYJJYpqPYNifcdFoiHu6/qXeJE2j2d8aAenI=;
        b=GL1Cbh+/CgSAL4lkyOLwKOefU8vLz3nQuwMJBGYj4mM1R4XztOovNGryf1iPA7iQVW
         IYKceiJLM4GOrm2mE7d388efnhqADBS13cq3+itEgsnhIY6xh+i2zh0QSH/+QrdSodx4
         W7OJXxOpJoU/ga13bNfQTxrhrc+OE30EE6opusgub5o9laAkX1QPPLjIqFrrOA1KYLCK
         vhjcL+il0M5n/asvPF/0+bd+dhpqn5lATZigFV+Mo1bg9tZU12m2gZTMXSOxxEBqFP18
         HVF77tUtqaCvCyl12CgFI1CrBtPp7+66CCxTn4JGc+mkJE+QgNJ0CeO42mkBdozQN6+Q
         g6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:cc:subject:from:to:references:in-reply-to;
        bh=QCeTPktxYJJYpqPYNifcdFoiHu6/qXeJE2j2d8aAenI=;
        b=2meEZcIsDkSkFAarGJc3OuV+lly1tiQN9S3ERj+678/mKYRHyc5FxpuUgurL6kNlfL
         CL7pFSFzOTE5iOo+O4XR7oCFo2/fCKBdhrC27cgiCiRsVcCUDDw5yR7LhBb34LGMaqfs
         AhjmwPbFCV7zE55GmBqK2g/lkoHGO6N4uuWgRmRlcYXqvoJeibWHwqccvlMoOUaJkpvU
         ucFUNH/0QaA7rw2ct8ooC15uZbLupFW89vgFSiRzsZfm0TT72crp2MyPeH8WfhkO/wGR
         JhL206VqiXKwWA+OZBTWqUMdF6gVz6FkBjYWUbeKMxMzEB0qPcXSBA5zroIT6cWo2E0c
         4Lfw==
X-Gm-Message-State: AOAM530Ea8S0D8ZGIuELwe1Qf6vC4YdH3xBnyXn5ZWxxOTWgKdCHUn/B
        MdY3pMZbex12YR6sobMKLrE=
X-Google-Smtp-Source: ABdhPJwn1ys3+LzoRmVn5YCRWkSIxHeN2Y4IO6ubZzgATn0CsloRfh34+fPlncqqFtMoyKx2cT2V7w==
X-Received: by 2002:a17:906:43c9:: with SMTP id j9mr5941529ejn.652.1644493430745;
        Thu, 10 Feb 2022 03:43:50 -0800 (PST)
Received: from localhost (a109-49-33-111.cpe.netcabo.pt. [109.49.33.111])
        by smtp.gmail.com with ESMTPSA id j9sm3365630ejb.189.2022.02.10.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 03:43:50 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Feb 2022 11:43:48 +0000
Message-Id: <CHSC9NU74XQV.2L2R0WCT1UZLA@arch-thunder>
Cc:     <johan@kernel.org>, <elder@kernel.org>,
        <gregkh@linuxfoundation.org>, <greybus-dev@lists.linaro.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Minghao Chi" <chi.minghao@zte.com.cn>,
        "Zeal Robot" <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: greybus: Remove redundant 'flush_workqueue()'
 calls
From:   "Rui Miguel Silva" <rmfrfs@gmail.com>
To:     <cgel.zte@gmail.com>
References: <20220210060205.1607792-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220210060205.1607792-1-chi.minghao@zte.com.cn>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Minghao,
Many thanks for the patch.

On Thu Feb 10, 2022 at 6:02 AM WET,  wrote:

> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>
> 'destroy_workqueue()' already drains the queue before destroying it,
> so there is no need to flush it explicitly.
>
> Remove the redundant 'flush_workqueue()' calls.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

LGTM.
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>

Cheers,
     Rui

> ---
>  drivers/staging/greybus/sdio.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdi=
o.c
> index 37bf04c22dbc..25bee5335c70 100644
> --- a/drivers/staging/greybus/sdio.c
> +++ b/drivers/staging/greybus/sdio.c
> @@ -858,7 +858,6 @@ static void gb_sdio_remove(struct gbphy_device *gbphy=
_dev)
>  	gb_connection_set_data(connection, NULL);
>  	mutex_unlock(&host->lock);
> =20
> -	flush_workqueue(host->mrq_workqueue);
>  	destroy_workqueue(host->mrq_workqueue);
>  	gb_connection_disable_rx(connection);
>  	mmc_remove_host(mmc);
> --=20
> 2.25.1




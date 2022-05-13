Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B489F526631
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381399AbiEMPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348935AbiEMPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:35:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE752DC6
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:35:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id iq10so8420921pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwEHROTwAWONW9LClMhxm8JAVtk6t0Q8QMuswvfpMFA=;
        b=F2xgswMAUMJnoWT2kgHwvwb7EA/MS5Gajp2D7DvfQFxBDqfagFm6uuiU3ENAPPnuW3
         ywUUwCVkvohIJe/URo9xZdNLMdvrB3jSiGl49mPgMXQAGUTwsi5KDaR8jqLTkVf1k+HD
         y6JrMQFc6VpMWkriDvhmKCByZI2z9sYvMtNXpVm/mHHzyNPC3UCup8WN3nQQeU1t6VEy
         cNWlGjS/phf5DRTbXUATM0q3f2COVZbh6GRNP4NHaIjeq9pBQP6r+kn0UArMQRPCYu/S
         dcivxAwEcnmTBWKjAIfj9X1HeMqPmrrweORk2ShDYYNTX+23U9q4zfwdCyo+oMmsRiDB
         VvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cwEHROTwAWONW9LClMhxm8JAVtk6t0Q8QMuswvfpMFA=;
        b=DV6eGiQ4kPrRpOJ6oBdnTrLSDi5eJ5g9tDcYJ7ShRD2RNBy7BD7g+ddgHqs+KFFWt9
         ufCVvZRWze35eZEy5b1FC8o/2lmqqywqBcOI3flTw3B5wsp71MxkxPdldSx6+4RQkGsp
         Nkew2IVopWfFxZEMZ88LASSOwVM/1uMFnFNpZfo48ktA/d5uIwbU33+IUy5jBBgIDB23
         5/oiN+0NHfwnFLmJFamV7aXzvxpBmH6/Q9MJi+YzyRtkQLmxxffOWqJXW3hQ3vHBbz2M
         aEYrQI+fObAaaKTo1A00jpLKl1Z4RGU6jRCYoEA5viTE9Z7KR9LwKxFZcXGeTF76I9kO
         Avxg==
X-Gm-Message-State: AOAM532BKgnk2YUGwDTiS58ND+WEgsc0gqqTDETCTg1VR9kmMNc/XAD/
        02yt95LHXYKUznPoVazzbu0Pb/AJrm4KZ9G8L47yJI2bG+Q=
X-Google-Smtp-Source: ABdhPJxZfZuyOwpsIqij6nkirkYBtmy/5yc5wER0gD3/nwfYeCw5KwZEIqQ6IpZVyIvFiv9ncmdfM8gHOBQPXjxSHtk=
X-Received: by 2002:a17:902:ea0e:b0:15e:c0e4:cf15 with SMTP id
 s14-20020a170902ea0e00b0015ec0e4cf15mr5415797plg.63.1652456143031; Fri, 13
 May 2022 08:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220510134146.1727701-1-zheyuma97@gmail.com>
In-Reply-To: <20220510134146.1727701-1-zheyuma97@gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 13 May 2022 08:35:31 -0700
Message-ID: <CAJ+vNU3f6vxwwCjXTA8E8n8EjMFosKpXKRk1TOBz-Tifx15Ufg@mail.gmail.com>
Subject: Re: [PATCH] media: TDA1997x: Fix the error handling in tda1997x_probe()
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 6:42 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The driver should disable the regulator when failing to probe.
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/media/i2c/tda1997x.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/media/i2c/tda1997x.c b/drivers/media/i2c/tda1997x.c
> index 8fafce26d62f..0de7acdf58a7 100644
> --- a/drivers/media/i2c/tda1997x.c
> +++ b/drivers/media/i2c/tda1997x.c
> @@ -2798,6 +2798,7 @@ static int tda1997x_probe(struct i2c_client *client,
>         cancel_delayed_work(&state->delayed_work_enable_hpd);
>         mutex_destroy(&state->page_lock);
>         mutex_destroy(&state->lock);
> +       tda1997x_set_power(state, 0);
>  err_free_state:
>         kfree(state);
>         dev_err(&client->dev, "%s failed: %d\n", __func__, ret);
> --
> 2.25.1
>

Acked-By: Tim Harvey <tharvey@gateworks.com>

Best Regards,

Tim

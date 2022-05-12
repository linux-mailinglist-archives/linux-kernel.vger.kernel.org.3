Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA215250FC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355768AbiELPNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355811AbiELPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:12:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0A22631CC
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:12:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id z2so10900333ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19mYXvplhrgGXSEnN4oN/HpZ9Pgg5x40SCiZXKwW4wM=;
        b=Tmn7nK2ifxi8WCA6ow0BAq9T4oD2+gFLhMucI2F/kbud8lY3yKkf8GketFBgRzuQ7u
         4n34376lCB/KzlAwOa5WXkEyqzSBnS/WMqQO0aU4o2Bu5e1bdoISHvYCuWJzAlub5PdP
         Fbuy21eg9rPYWIdE+sZXIIfLyH1GTqwSdDQW/33Uv8Zts2JQwOXfZI/z+EzBelV9ebz/
         aI2I6ej4xAJPtYAfHdlvbqoDHUnAVa1gznt/Hr5697JLyucN3PKppMAxZ43YbjkcJ7jn
         c7wutIFIlPSwcZEdxAfDWLqaeJrR7Ba0auIjx7oKpdCHHwTVvu/5loxa97VMe5qvQEU7
         SdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19mYXvplhrgGXSEnN4oN/HpZ9Pgg5x40SCiZXKwW4wM=;
        b=BI+GjDrQpGT0c357kQ+hzYk7SALfvQe4VX0j5UiMLTJW4faaKUh4kxhdNyKT4tCOAE
         /zEkeT07ngjA7ZE1RPRqI/81khqx3uFLpDbAdusn802cASZq0RlnMjSnM/5o5mAj2+5i
         Y36dKVggttwjhlOjlDWoMAO9G+4zP16wZgDTkDWET0UfoB112ikbNBTMRjPVQ2t1s8JV
         MlC1iKsMSb7zF85kHES31Gl/7xaa4sSh5OAOgrHe1LBvHimGMFWW+DjsG7LRipijPt14
         QQzCHFs61O9AXaXpyzmxDEi5o2CyNAFRTb2jh2tru7FVwVKfK6+2C1AWYwvZd6pi4UHM
         S/Gw==
X-Gm-Message-State: AOAM533FT2VD6WSXcANrOVrnjhV2VUuvwivs8Jh7cpLgm8AAKsDcQzfY
        8LCR3n0GNHAyLUp4+aCGfstpfkJrbW0jYagkiBMwBUlZ6zZ2EA==
X-Google-Smtp-Source: ABdhPJwHlZGV314IeMrqsCGLBw1J4ALM5lOb9sLKAG3lRpsJWY6zvEasMZFIr5DOBRUGdOXao0F8cdOboEOFBcnDZjQ=
X-Received: by 2002:a17:907:8a17:b0:6f4:4b56:f550 with SMTP id
 sc23-20020a1709078a1700b006f44b56f550mr352366ejc.720.1652368374926; Thu, 12
 May 2022 08:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220512083627.885338-1-tzungbi@kernel.org> <20220512083627.885338-6-tzungbi@kernel.org>
In-Reply-To: <20220512083627.885338-6-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 May 2022 08:12:43 -0700
Message-ID: <CABXOdTejOC41JJ750DVn1FTNb43NayPNsC3hq+o+Sr6OhkHtNA@mail.gmail.com>
Subject: Re: [PATCH 5/6] platform/chrome: cros_ec_i2c: drop BUG_ON() in cros_ec_pkt_xfer_i2c()
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, May 12, 2022 at 1:36 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> It is overkill to crash the kernel if the given message is oversize.
>
> Drop the BUG_ON() and return -EINVAL instead.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/platform/chrome/cros_ec_i2c.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chrome/cros_ec_i2c.c
> index a4f305f1eb0e..9f5b95763173 100644
> --- a/drivers/platform/chrome/cros_ec_i2c.c
> +++ b/drivers/platform/chrome/cros_ec_i2c.c
> @@ -72,13 +72,19 @@ static int cros_ec_pkt_xfer_i2c(struct cros_ec_device *ec_dev,
>         i2c_msg[1].flags = I2C_M_RD;
>
>         packet_len = msg->insize + response_header_size;
> -       BUG_ON(packet_len > ec_dev->din_size);
> +       if (packet_len > ec_dev->din_size) {
> +               ret = -EINVAL;
> +               goto done;
> +       }
>         in_buf = ec_dev->din;
>         i2c_msg[1].len = packet_len;
>         i2c_msg[1].buf = (char *) in_buf;
>
>         packet_len = msg->outsize + request_header_size;
> -       BUG_ON(packet_len > ec_dev->dout_size);
> +       if (packet_len > ec_dev->dout_size) {
> +               ret = -EINVAL;
> +               goto done;
> +       }
>         out_buf = ec_dev->dout;
>         i2c_msg[0].len = packet_len;
>         i2c_msg[0].buf = (char *) out_buf;
> --
> 2.36.0.512.ge40c2bad7a-goog
>

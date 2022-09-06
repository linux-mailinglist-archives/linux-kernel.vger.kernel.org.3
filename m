Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749CC5AF7FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiIFW3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiIFW26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:28:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437E01658B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:28:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z8so17054621edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oOdjtWoEzwzEzBCEi29UV4Widw7zGEnkb6xM+Aik0Pg=;
        b=le8j+0xAOah4jVyIZzHnu2IeY+kvgZstrNTB2EOkGFRSh24AWTM1Xj63HHJI+QHlRf
         pEFKAdIyki3bmnYHCxW8OmgHLL52/h9as8vhq7Z+Ya1gb+yKME/NewKE7Z1BdHizbNI/
         o3+GtdAPZo77s2yGSP3DSAh6+t5CVTC2zWrcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oOdjtWoEzwzEzBCEi29UV4Widw7zGEnkb6xM+Aik0Pg=;
        b=g6F7ysT5rxeAbUIJXMKkALZOpU9Nty1Mlu34JhXUhJcdFwPCeMueXFF+f3dc01LPdG
         u5W4Mrcz8m3zQq0A4E00jzQDR3D0kaYngaJVPORbp54P7OWGTegZS6Hz9rbDReaPS6TO
         SZJAhRnVgWdVHojJ6kqtObLsFR7wgEYuwWvBV20oIR/0gh+1zRjTIcYkKRQ1s4JoBgyQ
         etd8+j3Lkj8G4UcCe59OuBZzBNeMTdWe2BSV88His2rLXVcJQFDdcLmXyTb3oBEZ+1ix
         GedsZ1TI3bmwJGvl9GaxoSNGadnp/czUbR2RtoLva6pfHtfGwZ+d84ivWKO5eftD0wb1
         u02A==
X-Gm-Message-State: ACgBeo0ITzVtLX01D+LXNN8Q0m1QJ69oMFgCkQHRPXBU+4CMqHCphWva
        sChk5vIQLsz/RvM63WbdMiWvItRnULn8XA3T
X-Google-Smtp-Source: AA6agR5K0Q/n1u3Mk16VIILJAYUUHdOWD+FUcguIZa1A7VbZk0dvSDlw5GISSM4e24dSXOVbwRx/lw==
X-Received: by 2002:a05:6402:84c:b0:44e:d797:6df9 with SMTP id b12-20020a056402084c00b0044ed7976df9mr634714edz.186.1662503335603;
        Tue, 06 Sep 2022 15:28:55 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id kx2-20020a170907774200b0073d84a321c8sm7260310ejc.166.2022.09.06.15.28.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:28:54 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id b16so17531245wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:28:53 -0700 (PDT)
X-Received: by 2002:a5d:59af:0:b0:226:ffd5:58d with SMTP id
 p15-20020a5d59af000000b00226ffd5058dmr289347wrr.405.1662503333512; Tue, 06
 Sep 2022 15:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220902082843.1.I7da6ff6c8e8700624d61e51ff7d09e151bd83dcb@changeid>
 <20220902082843.2.I19ac6cf9b8502d92f551ff4166861debb14576ec@changeid>
In-Reply-To: <20220902082843.2.I19ac6cf9b8502d92f551ff4166861debb14576ec@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 6 Sep 2022 15:28:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VZQVfb7=+xN-kVPk6yWeYmrfuMtd=fUjXp6e_JHByAGg@mail.gmail.com>
Message-ID: <CAD=FV=VZQVfb7=+xN-kVPk6yWeYmrfuMtd=fUjXp6e_JHByAGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] input: touchscreen: elants_i2c: Add eth3915n
 touchscreen chip
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 2, 2022 at 1:33 AM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> The eth3915n requires more delay time than the eth3500 when reset.
> Define EKTH3915_RESET_DELAY_MSEC as the reset delay time of eth3915n,
> about 300ms.
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
>
> ---
>
>  drivers/input/touchscreen/elants_i2c.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index c9dd703b0c7d8..60ddb58281bdf 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -116,6 +116,7 @@
>
>  #define ELAN_POWERON_DELAY_USEC        500
>  #define ELAN_RESET_DELAY_MSEC  20
> +#define EKTH3915_RESET_DELAY_MSEC      300
>
>  /* FW boot code version */
>  #define BC_VER_H_BYTE_FOR_EKTH3900x1_I2C        0x72
> @@ -133,6 +134,7 @@
>  enum elants_chip_id {
>         EKTH3500,
>         EKTF3624,
> +       EKTH3915,
>  };
>
>  enum elants_state {
> @@ -664,6 +666,7 @@ static int elants_i2c_initialize(struct elants_data *ts)
>
>         switch (ts->chip_id) {
>         case EKTH3500:
> +       case EKTH3915:
>                 if (!error)
>                         error = elants_i2c_query_ts_info_ekth(ts);
>                 break;
> @@ -1361,7 +1364,17 @@ static int elants_i2c_power_on(struct elants_data *ts)
>         if (error)
>                 return error;
>
> -       msleep(ELAN_RESET_DELAY_MSEC);
> +       if (ts->chip_id == EKTH3915)
> +               /*
> +                * There need delay 300ms for power on sequence.
> +                * T1 + T2 + T3 >= 305 ms
> +                * T1: 0<time<500us
> +                * T2: >5ms
> +                * T3: >300ms
> +                */
> +               msleep(EKTH3915_RESET_DELAY_MSEC);
> +       else
> +               msleep(ELAN_RESET_DELAY_MSEC);
>
>         return 0;
>  }
> @@ -1686,6 +1699,7 @@ static const struct i2c_device_id elants_i2c_id[] = {
>         { DEVICE_NAME, EKTH3500 },
>         { "ekth3500", EKTH3500 },
>         { "ektf3624", EKTF3624 },
> +       { "ekth3915", EKTH3915 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(i2c, elants_i2c_id);
> @@ -1702,6 +1716,7 @@ MODULE_DEVICE_TABLE(acpi, elants_acpi_id);
>  static const struct of_device_id elants_of_match[] = {
>         { .compatible = "elan,ekth3500", .data = (void *)EKTH3500 },
>         { .compatible = "elan,ektf3624", .data = (void *)EKTF3624 },
> +       { .compatible = "elan,ekth3915", .data = (void *)EKTH3915 },

Adding giant delays isn't my favorite, but it seems like the trend in
touchscreens is that newer ones take forever to power up. I guess this
is no exception. FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

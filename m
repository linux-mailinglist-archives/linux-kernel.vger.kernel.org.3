Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B182257B994
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiGTP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGTP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:27:44 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EE564F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:27:43 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id f3so1578017uaq.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=egHHWRfHLuooJteJL4UiMdp23DTR6GCs9T7w8M7ONxk=;
        b=a5gM9FUXPFg1YIYEYkdVjOlOfrMB5V9IQM51MmXsv7qTxyIQN4epyZwS+814Z+LNFD
         MBf0zlLzCNbFW++F76USeIzhCSD711UtDJwtUSRMzaZh4kOz7X14lxDcyLMtmD50eDwZ
         TmJPv9zHlCDIFDvALblgmiGMAv+KDOQkDn+kF9Br4QQXILbJmGV0hfEuB5G9kCmzF0Fd
         Q6vwIyr1A6MtCaJ0HsP9kPV3dNpWXLBnw00bwnhPb6NG+DpjdHfu45+YTEzBBv9ekKwT
         mQ5OBILlM50gbNuB2pUoSmdhXJGOjCcBFfvAb5hak3FJFWhVo6jWPtWBGRtG5Zxe8uCI
         HzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=egHHWRfHLuooJteJL4UiMdp23DTR6GCs9T7w8M7ONxk=;
        b=C6QOVSzJpFxjmmP3zHAKckNGsw6PqOKDXpy+V0SCj5kItDsYYuMw/tB4dUsYdtlo+2
         kY6oyuJ+Sg83I1OB8WshRKDRgplcB8S+8DiU0gM6JUna9XtfmdCAcAvVDwdCGrvZKAIT
         GKQGULEcw//U/WjiqduyAmqGIUBtE74Ju6XK5oT+pgxY/zk7OYqOBmSkapuOjA+yGXjl
         YpGa7rv/Vu41JmJmD+omIxkyOIFtYwkBKtDyji5jYsWpyyRoHddXUeOla8VVNjVEGXVQ
         rqKig1rQu0WEZFQVOcp0MXQNRnL7oJpmwj1+4u2MLcEwsejw0UxuzHNyVHYz7ZxqG8X3
         Wd+Q==
X-Gm-Message-State: AJIora/6pHs1yZnq2AEo76cYJA2esXPua6DkltODAGoWt0tJSDxPvuHe
        W1bxUi3NvXhzpgxlGpjpNftkNw8X1Y8vW2p0PBouVg==
X-Google-Smtp-Source: AGRyM1sNXQwOb3Brl8C/bMjD7EfM+swjnfT23/2dt+E5y4c9XEV29McpkbOSCpW6amVuMdbGC0XA0l/+fyPouS/y3L8=
X-Received: by 2002:ab0:6512:0:b0:383:4aa:b452 with SMTP id
 w18-20020ab06512000000b0038304aab452mr13957811uam.55.1658330862179; Wed, 20
 Jul 2022 08:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220720054225.1623875-1-shraash@google.com>
In-Reply-To: <20220720054225.1623875-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 20 Jul 2022 08:27:31 -0700
Message-ID: <CABXOdTf5kJa5n2D8f6+LkpHTrhbn2u+Svg9B2AjKWRhbh473Vg@mail.gmail.com>
Subject: Re: [PATCH] HID: nintendo: Fix unused-const-variable compiler warning
To:     Aashish Sharma <shraash@google.com>
Cc:     "Daniel J . Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 10:43 PM Aashish Sharma <shraash@google.com> wrote:
>
> The following compiler warning is produced when CONFIG_NINTENDO_FF
> is not set:
>
> >> drivers/hid/hid-nintendo.c:405:29: warning: 'JC_RUMBLE_ZERO_AMP_PKT_CNT'
>    defined but not used [-Wunused-const-variable=]
>
> To fix this, move the variable 'JC_RUMBLE_ZERO_AMP_PKT_CNT' under the
> CONFIG_NINTENDO_FF's conditional compilation block.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  drivers/hid/hid-nintendo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 2204de889739..69de7504bdbc 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -402,8 +402,6 @@ struct joycon_input_report {
>  #define JC_RUMBLE_DATA_SIZE    8
>  #define JC_RUMBLE_QUEUE_SIZE   8
>
> -static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
> -
>  static const char * const joycon_player_led_names[] = {
>         LED_FUNCTION_PLAYER1,
>         LED_FUNCTION_PLAYER2,
> @@ -1512,6 +1510,8 @@ static void joycon_clamp_rumble_freqs(struct joycon_ctlr *ctlr)
>         spin_unlock_irqrestore(&ctlr->lock, flags);
>  }
>
> +static const unsigned short JC_RUMBLE_ZERO_AMP_PKT_CNT = 5;
> +
>  static int joycon_set_rumble(struct joycon_ctlr *ctlr, u16 amp_r, u16 amp_l,
>                              bool schedule_now)
>  {
> --
> 2.37.0.170.g444d1eabd0-goog
>

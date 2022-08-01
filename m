Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F155586610
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiHAIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiHAINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:13:24 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25E42B27A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:13:22 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 125so10436842vsx.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 01:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3Zv79Cs51isXrSdJsVm0i4Wa9LD12edge7RWxx7y3o=;
        b=dmqEzlOZ1X3YsuP2nwYbn+cD+s24NBSeT7TsDEkS1uorO87puy7L9Cvgoucf7L8WDs
         bUX1UYXP2+fi/dldoeY95oUgSmqErFNBTb6vEhO5V0ei9Q/0qH+hqJVVF+YPqYv8cOaV
         hcay9seG+ZC5DCr1aULZGcovFoskHIrBbmRgcyyfi1+V3xyVAvRmiKactcnylrDNGpYS
         nf1b3JLqGTWcLwQMQVsUJw6DC2Zg2PMKYXFhjcLzIA9RBq4sV5UsGn3z3KyVC2GOAzfX
         dINFBcBK65WaQkJ+5CoHy+H2eJkCrPpS8jGhhoJM4CRMdtgp4wQPxpUs1JPqnFo2ZqxU
         CjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3Zv79Cs51isXrSdJsVm0i4Wa9LD12edge7RWxx7y3o=;
        b=uNXLHvYoX9zVnw2cGSOBpAgbN/vg3C2FFbxwzsFCza2sR8U9OFCQMZ4JkG3XSnYie5
         NAF/TCiplOTwemBMWwctFdiAKV0Nncwf+n7DHWZI/EoJ+0tmYKzhIKJ3LJXHuar8Hp8M
         5rR4/w0alDB3w3aJ49D07EeMUK6uJ331JnwSNgfJmGF+jZKtNA/lgLgRZ/ZiI8KapGrN
         EeldZqxo71NXliRw7LmIiczvKKk0tFE1e1A6BjwM0J8bU7WsvpHDQhX+kRVFfYOCrE/+
         6I7jBEIKqpr4BCtfwImMykorsCpPiw2zEFbCgmpaxHfpBnHb8fg+Pte99P9BZGGMpV79
         gNXg==
X-Gm-Message-State: ACgBeo1e6F1c20unny1O/DwbIMwz6QXFdRYAXy3o3965SvH9MrP+h7b/
        jxsBRQg4f4w4d3XOQrFI3S9Xzkb6kfo6lANknEvGfw==
X-Google-Smtp-Source: AA6agR52sPn0O7rKsqSW4B1dL7cPYFngDmDT5Bc/jLGziLt9uaz9T4vam1lKXUObeAjdqtnFcMZwzzuzl4e9YsN68zI=
X-Received: by 2002:a67:c19c:0:b0:386:3a4b:dd5 with SMTP id
 h28-20020a67c19c000000b003863a4b0dd5mr632376vsj.53.1659341601797; Mon, 01 Aug
 2022 01:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220801042918.292541-1-shraash@google.com>
In-Reply-To: <20220801042918.292541-1-shraash@google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 1 Aug 2022 01:13:09 -0700
Message-ID: <CABXOdTfCxZ=r+iH0bwN3Rb6x-RgXHvCMeieeyQv_bwEAFF=tbQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Replace IS_ERR_OR_NULL with IS_ERR
To:     Aashish Sharma <shraash@google.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guenter Roeck <groeck@chromium.org>,
        Martin Faltesek <mfaltesek@google.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
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

On Sun, Jul 31, 2022 at 9:29 PM Aashish Sharma <shraash@google.com> wrote:
>
> Since bt_skb_sendmsg never returns NULL, replace IS_ERR_OR_NULL
> with IS_ERR.
>
> Signed-off-by: Aashish Sharma <shraash@google.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  include/net/bluetooth/bluetooth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 6b48d9e2aab9..a8b52175af05 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -494,7 +494,7 @@ static inline struct sk_buff *bt_skb_sendmmsg(struct sock *sk,
>         struct sk_buff *skb, **frag;
>
>         skb = bt_skb_sendmsg(sk, msg, len, mtu, headroom, tailroom);
> -       if (IS_ERR_OR_NULL(skb))
> +       if (IS_ERR(skb))
>                 return skb;
>
>         len -= skb->len;
> --
> 2.37.1.455.g008518b4e5-goog
>

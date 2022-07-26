Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FCE581A09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiGZS44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGZS4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:56:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619E410553;
        Tue, 26 Jul 2022 11:56:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ez10so27648837ejc.13;
        Tue, 26 Jul 2022 11:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70sWt+OOr9B+NH4bPsxGQ0naBq5a9pYzadwl5kejcqI=;
        b=L0KLbg9v7JPhjCDYU6mwAKgtEqlArH4uYw99tG6U4HoZ9W7JmeQOFypFywqGUIhCi0
         YbNsbHDjABZswbor3NvgUtur/mY2rvwPK5loW3f1OlnvkPodURSfZsaa6Q458RyqqEkI
         IH/O0p2JUPQH2kVVE8KijgGvkwcbgZ01oTc6sXYsHXBFwY+nocPqZup+oxepIhLiauIb
         oQVOIfd+tN10g17hcYRFaCc8k6MwbnwNe5K0Mlsc5pIKp/q1d1YJ6GoyJKE9NQKr2f4U
         UQQVW0p0jb6w3p47k2WJzlhZMcnX+MHLH9asnyUc2zWApiw4du3vJ7bxRDkDaNgIYgZg
         VNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70sWt+OOr9B+NH4bPsxGQ0naBq5a9pYzadwl5kejcqI=;
        b=XoyxpgHSgT7ukFHdVTTBy/LmlvE4iI9Fp3AfwYbDakWRzs+xFDX68Ab6NJwh70TSo9
         Rqyx2t1PalSfRA/HnrqHjqkTruBbv6a5KOQcJ0q/ATexp/DLhrjcXvUBr1R/tVb/PjAn
         z+arLz8tLgNSTVP9ZrDhkAqqAlQL9wVhyauuMmaIIet4SAnVqYgmJHsy64fSdwcDH9oN
         0mC5PmTUwHkbWYdiqh4aSwn5ve4DjKDgiEuvyzgdOwTBpFzZWS0OxgJpq+1gQtBe1QLx
         tqsMW9lU19tYuNXAP++ws7fGMCTXFzHl8GtAw+M2XSBRjlrlrkFfjeoxluPzEWzcseAO
         ud4w==
X-Gm-Message-State: AJIora8RMQ6QThizAA17xVXH6hGIaL/UjlEiRegR217fr+nZJN2Qdo7i
        yA4W3Md3yHpWHnNrl3/ZfbVAQaAny61tRogUsMyNPxDfbS0=
X-Google-Smtp-Source: AGRyM1sDQWLMOQBq5vlpFdmnfaAxEO/LhsjYYSg8S6SbUSlD2SeOCFsZTgLgko+py6/9fWkVXTi0hNGW9qsgZBzmam4=
X-Received: by 2002:a17:907:a40d:b0:72b:7f56:650 with SMTP id
 sg13-20020a170907a40d00b0072b7f560650mr14966530ejc.132.1658861810839; Tue, 26
 Jul 2022 11:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220725065316.6942-1-soenke.huster@eknoes.de>
In-Reply-To: <20220725065316.6942-1-soenke.huster@eknoes.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 26 Jul 2022 11:56:39 -0700
Message-ID: <CABBYNZKQ2Qx6Mb+dWH06a1a4=n7XdxfoFNVqR8UtaN=X16rCJQ@mail.gmail.com>
Subject: Re: [PATCH Resend] Bluetooth: virtio_bt: Use skb_put to set length
To:     Soenke Huster <soenke.huster@eknoes.de>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soenke,

On Sun, Jul 24, 2022 at 11:53 PM Soenke Huster <soenke.huster@eknoes.de> wrote:
>
> By using skb_put we ensure that skb->tail is set
> correctly. Currently, skb->tail is always zero, which
> leads to errors, such as the following page fault in
> rfcomm_recv_frame:
>
>     BUG: unable to handle page fault for address: ffffed1021de29ff
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     RIP: 0010:rfcomm_run+0x831/0x4040 (net/bluetooth/rfcomm/core.c:1751)

Please add the Fixes tag with the original patch that introduced the problem.

> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
>  drivers/bluetooth/virtio_bt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 67c21263f9e0..fd281d439505 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -219,7 +219,7 @@ static void virtbt_rx_work(struct work_struct *work)
>         if (!skb)
>                 return;
>
> -       skb->len = len;
> +       skb_put(skb, len);
>         virtbt_rx_handle(vbt, skb);
>
>         if (virtbt_add_inbuf(vbt) < 0)
> --
> 2.36.1
>


-- 
Luiz Augusto von Dentz

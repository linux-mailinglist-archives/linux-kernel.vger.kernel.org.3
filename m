Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4831D564EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiGDHf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGDHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:35:20 -0400
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639F7CC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:35:19 -0700 (PDT)
Received: by mail-qk1-f179.google.com with SMTP id n10so6254358qkn.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uTcz29t3pg1C4YGaeQ71ecfCeed2MNypmoCrMjlf/c=;
        b=BT0g3Kee97FhZaFTP8A3BIjnQCv0+VuKgq6ryzLN2BkfIs/EZBQhO7XKQHCJa19dn7
         RfIcutpYb9I5YSQs1zfi8JgLEYDTmZH34JfReqpOqkRbbjSL3RD3Gdrn6lmLlTggh0is
         hvhDbOxKxT0enkRQRw+3HXQHinbQsyAwNB5BjVS5+BY4vlSkNt7CkWbp5gNMwSYf5396
         spwDptdRZCZyurzxN9qh+EoKeCxipjcdOzaXq/JuqLCBEKNrqUa+L5geS2AMKJ7AsI3b
         gCN1KK83uIV7oCvVEy/6ZJH07RfjyEcIy/uia96GwoqYnkOFHU43nG690j/CjEkySfG6
         nCrQ==
X-Gm-Message-State: AJIora/NnyQj1qLBvqC3yF5xcF8YKkMM1k8yEF29mBranaOIJGCsnlg0
        CctASpLTL/4VnmD3WTrbaCR6grW8NUUB7A==
X-Google-Smtp-Source: AGRyM1s891dNfZs5vidcw3PvQNdStjlav8Mnfbt7MajL+mpnsN/VRac/vjShFuGgLPI+iGtjvK7EaQ==
X-Received: by 2002:a05:620a:1712:b0:6af:665d:7687 with SMTP id az18-20020a05620a171200b006af665d7687mr19235525qkb.156.1656920117680;
        Mon, 04 Jul 2022 00:35:17 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006afc53e0be2sm14823651qkp.117.2022.07.04.00.35.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 00:35:17 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id l144so2890663ybl.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:35:17 -0700 (PDT)
X-Received: by 2002:a05:6902:a:b0:65c:b38e:6d9f with SMTP id
 l10-20020a056902000a00b0065cb38e6d9fmr31448190ybh.36.1656920116950; Mon, 04
 Jul 2022 00:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220704073644.2384999-1-yangyingliang@huawei.com>
In-Reply-To: <20220704073644.2384999-1-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jul 2022 09:35:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUeCV9th=yc7d1OQ72wPUiSxrUFniyV4tJkVrNmRNcMaQ@mail.gmail.com>
Message-ID: <CAMuHMdUeCV9th=yc7d1OQ72wPUiSxrUFniyV4tJkVrNmRNcMaQ@mail.gmail.com>
Subject: Re: [PATCH] m68k/amiga: fix missing platform_device_unregister() on
 error in amiga_init_devices()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Mon, Jul 4, 2022 at 9:27 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Add the missing platform_device_unregister() before return
> from amiga_init_devices() in the error handling case.
>
> Fixes: eeed227966da ("m68k/amiga: Add error checks when registering platform devices")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Thanks for your patch!

TBH, I don't think it's worth adding this code: this happens during early
kernel startup.  If any of these devices fail to register, that must happen
because the system ran out of memory, and thus won't work anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

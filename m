Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D265170DF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385425AbiEBNt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352494AbiEBNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:49:45 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DFC1260F;
        Mon,  2 May 2022 06:46:16 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id x22so5973403qto.2;
        Mon, 02 May 2022 06:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTBaCHq+ZPp/83sC9QEFQMvZBDoFtqtvGEyIKWXC9I0=;
        b=pQ0P7mdf3UfBoup1qMUmHoQwKcTRRGn38eIKFi87irzAHAkTP7Eu5jXNGMJGKDbVti
         L+x1yV1Cb14Cyy9xBgqmVbuSFK1MweBcOcHFw8xV3KA0QlmD4vI+XF7pECmw8Yv2Ni5V
         vATM0y6LUAphA3jSfgBQ2ZmsnUa07bDmjwN08335wXwC6bUXAghkZNoRyWnrxGMNUMsS
         IJTERPbjbIidIRoKRQcW12SL8QAknVBXSMPIRzGUMon9VskWApqBxsTu7Lvu1e2coXg2
         K+uMquDSk3R4jCJMCwzBukrflB4ogqmJT/HmD9Kk/B3QUq9adH2uZ2MRUhRgNTwCQYZP
         Xs0g==
X-Gm-Message-State: AOAM532Ch/q2zwC0ISwdZrGP3M4sr/I8BQ0dXNXUBw9tOSuVV0DR1XXh
        0ExQdYMwZR2Uw9yEi6kqtSCkn0/wZzs4ow==
X-Google-Smtp-Source: ABdhPJxTmoL7T7I9Bkm5J8hYQjUv66Agz4bGolXwY6cMH+wJofMkI7y1cP/Da2V20fn5iJ80vXN8AQ==
X-Received: by 2002:ac8:5896:0:b0:2f3:a7b1:a2cb with SMTP id t22-20020ac85896000000b002f3a7b1a2cbmr2515932qta.476.1651499175408;
        Mon, 02 May 2022 06:46:15 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id s126-20020a37a984000000b0069fca79fa3asm3538092qke.62.2022.05.02.06.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 06:46:15 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id g28so26067571ybj.10;
        Mon, 02 May 2022 06:46:15 -0700 (PDT)
X-Received: by 2002:a25:4506:0:b0:648:cfc2:301d with SMTP id
 s6-20020a254506000000b00648cfc2301dmr10228415yba.380.1651499174794; Mon, 02
 May 2022 06:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220429082637.1308182-1-yangyingliang@huawei.com>
In-Reply-To: <20220429082637.1308182-1-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 May 2022 15:46:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUiXB3ouxM57Dy+puY-WfV4jpgnRwB8THSQqbhgvkk+g@mail.gmail.com>
Message-ID: <CAMuHMdUUiXB3ouxM57Dy+puY-WfV4jpgnRwB8THSQqbhgvkk+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: renesas: fix possible null-ptr-deref in sh_pfc_map_resources()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 4:30 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
>
> Fixes: c7977ec4a336 ("pinctrl: sh-pfc: Convert to platform_get_*()")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl-for-v5.19.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

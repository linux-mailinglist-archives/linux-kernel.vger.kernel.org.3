Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75211569E08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiGGIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiGGIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:48:02 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C3E193CB;
        Thu,  7 Jul 2022 01:48:02 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id r2so1113334qtx.6;
        Thu, 07 Jul 2022 01:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TC32F89z4NX+rauYaDqmY4874to+dNezztV+gLxaTs=;
        b=hRVqLg0Oooh1DXh2MqeVcinfVogN8otFAzemmWjcdhXXP98CqgfxYefd4GKYd2Oe6Y
         c2GkPzJLXU2GZkq4LS4lO+V/SYUtyYm1mpUF5gO0+maWPVWNo9FVCkwZXd0mdWRfI1a7
         pgc2o/JwqsxGG0Bl4PMrxJGF3V4Jl+hO2tqN7+iykm7OEHhB1uTElrRdPt46TY82HL8L
         iONkGo3qwnVQnZ09jIqOeAgp5zBcA5ctfDNjj/W8ail+6xijG4MGrQjQkxeaV8h9fPIF
         u4hYLy+zipyDZbMaq8+nLyGt5KRj17lLQ63mvlvdk7KCyyzgrh6q3XlEhkIIjY083gI0
         q+FA==
X-Gm-Message-State: AJIora+M/Ybb8v2WTr2M02pbwGs8tXinTwdzrbuuhyztVOsjX5vpR4mV
        h7tr1RDz2qZh7UtyKg/4YLh6aDaOqzZS1Fyi
X-Google-Smtp-Source: AGRyM1va1nZaq+qKAY2LeOfu11fNhu/mrf7/IRXNO9+3Dn1WglViDZK409KApapVTkhv6c/r7O3FCg==
X-Received: by 2002:ad4:5765:0:b0:473:20f:fc09 with SMTP id r5-20020ad45765000000b00473020ffc09mr12618787qvx.2.1657183681250;
        Thu, 07 Jul 2022 01:48:01 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id bl10-20020a05620a1a8a00b006a67eb4610fsm32116402qkb.116.2022.07.07.01.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:48:01 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-317a66d62dfso163467067b3.7;
        Thu, 07 Jul 2022 01:48:00 -0700 (PDT)
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr10302814ywe.47.1657183680441; Thu, 07
 Jul 2022 01:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220630140919.3857698-1-yangyingliang@huawei.com>
In-Reply-To: <20220630140919.3857698-1-yangyingliang@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Jul 2022 10:47:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=ht8rBnJfc5c_LyhRCzLwABNHMKLfPa22R5mxnTOjvA@mail.gmail.com>
Message-ID: <CAMuHMdU=ht8rBnJfc5c_LyhRCzLwABNHMKLfPa22R5mxnTOjvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sh-sci: fix missing sci_cleanup_single() in sci_probe_single()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Sjoerd Simons <sjoerd.simons@collabora.co.uk>
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

On Thu, Jun 30, 2022 at 3:59 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
> Add missing sci_cleanup_single() in error case in sci_probe_single()
>
> Fixes: f907c9ea8835 ("serial: sh-sci: Add support for GPIO-controlled modem lines")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

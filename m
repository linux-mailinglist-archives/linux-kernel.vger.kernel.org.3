Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083355996C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347661AbiHSIPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiHSIPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:15:16 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638A1D25E0;
        Fri, 19 Aug 2022 01:14:41 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p4so2871725qvr.5;
        Fri, 19 Aug 2022 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aCZoiGRwyMVY7WfRYM9uVBdL1wCHNtdff3dkV0mrBaQ=;
        b=l8mR22plJrQHFDkgURsmJ/ehMSuSK3nSuiKCKt1T8hb2GxnoYwSDaj+cECpNaUBDO2
         1v2p/E81hKOIGjR37Jvk+P0x5FakkubOPfBD6aLNPsNPf2cq97FSmhIR6HT+hW77M7P8
         nPnPfBNAUid3865Z04uxhK+YbwK4AhTwC0KyClY9WD7iU+7+PVMSxZj46boFg1N6PV9X
         GSkqKJzzO9b+MhaXRPeiDIroEQSv7w0AM++Abs2a7Cu9U+MTw85/FdWR7nuzrYDKkcgv
         e9dEnpryil2rYJMCg75hzmcklJqqhKP0LqXcHbMMh3xG/F4G8Grai+0PBufg/ZyE1AZb
         DNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aCZoiGRwyMVY7WfRYM9uVBdL1wCHNtdff3dkV0mrBaQ=;
        b=3hw4ZQhwvH1pbPhohph5pPKTEvTHstnxl5VLnrixe4Caje1XWBqEDploSFtOmcBesV
         Dh/FK2XGKNpWBzHsVU/Jis+76t69695Jl7ZsoFNm1XwGLmPlenkl9rGWYTQ4eXS8bGFV
         vseKrggBlT7wPB29g4xm3htT2sx04zhsRTPA7EFeZM7U14/gvSmNtgytgKCyG3BfN3dq
         32Jk4B5EQtN4OfYsuZUuXRnZw6FoxKd4DyXPr+Pjah2ShfuYoOMtdcr0QhkbmjLaGSp6
         jFJC5ac3hZEvcunVSSjygBWJmJhFXZd5PnOpe8zWQMwodgrjQENi1xtyvSbWacIdhsIN
         hUIw==
X-Gm-Message-State: ACgBeo39pGNBNkQR/SAIoqBfvca9o2DjxfM/3eXEn/+8w8m3/f9rTp6O
        mi2agNbEg0mJpKHKpCG/Yf6gachk13pHYRm/ej8=
X-Google-Smtp-Source: AA6agR5L+eaDB8mY1yhUSg6sgY+tLO/JsufbJsQH+fJX18C22+r/zLWgLTDHT638gikY5E6676jklqro6Bc//w1Y7sA=
X-Received: by 2002:ad4:4eaf:0:b0:496:ac46:2d9c with SMTP id
 ed15-20020ad44eaf000000b00496ac462d9cmr5395010qvb.82.1660896880435; Fri, 19
 Aug 2022 01:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220817105643.95710-1-contact@artur-rojek.eu> <20220817105643.95710-3-contact@artur-rojek.eu>
In-Reply-To: <20220817105643.95710-3-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 11:14:04 +0300
Message-ID: <CAHp75VcrM53+GW8qN4H-8kxuBRStAXjpt5F7YD5R2nHhh-Wiww@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: add iio_channel_cb_get_iio_buffer helper
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 1:58 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Introduce a helper function to retrieve an iio_buffer from
> iio_cb_buffer.
>
> This is useful for consumers that need to extract metadata about
> the buffer, e.g. get the channel offsets.

I'm wondering if we should start using the IIO namespace for new
exported symbols.

-- 
With Best Regards,
Andy Shevchenko

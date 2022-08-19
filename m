Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2618B599747
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347613AbiHSIWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHSIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:22:05 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0FE564C8;
        Fri, 19 Aug 2022 01:22:05 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b9so2832052qka.2;
        Fri, 19 Aug 2022 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jHoxLhPLeEqo5obusQoaXzvVIEivg5rvRbhCPfTpXxk=;
        b=hc2mxNwi7xDgAVhriVTXaY/sUTFcIriBvXnIpSgHTw274P/ItF71a5Wqt0x87EIzqj
         XM6uUUIWb3xc7Z8oZD8vW3thZn/fQF1af0Hofgb+VpO5S/TbpMQyKYOhrEOj5bMn4Lqk
         UHVDOVUMtAZgVRG7+uNpXgtuGfTeOTBHo5FpAE9Ddu1oMm+zwpjxnNbhVbio5o7WwQKh
         EVk3WmnnYS6Ikhhzme/7YZFlKejKMOHXkmR/1llPfAk29sD9E1m9horSF9qAJpDFbbLY
         IbTfDzLPS+1lklKNMsjJL2R717q5278ir0ZZj3/vjVC5ZSBqjNDPhR/zfALEVaKd7oTC
         +BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jHoxLhPLeEqo5obusQoaXzvVIEivg5rvRbhCPfTpXxk=;
        b=ZNW7MOloHs1XLIcJHZm0JeTVnW0i9HFrYlh+cjPKXs8qoB6gIPELGgv3RcCrSnH13+
         9S4/Q6ODQwpdLE0AuOZgL8+gOe37/TTroSw468Z0aEDG2P3kCjB7rL0goD6AsvOTfjeu
         hJB4MDe1feCqlf2M2DhSwFSZR39WUAPtCcIHFizu8L5zu+q15GINYvtBuggjDmAw/XjU
         SxBg47guwdlgRkpcecm6/s2nTK6HW69kLwvGIoQBoeSfZMKxlke5Qfy9sTawNaqhadvF
         IA3eCypDD6dQy9m0Y5dXfULE3saCL9UlmC3OGAlcbDuEPHvV5cxGz6rEuT7Wvm3eqd3g
         an1g==
X-Gm-Message-State: ACgBeo3llkbHgRqmuqdUuQev3IcJab7QCtyxwfj7iZWNZq39Fvr2tcCk
        yYX0s4jQe2gde8gG3Cgf0kWrErW4FbwPZA1rywU=
X-Google-Smtp-Source: AA6agR5eBbcKfnSc1FfOQbvYZmxUL3i/M2eCIy+d+iFu3GX882tOnfG70TQ+MOqjdMKbQQtt0KbIJ113x3c/7NXmE9o=
X-Received: by 2002:a05:620a:2809:b0:6b6:5908:316e with SMTP id
 f9-20020a05620a280900b006b65908316emr4607045qkp.734.1660897324141; Fri, 19
 Aug 2022 01:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220817105643.95710-1-contact@artur-rojek.eu> <20220817105643.95710-5-contact@artur-rojek.eu>
In-Reply-To: <20220817105643.95710-5-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Aug 2022 11:21:28 +0300
Message-ID: <CAHp75Vf=GpC6qv9bQNJ0ED8_aYJ9XNzD4e=1TWVVB6mraQcvHg@mail.gmail.com>
Subject: Re: [PATCH 4/4] input: joystick: Fix buffer data parsing
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
> Don't try to access buffer data of a channel by its scan index. Instead,
> use the newly introduced `iio_find_channel_offset_in_buffer` to get the
> correct data offset.
>
> The scan index of a channel does not represent its position in a buffer,
> as the buffer will contain data for enabled channels only, affecting
> data offsets and alignment.

> Fixes: 2c2b364fddd5 ("Input: joystick - add ADC attached joystick driver.")

You may not use Fixes here because it has dependencies. The possible
solutions are:
1/
a) create a real fix for the existing code;
b) refactor it.

2/
 put the Fixes tag to all dependencies (which is questionable).


> Reported-by: Chris Morgan <macromorgan@hotmail.com>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Try to keep tags in chronological order, I do not believe the change
may be tested before it has been created.

-- 
With Best Regards,
Andy Shevchenko

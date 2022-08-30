Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904C95A6DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 21:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiH3T47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 15:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbiH3T4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 15:56:55 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8670E6C;
        Tue, 30 Aug 2022 12:56:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a15so9308821qko.4;
        Tue, 30 Aug 2022 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=B7z26XIqnnDQkHMdYCIbF/h+gJRRyxIq0yn7zncBJrk=;
        b=YTnX+rhn984d5NOCrdBYNeb+VhC21SiC3ELqCVa0g/FHVCINcdFWpyRBc+ZenESTsu
         1EbWd0pLHXUiO6JWpC75u9oLgv5GCWCBrxyF6wi0INXtgRqSD6nR+9Z6GIBJtvHFQgfQ
         d+7yAjw8ZJf9E1+RmUHZbk8Wxi0gTWr8utmrsQIiNnaMydl3uQvzbsttNtAgKhDA+Msc
         jtWZIq7vJXTRUkA7/q+kFSMs23lMlEzcCaabUGSVVWrX0JmKEtzYQBcd6DthOo7Rhf1o
         Lc/quHnUw98Lq04EG4BFJaeopAa+CXkWLEzRu2owRzpeC+wjC0+psVyae8Y7LIgTANpI
         Z2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=B7z26XIqnnDQkHMdYCIbF/h+gJRRyxIq0yn7zncBJrk=;
        b=8BUti9//1LjYTAoOct3W0eAP3LJ+0uqXk/BKvGxIgiSlxAn93h3sFY2N/awlXFKhbj
         KmAQGTpLOjpJsc3H2GS/y8GljeR6kA1MNkk6XwAceVe3AljLA8c8v+dkELjlqZAW6pbJ
         iGZfefdJSZdSFNR4OmRSCuItcOpgRO3YP4FT+ynJxb5Xf8TOwG1AChUDv9La+iHutVcP
         oBJZo2xWUxau2Nw6lIloY3GFUH0WLBFQpMokM58CAEleB+0XRW1lC6hqZwLtnA30TX+l
         p1jIzOFgcDb5LoSYEsSC2mox++9pYnKWYxqV0TfWc6bHUjvFWN2+GVJhMDYXRUTfkPlZ
         zZYw==
X-Gm-Message-State: ACgBeo0X2CihXSlrUcsLLrhA3ViHsvZDq2oV1PGEzTm2Ces6dAR4wiik
        e/M/UMwLlemcJgCs5OtF0+CQhKXTG4erQuZKdjw=
X-Google-Smtp-Source: AA6agR7If6K9Ws6GFJM7MlVrzvzz8ToSXYYqOTNTvjdSnv+hnybpiixcbqyrkD49BDTHw0jsFVHfZPHkjTASrhb6ZCg=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr13249125qko.383.1661889413770; Tue, 30
 Aug 2022 12:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com> <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
In-Reply-To: <20220830180054.1998296-3-kumaravel.thiagarajan@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 30 Aug 2022 22:56:17 +0300
Message-ID: <CAHp75Vc=D4GVmQ+ohk21iXPGvXMex3WLcRGtquy57D-e4fx-7Q@mail.gmail.com>
Subject: Re: [PATCH v1 tty-next 2/2] 8250: microchip: pci1xxxx: Add power
 management functions to pci1xxxx's quad-uart driver.
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeremy Kerr <jk@ozlabs.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
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

On Tue, Aug 30, 2022 at 9:01 PM Kumaravel Thiagarajan
<kumaravel.thiagarajan@microchip.com> wrote:
>
> pci1xxxx's quad-uart function has the capability to wake up the host from
> suspend state. Enable wakeup before entering into suspend and disable
> wakeup upon resume.

on resume

...

First of all, we have pm_ptr() and pm_sleep_ptr() with corresponding
other macros in pm.h. Use them.
Second, if you need to duplicate a lot of code from 8250_pci, split
that code to 8250_pcilib.c and use it in the driver.

-- 
With Best Regards,
Andy Shevchenko

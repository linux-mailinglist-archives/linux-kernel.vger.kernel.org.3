Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA0550735
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbiFRWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFRWCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:02:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D3212605
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:02:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id e63so5493022pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9MEw8P/KO9fv9CIVm5BXX9V9CsXGvLFHrT2r30cWSdU=;
        b=LasUnXR9VPTMsAREIepo26bB3na8nPyR53896mHfb4W/6XoG50/Vyj9V0gysSXpgNI
         nmh2uCwKx/O6J9k1tlbC1k99fo4kfsV16M1dDY3kCJVx7u91ODvg05ctw/WLQAOBGv86
         N2wAWRMmT7/ckWucdqiPyoWTF78cFT9fWq0RehTJuuuL2ady70qp/hD06C/03lkjpn4F
         GBw54tNxftav/D2HIWROigoft21GPBsRk43vmZyUJpbFO7a5rftDlEWJgB1AfPB3PNua
         ITOTYVeLgTHuheucDczscn/YYoGf49VaZy52ztDfZIS2fRTzjy4AebiQe/DWpAeKTAXD
         Y9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MEw8P/KO9fv9CIVm5BXX9V9CsXGvLFHrT2r30cWSdU=;
        b=GMwt9GC7UmfqPKJY0FYmbp/X69fitA21DijNtTQYCCgFS1i7yiO5d8MqkBNshMLgGU
         27KOcVCW7eydiv4D4/ALM8ib36J1CSURUgCEJb5nPYjCgGNZCJjNdh229M+uefFm+hLV
         5j8uGHMieSxJfWBAr5BpPagpBvpPx8R5BvAD8NSE3xE0j3BoglFpdK0ay8J29ZcWRyMv
         xCYqrvNnN8VNr8i8/u3uHfb/EGIczlfv2dh0NH2m5GNC8Gevtt/sxDeP2uuWaHsp4ROE
         cp9p507iqzqJfyQnmRxFS2mE0m3DVmNSq3Il2wI9lkTbTP2Tmq41saot2UkB3WFGAenS
         pdYg==
X-Gm-Message-State: AJIora8jY2050Sv0YHCglwl2eYlYTgvb9l/GWhdIwqoFI49+yp3KXClt
        yD2k1f6Z77eH9aXt61H79zKA8+Ic8GwIXqCTtXc=
X-Google-Smtp-Source: AGRyM1tOrL0NEiH6HJjIvdQMQs26qGqnJpkpGwS8b9jQEZdo2fycTRUdvTmqacnyJmopCUWFNqnZdZjVpSJJxsjxom4=
X-Received: by 2002:a05:6a00:c88:b0:51c:1001:65f9 with SMTP id
 a8-20020a056a000c8800b0051c100165f9mr16762904pfv.66.1655589720270; Sat, 18
 Jun 2022 15:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220617115323.4046905-1-windhl@126.com>
In-Reply-To: <20220617115323.4046905-1-windhl@126.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 18 Jun 2022 15:01:51 -0700
Message-ID: <CAMo8BfKEtH3KrZPsUtDxZmYjqLt_ik09R8MxZtptgrxK=6xC6Q@mail.gmail.com>
Subject: Re: [PATCH] xtfpga: Fix refcount leak bug in setup
To:     Liang He <windhl@126.com>
Cc:     Chris Zankel <chris@zankel.net>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 4:54 AM Liang He <windhl@126.com> wrote:
>
> In machine_setup(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when
> it is not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/xtensa/platforms/xtfpga/setup.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks. Applied to my xtensa tree.

-- Max

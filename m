Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DE958A4D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbiHECsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiHECs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:48:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00904220F6;
        Thu,  4 Aug 2022 19:48:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d16so1462636pll.11;
        Thu, 04 Aug 2022 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NJmpSabGYVySx6BZBYlXrVGI+AUkhQcvqbpP5TAjxAs=;
        b=KhuBnWDMJyITR1swyC10Dikh3DeQ8Cps4R1NrejKNF+SrrvfRiRUynX4tqfzZ2yoc4
         5Za8ftfsBAfx1IHMMaRWgHYBJAfP0/u6vjmZ9TCvx93nb26PvslquXUH3Gsr20sHBlYc
         qr0mkZGH44kWj59dMALKKCB1WU7EVnHy7ntu9ck7tZceaTdTKqJDw2LilCv8DfbRz6TC
         YSE8duWnL0OvXvSbsvJctfOuHa3bED4hXQT5qFKc9ZTeBFkh2zm+CgEIZDrZbC2EQDuv
         VdIIeMf/MaEfLgjpazk1lZWlyrcPI+1omNIJjv08cJIuG3Wz51bDaweV3eAa8qRiGn0v
         NLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NJmpSabGYVySx6BZBYlXrVGI+AUkhQcvqbpP5TAjxAs=;
        b=OZL8VK+W2+sSWwKthuXYjajqbN/r0q8+rxh+IY9h7+ia5adaO4nJqiiu6SQAiMO5Lq
         3ggGSC2EhYXxSKlB99FsprHi61xUpUTc7co6TkYB5TGazBypoKE4HUK4QdeWw0IfTcQC
         d1wpyLAD6zussifhixNcNB8vackq2hWxACXtnOfWs7vNUGnXfdiTGPXGmjRysf6l6EyE
         mEqioB6TSUMaC1aYeABqjOx3eZgCPhFf9lIqjsUSNKTHmatubg8pT7vWP+/zIadHhOok
         1J68+j2UOZwAq8hsQtyVEF+p/Ld0NppsfCPARhgCInHaby+p/mtpw4ersJToJfYMzha2
         BcXg==
X-Gm-Message-State: ACgBeo03D5tpDbD/IJJXZ2pqrSd4yG9wxESUaMFe7/d5aJTQJl+MMek1
        oGHpWAx7CTdjZIOhdPPz7ZI9wDj5g/IOUfjLx99JsFqwqoyyr6Y=
X-Google-Smtp-Source: AA6agR6gZikLvwmG4YAjYzlgW6RPbub+vhwTLBM35vXf/i9hvAAoKYKKSKGO1wlYtRNMJMFVbIxfKOFU5KSteImpazk=
X-Received: by 2002:a17:90b:388e:b0:1f5:40d4:828d with SMTP id
 mu14-20020a17090b388e00b001f540d4828dmr5379294pjb.31.1659667707464; Thu, 04
 Aug 2022 19:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220804124125.3506755-1-zheyuma97@gmail.com> <YuvbI8NEpzciTgfc@finarfin>
In-Reply-To: <YuvbI8NEpzciTgfc@finarfin>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Fri, 5 Aug 2022 10:48:16 +0800
Message-ID: <CAMhUBjnf6T=eJAhkOW=TOKBTjQojCmNwMB0ekOss8yf65aRBTg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix bugs in *_set_par() caused by user input
To:     Ondrej Zajicek <santiago@crfreenet.org>
Cc:     Helge Deller <deller@gmx.de>, adaplas@gmail.com,
        akpm@linux-foundation.org,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Aug 4, 2022 at 10:43 PM Ondrej Zajicek <santiago@crfreenet.org> wrote:
>
> On Thu, Aug 04, 2022 at 08:41:22PM +0800, Zheyu Ma wrote:
> > In the function *_set_par(), the value of 'screen_size' is
> > calculated by the user input. If the user provides the improper value,
> > the value of 'screen_size' may larger than 'info->screen_size', which
> > may cause a bug in the memset_io().
>
> Hi
>
> I did not saw fbdev code in years, but should not this be already checked
> by *_check_var() ?
>
> arkfb_check_var():
>
>         ...
>         /* Check whether have enough memory */
>         mem = ((var->bits_per_pixel * var->xres_virtual) >> 3) * var->yres_virtual;
>         if (mem > info->screen_size)
>         ...

Thanks for the reminder. But since the user can control all the
parameters of the ioctl system call, it is possible to assign
'var->bits_per_pixel' to be 0 and thus 'mem' will be 0, bypassing this
check. And in *_set_par(), when 'var->bits_per_pixel' is 0,
'screen_size' will be calculated as follows:

    u32 bpp = info->var.bits_per_pixel;
    if (bpp != 0) {
        ...
    } else {
        ...
        screen_size = (info->var.xres_virtual * info->var.yres_virtual) / 64;
    }

resulting in a very large value.

regards,

Zheyu Ma

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4804BE9F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiBURqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 12:46:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiBURpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 12:45:33 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB9113D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:45:08 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id u7so8225984ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hGws8VeC3tIONMbk0280O7wxxVhyCbiHV3e2/1KcqOo=;
        b=M8uNRRjYG17Dxw4dNTNI8cyfXoY0brICmbxY1sKwZcx8ovw3m4YFAjAkiX32bHmOQx
         WbbMZvzKyJJR81nJ4F81z7aHsD25vUo3UghqLuSzlE6pFBm5qoF/HHW+Mr/f7KeBP5AH
         dMqxKliQFafbzZxb+K2eLbFKKneV97hnQy5/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hGws8VeC3tIONMbk0280O7wxxVhyCbiHV3e2/1KcqOo=;
        b=yUv0/UcBXqN5BuA1aIv5S0OtsYWP2moI6KRamYN/EZkkVhxQkdeJY5x59scBOu8c1K
         VKEezx92vvYWFDaLF8EsrU0cRYG2nGOMR/GjHc8qvayHwnWH56Qr0W90QtccexP+xiCH
         jSd+CCj6QUFInLEc2RRkg1cbni3Udeh0ZJ7cW60TgjsNCd33aOLEGlCpie/BeRBYA62N
         KgR6MFzsqYpuJlUJLNo+MzBZFIhhNVGK6yU+YGgRdPc7wWaTwTn5Xr0rp2tf+bhom6ID
         xjLxnIVD7auSQfmNdNtasqH0Uq0hS3hm7GLVCG6U9/WNOJXMI1qVBug1c38kjpPNkUGf
         3CFA==
X-Gm-Message-State: AOAM533OUX6yCJGO1xuT6jftpbPkJKhJcOOIPUZjRSQA3eKI89ARDGu0
        SsTeQtlRmu76Q7AaOjPkmo3GqZOnK6aNEJ3q
X-Google-Smtp-Source: ABdhPJyGMFvwQhIGoiMXS7pF5wZHML5bFemssxRcdN69WPV6lTqtIeYLx5eIYPy2X8tkVRyZSP/HNQ==
X-Received: by 2002:a05:651c:17a3:b0:245:f39e:f2d2 with SMTP id bn35-20020a05651c17a300b00245f39ef2d2mr15402594ljb.490.1645465506873;
        Mon, 21 Feb 2022 09:45:06 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s9sm1167484lfi.137.2022.02.21.09.45.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 09:45:05 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id bn33so15734590ljb.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 09:45:04 -0800 (PST)
X-Received: by 2002:a2e:3013:0:b0:246:2ca9:365e with SMTP id
 w19-20020a2e3013000000b002462ca9365emr9237427ljw.291.1645465504568; Mon, 21
 Feb 2022 09:45:04 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Feb 2022 09:44:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWZ=3dTuRq46KvQVpx-e7xqrnMAVB73dzj7g4Pbwc1zg@mail.gmail.com>
Message-ID: <CAHk-=wiWZ=3dTuRq46KvQVpx-e7xqrnMAVB73dzj7g4Pbwc1zg@mail.gmail.com>
Subject: Re: Linux 5.17-rc5
To:     Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Fixed the subject line - you answered the wrong email.]

On Sun, Feb 20, 2022 at 6:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Build results:
>         total: 155 pass: 152 fail: 3

Grr. Things are going in the wrong direction here.

At least the two new cases look trivial, and that ppc fix is finally
in linux-next.

> Qemu test results:
>         total: 488 pass: 427 fail: 61
> Failed tests:
>         arm:orangepi-pc:multi_v7_defconfig:usb1:net,nic:sun8i-h3-orangepi-pc:rootfs

Adding some devicetree and otherwise involved people to the cc, can we
*finally* get this fixed? It's been around for all of this release,
and Guenter has done a fair amount of bisecting and testing, chasing
down lockdep reports etc.

I've been ignoring this on the assumption that it will just get fixed,
but it's starting to be pretty late in the game now..

>         <almost all mips tests>

Gaah. And what happened here? There aren't even any MIPS changes in
rc5, so clearly something went sideways that just must have happened
to affect your mips qemu tests. Added Thomas Bogendoerfer despite the
lack of commits.

               Linus

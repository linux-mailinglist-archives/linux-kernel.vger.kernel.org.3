Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1754CC704
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbiCCUV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiCCUV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:21:56 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD717226C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:21:10 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id k7so4937646ilo.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5J9I65UbkqTgZqocupgFMVrh/v13xuePEj3sqiuHDrE=;
        b=ZOBR3gtw9JcM8CEtuun1vNHrFqCEdh2rIbArXdNAJGIWEKf0GdH5HSVtA4ZOsoQQiX
         YaW2jUZeiIo7D8WKv5SyBGM8fg62zv3bPYNIl7U0gHKMfG00w1SY0gPTV48jOK7KHlZc
         WIBdGFrESjjtJE0x2jd6cwpcFBkbA4vLS0yYgqawFJbdsOsXDtiyJwiZ6fAc/XJPnCE5
         jJ0VCxB7r6gmmB12SnsRHObPNPAkxXrzrwkG+RtZ1IvgArAd63ut33oxxuW7ewiCTzhA
         KTN221iOgq7l1dmF8UEKFWkVFdEZPaV7mTfj2sLI8eGC/IKPOzuTDIy+tpbqypWfyv5W
         iP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5J9I65UbkqTgZqocupgFMVrh/v13xuePEj3sqiuHDrE=;
        b=F/u+d84T055YJ0+9dFS+jrSfSkj3mhSqEzuDZCN/ZskOQFFP4/fuqMy5iAC4Sg58mc
         6RdyOVR7xjB+gol76+ZSGaSPp2yhTu822a7tD4UFPkCRvEKBKErOe1v6QbN7u4gxRO+D
         DEf/+LrSd9UipgWdLuAET0NAxQGSt2pakGMPi6brDu0d+T3fqj9BiP+++Cj1kLXk1cQh
         fri11Ls19Sr5lmio6YFWaWxRwBox4En8kWuqXs2zw8UXfKstgxlEVhRZd5OwmqdxA3qj
         ASXaFyuSPA3o5WHvaiIDuyVlP6f39qfgUYYWpJV5rPzTA6sMqTYinDSQUGUqDv3Pc8RD
         AC+Q==
X-Gm-Message-State: AOAM533MOzsuoX+eiIpBithtqM8RaTJLr6aGloKiqPfjfbarL2Jy6TXH
        0dxlH1fmPKg0xH1900vWTEOwHzm35l4g/ggal/Q=
X-Google-Smtp-Source: ABdhPJzj2w9/2PtPTXxAMO/2MMUQeXRz+pq2aqDVn1Da8Cy7PQpZTUlFbqh9YmfxHQjc/U+CqGBdv95lqiqwW+vZUrA=
X-Received: by 2002:a05:6e02:1bc5:b0:2c2:7bc9:8e8f with SMTP id
 x5-20020a056e021bc500b002c27bc98e8fmr33286489ilv.5.1646338869676; Thu, 03 Mar
 2022 12:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20220303173935.100622-1-cmirabil@redhat.com>
In-Reply-To: <20220303173935.100622-1-cmirabil@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Mar 2022 21:20:58 +0100
Message-ID: <CANiq72mcVrnm2bBP530c6rKfGzQj1vAJXgizQgk7f5G4X0SkGg@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Raspberry Pi Sense HAT driver
To:     Charles Mirabile <cmirabil@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
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

On Thu, Mar 3, 2022 at 6:58 PM Charles Mirabile <cmirabil@redhat.com> wrote:
>
>         - Changed userspace layout of the display driver to rgb565 triples
>           and removed the gamma table lookup and the associated ioctl. If
>           the user wants to recreate linear brightness scaling, they can
>           use a lookup table on their end. Doing this also removes a lot
>           of error checking and general code complexity, so I think removing
>           this feature is actually for the better.

Sounds better indeed! If I understood correctly how it worked in the
previous round, it should also allow to use the hardware to a fuller
extent.

>         - Replaced if statement with call to `min_t` function in display
>           read and write functions.
>         - Replaced the custom llseek implementation with a call to
>           `fixed_size_llseek`. Thanks to Miguel Ojeda for all of these
>           great suggestions.

You're very welcome!

Cheers,
Miguel

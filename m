Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F849EAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbiA0TSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiA0TSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:18:43 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60CC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:18:43 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id h14so11641286ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=howett-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aC48KH6V3XmmrT5/w0oKx66CGk7WIL8m2w7STuh0meQ=;
        b=XMu4tnK4KcSZ1cna9kqFgZQ/Lg2E2brBZoo2IG6n2aXNSOHuY8m9o+dKKynxoHbdLb
         OlkQ4LRByKDvLab29KtkAU/Eh2gYrhNCiFWjntCYXNglgHgiuKG2fllcuQiSRoZcT4wX
         HdQpnxTlkiwmDhzyggWAUnEJ4E0Thv8ltMqc1u3URsFVjfxDFsFpiWXiVpPXuVckB3SY
         r5Q//XxkPXdHKXfSHzCp0Km9iOPfKwOyyRRPmhVsbMtIv0FWZb+NPw3UcFqIuM/vven8
         sGAHUBDNQ3DjICuBcb2XyKgQmpzQSpx3PWjcw9Sp1AUgY9sKGHs2jzpstgQ/OczCYsOO
         6bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aC48KH6V3XmmrT5/w0oKx66CGk7WIL8m2w7STuh0meQ=;
        b=gfzXGLbPlI9wnmzocA6xnXIQosrTWlCUG6123xwtrAaTe70A8GIrVY7JeOq1RuEGmP
         KBRWwC3VSZ/DIPnspTG9kVISf3weUAlcGjntE5mzhTmbwjMdiS/dw2h3BGPqqvHGXBh5
         t4QFm7HcZgy62NP3/QGWMUm0i7mKLFCM0wTKWHMIV3BsCXW8+8kJbTl3nnM5shWeiKj6
         xoRf8fQWDQRKQzBcMZC+EJ5OU+Fj9VW3YCWuKCxWtO//ABUYUW85ZnDpxEos+5QaJQiX
         dXv/hyQYF0yIViWKN+OnsT8K0pbZMxU40mLjXwZaTrV2bQocDHJSoOgXsbrKtA8R9/8z
         MQdA==
X-Gm-Message-State: AOAM531QVV92Ng2Kx1d9uP05I9FdFoHNfYx9Goo1LiUvZ8yR/5VCiJvh
        DH+PqrQErqHWK82wsGG5g3WWx2PRFwUuSBKZ4mzKNw==
X-Google-Smtp-Source: ABdhPJxK1x+ykwISdwoZ+vrCN4Ztz3s7awgLGueodNCqxDFjDiC/Eh2khNlRmO7T1/XCN8eKLbeHAB/Frha2qGh8Plc=
X-Received: by 2002:a05:6902:154c:: with SMTP id r12mr8040586ybu.674.1643311122667;
 Thu, 27 Jan 2022 11:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20220126180020.15873-1-dustin@howett.net> <20220126180020.15873-3-dustin@howett.net>
 <YfLqloFQpF7bURGi@chromium.org>
In-Reply-To: <YfLqloFQpF7bURGi@chromium.org>
From:   Dustin Howett <dustin@howett.net>
Date:   Thu, 27 Jan 2022 13:18:31 -0600
Message-ID: <CA+BfgNKS_uGZVh5K=O5Q-Brj-wWyg+gn1Nx4-Gr5OVb46ZFi=A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC LPC
 I/O ports first
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:55 PM Prashant Malani <pmalani@chromium.org> wrote:
>
> Hi Dustin,
>
> I can't find this update in the EC code base [1]. Is there any reason
> you are not adding this, or is the change in flight (or in some other
> location)?
>
> [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
>

Hey Prashant,

The host communication adapters in the EC repo don't support the MEC
protocol at all,
so it did not seem necessary to bring these changes over. I'd be happy
to do so, of
course, if that is desirable.

My understanding (well, my guess) is that protocol support was never
added because
it is already implemented here in cros_ec_lpcs. Userland I/O port
access is(?) less desirable
than having this driver handle it.

d

> Thanks,
>
> -Prashant

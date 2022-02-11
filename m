Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C244B2F68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 22:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353735AbiBKVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 16:32:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353715AbiBKVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 16:32:49 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC699C61
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:32:46 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id c6so28756278ybk.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlMNdPedHPycBXQ85x4bFGxtLOLbRfBW7nz64ipbjBY=;
        b=R7+8WmZ8z5W8QeBvnhcVZ9ocPoXPI4IfaWnDSFcyXbagwpzAg5QoJWGBcQQg4gg9fN
         37CodB/qEUvKwV+uvKXESNth5g8mJ0DTtf5mxdzJeJcXuwJmbZ/axGotqDdWbrFB3UR+
         S6nOx8DCf7bOcLL5M9iyQv/IqY0FCH3Ow15F0CVHiOvYKlSeAEXYYh1hvgGdmZsxdDK8
         udCxlM79RY0G3/7HTCxNPYex8uJf18qSsKx+od7ygwGnPTymwfUW/1V7JM0R5u4FS3DV
         c/XWdiOymV3d2+e7RWsbqDAm7omrwEeZo88/Nw/nRfTU0DO3vIBqwN0S282EFs5il9Ma
         YFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlMNdPedHPycBXQ85x4bFGxtLOLbRfBW7nz64ipbjBY=;
        b=G1qsngiuRmDsX3z79A8wdXIa7IaB7Rz1AmQqD7KVdXXdz1LF353TyN9H82KZfPeJOJ
         4nau5ya/3b0pc+3VIoAx5N8X0No8dBhpRO4GjDBRVvdYNcc1wuW7BwUAtx7z7pW3eFPb
         jSSjTv4oCetMV+Tz5P5Nd2N/9FCS9le4/lGJe0SSATbCZyCBYcwhQPFWlDC1AOI4BYtW
         R+qlraMm/POzWPUjtb719za9GfcshZoSY/0n2y+9FAKqCPG6n4UOe4OSPPFelI6qsqWa
         KQxZRfyoxz0tJTbgVBjlALxthtoyFfpm9ADBW/DKeRtE5ra9i7rHwlf5z6tg4Xc4V22X
         ZjDw==
X-Gm-Message-State: AOAM531Z7OspoguIHmTkh0+f6UeRZf0VKd78YGecqiXcaftZGUhV1BRN
        uWMmtFAgRzpZcPTRDEz3rAvvGCuPp8EBdmt+rcvNIw==
X-Google-Smtp-Source: ABdhPJwxt/ccwzQXgeYQSdW1n8H1uNZN4bQTPzzBDg4pfrNxnshkiT6JI3ZaakqbnLo8Pph2JwGiM91mGnY6+KkRScA=
X-Received: by 2002:a25:684a:: with SMTP id d71mr3340888ybc.284.1644615166048;
 Fri, 11 Feb 2022 13:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20220124131346.12571-1-linmq006@gmail.com> <20220211200404.ywlfdj2pybtnmezp@mercury.elektranox.org>
In-Reply-To: <20220211200404.ywlfdj2pybtnmezp@mercury.elektranox.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 22:32:34 +0100
Message-ID: <CACRpkdbOdVbsFPEJ3vScG83Uyd8cGYNcRU9o11WHbjkZ07neNg@mail.gmail.com>
Subject: Re: [PATCH] power: supply: ab8500: Fix memory leak in ab8500_fg_sysfs_init
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 9:04 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> > Fixes: 8c0984e5a753 ("power: move power supply drivers to power/supply")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> > ---
>
> Thanks, queued power-supply's for-next branch.
>
> Linus, if I'm not mistaken the custom sysfs ABI (i.e. everything related
> to ab8500_fg_sysfs_init() can just be removed since the same thing is
> already exposed standardized via POWER_SUPPLY_PROP_CHARGE_FULL and
> POWER_SUPPLY_PROP_CHARGE_NOW?

Yes, I delete other weird custom sysfs, so I'll cook a patch to
get rid of this too.

Yours,
Linus Walleij

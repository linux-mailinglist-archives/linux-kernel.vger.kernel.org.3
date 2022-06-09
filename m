Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70C54458C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiFIIUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiFIIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C582B3B7E7C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4013F61335
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D446C34114
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:20:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EYtWQSgb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654762845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HTw/gzxaEhLz0nOO9Yj7AYPfaN2PQMST+llLMdzvydw=;
        b=EYtWQSgbPAUzIQ2wOciMa+e2kTiux9AzFT975Rk5Sjd67oALzPSbeAwjjwrtU/pphEZeKN
        H/auFZ50/S3m1XKEliNuIetYpeX31YgK/vH6+2v5wKBjtSYASBj4hVuNyZ8wX3sDdh/xFF
        6K/ANd16GVjNVWMfWzk7NKJoVul7C8g=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 405f423e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 9 Jun 2022 08:20:45 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id v22so40542762ybd.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:20:45 -0700 (PDT)
X-Gm-Message-State: AOAM530mNOF2ztYz44T67Vt+7AIWfeOOOAI0XEGn8VvpF5dsJTqHUK7j
        L9TVOKQ5nt0EtC/YOwuZP9EXK/LjHNOmpTF5EjM=
X-Google-Smtp-Source: ABdhPJwavQ6tDj1c3W2gP6rzri/NSuiXE0/Aiadbq+tXb2epGwQOC3X2d2qK5Top6IhY7jfK/xTXrPuTTgE/QZt/DZ8=
X-Received: by 2002:a25:83c2:0:b0:65c:bc75:800b with SMTP id
 v2-20020a2583c2000000b0065cbc75800bmr38694681ybm.373.1654762844293; Thu, 09
 Jun 2022 01:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
In-Reply-To: <Ykyf5Zuz1W8yHhNY@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 9 Jun 2022 10:20:33 +0200
X-Gmail-Original-Message-ID: <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
Message-ID: <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
Subject: 2 second nvme initialization delay regression in 5.18 [Was: Re: [bug
 report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR observed
 during blktests]
To:     Yi Zhang <yi.zhang@redhat.com>, alan.adamson@oracle.com
Cc:     "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On Tue, Apr 5, 2022 at 10:00 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Using a Samsung SSD 970 EVO Plus 2TB, firmware version 2B2QEXM7, in case
> that's useful info.
>
> I also noticed a ~2 second boot delay on 5.18-rc1:

Just FYI, I am still seeing this delay in 5.19-rc1.

Boot lines from 5.17:

[    0.882680] nvme nvme1: missing or invalid SUBNQN field.
[    0.882719] nvme nvme1: Shutdown timeout set to 10 seconds
[    0.885227] nvme nvme1: 8/0/0 default/read/poll queues
[    0.887910]  nvme1n1: p1 p2 p3
[    0.888317] nvme nvme0: missing or invalid SUBNQN field.
[    0.888361] nvme nvme0: Shutdown timeout set to 8 seconds
[    0.906301] nvme nvme0: 16/0/0 default/read/poll queues
[    0.910087]  nvme0n1: p1 p2

Boot lines from 5.18 & 5.19:

[    0.846827] nvme nvme1: missing or invalid SUBNQN field.
[    0.846857] nvme nvme1: Shutdown timeout set to 10 seconds
[    0.849043] nvme nvme1: 8/0/0 default/read/poll queues
[    0.851595]  nvme1n1: p1 p2 p3
[    3.226962] nvme nvme0: Shutdown timeout set to 8 seconds
[    3.253890] nvme nvme0: 16/0/0 default/read/poll queues
[    3.263778]  nvme0n1: p1 p2

The Samsung 970 EVO Plus has a ~2 second delay that wasn't there in 5.17.

Any idea what's going on?

Thanks,
Jason

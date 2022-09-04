Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633E5AC37B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 10:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiIDIsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDIs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 04:48:28 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3F043E48;
        Sun,  4 Sep 2022 01:48:27 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1273a47cdb6so1323742fac.13;
        Sun, 04 Sep 2022 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=dGmayfXc9w/lfNLKggje5mvDJdeDpyPvfT6beacitTE=;
        b=pJAs11c3l33RJL77Wqdaa+JvCT/GqfBuF0ZJYsoPdRjL8ctZFCJLK39J532rfKN2yW
         uwW0eDK756uyD7Ys+hMocd0ymJF9wUJHkPUdp0bEP65c5EtKuCSHP0rzWrEU4OG2a1Qx
         7qHU1t93qSVusyRqDooXhIolTJ26zV+pQ1rtpQ/TPXcJzsqZmOLnLvexSm4oVLvjCFae
         /8OJ/9/AvQer9XWK49LjuAzrWP8+R7FBN2d7zrz1eXKRX8hGkYlSvyT9acg5wemX9eHd
         hbUdJFu8ZJ16mwbx+fomesul5MOmFTjR9SqOAuVyfF+FcRCbBiwIs/twjBUS4KvayANi
         Bcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dGmayfXc9w/lfNLKggje5mvDJdeDpyPvfT6beacitTE=;
        b=228pq/DlEob+3Rr6PR9jq2VOmO46SeuaN3qvRkDcUzI9MHlKr6hBopDC6UYiNU7XcB
         NtcgiMcCkNTLOHAeWDNHs8CVdv3x3FMWylo1xWkMtyOfGZmVWFxANuj+dSEx9j8HCiB4
         oE0v9dnNB7CP+VyGhJyHbPEGZyY5yRZ6U6ytmR9wMDUowVJnkhUB33tbbg0Q1C0lT4DO
         /cDh8aDqvjE21/xd7VK8R6HtQ0HZ/d3cFaDQjT7HpOb7B2qsGOLOcPAzhQbvzbBCbKM3
         0Rk188Qt/SJ1y0a4G4RiEB57PwGXdMF4p0D8IcTCUWCh2/3v0iBhH/RdYuTLfGRTE3Kr
         Oacw==
X-Gm-Message-State: ACgBeo1uOPUfiMRkCsEct4STNV35tjgukx9AJRa4oltEJjE3RFHmtZxs
        WYg0EV+Q/zufP3Owjy7HzlP7Vli5ow0T/vyBeks=
X-Google-Smtp-Source: AA6agR5HItE5b9HOyknTNTcGei9/A5ATki8diaYMjR6pMorNY/bbPVSjJTN4QneULu0B2AH9AsK71cyWLXQUgibnKFg=
X-Received: by 2002:a05:6870:3486:b0:10e:62b:159a with SMTP id
 n6-20020a056870348600b0010e062b159amr6536755oah.254.1662281305739; Sun, 04
 Sep 2022 01:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220822141110.17199-1-91tuocao@gmail.com> <YwORy3QMbRUSlBZE@kroah.com>
 <CAEVeK2AiYFK9eopn1Uzp+osA-j22e1KbfUohJ+hRVmLNsq0gpQ@mail.gmail.com> <Yw316/3zuIXvm/Ty@kroah.com>
In-Reply-To: <Yw316/3zuIXvm/Ty@kroah.com>
From:   tuo cao <91tuocao@gmail.com>
Date:   Sun, 4 Sep 2022 16:48:13 +0800
Message-ID: <CAEVeK2DfcvguQ__GroRY+erU+-4=ZKvPBf1V2poRxUF77G60OQ@mail.gmail.com>
Subject: Re: [RESEND] serial: 8250_bcm7271: move spin_lock_irqsave to
 spin_lock in interrupt handler
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B48=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C 19:35=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 27, 2022 at 05:42:19PM +0800, tuo cao wrote:
> > No, whether it's spin_lock_irqsave() or spin_lock(), the security is
> > the same. Since this commit:e58aa3d2d0cc01ad8d6f7f640a0670433f794922,
> > interrupt nesting is disabled, which means interrupts has disabled in
> > the interrupt handlers. So, it is unnecessary to call
> > spin_lock_irqsave in a interrupt handler. And it takes less time
> > obviously to use spin_lock()=EF=BC=8Cso I think this change is needed.
>
> I have no context at all here, please never top-post :(
>
Sorry for causing you trouble. It should be OK this time.

> And have you measured the time difference?  Is it a real thing?
>
Yes, sir. I have measured it, it is a read thing. The test code and
log have been put on Github, please check:
https://github.com/tuocao1991/api_test

> > Finally, I'm sorry I lacked real hardware to verify it and can't
> > provide changelog text.
>
> Try to never do changes for drivers for functionality like this where
> you do not have the hardware to test for, until you get a lot more
> experience.
>
I got it, thanks

> good luck!
>
> greg k-h

Best Regards!

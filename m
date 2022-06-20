Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B71551606
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiFTKi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240922AbiFTKit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:38:49 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5FB1400F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:38:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l192so7470582qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IrCv3Bm8glJHfuCDfJUKntuSC2uZKfAg4mgZ3vW4W70=;
        b=ctqmMavVUzj1XSQ2JoA3Jy6UppwhH6jXKTEnTFPAaJE1iKYHVvbfrcXJGDkEzm8cXh
         C1pNt94D+zeGPsVInbFL01ckuv+5YeWi3RvCJYckdfyLDHYljteOFvfsJxzvORKj0qQH
         ccmSjCGsM2cnGqkJNM8BDo7pUTGvZn0RHgBfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IrCv3Bm8glJHfuCDfJUKntuSC2uZKfAg4mgZ3vW4W70=;
        b=L4fgEUnrKBmFUpddZmNRkD/21t3giewAg3TX8hKTNjJ0oUoVjvdLY01blqoCvynhRE
         4UwpTOOw3pAmkCbYYGnVTytRR5UeyWIcGozpzuaAhfm1pXtEMdQTm61hD9boplrWmTkW
         cNscTy9Hrvps19Z27R/gcW4jU950QElOVjWf60+I84zXcGgHY/eBW/VnQNJOQBHVN/8I
         Qw18AnbExIjOjEJIv+tW7thtPB+PtZTlVS7MglC2ZgVASuGA3cWyAAqACTYtUK9K/fda
         SNrXQ5ex+NuVrO+QxPf23OPvoZF/YBtVzRBJ2xuPHd+ENA9+HSPx0i60nMxTMshOiZHs
         MkYg==
X-Gm-Message-State: AJIora9M9QdNc6iCq8z8s75XkpP6c55rqLBa/HVwNlcXZ5sCchu+jAlq
        QmvLwBB0K3OtHZA8/AEww1rKcaHDNwRFlpy6Qy4/LODzzRed5Q==
X-Google-Smtp-Source: AGRyM1vMk2pbTzgkwvmi5IXB4LVUVc+0dH8TcdCr/0E6Asvt4K0kiPdiY9a9w9bMCuJNheUI0UF2tqTVgK5j38K+GDA=
X-Received: by 2002:a05:620a:40c9:b0:6a7:84a6:11a3 with SMTP id
 g9-20020a05620a40c900b006a784a611a3mr15612600qko.331.1655721527657; Mon, 20
 Jun 2022 03:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220619204949.50d9154d@thinkpad>
In-Reply-To: <20220619204949.50d9154d@thinkpad>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 20 Jun 2022 19:38:37 +0900
Message-ID: <CAFr9PXkVVYQ8+uxQF=42D7svnM95vzVoySv0pv22vH07m0VeNg@mail.gmail.com>
Subject: Re: Boot stall regression from "printk for 5.19" merge
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Mon, 20 Jun 2022 at 03:51, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> Hello Linus, Petr, John,
>
> the series
> https://lore.kernel.org/linux-kernel/YouKQw72H7y9EJQK@alley/
> merged by commit 537e62c865dc ("Merge tag 'printk-for-5.19' of
> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux")
>
> and in particular the commit 09c5ba0aa2fc ("printk: add kthread console
> printers")
>
> causes a regression on arm64 (Marvell CN9130-CRB board) where the
> system boot freezes in most cases (and is unusable until restarted by
> watchdog), or, in some cases boots, but the console output gets mangled
> for a while (the serial console spits garbage characters).

FWIW I have seen a similar issue to this on a totally different
machine/board on arm (Sigmastar SSD202D, "mstarv7" in the kernel..)
since rebasing my tree on 5.19.
I don't see lock ups all the time but every few boots the machine will
deadlock. Usually with garbage as the last message on serial.
With both serial and a display as consoles on the command line I could
sometimes see more output on the display but I didn't manage to debug
it.
Adding quiet to the command line made it go away so I've been doing
that as workaround.

Serial driver in question is 8250_dw.c

Cheers,

Daniel

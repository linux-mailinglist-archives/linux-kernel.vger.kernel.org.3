Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F014D0436
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbiCGQf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiCGQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:35:56 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C28DF5E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:34:57 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 55A3F6000B;
        Mon,  7 Mar 2022 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646670896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m70B0IH/7HmN66dahNn5qiOkRxfLpaUjjkTXUfTQcr0=;
        b=KC7PGef7tFC2T8yTNRAsmcz47gID67fAQs+MC8eJikmK04+t0Abzt4pZ/FFeQjnIm3lBis
        iNlclT7eXifvaCQJ8FiU8CQbO100C/WhTK6DfYU8UP4csN+P09Zw+o0UUTZHa3KTir1lGg
        WCryIte2NgVOfSlmwxkY4AflNCx+LUdE7Y2iBL1vjzqEEfELAD4bHNUhclS2oCWR25FxOZ
        5iPA7Jrrpb4Bplp4Irg8HakEAomNo8uDphun01hoXySpbQHgrc+NeXGXfUByQHAPmWGNyL
        wDQnf0mv1PCKnBpMY9Uhq+Z3SucMkF0yVVJZ5U3Zsy7rY8cDDzYSzUZtrviE7g==
Date:   Mon, 7 Mar 2022 17:34:53 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] mtd: Fixes for v5.17-rc5
Message-ID: <20220307173453.24a55573@xps13>
In-Reply-To: <CAHk-=wjweAonv54h4rxFPVReKS5qZkVCGfB80GUDPNKbo-uEqQ@mail.gmail.com>
References: <20220218153617.016a905a@xps13>
        <CAHk-=wjweAonv54h4rxFPVReKS5qZkVCGfB80GUDPNKbo-uEqQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

torvalds@linux-foundation.org wrote on Sun, 6 Mar 2022 12:08:04 -0800:

> I'm about to release rc7, and I still don't have the build fix for MTD
> that has been pending in the mtd tree since Feb 19.
>=20
> I'm talking about commit 7cf1de957a98 ("mtd: rawnand: omap2: Actually
> prevent invalid configuration and build error"). The lack of which
> still causes build errors on at least sparc64, and has since rc4.

I have received a robot error triggered because of COMPILE_TEST being
selected in a random config. Yes it should not happen, but no it does
not break sparc64 AFAIK. If it effectively does, then I deeply
apologize but I didn't receive this information myself.

I proposed a fix a month ago but it got rejected because people claimed
"nobody else used that solution until now so let's not try that". So we
went for another fix, which lead to the issue you complain about.

I then received another fix to queue on top of -rc4, which I did,
in a reasonable time frame. But then I had to wait for robots to
tell me if there is still a breakage with another random configuration,
and this may take about a week to happen.

Last week I was fine with the result and finally took the time to send
it to you on Friday. Yes, it could have been earlier. To be short, when
writing a short explanation for this PR, I realized the fix would
increase the kernel size for no reason on several architectures so I
asked if we could consider another way:
https://lore.kernel.org/linux-mtd/6c09de15-1ab2-5ca8-7003-69ff3f7c4dc5@kern=
el.org/T/#mec7f38108f189f4af5b865011d758a2afa6009c4

Thanks to the discussions we had today, there was actually a
misunderstanding regarding this dependency and the fix can go in as-is.

Should I have sent this fix anyway? I still think retaining the fix
was the good thing to do. Should I have done that earlier? Yes, I could
have saved a week in the best case. Was this fix urgent? I don't think
it was to the point of getting you (and now myself as well) frustrated.

> This is getting quite frustrating. These are basic errors that fail
> some very basic issues,

"select" dependencies are the source of many problems because of the
"I won't propagate the dependency any further" choice. Yes for many
simple situations Kconfig is well shaped but for any non trivial
situation it is not what I would call a "very basic issue".

> have fixes,

Not from my point of view, at least not while I was still in time to
send the fix.

> and the fixes for some inexplicable reason aren't actually propagated up.

The truth is, you personally cannot follow all the patches nor read
all the discussions. I am not blaming anybody for that. I understand
you have to ask. But I would personally appreciate if you could use a
more friendly tone; "getting quite frustrating", "basic errors, "very
basic issues", "inexplicable reason" are all superfluous.

Anyway, I am sorry for the inconvenience, I will provide this fix asap.

Thanks,
Miqu=C3=A8l

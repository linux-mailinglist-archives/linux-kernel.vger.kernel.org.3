Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7523F50CAE6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiDWODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiDWODA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:03:00 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7B2700
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:00:03 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id p65so19280420ybp.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2C1eFtKNGX8QEDYqrcJVwsDL7oT/Kam52huekmVegQo=;
        b=XTircMFL8zRWlN8/rGu9vK37+rPtyDeJfvoMV1EWVg0pBORBQGY5b9jTCUyhxKsMXq
         UQbNLgMoEV5wFnqN5ZlHKh9yv8+/nP++Fa/ZiXGSjVxuMNskc1M2tdJ9x7NDtsYd9cXh
         6PkKzvOa3dc9u7U+DZfgdbj+Ln5B1NDS2J+JwyX8NMOXdvzsj7b9kNDwemz9Yw83jwLI
         R/DTe730vmYbRC9wB0Du1/n8H+eMp891GNk2RWKuTECtV6N/52QhT+VZlVg6UQX++k6p
         aRkKZD8qJxwNGR8drt73gzUpuU1usUig5eaf6RVizLlrwOLABJEPIizHK69kLbRiEtot
         VxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2C1eFtKNGX8QEDYqrcJVwsDL7oT/Kam52huekmVegQo=;
        b=LszuuQHkGp7VGL9xWN93OhuMa+C36Mtqlo8yOf8ory3eMFuMrE5x+v7FdqZPsangyf
         InOlhthDCZ5K5F6/ZUSKxnEd6SvwwlnleH6KDgeatVatOFDEaL4l3B6k/Az60H1qR7Iq
         gOjJdEJn82+Jh8W6VD4NEUt1Ja9rd9U3MVta5IfGDUyhhYsDcLG22y65KOaoRtMLzjoH
         nrCZpx2YND3PZFpkg/XjhTM7v8fmEjlF4W+42GFK+CzMiNWhzU0wZciKsAkIsrI031XF
         DwBTGxrXPf6XZep6zv16Cysf4Q8tSdNYhLF4KJ6fk580ZcfUynM5HwAfXQLwDrsGZ068
         cNMA==
X-Gm-Message-State: AOAM5331F7mD0T7+w6AETnHvqoj6kH1vx9/Q6KyWdGu6+2gCuVCR3EBW
        B6wzRCKxreegVxqmWbnU11L/1SyPUd6fojsdEKNkcQ==
X-Google-Smtp-Source: ABdhPJw+6alGxQ5KA63kaNTSaD/ft5OlfJq36gmp979GfuKe4y2aNDOpk5mPA/+KIzk4Tl9zk70ZBdyuSaLzubWRIkY=
X-Received: by 2002:a25:e056:0:b0:645:d68d:8474 with SMTP id
 x83-20020a25e056000000b00645d68d8474mr6281907ybg.294.1650722402279; Sat, 23
 Apr 2022 07:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220423132035.238704-1-nathan@nathanrossi.com> <20220423152523.1f38e2d8@thinkpad>
In-Reply-To: <20220423152523.1f38e2d8@thinkpad>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Sat, 23 Apr 2022 23:59:50 +1000
Message-ID: <CA+aJhH0FMBfvaww3EZEwTwfO8PdWJKoDFF2s50-Pp8Tx-b-vCQ@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Skip cmode writable for mv88e6*41 if unchanged
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Apr 2022 at 23:25, Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> On Sat, 23 Apr 2022 13:20:35 +0000
> Nathan Rossi <nathan@nathanrossi.com> wrote:
>
> > The mv88e6341_port_set_cmode function always calls the set writable
> > regardless of whether the current cmode is different from the desired
> > cmode. This is problematic for specific configurations of the mv88e6341
> > and mv88e6141 (in single chip adddressing mode?) where the hidden
> > registers are not accessible.
>
> I don't have a problem with skipping setting cmode writable if cmode is
> not being changed. But hidden registers should be accessible regardless
> of whether you are using single chip addressing mode or not. You need
> to find why it isn't working for you, this is a bug.

I did try to debug the hidden register access, unfortunately with the
device I have the hidden registers do not behave correctly. It simply
times out waiting for the busy bit to change. I was not sure the
reason why and suspected it was something specific to the single mode,
and unfortunately the only information I have regarding these
registers is the kernel code itself. Perhaps it is specific to some
other pin configuration or the specific chip revision? If you have any
additional information for these hidden registers it would be very
helpful in debugging. For reference the device is a MV88E6141,
manufactured in 2019 week 47 (in a Netgate SG-3100).

Thanks,
Nathan

>
> Marek

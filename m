Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B90648AAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbiAKKCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiAKKCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:02:20 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8438FC06173F;
        Tue, 11 Jan 2022 02:02:19 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id w22so11101483iov.3;
        Tue, 11 Jan 2022 02:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YmlpQBVfySpCt/YYkAns1X1WN6EovAoYf8bIgONcDcg=;
        b=UbBw4wf53T+Uo1yqOpzWKAyMUtWUAKi4Kw19l8W5Z/vlOUelClaC+MlKo+ZuWhb6ei
         mqT6G9Xz5EMqcwEBnjT40s42YFdURzCnIth2t+ywuB8AvKV2XnFdc4EPTVmockGuJZiD
         wDOdwAf/IuOocSMpM2Wvfpp7jpumg+G8oHf2fG3cQEfyrh/tDluNESdHlaFs9PJO+ZU1
         /82wLNc50v9VRxZyr0alOiw6mGFte4/mV6N0f3rqOujXT5fiTsvcF9gKhBCXBb8m1Y3b
         L+r/wq8AiXaktdqZbs8Cw+RTwQgqJiGDrDIcXYvSlZouqtGK81V4+VGojseKeBiW5DwQ
         KPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YmlpQBVfySpCt/YYkAns1X1WN6EovAoYf8bIgONcDcg=;
        b=sNDVC8vQcAcrBzdAHni+wPrHdAUMLR/3bjFbGAWwJehuKhsa6TU+rnETHVmbrvpcns
         Fs8jBkf19NCHkXlQ6g6f3KLQR9r1A6QqPKmA7Q/gjnrCThLSkywDpeUKUlvdxswdGEs/
         fppZmCZ7M5krdlfjL4xdyNdUhKwNrD3xDIJHnpsXeik7SBUjEKrukuAXuSL0i64W7uSi
         mbwoRdZP0aKxX7twI7Awq9baeWq9etr4i2NT2wId9Ii6Yi0pYI+4lYum0TQdyOvGw2bi
         bSoAWkY5L41Dh4usl00/3QmCxh/h2gqJR3jrjo64ON84a4olA54kmiuqqSjt6PU4REqI
         A0UQ==
X-Gm-Message-State: AOAM53264oepa6sTVF+DgEQWYoUuj0h5x9tel7j9XTgLQLNvpFcof7Sb
        Bjs1nh3dg1YbSMhiRYwOHi2/v5BqLV5JkrHs+0M=
X-Google-Smtp-Source: ABdhPJyPov8/v7hiYlAGc60n72Zio2+eWIijGDHfzGsLcCrojJoeESesdRdL+54CVKalEgzaE0uQTZ74cpxlyVPkLGY=
X-Received: by 2002:a05:6638:251:: with SMTP id w17mr1836768jaq.315.1641895338977;
 Tue, 11 Jan 2022 02:02:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oSK5sVVhMewm-oVvn=twP4yyYnLY0OVebYZ0sy1mQAyA@mail.gmail.com>
 <YdxCsI3atPILABYe@mit.edu> <CAHmME9oRdoc3c36gXAcmOwumwvUi_6oqCsLmFxRP_NDMz_MK1Q@mail.gmail.com>
 <Ydxu+KS5UkQ6hU9R@mit.edu> <Ydx7D3H0PS0Zs9/B@sol.localdomain>
 <CAHmME9pe-DxTcFcMtsNnLPcccoY+0gEysivZQszAusH1M8ThmA@mail.gmail.com>
 <YdyNxJzdBmSSEtDC@mit.edu> <CAHmME9rmWBA02SyeFiiGZ8=kydYJSJwcYPscBrTBzoXMEPH9sQ@mail.gmail.com>
 <e6fac6ab-07eb-4d8c-9206-bacf6660a7cf@www.fastmail.com> <Ydz1F/AqB1oO/qHF@mit.edu>
 <20220111041349.GA5542@srcf.ucam.org>
In-Reply-To: <20220111041349.GA5542@srcf.ucam.org>
From:   "Alexander E. Patrakov" <patrakov@gmail.com>
Date:   Tue, 11 Jan 2022 15:01:42 +0500
Message-ID: <CAN_LGv3x==7Mt2J4gis1L8xoNqUhSus0Sue1f92bU=aJDKDn0Q@mail.gmail.com>
Subject: Re: [PATCH v43 01/15] Linux Random Number Generator
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Simo Sorce <simo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Walton <noloader@gmail.com>,
        Stephan Mueller <smueller@chronox.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(resending without HTML this time, sorry for a possible duplicate)
=D0=B2=D1=82, 11 =D1=8F=D0=BD=D0=B2. 2022 =D0=B3. =D0=B2 09:13, Matthew Gar=
rett <mjg59@srcf.ucam.org>:
> The goal is to identify a solution that avoids the enterprise kernels
> needing to do their own thing. They're in a position to globally
> LD_PRELOAD something to thunk getrandom() to improve compatibility if
> they want to, and they're also able to define the expected level of
> breakage if you enable FIPS mode. An approach that allows a single
> kernel to provide different policies in different contexts (eg,
> different namespaces could have different device nodes providing
> /dev/random) makes it easier to configure that based on customer
> requirements.

LD_PRELOAD is not a solution because of containers (that need to be
modified to make use of the preloadable library) and statically-linked
binaries.

--=20
Alexander E. Patrakov

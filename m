Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB235532A60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiEXMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiEXMaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 08:30:04 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EE49398D;
        Tue, 24 May 2022 05:30:03 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id z16so5527537ilp.5;
        Tue, 24 May 2022 05:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oJvDE3rqw1POgMlD+U//hql5RM2jeKo+o/vwbI7DRw=;
        b=ljA7Qx9wZeM3JXxhMCZDEpmHllMrC5husOlVjnjkG54MrLWMicRWxFdMUSmQ1bXOfa
         jZ434/DcRZzGRG8AD8WkjF0QhaYw5+LJC2O5VvCRj0ZM7hms602wP72tWv2pkBqbevU1
         sOpOaTZgVE82VZ8pP1KIxFOyUwkVU/DvimAPTeq+C3iRPZjTTDH63XGhiGdaszAGNEf/
         RoLFK4OMy4Mmj8uYEOn7hbaiu1GBB/5arFpU4liVoqWf86Ylu3wN423MuHbEFfSbu1L/
         FmXSmwh/+xcry9R+F9hK6h3xGOUWSZHAZql9xGvsV+ber4bQWusB6sAMpbett7Ho4Py9
         ALWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oJvDE3rqw1POgMlD+U//hql5RM2jeKo+o/vwbI7DRw=;
        b=3pvwwH+GVNvyrV5+DttJF7KD57+GcIy9iB5WtS4gJM8GLV8V7uqFswwdvU/VNN2a8F
         k3ztr+3ihpegmqZw7gfsKFJjmy3bgO/VdTGzZ0/zuZhtMnT8OH2H2DCCDBb7AGxBSzXe
         pQuRW27Lg4NRtRToFLS6sbOpToK2ed0AlE6nbnt4m4sFInvd40DSoeAC17CM0ahCYS4O
         5ilCpOi3YDhWzIECuHKvoxri73+gDTd56l/QAPLCQPcujxsVgc2/WLEKK1XU/zQvA7zl
         td6ADDNzXn6w9r4O5D47yVIUnex54ACnOINXKmAGCNgPOJ+ikEZtEx7CNAaqLj8UksTZ
         eaNg==
X-Gm-Message-State: AOAM531j5zUWVq44Q/bP3bktqetBW15IouBLGoZTSb9Jlzm8a8lT2ehu
        rP4ltL1nWjoIZciEFrmN9cFkaMTD/sCDRfJIhn1s3sOgbq8=
X-Google-Smtp-Source: ABdhPJwt/V4ZI5PCZH8bI1yKUtKl2skmZn0Mo4mHdveSh2+tCMfr9XZ5iliMBpE1y7hVWvmfS9tbiBytXMDrh0lRQ58=
X-Received: by 2002:a05:6e02:1c81:b0:2d1:3971:9343 with SMTP id
 w1-20020a056e021c8100b002d139719343mr14028193ill.237.1653395402449; Tue, 24
 May 2022 05:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-7-ojeda@kernel.org>
 <CAKwvOd=mFhxjKRP_qt3Yu69dj_P6VUMSUSQm7fY6yS2bsO8Y2w@mail.gmail.com>
In-Reply-To: <CAKwvOd=mFhxjKRP_qt3Yu69dj_P6VUMSUSQm7fY6yS2bsO8Y2w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 14:29:51 +0200
Message-ID: <CANiq72nT1=+2AFe9sdesf7hyAnkAR41fMaFi9JV4-ci2NZFD+Q@mail.gmail.com>
Subject: Re: [PATCH v7 06/25] rust: add `compiler_builtins` crate
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>
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

On Mon, May 23, 2022 at 8:37 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> ^ Any progress on this? Got any links to any feature requests or bug reports.

We got the floating point ones removed via a new feature flag
(https://github.com/rust-lang/rust/pull/86048) that Gary added (they
were already removed by the time of the message you link), so upstream
Rust is willing to add this sort of thing for us.

For the `i128`/`u128` ones, no change; but upstream Rust is aware of
this need (e.g. we presented them in the Rust CTCFT from November:
https://youtu.be/azcrUzeY3Pw?t=751).

See also https://github.com/Rust-for-Linux/linux/issues/2 and linked
issues there for more information.

> Also, I'm not sure my concern about explicit build failures for C code
> was ever addressed?  We have a constant problem with `long long`
> division on ARCH=arm32 and ARCH=i386 in C code.
> https://lore.kernel.org/lkml/CAKwvOdk+A2PBdjSFVUhj4xyCGCKujtej1uPgywQgrKPiK2ksPw@mail.gmail.com/

In my reply to that message I mentioned that the goal is to avoid the
panicking intrinsics to begin with. We already removed some, so I
would try to continue down that path. If that proves not possible,
then yeah, we would need something different.

Cheers,
Miguel

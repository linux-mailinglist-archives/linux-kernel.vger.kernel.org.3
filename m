Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98005808B7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiGZAWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiGZAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 20:22:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A9725E8E;
        Mon, 25 Jul 2022 17:22:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d17so18328109lfa.12;
        Mon, 25 Jul 2022 17:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaYNG2aQ0oiTpHSnTbpApj7mEaMN9HPDBkq1B1/AltU=;
        b=fyXzC1OSbVNMehWpe0sazaYp8HJ9WnM4fHxHbHAtxJzpvcDWFqfZ104p8EuOG5bQxk
         v2yVEcP9P9YCQma9nNg4WDvYtC+cA8Ff4SSUWyib88GyVtmQ0suu8Ninm6qZp22AOP4p
         AjJcleU5M8WhVeICiCP7OtN9TC7LtViPG+zqEcMnoiqH/GcQ8pZk7JOOCV+uXjGReP3I
         tIMPHzOPRjQDjVfzGt+F3gBugF15BaAXGgajRqqCEA9tHevF71C8qBl6080u79EaCPa2
         N82NMj2KlNKoeHdt1KHpD3fdggQ945TzJxCYlzTiRF/EsLgfQKX0O3IfZDLmI28Urdm3
         Js/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaYNG2aQ0oiTpHSnTbpApj7mEaMN9HPDBkq1B1/AltU=;
        b=EYmEyli5vqU0TRZGSAjcHpQU6NW2nvvS/ceF7sQtDCE8dbajHUziG8lIZ66VCVYSg6
         Xy41EzS19t/caA3S72VKyCLcwkm8zypqHd2x9Uekao66CUutXW4y5odXlc1rV/nEA4y2
         3Mw89Kx5xqpVqzvfjV3+Eg0asa7fz+ZPGC0Uho/7H4pgjUfgbGDpo3jrIhrFlp2rr/YE
         ie7bV720vkg47MPoJ2YEnuDxI0MD4jdqZeQb/M1AK+mHLuRiJNbw84VgqZBYM96+9wJr
         qMvKKjTokBuT4zfp0x692GbOeAQb/ju3mza6gCUga+eTAHHKgOcHmGy8HaA8FH4dfZLP
         dRig==
X-Gm-Message-State: AJIora8H/v5YO5F1s7PgH6ifqkkxkBgurmNILGJBlMRyEiWMN4KQlxYa
        eWCbY9/8t4+6n2ucrRqA9mQmXImHA9yYbDhOiAM=
X-Google-Smtp-Source: AGRyM1vaNr9ZbK2sLsRtcCiLtDkFXowpSziaiSMqGPZJcdNe25N3DBBuJ44EmmTa3hIyseewUpfKl74ZcPaXOdTx6+s=
X-Received: by 2002:a05:6512:10c9:b0:48a:9fd6:8527 with SMTP id
 k9-20020a05651210c900b0048a9fd68527mr289049lfg.384.1658794923344; Mon, 25 Jul
 2022 17:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220725030605.1808710-1-klimov.linux@gmail.com> <Yt5Zn9cXDe9/F9RJ@kroah.com>
In-Reply-To: <Yt5Zn9cXDe9/F9RJ@kroah.com>
From:   Alexey Klimov <klimov.linux@gmail.com>
Date:   Tue, 26 Jul 2022 01:21:52 +0100
Message-ID: <CALW4P+Kd_XdvzGfA=Cmtu0c=kEHfhp2pph2Wh0Sa8Fm8GxDRTA@mail.gmail.com>
Subject: Re: [PATCH v5] watchdog: add driver for StreamLabs USB watchdog device
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        Oliver Neukum <oneukum@suse.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        atishp@rivosinc.com, atishp@atishpatra.org,
        Yury Norov <yury.norov@gmail.com>,
        Alexey Klimov <aklimov@redhat.com>,
        Aaron Tomlin <atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 9:51 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 25, 2022 at 04:06:05AM +0100, Alexey Klimov wrote:

[..]

> Anyway, driver looks good to me, nice work!
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, Greg. If you don't mind I'll use your tag in next version
after making changes suggested by Guenter since there will be no
significant functional changes. If code will change a lot, then the
process (Documentation/process/submitting-patches.rst) will require me
to drop the tag.

Best regards,
Alexey

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA94C4DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiBYSkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiBYSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:40:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AEC574A6;
        Fri, 25 Feb 2022 10:39:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA94B832FA;
        Fri, 25 Feb 2022 18:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC549C340F0;
        Fri, 25 Feb 2022 18:39:45 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X9kxt8h6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645814382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+cZM3tqH37OBLiFp4YPPctLuuNx//1CKHc+R0z71lXU=;
        b=X9kxt8h6M/ruDEvHoKIrLMPZHo2yO+8XbfCZot2KHwQSz3jBaCTSDDRP30ZJxqoh1UAwPa
        8ZsbMQeX/LGOloNSv2d7UJBc7mXroeO2etgi/gThKzDdxGZIFcUkkZkxjmRMXHIsxmsAgY
        3mDOXIPgFWmuQVcX5ks83H59j7Vj2F8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 49ea77f8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 18:39:42 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2d07ae0b1c4so43045647b3.11;
        Fri, 25 Feb 2022 10:39:42 -0800 (PST)
X-Gm-Message-State: AOAM530T3fv6O3kShRZiwXJQ7DAmFDLZiloj42psqBH4nS0dcW2L2C6T
        oyOe2A7fdpgTJUBZyPxoO1FhovQ3jgRbmersjEo=
X-Google-Smtp-Source: ABdhPJwFlF7UGnzxZAQpX2LSJVz56JLxOKSWAm7gYadFtCOkE+toxm4/dkfAkSqVwqeqMjm//9pGVySRm25S2PhhFcI=
X-Received: by 2002:a0d:e005:0:b0:2d7:fb79:8f36 with SMTP id
 j5-20020a0de005000000b002d7fb798f36mr9557404ywe.404.1645814381161; Fri, 25
 Feb 2022 10:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20220225155552.30636-1-graf@amazon.com> <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
 <YhkQKfE8ErtFBmSB@zx2c4.com> <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
 <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com> <YhkaAUQ/5ChlKlXt@zx2c4.com>
In-Reply-To: <YhkaAUQ/5ChlKlXt@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 25 Feb 2022 19:39:30 +0100
X-Gmail-Original-Message-ID: <CAHmME9rzS5rAKoAfv7+N_R71pWduV=a=gJJoKPoLtYx7m7CFEg@mail.gmail.com>
Message-ID: <CAHmME9rzS5rAKoAfv7+N_R71pWduV=a=gJJoKPoLtYx7m7CFEg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
To:     Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, the final piece, userspace:

/sys/bus/acpi/devices/QEMUVGID:00/modalias gives:
    acpi:QEMUVGID:VM_GEN_COUNTER:

modinfo -F alias vmgenid.ko gives:
    acpi*:VM_GEN_COUNTER:*

udev src uses fnmatch.

Bash confirms a match:

$ [[ "acpi:QEMUVGID:VM_GEN_COUNTER:" == acpi*:VM_GEN_COUNTER:* ]] &&
echo matches
matches

So I think with ACPI_ID_LEN --> 16 we are good to go.

Jason

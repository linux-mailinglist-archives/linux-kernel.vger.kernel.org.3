Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2084C4C35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbiBYRee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiBYRec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:34:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CB41637FD;
        Fri, 25 Feb 2022 09:34:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7679B832D0;
        Fri, 25 Feb 2022 17:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A3DC340F1;
        Fri, 25 Feb 2022 17:33:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PxBxo4FT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645810434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5/UfaZITJxu0H1BQwiMhOXGkrGHeskVTi/A9G28Of3c=;
        b=PxBxo4FTEb2YcdGU6iJx5RXgFvNLDy/JCeoJNRQ/Aa7R3Lfg7yRyOXXIRKGiBV0f+yGzM/
        C2CFBt8UQhl7eqDikkacwsWRJW12yY/SN9+cCYTHlG2ijA+CDQV61vuXvur47uVMzNhdSX
        tIGxR60SfazHMPq2RAQAiajq9yjO4zM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8eda722c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 25 Feb 2022 17:33:54 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-2d310db3812so41434197b3.3;
        Fri, 25 Feb 2022 09:33:54 -0800 (PST)
X-Gm-Message-State: AOAM532yi2NHWIXamUiQgJoXKKd9Ud1//T9z+VxXovDhHqeXR2h0UlaC
        XTB5qvl3WaPzIDTxitupqAzw7hKKIqu/2EB2hyw=
X-Google-Smtp-Source: ABdhPJxswLWCUsTRFGAuxcief/Pj1DvT7KnwtUGFELbRndJZsvrVIdz4BWtlerGT5nE8NSVfb8AtBsNIQf3/c3WJZis=
X-Received: by 2002:a81:c74c:0:b0:2d6:b681:af58 with SMTP id
 i12-20020a81c74c000000b002d6b681af58mr8883802ywl.100.1645810433242; Fri, 25
 Feb 2022 09:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20220225155552.30636-1-graf@amazon.com> <CAMj1kXGtANm3SMoREymDSyx+wpn3L=Ex5q5mpgQigOwmEp33Lg@mail.gmail.com>
 <YhkQKfE8ErtFBmSB@zx2c4.com> <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
In-Reply-To: <CAMj1kXEtUUod8Hp6VhS6k7iDKYkFj_t_J=qS2XF1p2X_SFdTvg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 25 Feb 2022 18:33:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com>
Message-ID: <CAHmME9oJpL_y4bDaLwrZZZ54p5_C0YF9=vW7Zz1iUhpBHx2TvA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Match first 9 bytes of device IDs
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Alexander Graf <graf@amazon.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Fri, Feb 25, 2022 at 6:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> Yeah, good point. I think this is fine, although there are a few other
> uses of ACPI_ID_LEN in the tree. So perhaps this should be something
> like
>
> #define ACPI_ID_LEN    9
> #define ACPI_CID_LEN    16
>
> /* explanation goes here */
>
> struct acpi_device_id {
>     __u8 id[ACPI_CID_LEN];
>
> instead? At a quick glance, none of those ACPI_ID_LEN users seem
> related to the CID or the match metadata.

Either way is fine by me. Looking at all the current users of
ACPI_ID_LEN, none of them really mind if it's >9. I can't see where
it'd change any behavior or performance or really anything at all,
anywhere. So I'm inclined to go with my original simpler solution. But
again, either way is fine.

Alex, do you want to pick one of these and submit a v2 based on it? Or
do you see a shortcoming in that approach?

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C0C4AC8CA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiBGSnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbiBGSm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:42:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A6C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:42:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7528B8164D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49042C004E1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 18:42:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VaQDLxfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644259372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5f6xoMurihFxc+jyT3VNTd9P91s3UDjpEA7MgFF4tlg=;
        b=VaQDLxfNzJ79xTmcxtVpnKl+KB68LFOjCrS6wTj5gPlaodw7Y5qd/vzXMBpxBnN2Gh4DqR
        tE/MOMBGGE0GOi9K0xp8WnIXqplIP7ZniNL7xCkEdaUfjg/wewzCzggfayYRjVZ+uahg70
        g9Pxk8Eu2sxToKB/kLjWcN1jTAsUo5o=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1ac30f09 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 7 Feb 2022 18:42:52 +0000 (UTC)
Received: by mail-yb1-f171.google.com with SMTP id c6so42841273ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:42:52 -0800 (PST)
X-Gm-Message-State: AOAM533MVITQPgKloJ0tK+zkgSqUi9Nwj9XDCAg3uW9saT7TkCVba1m+
        RlTnoT1ciblAB3KgAIdgV4n7jnl2HHju7yAreug=
X-Google-Smtp-Source: ABdhPJwjNWJxLwOB9ojzgqsLPkcQ7PiF7REVUngwHVGRdlgzYXukTlGz5kcw+FR7+Zk3vGohmqsoQIDFis8LYMnWMbU=
X-Received: by 2002:a81:c40d:: with SMTP id j13mr1209089ywi.499.1644259371472;
 Mon, 07 Feb 2022 10:42:51 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
In-Reply-To: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 7 Feb 2022 19:42:40 +0100
X-Gmail-Original-Message-ID: <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
Message-ID: <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     pmenzel@molgen.mpg.de
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
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

Hi Paul,

Thanks for the report. I assume that this is actually an old bug. Do
you have a vmlinux or a random.o from this kernel you could send me to
double check? Without that, my best guess, which I'd say I have
relatively high confidence about, is that the "1 byte read" is
actually a `movzx eax, cs:lfsr` referring to the `static u8 lfsr`
here, which gets inlined into add_device_randomness:

static int crng_slow_load(const u8 *cp, size_t len)
{
    unsigned long flags;
    static u8 lfsr = 1;

This was added in 2008 with dc12baacb95f ("random: use a different
mixing algorithm for add_device_randomness()"). My understanding is
that the race here isn't super problematic as we're in kind of a half
assed "low effort" phase anyway. But I'll give it some thought. I'm
CCing Jann as well who reported the original issue that motivated that
change.

Regards,
Jason

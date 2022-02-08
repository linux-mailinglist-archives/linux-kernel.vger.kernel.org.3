Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC14ACDA4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239806AbiBHBIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiBHAg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:36:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363AFC061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 16:36:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C37EF60ED0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2B0C340F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:36:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A2f5wHJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644280582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJt8rbu3AYDoBNc/EdQTMBvSLH8yRYqHWGRsR+89oog=;
        b=A2f5wHJEAXgAt0T7iWdYtzPxyGiOv442ggfCLgAEVGPsQ3zjcSaGco8vyhZAEYxtfd8BWp
        JA+8PonRf4Klw2Nk7Svp1QYVcVtJZHTMpgkMLAWma4MgW5J69ix7yfJfBrnX5uKtU+QEh4
        3gri3t2hV089X/3lhl//WSKk7CdM2Sc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 55871bb8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Feb 2022 00:36:21 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 124so44503565ybw.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 16:36:21 -0800 (PST)
X-Gm-Message-State: AOAM5330qQHfBFS0z7XhAVv3JDHjTrB0HWClunfsNxERbK89NCOLm/vo
        m67lwrd6pJ69jflMGt7O83STrL+UvAWChyvKDr4=
X-Google-Smtp-Source: ABdhPJweAimco5zPp1mHY1t7UXPEjwVynXI4FfQ9H1oBNFhgY/j7o+kBMl8UwoNjH07uMlMn0qtpkYL06j/0gaZt2Pw=
X-Received: by 2002:a05:6902:14d:: with SMTP id p13mr2403206ybh.638.1644280580410;
 Mon, 07 Feb 2022 16:36:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:6254:b0:129:4164:158b with HTTP; Mon, 7 Feb 2022
 16:36:19 -0800 (PST)
In-Reply-To: <CANpmjNPVJP_Y6TjsHAR9dm=RpjY5V-=O5u7iP61dBjH2ePGrRw@mail.gmail.com>
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <CAG48ez17i5ObZ62BtDFF5UguO-n_0qvcvrsqVp4auvq2R4NPTA@mail.gmail.com> <CANpmjNPVJP_Y6TjsHAR9dm=RpjY5V-=O5u7iP61dBjH2ePGrRw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Feb 2022 01:36:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9oPGnAQ23ZGGJg+ZZRDjG8M+hkqvTko1Zkrc5+zQYUvVg@mail.gmail.com>
Message-ID: <CAHmME9oPGnAQ23ZGGJg+ZZRDjG8M+hkqvTko1Zkrc5+zQYUvVg@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     Marco Elver <elver@google.com>
Cc:     Jann Horn <jannh@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>, pmenzel@molgen.mpg.de,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
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

Hi Marco,

On 2/8/22, Marco Elver <elver@google.com> wrote:
> Jason - if you're interested in KCSAN data race reports in some
> subsystems you maintain (I see a few in Wireguard), let me know, and
> I'll release them from syzbot's moderation queue. The way we're trying
> to do it with KCSAN is that we pre-moderate and ask maintainers if
> they're happy to be forwarded all reports that syzbot finds (currently
> some Networking and RCU, though the latter finds almost all data races
> via KCSAN-enabled rcutorture).

Oh that'd be great. Please feel free to forward whatever for WireGuard
or random.c to jason@zx2c4.com and I'll gladly try to fix what needs
fixing.

Jason

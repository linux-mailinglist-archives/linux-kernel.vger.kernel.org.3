Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFE54AD4C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354139AbiBHJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354115AbiBHJXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:23:50 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB41C0401F0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:23:48 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id m6so47970796ybc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZ03WaXjCB1/PPBbkHxtR46rnb83dwuwKCXnSai0rXM=;
        b=DX6memat2HqLjnAS7y2wJyGBIcCSvFCIX2diIwxjvhawJUk0LEiOSud3eWKg/HfoUS
         oSapkRfQ0X/ZKBOYklGLL0IaB9h4LVBJ1Ur2FLvxxUw/3FMb4OcNmqtvwycvLxWU6KMS
         Rd566JfVkltr+QiWcpINNZD1CqFEuAz/Q4oC2eRwxOQ7mBcv4wtOZ3U2/sTBBz2FVmr0
         Ff+PyYntSVmqgjqEvpKWkDMMdrJB9wGHyqJCGD7MNsJbzQIRAazsw6Y4iUU8a18m1f8R
         BXQDyHHykItCDUT8uFRcEtXaynI6CqnAtEM0gTTE++wFTBlM1OKYndIWGP12KcjkkOP4
         zhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZ03WaXjCB1/PPBbkHxtR46rnb83dwuwKCXnSai0rXM=;
        b=FIxKLx6698Ru1CvKiG8rvD6u8WM6cJmxXQ8zIJOF/O0VbTHccylFcXRcPf3V7HCKQn
         Y1tjUGhXAyLVYZ4pxrOrS0p0GLi7EttavnjkA8swsSZM4ZTEO2I6eTrxUnk6DwuOwSgd
         jq/+wK41bmuKtCnjO1oMmlA9RPqKxfFkv435I6UmnZ8OZmthLDhUAoDdeAU43o4mepvW
         nhXOnLZf7Hms1txoUE6lyjFpJICcCrGG1mH0r2kARWdRiaOT+OCIzh6bszkwpR5lDwVl
         /gBUmC3Fd+YQxNZWvj/t3Gi8DTqHcVkoR8Oo71PhtKtRGhYc8aTgMCGSttin094+gcwy
         yNXQ==
X-Gm-Message-State: AOAM533Omwtp0Dz+gZIY9QQDExdJk7VjqZemx4iThAQpIGf1R6zpXgxm
        YeEB99QpfznuY3132b6lopCdGxPMYyHdpP7/zqQlbQ==
X-Google-Smtp-Source: ABdhPJzNZwdpI7As6Vcl3IKOUiJJV1tZVDiYb3vcfuX75N4c8Kg8o1c5tMFwig+CS4CJqOmwSxhH8K0omIBZ/ht3AkU=
X-Received: by 2002:a0d:ec04:: with SMTP id q4mr3914719ywn.412.1644312227704;
 Tue, 08 Feb 2022 01:23:47 -0800 (PST)
MIME-Version: 1.0
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
 <CAG48ez17i5ObZ62BtDFF5UguO-n_0qvcvrsqVp4auvq2R4NPTA@mail.gmail.com>
 <CANpmjNPVJP_Y6TjsHAR9dm=RpjY5V-=O5u7iP61dBjH2ePGrRw@mail.gmail.com> <CAHmME9oPGnAQ23ZGGJg+ZZRDjG8M+hkqvTko1Zkrc5+zQYUvVg@mail.gmail.com>
In-Reply-To: <CAHmME9oPGnAQ23ZGGJg+ZZRDjG8M+hkqvTko1Zkrc5+zQYUvVg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Feb 2022 10:23:36 +0100
Message-ID: <CANpmjNNoAEqab7Zi2bB7=3FVpajXe_4jmVV-orCO=DzT1Ber9w@mail.gmail.com>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Jann Horn <jannh@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>, pmenzel@molgen.mpg.de,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 at 01:36, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Marco,
>
> On 2/8/22, Marco Elver <elver@google.com> wrote:
> > Jason - if you're interested in KCSAN data race reports in some
> > subsystems you maintain (I see a few in Wireguard), let me know, and
> > I'll release them from syzbot's moderation queue. The way we're trying
> > to do it with KCSAN is that we pre-moderate and ask maintainers if
> > they're happy to be forwarded all reports that syzbot finds (currently
> > some Networking and RCU, though the latter finds almost all data races
> > via KCSAN-enabled rcutorture).
>
> Oh that'd be great. Please feel free to forward whatever for WireGuard
> or random.c to jason@zx2c4.com and I'll gladly try to fix what needs
> fixing.

Great! I've released everything I could see right now.

Thanks,
-- Marco

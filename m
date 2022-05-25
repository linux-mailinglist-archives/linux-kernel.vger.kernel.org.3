Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB461533729
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiEYHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiEYHMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:12:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBA95FDB;
        Wed, 25 May 2022 00:12:03 -0700 (PDT)
Date:   Wed, 25 May 2022 09:11:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653462718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+orsWNjWtAwiggB87niLJ7T2vo66GNbCnC4aWo769UQ=;
        b=tXIaQWvesmewK1SQvqwWgjKsyAyyIrLjEanwcNAy2h/P5FMGq/kJgWZClGgDeKmANuYAkW
        6I7SL146oVeYMmgPOm/K/5ULiZwNsVMQKo5zuy5USu5ms+bQvLeomBnv/Y7RF7ep6r43Fg
        yrE+GteNpeB84vc7KB5yHCiGDGSLxpJF9n26BehK7VVK2KwTS1qiOtnBNXBBg3s07zq9LZ
        QuC90oOJFyjhHJqpIG4b7pe7LqIsPAYDmbR2tbrm4G6CKN84jA5eTlcpkoSp3W47VVgETh
        utsXLbJ9WiKBewsE1+4q4+5PmLVYRznaktasLTJPtcPFwgqlSj1UxEdIbhT9hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653462718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+orsWNjWtAwiggB87niLJ7T2vo66GNbCnC4aWo769UQ=;
        b=1vNUO3Dakuo2lI9Z/n9vsWIZ8Loex9gUHN2zaefzYBYblmfryFJ25az2ZrOSX+XZBIv9t6
        eUlvctYCzDyGwvCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Will Deacon <will@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
Message-ID: <Yo3WvGnNk3LvLb7R@linutronix.de>
References: <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
 <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
 <Yo0KyWx+3oX3cMCS@linutronix.de>
 <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx_qTLwbjzMruLThLYV+MZD5W2Ox-QwLFQeW=eQgxzq-Hw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-24 10:46:49 [-0700], Saravana Kannan wrote:
> > Removing probe_timeout_waitqueue (as suggested) or setting the timeout
> > to 0 avoids the delay.
>=20
> In your case, I think it might be working as intended? Curious, what
> was the call stack in your case where it was blocked?

Why is then there 10sec delay during boot? The backtrace is
|------------[ cut here ]------------
|WARNING: CPU: 4 PID: 1 at drivers/base/dd.c:742 wait_for_device_probe+0x30=
/0x110
|Modules linked in:
|CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc5+ #154
|RIP: 0010:wait_for_device_probe+0x30/0x110
|Call Trace:
| <TASK>
| prepare_namespace+0x2b/0x160
| kernel_init_freeable+0x2b3/0x2dd
| kernel_init+0x11/0x110
| ret_from_fork+0x22/0x30
| </TASK>

Looking closer, it can't access init. This in particular box boots
directly the kernel without an initramfs so the kernel later mounts
/dev/sda1 and everything is good.  So that seems to be the reason=E2=80=A6
My other machine with an initramfs does not show this problem.

> -Saravana

Sebastian

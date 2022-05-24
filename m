Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D328532F23
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiEXQl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239552AbiEXQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:41:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56629369E3;
        Tue, 24 May 2022 09:41:51 -0700 (PDT)
Date:   Tue, 24 May 2022 18:41:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653410507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YK2eEOx7qW4qJHtFCm6AqFTk2cYYBK5VN6M5h7/LPJY=;
        b=RpxUjmeXaoO/cBMYYtR+W0dgahHZXn+pWhavM1CLX7ZfQbTpfWIlyVxXP2YkVVmh2rwFni
        oLUkOWEklbTTdrrQ7EBqMg9VljxqAkk2RMpDM3IceQGLMwRX/iWplU9ypzMYYcF6rIsNq5
        gEQ4o1/jjw0KCo+cUaPASqE1n/pDEduI0UjFZDyXV0oSZG/MAsghi4jn0Q2Rgd5KSWzxGx
        bQvfZfriHlwfgaQV7kIhJvTA4aJo6Sat/396ZLjHmqW288KyLlFNIavuowjRfXYfA7qDR7
        byhLkWlIiN/whQv1P/8pn5vO4+sDy2ImQNzEoKhEtwkvfwviQyVSr29nT72Agg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653410507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YK2eEOx7qW4qJHtFCm6AqFTk2cYYBK5VN6M5h7/LPJY=;
        b=/mpKm9K+KmM77y1Sv2U9sqow5FiO6MRm6Pw38G0V5vb80cMf3MtUbFzjWo6JzMqnXUz52M
        Ak5KSCUA8QKj4tCw==
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
Message-ID: <Yo0KyWx+3oX3cMCS@linutronix.de>
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
 <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-23 20:43:06 [-0700], Saravana Kannan wrote:
=E2=80=A6
> Thanks for all the help. I think I know what's going on.

I, too got here because my boot recently was extended by 10 seconds and
bisected to that commit in question.

> If you revert the following commit, then you'll see that your device
> no longer hangs with my changes.
> 35a672363ab3 driver core: Ensure wait_for_device_probe() waits until
> the deferred_probe_timeout fires

Removing probe_timeout_waitqueue (as suggested) or setting the timeout
to 0 avoids the delay.

> -Saravana

Sebastian

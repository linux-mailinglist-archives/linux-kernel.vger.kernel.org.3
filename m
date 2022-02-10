Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC7D4B07E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiBJINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:13:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiBJIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:13:28 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7054D108A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:13:26 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x4so1195310plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bO+Jcgpt393mmvw7hWqpbnpyQZTC3EQ5YNZf+mvO9Jo=;
        b=bhUyXrrl/fStj/Fh/OyKQCL0uj7GVwTOaqiqNoImZLt8mbSfBxz1s9YHa90GH50xju
         fLB1kUWp6kNCp/FuMt2VI/naCioRLhe2eISZqatWYyAULvXPm+M1+kDDGyFLIU2tSPHz
         ky5jcxEQUtv4TJMhllTMaGL6eB4U7R2foF11jx+NdziYQ1KMT6IAmmw4A09Xev89YkmW
         xw7YKZc/qXCBc9L3zhbShL8fwTdJ3skyINkPO8nYfcKuY+OPEcQSiVv0Rn3dCvH4eHyb
         s0H2ur7mck3uxoR7mJHMUkXXLFWsilwkMk8nPQ2DdvW5xtU+ezAj4m7XUg+CR05uT5/2
         00mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bO+Jcgpt393mmvw7hWqpbnpyQZTC3EQ5YNZf+mvO9Jo=;
        b=507xUl7rfe0RaK0EafyJSvzpp6ziETthGVYDEnZJh7k4cTxxQuIs/PAa9xZw8lYG/j
         ngWeX3b1ufTpnP8D27dXvtBIchTWIDnZw/pO1K4l0ISLnTXc9FD06XPk7fygOSTNvDkz
         VubcKi8d/w4x/j9dI9onNg3JsawVu9VsFCDawb00hHXH5bMZdWGzMm5lNDjgEreNxA87
         WqwyEZ32gfhcY7o4FZVoQr4myz+nEpPy6isgyR+AvchQxr6RYFkql3nJenv9hzWPd9H4
         lC9pCpOouu9tBzHuijHkrfvbnn1YtmzZo6MCVYgSSOx9EWRjMYOb2OJqg4Lh/pfMV6O3
         ERwA==
X-Gm-Message-State: AOAM5305daGY1p5XOxjrXrNOxCxZ9dCF+XzvKoLz0tXEj9aXRalst3ve
        dWHZXY+1AoWQ4+kDKHGOP6XfnHO+zzwdRs/LzyIKPQ==
X-Google-Smtp-Source: ABdhPJyT5/JbvvVvpH2gdfpK9WJPLlUlqqwiwN1MC0YK332Oj1cOtTLaNGarMrSWWTO1Qo/JHFoy2RJWCkYXB8lDd28=
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr1555020pjb.71.1644480805969;
 Thu, 10 Feb 2022 00:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20220208141218.2049591-1-jsd@semihalf.com> <2551b3f1-0dc0-aaf1-680c-9634d2a6b65d@linux.intel.com>
In-Reply-To: <2551b3f1-0dc0-aaf1-680c-9634d2a6b65d@linux.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Thu, 10 Feb 2022 09:13:15 +0100
Message-ID: <CAOtMz3NX=J3YZa=1tORZA6eLxYpFQb=zChB5gRrQX6BHG2zTLg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] i2c-designware: Add support for AMD PSP semaphore
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Easow, Nimesh" <Nimesh.Easow@amd.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 9 lut 2022 o 16:11 Jarkko Nikula <jarkko.nikula@linux.intel.com>
napisa=C5=82(a):
>
> On 2/8/22 16:12, Jan Dabros wrote:
> > This patchset comprises support for new i2c-designware controller setup=
 on some
> > AMD Cezanne SoCs, where x86 is sharing i2c bus with PSP. PSP uses the s=
ame
> > controller and acts as an i2c arbitrator there (x86 is leasing bus from=
 it).
> >
> > First commit aims to improve generic i2c-designware code by adding extr=
a locking
> > on probe() and disable() paths. I would like to ask someone with access=
 to
> > boards which use Intel BayTrail(CONFIG_I2C_DESIGNWARE_BAYTRAIL) to veri=
fy
> > behavior of my changes on such setup.
> >
> I'm going to run overnight with both patches a test case that used to
> cause some activity on a shared I2C bus on Baytrail based MRD 7 tablet.
> Test below used to trigger system hang after a few hours - days before
> some PUNIT - graphics related issue was fixed a few years ago:
>
> #!/bin/sh
> X &
> export DISPLAY=3D:0
> sleep 2
> xclock -update 30 -digital -geometry 500x50+1+1027 &
> xload -update 60 -bg black -hl red -fg green -geometry 1916x250+1+774 &
> sleep 1
> xsetroot -solid red
> xset s noblank s off -dpms
> glxgears >/dev/null &
> while :; do acpi -b; sleep 1.2; done

Thanks, looking forward to the results.

Best Regards,
Jan

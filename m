Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D8496752
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiAUVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiAUVdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:33:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34C5C06173B;
        Fri, 21 Jan 2022 13:33:36 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i82so12314124ioa.8;
        Fri, 21 Jan 2022 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iavqU42bj2wSTgmqVt3xxjReKzumqOVjWmleUy0bDaU=;
        b=lBuls2whODaDh0IeWokO1lc2qJgP2JLiB3bCnsDp1cbXFhdRiIVQWIti1HZVV4yYr+
         OMCvjRPRz1AfCG3RIGuQfU8DiRSzl/ahIHw1ePh6o6bOxXAnr38dT9DesX/xSyTPqyDI
         2OWbT+sw8dhSRPCP8AlePg3+HxvkxpeaFrkF0p40JxX3h1SX0qSB/snVuwJulwg5SH3p
         uRACmPUmIw0MU29qRqblGsC7YgX4QQ0KlyvWe5EQmhCGPLN1WrUAQbvkBYHS2X1Y8/2I
         N1/jdYEOVwJbFh32pGTgHF3L0Pz49xoXdKm8zLGliqc3YMejygmu9WgLNMUuOYig+kEc
         I3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iavqU42bj2wSTgmqVt3xxjReKzumqOVjWmleUy0bDaU=;
        b=PaETwJJEe69QuHZ2InjDVkpMtuIcUtVaCL+Hay0ugfM8bTEKtvOD8yGyK3T7s/uV+3
         SX3GRUv58P4kuxk+OlbevE+BiuwmxwLvMtp0/EqyBhBgZoduNMuetWvDkOufRduyMlmp
         3WZ8a8aV4s2+oyV47V1Qrxv1DihXez8SD0aHt74vDgbf/M6aCWtmyIB4nR7ihzO5lNWP
         04Jr8vA56uVIRZ46ygDCGzB+4QiDsC872EncIY3FPwKAEPSCtSXJAFccXW0xjCqHbLWg
         gmh0aGW/LuKwUNWbyxXGmyoMYiVv1QL6Jlj7O1uucJhqvIH+CDcmR022eH8SBpbI74cp
         wv5g==
X-Gm-Message-State: AOAM533aHprcNLJ3mQaF2mmCcWEiKuiGqehqjMAsHLA9nMxpd6A1PkjC
        VJV09TdSvgNUJsEj65IXVUdQM2YJZP5NkhdbmY0=
X-Google-Smtp-Source: ABdhPJzyP4r0f30I+sUcs66o3RZrX5hWJGLcsiHXwcnJyBP+ppPsiL3PgaJV1jFjOe39KrjpPgX8Jr/j45mxjoiLlZ8=
X-Received: by 2002:a02:a717:: with SMTP id k23mr2857417jam.155.1642800816294;
 Fri, 21 Jan 2022 13:33:36 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNb22JCJ4AyR1sYqFtF4QUnvM3B2zQcc1svcm2mquWxoA@mail.gmail.com>
 <YeUvvIaVJnJrrpYe@kuha.fi.intel.com> <CABXGCsO5PYBuZ11YR16NLLa0H07Jom1JQhWHFuETfotfBfzkMw@mail.gmail.com>
 <YeVQsRp7aDMcQKs7@kuha.fi.intel.com> <CABXGCsMWXFFQY3L8ixK9K-gYX41_gTjqHRBXNp6gDpUgdnvFfg@mail.gmail.com>
 <YeVfYOhxGTgg8VpZ@kuha.fi.intel.com> <CABXGCsOwsP7NJ67oyK3HPs2EarSJKLB9EVW7oEh+8bAFihSa8g@mail.gmail.com>
 <Yea8p1b/sZYKNGaB@kuha.fi.intel.com> <YebBq/WDeYCIvwYw@kuha.fi.intel.com>
In-Reply-To: <YebBq/WDeYCIvwYw@kuha.fi.intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 21 Jan 2022 13:33:24 -0800
Message-ID: <CANcMJZDrs418aUoVS4CijQFqgAW3pCbfm_NUCmx+T7HNoiMVnQ@mail.gmail.com>
Subject: Re: [Bug][5.17-rc0] Between commits daadb3bd0e8d and 455e73a07f6e,
 the kernel stops loading on my devices.
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        rafael.j.wysocki@intel.com, linux-usb@vger.kernel.org,
        YongQin Liu <yongqin.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 3:27 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Tue, Jan 18, 2022 at 03:12:10PM +0200, Heikki Krogerus wrote:
> > I can reproduce this one by simply not creating the component list in
> > the code. That function - component_master_add_with_match() - can't
> > handle situation where the list is empty. I'll prepare the fix.
>
> I'm again attaching the proposed fix, just to see if it also gets
> corrupted. Can you test does it fix this issue?
> You need to apply it on top of the previous one.

We've been hitting the null pointer crash from
component_master_add_with_match() regression as well on the hikey960
board.

The patch you attached resolves the issue. It would be great to see it
merged upstream soon!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john

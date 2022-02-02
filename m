Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B144A78E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 20:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbiBBTrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 14:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239991AbiBBTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 14:47:30 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F61C06173E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 11:47:29 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v186so2004573ybg.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 11:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co0UxehcT10KvKeO2HMl27sRQGzVzaRaaBVplxip7qw=;
        b=SLaoGd8dLroMo5YxyBi9jnv5iD6ziKqemavNXtbhEP97AYJ3eyFPP49FNWfveLhMox
         zQBZhH1z59850/KS+1pgUI5iBxZkDZCrmXt6l0T+Evp/is5lkdF8MVzUYsmMfFyGVFNY
         K3SuKfccY94QuyCApGmUtWgq4hGMPNHRXjShw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co0UxehcT10KvKeO2HMl27sRQGzVzaRaaBVplxip7qw=;
        b=a3sAe3gLaS8RqiozwmHrJvR7uOtin30ciJRa8+i9JtHbZNLvm13R87LFk4Exl4b+E0
         qvVXeV5zevz9+hj63mvMqVyWbu9+8C3oYPzGKTe9SAYXrmVfQPzHaG10k92Eh+7gpSjM
         1VauhURVElnsoALpwOjR6931sHs6fBOgo1WnIQFhUDs6kw0ahFtk5jDy92h0Jr9Uc3hd
         IeMCpCM0+HLeISxXnDARC+y1D+wUYGfMx11//thPf4O6BlrHpe47CvKurJtFJBzFrWNw
         iai3EyqfgMtXFHVDcE7lfZMorsiuFKr+qP717wMb1doqDZ7CC19BAy1RHMuwIxfXyjzt
         8Q+w==
X-Gm-Message-State: AOAM532g2Lq0IQLJSly5jbkdOBpGtrZqqQ/5bCSjgJFfm7wjRseIVRb2
        /MDRaD+jenLJIGRwx6kWNvkfiDRkBhWmOEJYO8+8cA==
X-Google-Smtp-Source: ABdhPJyx/Yh66eh4potOrtkBUp+MmWnprcO9LCD3hc+BXMIwtFIjdb4Yi0zFxHHLneg7LA52ah5I8u469dqUjBcQ/tE=
X-Received: by 2002:a0d:ca8f:: with SMTP id m137mr2154641ywd.5.1643831248225;
 Wed, 02 Feb 2022 11:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20220126180020.15873-1-dustin@howett.net> <20220126180020.15873-3-dustin@howett.net>
 <YfLqloFQpF7bURGi@chromium.org> <CA+BfgNKS_uGZVh5K=O5Q-Brj-wWyg+gn1Nx4-Gr5OVb46ZFi=A@mail.gmail.com>
 <YfLxw9r6VvbxijRM@chromium.org> <CA+BfgNKCYT6EnOK1JTsy+AJCzZ+p6UbYD+SgBZ=ANHCV1pC7oA@mail.gmail.com>
 <CAJnPg5+bU68s2hq75aewap2gyW3YB+gpamKmuB-VfcpGf5krwA@mail.gmail.com>
In-Reply-To: <CAJnPg5+bU68s2hq75aewap2gyW3YB+gpamKmuB-VfcpGf5krwA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 2 Feb 2022 11:47:17 -0800
Message-ID: <CACeCKafGc7Mbijb4QMJ36atPP08yUN2MSA+ya-vQR-rbAFrPKg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC LPC
 I/O ports first
To:     Aseda Aboagye <aaboagye@google.com>
Cc:     Dustin Howett <dustin@howett.net>, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>,
        Aseda Aboagye <aaboagye@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 28, 2022 at 9:57 AM Aseda Aboagye <aaboagye@google.com> wrote:
>
> Generally ec_commands.h is to be kept in sync with the copies in other projects. Periodically when someone modifies it, we should update the copies as well.
> --
> Aseda Aboagye
>
>
> On Thu, Jan 27, 2022 at 9:16 PM Dustin Howett <dustin@howett.net> wrote:
>>
>> On Thu, Jan 27, 2022 at 1:25 PM Prashant Malani <pmalani@chromium.org> wrote:
>> >
>> > What source do Framework laptop ECs (MECs?) compile their EC firmware
>> > from?
>>
>> They just released their source here:
>> https://github.com/FrameworkComputer/EmbeddedController
>>
>> FWIW, this series was written before they went open, and you're not
>> likely to see a similar construct
>> over there.
>>
>> > Yeah, I wasn't thinking about userland i/o port access, but just having
>> > this behaviour/different I/O port mapping described in the EC code base
>> > too.
>>
>> Happy to submit this over there as well. Are cros_ec_commands.h (here)
>> and ec_commands.h (there)
>> intended to be kept in 1:1 sync?

It's not auto-generated, but FWIW cros_ec_commands.h is a subset of
ec_commands.h (only the parts of ec_commands.h which are relevant to
the kernel drivers are brought over)

>>
>> As well, is this a blocking concern?
I'd prefer it to be first documented in the EC sources via a header
update before we make changes to the kernel here. This ensures that
the authors and maintainers of the various EC sources (Chromium EC,
framework EC etc) are aware of this change and sign-off on it.

I think making this update to the Chromium OS platform/ec code base
will be sufficient (it can flow down to framework when/if they chose
to sync to Chromium platform/ec); but happy to be corrected here by
Aseda or other EC experts.

Thanks,

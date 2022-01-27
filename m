Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BAA49E4E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiA0Ood (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiA0Oob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:44:31 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7074BC061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:31 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p63so2938846iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TXXxAA22JP55U2d5KcEju2kMZrmD6a4AiOWrq8N6KU=;
        b=hks7nMfHeG1O6/iSHwf3VQNmLIui784tr+mUrsdRtKWklyXM3EHK5UQMezkB1a53Fj
         Xe8/FA2bEmcQXXOIsA9K+hyq5JnOFDJjKSZ+Mlpx4F/4CIYPQ3IKRC/nTGPu0ojoNMaY
         h/BjBiqYDkljFlrXa7cEbL21DvAVb0rcYLV6HRHI3K7kv/f1+LE5KjPlHZYcwDV0LTDc
         BPvPQTafXmAtuPE/44fxvNkq+fAkJ5qPkvNl3GhEAN49MSc7ec4sh7QYUzqST5eqgZO0
         xuUBFysv9O05ffOPhGh6BUiTlkXg5JOIzjn4R0hND5ha77B2PBWgeFWNmWwnLAXjCRu9
         F79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TXXxAA22JP55U2d5KcEju2kMZrmD6a4AiOWrq8N6KU=;
        b=02tW0901vnoBDqf1MiCV2BT7G67CjyvQP8lV5T6MsthD0XsTjPewuCHda8Qew/zRmI
         nGmDR13rzwLlK6pqe+zekN+QfTzaKYXqo33nGar5xUnQ/5lFq2VmbsrbJ8JyxuvVBwTT
         bklTs1ZUNmT92JxoCp3P6tjmx+T8C/cponhnVNTYsJMEMLykz4UruJI8rkf9w4+gWu3R
         OCzTBxc7MnfBMiD5rFf9MgwFCAasf0p2M/3zpXIukizWX1jcycBFiGocgxUpI5Fc0jEZ
         aOV0wgo2XfaPBt4sBOv8adI+bOQW/dNjoLqk2dS/SVxblAMWQ6EBXrCdMlYjkPU1yEWM
         HzeQ==
X-Gm-Message-State: AOAM533Ft3/3/a/zxyo0cML4MIs7vLmj8zDia4HdLip2PFVlcmr6GK6K
        YUy0wRgD7IBWJnqpTjeuuYoCqdL70zPltgKdq14S74uA
X-Google-Smtp-Source: ABdhPJyjYQkK30yF9LrqatH2JvSYsgA0twQ9CE2bho07UqZJyO2P/gsHsIc4qJ2ONo8j3aAo3LNmiq32b4vlcas9oDE=
X-Received: by 2002:a02:ac88:: with SMTP id x8mr1972396jan.264.1643294670931;
 Thu, 27 Jan 2022 06:44:30 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72n_FmDx=r-o9J8gYc6LpwRL5EGmhM6Xzwv27Xc7h1TNDw@mail.gmail.com>
 <871r0tmosw.fsf@mpe.ellerman.id.au>
In-Reply-To: <871r0tmosw.fsf@mpe.ellerman.id.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Jan 2022 15:44:20 +0100
Message-ID: <CANiq72n3ReEAf6BNXL99Q9Ovg5kqpXDRSSDaWLd+mJKK7FxdCw@mail.gmail.com>
Subject: Re: ppc: hard lockup / hang in v5.17-rc1 under QEMU
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Jan 27, 2022 at 11:54 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It looks like your kernel-ppc64le-release.config does not have the
> hardlockup detector enabled, so I suspect you're hitting the bug
> described in that patch.

On -release it was a hang; but please note that on -debug the hard
lockup was actually being detected (so it was also reproducible with
the detectors enabled).

> That fix will hit linux-next in the next day or so and should be in rc2.

I confirm the fix works for us -- thanks a lot!

Cheers,
Miguel

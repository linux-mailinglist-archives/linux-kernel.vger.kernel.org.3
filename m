Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3854B23E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245523AbiFNN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245372AbiFNN0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:26:09 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDB3D1E1;
        Tue, 14 Jun 2022 06:26:05 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id v22so15145464ybd.5;
        Tue, 14 Jun 2022 06:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg40Qzlh3CkBmc2CNOSyZdIPDINffPR4aYYE9K/cZmg=;
        b=TUViGrVg9+/qQLlpqMJ85PJ92WtE0VTEPUiq2feZIpjoiO0clmcJZ3ZlihiGyNyW/E
         dO9EwfbwyI1KKeHfqW1XKUSHm6sT5rafroSSRBdB56fbbIAX5NdxhaBPBPoZ4nCIf1nF
         D5buPjXXYam9RNeNUFxuh+oxrlAWyBLoSzMl6twaTXroyJesKh0o1vKQjZv1YllR6cnj
         asuYEB2ZBX73QD0ig01/ZXe7gPP5Iuw69pWCEg/w42yH3AIlVbwaHgckOutog6L4XYbF
         XuvLfli9XAMO5WVu43zWFDz1ETkcZ41U/967wGHRriIC2HUEaCJ3qJpCNE0pMlNyingb
         gAFA==
X-Gm-Message-State: AJIora8PZ3v070/6wsz40hIzMvE+1HZ7bNIK05IAg/SGdJU/6WXpxL9r
        tHcGDKj68TmotPYocZYvyig2n2/2VH9rmUIyWlM=
X-Google-Smtp-Source: AGRyM1uMZx5W26G2ppurb8xQvisHxvQ9Dqths6isngEG5nqEoYNoNxUyNQ5syyDJUWdOaiSpvoVwH9DWrkUv/sMnjCo=
X-Received: by 2002:a25:84ca:0:b0:65c:b5a4:3d0a with SMTP id
 x10-20020a2584ca000000b0065cb5a43d0amr4985609ybm.137.1655213164860; Tue, 14
 Jun 2022 06:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <5578328.DvuYhMxLoT@kreacher> <4200238.ejJDZkT8p0@kreacher>
 <CAJZ5v0gWYZ_BSonhLGT7L4wPQvXLVyobPptE1Nx6PoNSGn4yXg@mail.gmail.com> <fd14c5e5-9635-7ef5-0bf4-438dfaea5361@molgen.mpg.de>
In-Reply-To: <fd14c5e5-9635-7ef5-0bf4-438dfaea5361@molgen.mpg.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jun 2022 15:25:54 +0200
Message-ID: <CAJZ5v0gYNeson93Zs-ZR7PVQEfwK3GBFpHuBGCk3DeDeeJH6LQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] ACPICA: executer/exsystem: Warn about sleeps
 greater than 10 ms
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bob Moore <robert.moore@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Sorry for the delay.

On Sun, May 22, 2022 at 1:28 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Rafael,
>
>
> Am 21.05.22 um 18:11 schrieb Rafael J. Wysocki:
> > On Mon, Apr 11, 2022 at 9:04 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> From: Paul Menzel <pmenzel@molgen.mpg.de>
> >>
> >> ACPICA commit 2a0d1d475e7ea1c815bee1e0692d81db9a7c909c
> >>
> >> Quick boottime is important, so warn about sleeps greater than 10 ms.
> >>
> >> Distribution Linux kernels reach initrd in 350 ms, so excessive delays
> >> should be called out. 10 ms is chosen randomly, but three of such delays
> >> would already make up ten percent of the boottime.
> >>
> >> Link: https://github.com/acpica/acpica/commit/2a0d1d47
> >> Signed-off-by: Bob Moore <robert.moore@intel.com>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > I have decided to revert this, because it spams logs with unuseful
> > warnings on many production systems.
>
> Thank you for the information. Can you please give an example?

Personally, I saw this on Dell XPS13 9360 and 9380 machines in my
office, but it has been reported to be that it was visible on multiple
systems in the Linux client power lab at Intel.

You can also see here that Linux is not the only affected OS:
https://github.com/acpica/acpica/pull/780

Thanks!

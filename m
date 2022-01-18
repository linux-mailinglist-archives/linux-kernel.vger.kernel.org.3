Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC2492BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346822AbiARQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:54:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52358 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346967AbiARQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:53:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E4FCB81238;
        Tue, 18 Jan 2022 16:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02645C340E8;
        Tue, 18 Jan 2022 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642524836;
        bh=ffk6JLpNO8FRNQ6RwvDOafwk2ujcbcrKrwR0MrvRn7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pUZBOkZcTOtNu0UvbidZZjfap7OjpGDIRwIqaa4ayYPzhuOn1Sgz4FdD9wTblDPH6
         d+RkpR/Q9Z7JilugoqPnR5YFi8smWiFEJKazuq2UFr/3f8XM1xsa40Uvs5aSfsa2fS
         gifoBVUnJJxDHsKWbToG93+XJjxs5VsMSM6IwukJI0D4pPGo0gpNqqHAt1z4fb0qNx
         oz2cnFFSg1nKxdIhsEahYX37H6M22ol6mwP5OTvmipaldx/ucYlYQMityb0i1oW5F7
         oMU/ETD33AdT0ptjPY15LurUoWOiSgPAa/BRY2wxbsS0x8IqQ/TmVMgRFjhPWWFEar
         MWmLYutxsSz5w==
Received: by mail-ed1-f43.google.com with SMTP id q25so82335716edb.2;
        Tue, 18 Jan 2022 08:53:55 -0800 (PST)
X-Gm-Message-State: AOAM532VQtIJCMzzWO0eWyXEKTLJk5DMDkvg3KQbNSqZcjJRsS9tI6cT
        yhWu2+KVhA9r1P4XnFjIcedYe7xpZMLM5INA+Q==
X-Google-Smtp-Source: ABdhPJxX2sAKloql9ZAg3sNFNxwwHYRoDefXV7wvtuNgdtIw67e5J4xVycF6R7EsfRnM2vvjwU6+oqa47d6oxQtZQO4=
X-Received: by 2002:aa7:c587:: with SMTP id g7mr22782115edq.109.1642524834268;
 Tue, 18 Jan 2022 08:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com> <5bd2dba7-c56f-4d8c-2f28-f2428afdcead@leemhuis.info>
In-Reply-To: <5bd2dba7-c56f-4d8c-2f28-f2428afdcead@leemhuis.info>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jan 2022 10:53:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKH90fgSPjKqALweEmZDfxy88jAiRZ4uRKE3+-OZv1ZXQ@mail.gmail.com>
Message-ID: <CAL_JsqKH90fgSPjKqALweEmZDfxy88jAiRZ4uRKE3+-OZv1ZXQ@mail.gmail.com>
Subject: Re: ChipIdea USB regression
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 16, 2022 at 4:21 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [TLDR: I'm adding this regression to regzbot, the Linux kernel
> regression tracking bot; most text you find below is compiled from a few
> templates paragraphs some of you might have seen already.]
>
> Hi, this is your Linux kernel regression tracker speaking.
>
> Adding the regression mailing list to the list of recipients, as it
> should be in the loop for all regressions, as explained here:
> https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
>
> On 14.01.22 11:56, Charles Keepax wrote:
> > Hi guys,
> >
> > My Zynq based board stopped booting today, a bisect points to this
> > patch:
> >
> > commit 0f153a1b8193 ("usb: chipidea: Set the DT node on the child device")
>
> Thanks for the report.
>
> To be sure this issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, my Linux kernel regression tracking bot:
>
> #regzbot ^introduced 0f153a1b8193
> #regzbot title usb: chipidea: Zynq based board stopped booting today
> #regzbot ignore-activity
>
> Reminder: when fixing the issue, please add a 'Link:' tag with the URL
> to the report (the parent of this mail) using the kernel.org redirector,

'kernel.org redirector' is lore.kernel.org? It would be clearer to
just say that.

> as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
> then will automatically mark the regression as resolved once the fix
> lands in the appropriate tree. For more details about regzbot see footer.

Would it be possible for you to provide the exact link tag in your
reports? That would be easier and less error prone than describing
what to do in prose.

Rob

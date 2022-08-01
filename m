Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31977587472
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbiHAXdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiHAXdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:33:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C166119C36
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 16:33:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o15so21197885yba.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 16:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfwgW/Cs/j3krR3RaLtXmPPIt4zR66/irWtO6+YT90s=;
        b=DhBf4BwKj1Y7kwHhpaQmCJ68hIimv7LeRFZLPZsM/LhiQBwWjBuG+ZM2f/QZFBWfLv
         ngq22Ns/PFPx81v2H3T/oF+9M9w3cdMhSYi1wIjtTajftS3yOe8PHvsGzKnFPmUxQH+F
         u6kzLLItYl6AKCWcr/uhn/kqfpPXgzu+UqfMZaKVcPmyqo2jFCldSnSA4q3XfnBsZl2k
         IERKJhyiY6PAEEi3pzeUxy+JH4ZJAzLCqgg3SETj3D4Hacien9Nj8l0XlW/a+NIE8ozE
         goiDhN2jBdbrZymNve5ohXyrYy+Vntlv8b8dT7mRUBHoNLW7m3lfmcYscR/gGlR6MYMa
         Kzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfwgW/Cs/j3krR3RaLtXmPPIt4zR66/irWtO6+YT90s=;
        b=pp9a/t/zwufHH6tQueoUGICEUmpLOndXuVY6Xsqj68d2fXjnrWLcSP/Pfad/d4XD1I
         95VQ9qNxd0/KZBuVFiKrwk+THDTNZbLCG1gMj7+jUuRiNK/g1K9gBWnnV1mHQQtKvsbG
         41jwHwiZDZzIf38YvAITPpMV8NiJ3kRyhscNQjYpU/Q+Q/TAzx/5QeHY0Jfma9ot8cO2
         dTDLdMHNd+HfPGXp4bF2SR48ettsoZ0aQ0Y4/GlIE+aLDpR28KqJkRr8AWPKuiq2l8nC
         tsat6Yte4a02+/9vHJ+TYXwulPjH2OeiZ6PyDND7C/u9FxzOk0CffhOeHyiIMlxwvHAQ
         faGQ==
X-Gm-Message-State: ACgBeo0xXqM2NrrDb1owm2NF/IBqvgwMCmbT61d2Z4VKr0BmraYaAWer
        fioh8zCdznuInxzL2F07ZTgiE+9kpn5NGSk3LeQb0kCYtAuNbCuB
X-Google-Smtp-Source: AA6agR7ywohYB/xkSBz811iJCFTsuhFoaJwB6Nna6ZSF1msOkE1HH5b9hmYO0uC+5JMliLxRz1V29HvTtH42caA+e3c=
X-Received: by 2002:a5b:ecc:0:b0:677:569c:a4e2 with SMTP id
 a12-20020a5b0ecc000000b00677569ca4e2mr3288604ybs.609.1659396825613; Mon, 01
 Aug 2022 16:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220706205136.v2.1.Ic7a7c81f880ab31533652e0928aa6e687bb268b5@changeid>
 <CACeCKadV=k5J1ZSG+p8M5iBnX5nXrn-XnK62Nq_op2kJ68+-9w@mail.gmail.com>
 <CANkg5ewRc5zhBtxLhazo8Wsfa3Srj32AwZD9mD=W=Qqpqi7zJQ@mail.gmail.com>
 <CACeCKaer_hacWmLDDMJSK-KFjxqiXV8S1-ydCWGT3mkQVeN-rg@mail.gmail.com>
 <CANkg5exPZH7LXV93SbAbNPsX2M-kE1yHqDhfk-cB0ywS15pOPQ@mail.gmail.com> <CACeCKafvVATzEqOnkT3-QPyfaTV8baHNKbLy8069-K+P+RPeMg@mail.gmail.com>
In-Reply-To: <CACeCKafvVATzEqOnkT3-QPyfaTV8baHNKbLy8069-K+P+RPeMg@mail.gmail.com>
From:   Tim Van Patten <timvp@google.com>
Date:   Mon, 1 Aug 2022 17:33:34 -0600
Message-ID: <CANkg5ezJS+FHoZcRQNwPEoBRCOrN7WNJiCaBrFKmxDXNtTE5UA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec: Send host event for prepare/complete
To:     Prashant Malani <pmalani@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rrangel@chromium.org,
        Rob Barnes <robbarnes@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the slow reply here, but I wanted to talk with Rob and Raul
to verify my understanding of the EC/AP behavior, as well as run some
additional testing.   I'll send out a new version with the updated
function names, but the rest of the patch is essentially the same.

> > > Calling such a theoretical new EC host command from the userspace power manager
> > > would probably accomplish the same thing.
> >
> > We investigated something like that internally initially:
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3646238)
> >
> > We decided to take this simpler approach instead, since it
> > accomplishes the same goal without requiring new host commands.
>
> - That link discusses updating the existing host command and the EC
> implementations;
> have you investigated adding a command for logging needs and calling it from
> power_manager/powerd directly?

That link is the only other investigation we've done.   We don't want
to add another host command just for logging since we already have one
that serves our purposes.

> - That link addresses several busses (UART, SPI etc.) whereas this patch only
> touches LPC. Is this intentional?

Yes, this is intentionally only focusing on the LPC EC. The LPC EC is
the only one we are interested in, as well as the only one we can
explicitly test.    The other ECs can be updated in the future if
necessary, but we don't want to introduce the possibility of unknown
side effects for platforms we can't verify.

> >
> > > From the kernel documentation[2], "The prepare phase is meant to
> > > prevent races by preventing new devices from being registered; the PM core
> > > would never know that all the children of a device had been suspended if new
> > > children could be registered at will." and "The method may also prepare the
> > > device or driver in some way for the upcoming system power transition, but
> > > it should not put the device into a low-power state."
> > >
> > > So it seems like an incorrect usage of this callback.
> >
> > Why is this usage incorrect?
> >
> > Sending the message to the EC is the preparation for the AP to enter
> > the system power transition. For example, it allows the EC to begin
> > watchdogging the AP once the suspend begins and stop once the resume
> > completes. This allows the EC to watchdog the entire process, without
> > any gaps - a beneficial side effect of this change.
>
> OK. Is that all it does? Does this not allow the EC itself to enter a
> deep sleep state,
> or put connected peripherals and/or state machines in a low power state??

The only work triggered by host command is starting/stopping the EC's
watchdogging of the AP. The work of monitoring/manipulating any other
power states is triggered by interrupts from the power signal changes
themselves.   To verify this, I removed the host command and EC
watchdogging and validated that suspend/resume behaves the same.

> If you're still set on this approach, please update the function names;
> setting the .prepare()/.complete() function pointers to
> cros_ec_lpc_suspend/resume()
> is inconsistent, if those functions aren't being used elsewhere in the file.

Done in the next patch version.

The only other thing not mentioned here is the logging that was added.

Here are the log messages without this change:
[   97.896425] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_suspend+0x0/0x55 @ 4582, parent: PNP0C09:00
[   97.896427] cros_ec_lpcs GOOG0004:00: acpi_subsys_suspend+0x0/0x55
returned 0 after 0 usecs
[   98.021116] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_suspend_late+0x0/0x4e @ 4582, parent: PNP0C09:00
[   98.021879] cros_ec_lpcs GOOG0004:00:
acpi_subsys_suspend_late+0x0/0x4e returned 0 after 741 usecs
[   98.127753] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_suspend_noirq+0x0/0x45 @ 4582, parent: PNP0C09:00
[   98.127757] cros_ec_lpcs GOOG0004:00:
acpi_subsys_suspend_noirq+0x0/0x45 returned 0 after 0 usecs
[  111.216731] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_resume_noirq+0x0/0x25 @ 4582, parent: PNP0C09:00
[  111.216746] cros_ec_lpcs GOOG0004:00:
acpi_subsys_resume_noirq+0x0/0x25 returned 0 after 0 usecs
[  111.243019] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_resume_early+0x0/0x67 @ 4582, parent: PNP0C09:00
[  111.246131] cros_ec_lpcs GOOG0004:00:
acpi_subsys_resume_early+0x0/0x67 returned 0 after 3035 usecs
[  111.247008] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_resume+0x0/0x56 @ 4582, parent: PNP0C09:00
[  111.247011] cros_ec_lpcs GOOG0004:00: acpi_subsys_resume+0x0/0x56
returned 0 after 0 usecs

Here are the log messages with the change:
[ 5510.348705] cros_ec_lpcs GOOG0004:00: Prepare EC suspend
[ 5510.352958] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_suspend+0x0/0x55 @ 17033, parent: PNP0C09:00
[ 5510.352960] cros_ec_lpcs GOOG0004:00: acpi_subsys_suspend+0x0/0x55
returned 0 after 0 usecs
[ 5510.463143] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_suspend_late+0x0/0x4e @ 17033, parent: PNP0C09:00
[ 5510.463165] cros_ec_lpcs GOOG0004:00:
acpi_subsys_suspend_late+0x0/0x4e returned 0 after 16 usecs
[ 5510.550825] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_suspend_noirq+0x0/0x45 @ 17033, parent: PNP0C09:00
[ 5510.550828] cros_ec_lpcs GOOG0004:00:
acpi_subsys_suspend_noirq+0x0/0x45 returned 0 after 0 usecs
[ 5518.065012] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_resume_noirq+0x0/0x25 @ 17033, parent: PNP0C09:00
[ 5518.065036] cros_ec_lpcs GOOG0004:00:
acpi_subsys_resume_noirq+0x0/0x25 returned 0 after 0 usecs
[ 5518.089437] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_resume_early+0x0/0x67 @ 17033, parent: PNP0C09:00
[ 5518.089455] cros_ec_lpcs GOOG0004:00:
acpi_subsys_resume_early+0x0/0x67 returned 0 after 0 usecs
[ 5518.090774] cros_ec_lpcs GOOG0004:00: calling
acpi_subsys_resume+0x0/0x56 @ 17033, parent: PNP0C09:00
[ 5518.090784] cros_ec_lpcs GOOG0004:00: acpi_subsys_resume+0x0/0x56
returned 0 after 6 usecs
[ 5518.386462] cros_ec_lpcs GOOG0004:00: EC resume completed: ret = 0

PM will call each driver regardless of whether there's anything to do
(note that the calls "complete" in 0usec), which results in a lot of
unnecessary output.   However, PM doesn't log .prepare()/.complete()
calls, so while previously we got the logging for free (due to PM
performing it for us), we need to add logging to know when the
.prepare()/.complete() calls are made.   This is why we'd like to keep
the logging, even if it's in a separate patch.

--

Tim Van Patten | ChromeOS | timvp@google.com | (720) 432-0997

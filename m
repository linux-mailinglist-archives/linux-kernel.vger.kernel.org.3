Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAF4DE520
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 03:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiCSCFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 22:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235982AbiCSCE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 22:04:57 -0400
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA18D1207D9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 19:03:37 -0700 (PDT)
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4KL3pT4Zh1z4xx3L
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:54:25 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="UYhvRppa"
Date:   Sat, 19 Mar 2022 01:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1647654861;
        bh=+zmtPIV9tSSZgwxIVl/xkVQsn7YJY/XahHOFfrwoDrY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=UYhvRppalZ8CuCT5vsLMgYUHwuFNe4KtGhTdp3GOAqBDJZcKiLrikt1BHvmDMCuvC
         uqxEqG5IRxm0OI4sSQFrwrAqZVNXAhS8FTB8NsUAuZUnf0a6sNg7puKpgDBm/Om2V7
         U+0ZLY59dOc6SvQ39rotoZKevG+jxYVpkWEHhtJNqgIp6PW9L+iTOfY0Rbo+F6ma/U
         8OPcPJ/4XQTvKw2Ky6dPMQqU8YY84mdNtkxroJI1jjKs/eg85iflFy7U62IU3tBL4D
         LTemHkpa5aKvCXp8+OMGLWGPpreDLOyLh+BZjf14eerPklEIKi19I5gML2c7s81fjO
         kdmFRKnAbmhwQ==
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   David Cohen <dacohen@pm.me>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: David Cohen <dacohen@pm.me>
Subject: Re: [PATCH v2] PM: fix dynamic debug within pm_pr_debug()
Message-ID: <YjU3sfYLcEqK1Usd@jiban.lan>
In-Reply-To: <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com>
References: <20220312043624.40732-1-dacohen@pm.me> <CAJZ5v0gqpQTuNN0WpnEd4dAQmnR=BXSoH_w7kkAxOG7xkftW6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:45:11PM +0100, Rafael J. Wysocki wrote:
> On Sat, Mar 12, 2022 at 5:37 AM David Cohen <dacohen@pm.me> wrote:
> >
> > Currently, pm_pr_debug() and pm_deferred_pr_debug() use __pm_pr_debug()
> > to filter pm debug messages based on pm_debug_messages_on flag.
> > According to __pm_pr_debug() implementation, pm_deferred_pr_debug()
> > indirectly calls printk_deferred() within __pm_pr_debug() which doesn't
> > support dynamic debug, but pm_pr_debug() indirectly calls pr_debug()
>
> I'm not sure what you mean by pm_pr_debug().  There's no such thing in
> the kernel tree.
>
> Assuming that it means pm_pr_dbg(), it doesn't call pr_debug():

Yeah, I apologize for the typo. I meant pm_pr_dbg(). I can fix that if
you're ok with the patch as per comments below.

>
> #define pm_pr_dbg(fmt, ...) __pm_pr_dbg(false, fmt, ##__VA_ARGS__)
>
> and
>
> void __pm_pr_dbg(bool defer, const char *fmt, ...)
> {
> ...
>         if (defer)
>                printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
>         else
>                printk(KERN_DEBUG "PM: %pV", &vaf);
>
> And as I said printk(KERN_DEBUG ...) is not equivalent to
> pr_debug(...), because it is not dynamic printk().

The problem is not about __pm_pr_dbg() calling printk(). The problem is
the pm files that used to call pr_debug() were modified to call
pm_pr_dbg() in order to be behing the pm_debug_messages_on flag, as per
this commit:
8d8b2441db96 PM / sleep: Do not print debug messages by default

That's the moment dynamic debug was no longer available for kernel pm files=
.

>
> pm_pr_dbg() is not dynamic printk() on purpose, so they both can be
> controlled independently.

The current solution is all or nothing (using pm_debug_messages_on). The
patch I'm sending is making dynamic debug available on the kernel pm
files, while still allowing the pm_debug_messages_on flag to work
independently.

Regards, David


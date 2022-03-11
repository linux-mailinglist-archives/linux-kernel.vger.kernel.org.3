Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17554D5986
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 05:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346205AbiCKE0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 23:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233230AbiCKE0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:26:51 -0500
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332D31A41C0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 20:25:49 -0800 (PST)
Date:   Fri, 11 Mar 2022 04:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail2; t=1646972744;
        bh=CYecxGUS8BPtyx0bXzHbATJSelg1KqiideWujqia9co=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=FUTNkRe1K1N6sjQXmfcMs5z2W3lEwEX7l7CEG3JmMs3pIZbRy+IdqY1DJYZ2izg6l
         DXIyHRxbF5CM86crP6ARfIfJT+FjYVZiHTGy8sCu8jmK7ESBO6l/ytML/qXQLWXrDZ
         2J6jKBhDRfAFdITIX9hCtW+JSW1oUNVrpFG/fC17v/Naiz2OzzuJuVzw6elgkCxbn3
         5osdv7HUK0QvwHc7pWO2wgTsjUmwQimo12FXYS6yqKml8QxH/VaZHrK1qiwF62lt3u
         EWnGh+45ZbfQ/gCBeDygXy52ps8WQY8sbscwOAIUAyw1fv1jvgKD64QBXx+Ao1JfQl
         JFBqTFH07o4AA==
To:     "Rafael J. Wysocki" <rafael@kernel.org>
From:   David Cohen <dacohen@pm.me>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: David Cohen <dacohen@pm.me>
Subject: Re: [PATCH] PM: fix dynamic debug within pm_pr_debug()
Message-ID: <a1872f1f-bdea-0e4b-75de-298f3ba87e6b@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/10/22 12:48, Rafael J. Wysocki wrote:

> On Sun, Mar 6, 2022 at 6:52 AM David Cohen <dacohen@pm.me> wrote:
>
> The patch has been sent as an attachment, so I cannot comment it inline.

Ouch. I used git send-email, but I'm using protonmail with
protonmail-bridge and it somehow mangled it. I'll fix it in
future.

>
> However, printk(KERN_DEBIG, ...) is not the same as pr_debig() AFAICS.
A bit of history I found on kernel git history:

kernel pm debug messages used to use pr_debug() until it was
changed by this commit to prevent printing pm debug messages
unless the sysfs debug flag was set:
8d8b2441db96 PM / sleep: Do not print debug messages by default

This commit implemented their own debugging print function. And
It was this commit that broke dynamic debug on kernel pm functions
when changed pr_debug() to printk(KERN_DEBUG, ...).

The patch I'm sending is keeping the same logic of checking the
sysfs flag, but instead of implementing its own debugging print function,
it will just use pr_debug again which is dynamic debug friendly.
As per my tests I'm able to individually control them again through
dynamic debug control interface.

FWIW I found a typo on my commit message, so I'll fix it and resend,
avoiding the protonmail-bridge (then inline comment will be possible).

Regards, David



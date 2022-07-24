Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6D857F514
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiGXMbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiGXMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:30:54 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E083885
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gwguV63Fi5fB1wTTDHlqLIZrWqWY7WfW5nfc8u5bpKE=; b=n+AHe5UDeDKrM/fd/enGiSzNMm
        /eDSjcjG1KNoElE0QsCBsi2ZIZPxdBi79IFCNycHaXAJRqFgTH3spmA5ukxnQPwDwBOyKgAas+pin
        0mU1M377EDShpHU7eK76Ixx4WflY7lnO5Vt5yTZ0FVCun1PDlpQrJ0JcrrzXBn7DMhL8=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oFake-004e7X-9V; Sun, 24 Jul 2022 14:30:28 +0200
Date:   Sun, 24 Jul 2022 14:30:28 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable
 to RETBleed attacks, data leaks possible!
Message-ID: <Yt07ZMAT+EEHvt/M@angband.pl>
References: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
 <Ys/bWIk0F5srkkpF@kroah.com>
 <YtxtNJorUMwCU+Gf@angband.pl>
 <3139s0q2-2o3s-4334-o670-n3p223o34ps9@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3139s0q2-2o3s-4334-o670-n3p223o34ps9@vanv.qr>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 11:25:04AM +0200, Jan Engelhardt wrote:
> On Saturday 2022-07-23 23:50, Adam Borowski wrote:
> >> > We are booting the i386 kernel on an x86 machine.
> >
> >[..] And for quite some tasks, halved word
> >size (thus ~2/3 memory usage) can overcome register starvation and win
> >benchmarks.
> 
> So how many benchmarks does a 32-bit userspace with a 32-bit kernel
> win over 32-bit userspace with a 64-bit kernel?

Likely none or almost none.
What we want is for people to run 64-bit kernel, there are no real issues
with userland.

Valid uses to run 32-bit kernel:
* ancient hardware (so much more prevalent than m68k we support!;
  non-hobbyists should upgrade to reduce power costs)
* hardware to run that 100$k-1M ISA industrial control/medical imaging card
  (which, having ISA, is necessarily ancient too)
* us devs testing the above

Only the last case will have a modern CPU, thus requiring an explicit
override won't hurt less educated users -- while telling the latter to grab
a 64-bit kernel if their hardware isn't ancient would have other benefits
for them beside just vulnerabilities.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ Aryans: split from other Indo-Europeans ~2900-2000BC → Ural →
⣾⠁⢠⠒⠀⣿⡁     Bactria → settled 2000-1000BC in northwest India.
⢿⡄⠘⠷⠚⠋⠀ Gypsies: came ~1000AD from northern India; aryan.
⠈⠳⣄⠀⠀⠀⠀ Germans: IE people who came ~2800BC to Scandinavia; not aryan.

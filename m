Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4A57F1D2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 23:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbiGWVvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 17:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbiGWVvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 17:51:18 -0400
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA0F1AD81
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 14:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E8m+xLzbfrZi9Nc2uLK+1RiRF1Jn5Hva1blr5jB++Cw=; b=JkARt4H82iYVI7DaV7IKx3NN4q
        uArbfoeLPWyjufVFVNYF+zQzsqYB9kQ8chFAw3RbkLVij6wh9AJOIlGSZZGNsYlKzOw0ysGX0WhKP
        dRXNDWoXd+ESyvuZ3+Y1P1Smf8RFSBOkHHN3fCV8VgbxxjqiSu1IvVm2EN1Lrona/FKo=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oFN1I-004Nuk-5B; Sat, 23 Jul 2022 23:50:44 +0200
Date:   Sat, 23 Jul 2022 23:50:44 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable
 to RETBleed attacks, data leaks possible!
Message-ID: <YtxtNJorUMwCU+Gf@angband.pl>
References: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
 <Ys/bWIk0F5srkkpF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ys/bWIk0F5srkkpF@kroah.com>
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

On Thu, Jul 14, 2022 at 11:01:12AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 14, 2022 at 02:15:07PM +0530, Naresh Kamboju wrote:
> > We are booting the i386 kernel on an x86 machine.
> > With Spectre V2 patches merged into Linux mainline we have been noticing
> > RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to
> > RETBleed attacks, data leaks possible!
> 
> That's funny.  I don't think that's a valid combination that should be
> cared about, but I'll leave it to Pawan to comment if it is something
> that is "real" to be concerned for.

Alas, some people still run that because of not knowing any better.
Until not so long ago, they were proposed with two install media, "32-bit"
and "64-bit", but no explanation.  Upgrades keep working, crossgrades are
still only for the brave of the heart, and reinstalling might not appear
to have a reason compelling enough.  And for quite some tasks, halved word
size (thus ~2/3 memory usage) can overcome register starvation and win
benchmarks.

Thus I wonder: perhaps such combinations we consider to be invalid should
refuse to boot unless given a cmdline parameter?


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ What kind of a drug are "base" and "red pill"?  I think acid is
⢿⡄⠘⠷⠚⠋⠀ LSD, which would make base... ?  Judging from the behaviour of
⠈⠳⣄⠀⠀⠀⠀ those "based and redpilled", something nasty.

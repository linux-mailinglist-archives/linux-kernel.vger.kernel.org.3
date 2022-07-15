Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663B575B66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiGOGQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGOGPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:15:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5845F774B1;
        Thu, 14 Jul 2022 23:14:30 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657865668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEFrGRzx2HRmzhJ7UPpw8gHa4O4qj4ywFqjMDBC7ZXg=;
        b=DUixPfAjTwHcZ91MSA7eJganvqbUgueXazFi+F1VBlI8C/krnKmID0y5WVAHljpGP8s8Nh
        kAMrhh1laSaViMucwqFzRZ3L1Hbue11PPQ89k7F6ceU6i02Ruc4uzrKldELGEhrBPXYpSh
        EhjWZ6dR0fnxrBHvgSZX3ipXAcl7IgFC83Voh/j5YEWSsVBUHpXm5rx/DyFQQUlBaDNCBH
        d27RZuI/IvZmM1m03YnTwd3tZeUJX9tZb92VpKmxSjtWl3GadEcTbTLlSUlIWUHyvlsnay
        qq+AzH7F2OtwEq3l+06dfOA5cSyN4Qv9Lin6utPnsb04GcVYde/suiTlb4zk5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657865668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEFrGRzx2HRmzhJ7UPpw8gHa4O4qj4ywFqjMDBC7ZXg=;
        b=VhykZswD1fCTN4vsmaBG/oZCrHvXluGEhdQmSywaFUKeqVY9BE4UurdnzBZ86f4x4sVqJo
        jEDCXaqELswn29AQ==
To:     todd.e.brandt@linux.intel.com,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, rafael.j.wysocki@intel.com,
        len.brown@intel.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
In-Reply-To: <472f7fc2d44d781edb64f19f9970fe50eec79c1f.camel@linux.intel.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
 <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
 <87o7xwbuoy.fsf@jogness.linutronix.de> <Ysvbp8vz7R9hDNqx@alley>
 <Ysv3JNs4RwE7kAou@google.com> <87ilo1wdac.fsf@jogness.linutronix.de>
 <c60f5634e8605cb4c2ef4646b6e511e6135bea48.camel@linux.intel.com>
 <7d79e9877d63cdb74144f38d8736959281b562cc.camel@linux.intel.com>
 <875yk0908j.fsf@jogness.linutronix.de>
 <472f7fc2d44d781edb64f19f9970fe50eec79c1f.camel@linux.intel.com>
Date:   Fri, 15 Jul 2022 08:20:27 +0206
Message-ID: <8735f2x5q4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-14, Todd Brandt <todd.e.brandt@linux.intel.com> wrote:
> I ran with your fix on 30 systems. On the 7 machines where this
> problem appears, the patch fixes it completely. On the 23 machines
> where this problem does not appear, there are no issues or
> regressions.
>
> Fix verified, thank you!

I have posted [0] an official patch for 5.19-rc7. For the posted
version, I added more information to the commit message and comments.

Todd, thanks for reporting and testing!

John

[0] https://lore.kernel.org/lkml/20220715061042.373640-1-john.ogness@linutronix.de
